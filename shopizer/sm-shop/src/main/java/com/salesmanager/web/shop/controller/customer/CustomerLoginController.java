package com.salesmanager.web.shop.controller.customer;

import java.math.BigDecimal;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.salesmanager.core.business.customer.model.Customer;
import com.salesmanager.core.business.merchant.model.MerchantStore;
import com.salesmanager.core.business.reference.language.model.Language;
import com.salesmanager.core.business.shoppingcart.model.ShoppingCart;
import com.salesmanager.core.business.shoppingcart.model.ShoppingCartItem;
import com.salesmanager.core.business.shoppingcart.service.ShoppingCartService;
import com.salesmanager.core.utils.ajax.AjaxResponse;
import com.salesmanager.web.constants.Constants;
import com.salesmanager.web.entity.customer.SecuredCustomer;
import com.salesmanager.web.entity.shoppingcart.ShoppingCartData;
import com.salesmanager.web.shop.controller.AbstractController;
import com.salesmanager.web.shop.controller.customer.facade.CustomerFacade;

/**
 * Custom Spring Security authentication
 * @author Carl Samson
 *
 */
@Controller
@RequestMapping("/shop/customer")
public class CustomerLoginController extends AbstractController {
	
	@Autowired
    private AuthenticationManager customerAuthenticationManager;
	

    @Autowired
    private  CustomerFacade customerFacade;

    @Autowired
    private ShoppingCartService shoppingCartService;
	
	private static final Logger LOG = LoggerFactory.getLogger(CustomerLoginController.class);
	
	
	private AjaxResponse logon(String login, String password, String storeCode, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
        AjaxResponse jsonObject = new AjaxResponse();
        

        try {

        	LOG.debug("Authenticating user " + login);
        	
        	//user goes to shop filter first so store and language are set
        	MerchantStore store = (MerchantStore)request.getAttribute(Constants.MERCHANT_STORE);
        	Language language = (Language)request.getAttribute("LANGUAGE");

            //check if username is from the appropriate store
        	Customer customerModel = null;
            customerModel = customerFacade.getCustomerByUserName(login, store);
            
            if(customerModel==null) {
            	jsonObject.setStatus(AjaxResponse.RESPONSE_STATUS_FAIURE);
            	return jsonObject;
            }
            
            if(!customerModel.getMerchantStore().getCode().equals(storeCode)) {
            	jsonObject.setStatus(AjaxResponse.RESPONSE_STATUS_FAIURE);
            	return jsonObject;
            }
            
            customerFacade.authenticate(customerModel, login, password);
            //set customer in the http session
            super.setSessionAttribute(Constants.CUSTOMER, customerModel, request);
            jsonObject.setStatus(AjaxResponse.RESPONSE_STATUS_SUCCESS);
            jsonObject.addEntry(Constants.RESPONSE_KEY_USERNAME, customerModel.getNick());
            super.setSessionAttribute(Constants.ANONYMOUS_CUSTOMER, null, request);


            
            
            LOG.info( "Fetching and merging Shopping Cart data" );
            final String sessionShoppingCartCode= (String)request.getSession().getAttribute( Constants.SHOPPING_CART );
            if(!StringUtils.isBlank(sessionShoppingCartCode)) {
	            ShoppingCartData shoppingCartData= customerFacade.mergeCart( customerModel, sessionShoppingCartCode, store, language );
	            if(shoppingCartData !=null){
	                jsonObject.addEntry(Constants.SHOPPING_CART, shoppingCartData.getCode());
	                request.getSession().setAttribute(Constants.SHOPPING_CART, shoppingCartData.getCode());
	            }
	            
	            
	            
	            //set username in the cookie
	            Cookie c = new Cookie(Constants.COOKIE_NAME_CART, shoppingCartData.getCode());
	            c.setMaxAge(60 * 24 * 3600);
	            c.setPath(Constants.SLASH);
	            response.addCookie(c);
	            
            } else {

	            ShoppingCart cartModel = shoppingCartService.getByCustomer(customerModel);
	            if(cartModel!=null) {
	                jsonObject.addEntry( Constants.SHOPPING_CART, cartModel.getShoppingCartCode());
	                request.getSession().setAttribute(Constants.SHOPPING_CART, cartModel.getShoppingCartCode());
	                
		            Cookie c = new Cookie(Constants.COOKIE_NAME_CART, cartModel.getShoppingCartCode());
		            c.setMaxAge(60 * 24 * 3600);
		            c.setPath(Constants.SLASH);
		            response.addCookie(c);
	                
	            }

            
            }
            String cartCode = super.getSessionAttribute(Constants.SHOPPING_CART, request);
            ShoppingCart cartModel = shoppingCartService.getByCode(cartCode, store);
            if(cartModel != null){
            cartModel.setPromotionalVoucher(null);
    		cartModel.setPromotionApplied(false);
    		if(cartModel.getLineItems() != null){
        		for(ShoppingCartItem cartItem : cartModel.getLineItems()){
	        			cartItem.setPromotionalVoucher(null);
	        			cartItem.setPromotionApplied(false);
	        			cartItem.setDiscountedPrice(BigDecimal.ZERO);
        			}
    			}
    		shoppingCartService.saveOrUpdate(cartModel);
            }
            StringBuilder cookieValue = new StringBuilder();
            cookieValue.append(store.getCode()).append("_").append(customerModel.getNick());
            
            //set username in the cookie
            Cookie c = new Cookie(Constants.COOKIE_NAME_USER, cookieValue.toString());
            c.setMaxAge(60 * 24 * 3600);
            c.setPath(Constants.SLASH);
            response.addCookie(c);
            if(super.getSessionAttribute("gotoCart", request) != null){
            	jsonObject.addEntry(Constants.GOTO_CART_KEY, super.getSessionAttribute("gotoCart", request).toString());
            	super.removeAttribute("gotoCart", request);
            }
            
        } catch (AuthenticationException ex) {
        	jsonObject.setStatus(AjaxResponse.RESPONSE_STATUS_FAIURE);
        } catch(Exception e) {
        	jsonObject.setStatus(AjaxResponse.RESPONSE_STATUS_FAIURE);
        }
        
        return jsonObject;
		
		
	}
	//http://localhost:8080/sm-shop/shop/customer/authenticate.html?userName=shopizer&password=password&storeCode=DEFAULT
	@RequestMapping(value="/authenticate.html", method=RequestMethod.GET)
	public @ResponseBody String basicLogon(@RequestParam String userName, @RequestParam String password, @RequestParam String storeCode, HttpServletRequest request, HttpServletResponse response) throws Exception {

		AjaxResponse jsonObject = this.logon(userName, password, storeCode, request, response);
		return jsonObject.toJSONString();
		
	}
	
	/**
	 * Customer login entry point
	 * @param securedCustomer
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/logon.html", method=RequestMethod.POST)
	public @ResponseBody String jsonLogon(@ModelAttribute SecuredCustomer securedCustomer, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
        AjaxResponse jsonObject = this.logon(securedCustomer.getLogin(), securedCustomer.getPassword(), securedCustomer.getStoreCode(), request, response);
        return jsonObject.toJSONString();
        
	
	}
	
	@RequestMapping(value="/logout.html", method=RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.getSession(true).invalidate();
		return "redirect:/shop";
	}

}
