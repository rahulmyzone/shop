package com.salesmanager.web.shop.controller.customer;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import net.tanesha.recaptcha.ReCaptchaImpl;
import net.tanesha.recaptcha.ReCaptchaResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.salesmanager.core.business.customer.CustomerRegistrationException;
import com.salesmanager.core.business.customer.model.Customer;
import com.salesmanager.core.business.generic.exception.ServiceException;
import com.salesmanager.core.business.merchant.model.MerchantStore;
import com.salesmanager.core.business.reference.country.model.Country;
import com.salesmanager.core.business.reference.country.service.CountryService;
import com.salesmanager.core.business.reference.language.model.Language;
import com.salesmanager.core.business.reference.language.service.LanguageService;
import com.salesmanager.core.business.reference.zone.model.Zone;
import com.salesmanager.core.business.reference.zone.service.ZoneService;
import com.salesmanager.core.business.system.service.EmailService;
import com.salesmanager.core.utils.CoreConfiguration;
import com.salesmanager.core.utils.ajax.AjaxResponse;
import com.salesmanager.web.constants.Constants;
import com.salesmanager.web.entity.customer.Address;
import com.salesmanager.web.entity.customer.AnonymousCustomer;
import com.salesmanager.web.entity.customer.CustomerEntity;
import com.salesmanager.web.entity.customer.SecuredShopPersistableCustomer;
import com.salesmanager.web.shop.controller.AbstractController;
import com.salesmanager.web.shop.controller.ControllerConstants;
import com.salesmanager.web.shop.controller.customer.facade.CustomerFacade;
import com.salesmanager.web.shop.controller.shoppingCart.facade.ShoppingCartFacade;
import com.salesmanager.web.utils.EmailTemplatesUtils;
import com.salesmanager.web.utils.LabelUtils;
import com.salesmanager.web.utils.SMSTemplateUtils;

/**
 * Registration of a new customer
 * @author Carl Samson
 *
 */

@SuppressWarnings( "deprecation" )
// http://stackoverflow.com/questions/17444258/how-to-use-new-passwordencoder-from-spring-security
@Controller
@RequestMapping("/shop/customer")
public class CustomerRegistrationController extends AbstractController {

	private static final Logger LOGGER = LoggerFactory.getLogger(CustomerRegistrationController.class);
    
	@Autowired
	private ShoppingCartFacade shoppingCartFacade;
	
	@Autowired
	private CoreConfiguration coreConfiguration;

	@Autowired
	private LanguageService languageService;


	@Autowired
	private CountryService countryService;

	
	@Autowired
	private ZoneService zoneService;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	EmailService emailService;

	@Autowired
	private LabelUtils messages;
	
	@Autowired
	private CustomerFacade customerFacade;
	
	@Autowired
    private AuthenticationManager customerAuthenticationManager;
	
	@Autowired
	private EmailTemplatesUtils emailTemplatesUtils;
	
	@Autowired
	private SMSTemplateUtils smsTemplateUtils;



	@RequestMapping(value="/registration.html", method=RequestMethod.GET)
	public String displayRegistration(final Model model, final HttpServletRequest request, final HttpServletResponse response) throws Exception {

		MerchantStore store = (MerchantStore)request.getAttribute(Constants.MERCHANT_STORE);

		//model.addAttribute( "recapatcha_public_key", coreConfiguration.getProperty( Constants.RECAPATCHA_PUBLIC_KEY ) );
		
		SecuredShopPersistableCustomer customer = new SecuredShopPersistableCustomer();
		AnonymousCustomer anonymousCustomer = (AnonymousCustomer)request.getAttribute(Constants.ANONYMOUS_CUSTOMER);
		if(anonymousCustomer!=null) {
			customer.setBilling(anonymousCustomer.getBilling());
			customer.setDelivery(anonymousCustomer.getDelivery());
		}
		
		model.addAttribute("customer", customer);

		/** template **/
		StringBuilder template = new StringBuilder().append(ControllerConstants.Tiles.Customer.register).append(".").append(store.getStoreTemplate());

		return template.toString();


	}
	
	@RequestMapping( value = "/registerCustomer.html", method = RequestMethod.POST )
    public @ResponseBody String registerNewCustomer(HttpServletRequest request, HttpServletResponse response, final Locale locale )
        throws Exception
    {
		AjaxResponse resp = new AjaxResponse();
        String name = request.getParameter("billing.firstName");
        String email = request.getParameter("emailAddress");
        String phone = request.getParameter("billing.phone");
        String gender = request.getParameter("gender");
        String pass = request.getParameter("password");
        
        MerchantStore merchantStore = (MerchantStore) request.getAttribute( Constants.MERCHANT_STORE );
        Language language = super.getLanguage(request);
        
        SecuredShopPersistableCustomer customer = new SecuredShopPersistableCustomer();
		AnonymousCustomer anonymousCustomer = (AnonymousCustomer)request.getAttribute(Constants.ANONYMOUS_CUSTOMER);
		if(anonymousCustomer!=null) {
			customer.setBilling(anonymousCustomer.getBilling());
			customer.setDelivery(anonymousCustomer.getDelivery());
		}
		
		customer.setEmailAddress(email);
		customer.getBilling().setFirstName(name);
		customer.getBilling().setPhone(phone);
		customer.setGender(gender);
		customer.setPassword(pass);
		
		customer.getBilling().setZone("IND");
        customer.getBilling().setCountry("IN");
        
        Address delivery = customer.getDelivery();
        if(delivery == null){
        	delivery = new Address();
        }
        delivery.setZone("IND");
        delivery.setCountry("IN");
        customer.setDelivery(delivery);
        
        String userName = null;
        String password = null;
		Map<String, String> msgs = new HashMap<String, String>();
		if(!StringUtils.isNotBlank(customer.getBilling().getFirstName())){
			LOGGER.debug( "Name is required.", customer.getUserName() );
            msgs.put("firstName", "Name is required.");
		}
		
        if ( StringUtils.isNotBlank( customer.getEmailAddress() ) )
        {
            if ( customerFacade.checkIfUserExistsWithSameEmail(customer, merchantStore ) )
            {
                LOGGER.debug( "Customer with email {} already exists for this store ", customer.getUserName() );
                msgs.put("email", "Email already exists.");
            }
            userName = customer.getEmailAddress();
        }else{
        	LOGGER.debug( "Email address is required.", customer.getUserName() );
            msgs.put("email", "Email address is required.");
        }
        
        if ( StringUtils.isNotBlank( customer.getBilling().getPhone() ) )
        {
            if ( customerFacade.checkIfUserExistsWithSamePhone(customer, merchantStore ) )
            {
                LOGGER.debug( "Customer with Mobile Number {} already exists for this store ", customer.getUserName() );
                msgs.put("phone", "Mobile number already exists.");
            }
        }else{
        	LOGGER.debug( "Mobile Number is required.", customer.getUserName() );
            msgs.put("phone", "Mobile Number is required.");
        }
        
        
        if ( !StringUtils.isNotBlank( customer.getPassword()))
        {
        	LOGGER.debug( "Password should not be empty. ", customer.getUserName() );
            msgs.put("password", "Password is required.");
        }
        password = customer.getPassword();
        if ( !msgs.isEmpty() )
        {
            LOGGER.debug( "found {} validation error while validating in customer registration ",
                         msgs );
            resp.addDataEntry(msgs);
            resp.setStatus(AjaxResponse.RESPONSE_STATUS_FAIURE);
            return resp.toJSONString();

        }

        @SuppressWarnings( "unused" )
        CustomerEntity customerData = null;
        try
        {
            //set user clear password
        	customer.setClearPassword(password);
        	customer.setUserName(userName);
        	customerData = customerFacade.registerCustomer( customer, merchantStore, language );
        }
        catch ( CustomerRegistrationException cre )
        {
            LOGGER.error( "Error while registering customer.. ", cre);
        	ObjectError error = new ObjectError("registration",messages.getMessage("registration.failed", locale));
        	msgs.put("registrationError", error.getDefaultMessage());
        	resp.addDataEntry(msgs);
        	resp.setStatus(AjaxResponse.RESPONSE_STATUS_FAIURE);
            return resp.toJSONString();
        }
        catch ( Exception e )
        {
            LOGGER.error( "Error while registering customer.. ", e);
        	ObjectError error = new ObjectError("registration",messages.getMessage("registration.failed", locale));
        	msgs.put("registrationError", error.getDefaultMessage());
        	resp.addDataEntry(msgs);
        	resp.setStatus(AjaxResponse.RESPONSE_STATUS_FAIURE);
            return resp.toJSONString();
        }
              
        /**
         * Send registration email
         */
        emailTemplatesUtils.sendRegistrationEmail( customer, merchantStore, locale, request.getContextPath() );
        smsTemplateUtils.sendRegistrationMessage(customer, merchantStore, locale, request.getContextPath());

        /**
         * Login user
         */
        
        try {
        	
	        //refresh customer
	        Customer c = customerFacade.getCustomerByUserName(customer.getUserName(), merchantStore);
	        //authenticate
	        customerFacade.authenticate(c, userName, password);
	        super.setSessionAttribute(Constants.CUSTOMER, c, request);
	        
	        StringBuilder cookieValue = new StringBuilder();
            cookieValue.append(merchantStore.getCode()).append("_").append(c.getNick());
	        
            //set username in the cookie
            Cookie cookie = new Cookie(Constants.COOKIE_NAME_USER, cookieValue.toString());
            cookie.setMaxAge(60 * 24 * 3600);
            cookie.setPath(Constants.SLASH);
            response.addCookie(cookie);
            
            MerchantStore store = (MerchantStore)request.getAttribute(Constants.MERCHANT_STORE);
            String shoppingCartCode  = (String)request.getSession().getAttribute(Constants.SHOPPING_CART);
            com.salesmanager.core.business.shoppingcart.model.ShoppingCart cart = null;
            if(shoppingCartCode != null){
            	cart = shoppingCartFacade.getShoppingCartModel(shoppingCartCode, store);
            	cart.setCustomerId(c.getId());
            	//customerFacade.saveOrUpdate(c);
            	shoppingCartFacade.saveShoppingCart(cart);
            }
	        
            if(super.getSessionAttribute("gotoCart", request) != null){
            	msgs.put("gotoCart", (String)super.getSessionAttribute("gotoCart", request));
            	super.removeAttribute("gotoCart", request);
            	msgs.put("url", "/shop/order/checkout.html");
            	resp.addDataEntry(msgs);
            	resp.setStatus(AjaxResponse.RESPONSE_STATUS_SUCCESS);
            	return resp.toJSONString();
            }
	        
            msgs.put("url", "/shop/customer/dashboard.html");
        	resp.addDataEntry(msgs);
            resp.setStatus(AjaxResponse.RESPONSE_STATUS_SUCCESS);
        	return resp.toJSONString();
        	
        
        
        } catch(Exception e) {
        	LOGGER.error("Cannot authenticate user ",e);
        	ObjectError error = new ObjectError("registration",messages.getMessage("registration.failed", locale));
        	msgs.put("registrationError", error.getDefaultMessage());
        	resp.addDataEntry(msgs);
        	resp.setStatus(AjaxResponse.RESPONSE_STATUS_FAIURE);
            return resp.toJSONString();
        }
        
    }

    @RequestMapping( value = "/register.html", method = RequestMethod.POST )
    public String registerCustomer( @Valid
    @ModelAttribute("customer") SecuredShopPersistableCustomer customer, BindingResult bindingResult, Model model,
                                    HttpServletRequest request, HttpServletResponse response, final Locale locale )
        throws Exception
    {
        MerchantStore merchantStore = (MerchantStore) request.getAttribute( Constants.MERCHANT_STORE );
        Language language = super.getLanguage(request);
        customer.getBilling().setZone("IND");
        customer.getBilling().setCountry("IN");
        
        Address delivery = customer.getDelivery();
        if(delivery == null){
        	delivery = new Address();
        }
        delivery.setZone("IND");
        delivery.setCountry("IN");
        customer.setDelivery(delivery);
        /*ReCaptchaImpl reCaptcha = new ReCaptchaImpl();
        reCaptcha.setPublicKey( coreConfiguration.getProperty( Constants.RECAPATCHA_PUBLIC_KEY ) );
        reCaptcha.setPrivateKey( coreConfiguration.getProperty( Constants.RECAPATCHA_PRIVATE_KEY ) );*/
        
        String userName = null;
        String password = null;
        
        //model.addAttribute( "recapatcha_public_key", coreConfiguration.getProperty( Constants.RECAPATCHA_PUBLIC_KEY ) );
        
        /*if ( StringUtils.isNotBlank( customer.getRecaptcha_challenge_field() )
            && StringUtils.isNotBlank( customer.getRecaptcha_response_field() ) )
        {
            ReCaptchaResponse reCaptchaResponse =
                reCaptcha.checkAnswer( request.getRemoteAddr(), customer.getRecaptcha_challenge_field(),
                                       customer.getRecaptcha_response_field() );
            if ( !reCaptchaResponse.isValid() )
            {
                LOGGER.debug( "Captcha response does not matched" );
    			FieldError error = new FieldError("recaptcha_challenge_field","recaptcha_challenge_field",messages.getMessage("validaion.recaptcha.not.matched", locale));
    			bindingResult.addError(error);
            }

        }*/
        
        if ( StringUtils.isNotBlank( customer.getEmailAddress() ) )
        {
            if ( customerFacade.checkIfUserExistsWithSameEmail(customer, merchantStore ) )
            {
                LOGGER.debug( "Customer with email {} already exists for this store ", customer.getUserName() );
            	FieldError error = new FieldError("emailAddress","emailAddress",messages.getMessage("registration.emailAddress.already.exists", locale));
            	bindingResult.addError(error);
            }
            userName = customer.getEmailAddress();
        }
        
        if ( StringUtils.isNotBlank( customer.getBilling().getPhone() ) )
        {
            if ( customerFacade.checkIfUserExistsWithSamePhone(customer, merchantStore ) )
            {
                LOGGER.debug( "Customer with Mobile Number {} already exists for this store ", customer.getUserName() );
            	FieldError error = new FieldError("billing.phone","billing.phone",messages.getMessage("registration.phone.already.exists", locale));
            	bindingResult.addError(error);
            }
        }
        
        
        if ( StringUtils.isNotBlank( customer.getPassword() ) &&  StringUtils.isNotBlank( customer.getCheckPassword() ))
        {
            if (! customer.getPassword().equals(customer.getCheckPassword()) )
            {
            	FieldError error = new FieldError("password","password",messages.getMessage("message.password.checkpassword.identical", locale));
            	bindingResult.addError(error);

            }
            password = customer.getPassword();
        }

        if ( bindingResult.hasErrors() )
        {
            LOGGER.debug( "found {} validation error while validating in customer registration ",
                         bindingResult.getErrorCount() );
            StringBuilder template =
                new StringBuilder().append( ControllerConstants.Tiles.Customer.register ).append( "." ).append( merchantStore.getStoreTemplate() );
            return template.toString();

        }

        @SuppressWarnings( "unused" )
        CustomerEntity customerData = null;
        try
        {
            //set user clear password
        	customer.setClearPassword(password);
        	customer.setUserName(userName);
        	customerData = customerFacade.registerCustomer( customer, merchantStore, language );
        }
        catch ( CustomerRegistrationException cre )
        {
            LOGGER.error( "Error while registering customer.. ", cre);
        	ObjectError error = new ObjectError("registration",messages.getMessage("registration.failed", locale));
        	bindingResult.addError(error);
            StringBuilder template =
                            new StringBuilder().append( ControllerConstants.Tiles.Customer.register ).append( "." ).append( merchantStore.getStoreTemplate() );
             return template.toString();
        }
        catch ( Exception e )
        {
            LOGGER.error( "Error while registering customer.. ", e);
        	ObjectError error = new ObjectError("registration",messages.getMessage("registration.failed", locale));
        	bindingResult.addError(error);
            StringBuilder template =
                            new StringBuilder().append( ControllerConstants.Tiles.Customer.register ).append( "." ).append( merchantStore.getStoreTemplate() );
            return template.toString();
        }
              
        /**
         * Send registration email
         */
        emailTemplatesUtils.sendRegistrationEmail( customer, merchantStore, locale, request.getContextPath() );

        /**
         * Login user
         */
        
        try {
        	
	        //refresh customer
	        Customer c = customerFacade.getCustomerByUserName(customer.getUserName(), merchantStore);
	        //authenticate
	        customerFacade.authenticate(c, userName, password);
	        super.setSessionAttribute(Constants.CUSTOMER, c, request);
	        
	        StringBuilder cookieValue = new StringBuilder();
            cookieValue.append(merchantStore.getCode()).append("_").append(c.getNick());
	        
            //set username in the cookie
            Cookie cookie = new Cookie(Constants.COOKIE_NAME_USER, cookieValue.toString());
            cookie.setMaxAge(60 * 24 * 3600);
            cookie.setPath(Constants.SLASH);
            response.addCookie(cookie);
            
            MerchantStore store = (MerchantStore)request.getAttribute(Constants.MERCHANT_STORE);
            String shoppingCartCode  = (String)request.getSession().getAttribute(Constants.SHOPPING_CART);
            com.salesmanager.core.business.shoppingcart.model.ShoppingCart cart = null;
            if(shoppingCartCode != null){
            	cart = shoppingCartFacade.getShoppingCartModel(shoppingCartCode, store);
            	cart.setCustomerId(c.getId());
            	//customerFacade.saveOrUpdate(c);
            	shoppingCartFacade.saveShoppingCart(cart);
            }
	        
            if(super.getSessionAttribute("gotoCart", request) != null){
            	super.removeAttribute("gotoCart", request);
            	return "redirect:/shop/order/checkout.html";
            }
	        
	        
	        return "redirect:/shop/customer/dashboard.html";
        
        
        } catch(Exception e) {
        	LOGGER.error("Cannot authenticate user ",e);
        	ObjectError error = new ObjectError("registration",messages.getMessage("registration.failed", locale));
        	bindingResult.addError(error);
        }
        
        StringBuilder template =
                new StringBuilder().append( ControllerConstants.Tiles.Customer.register ).append( "." ).append( merchantStore.getStoreTemplate() );
        return template.toString();

    }
	
	
	@ModelAttribute("countryList")
	public List<Country> getCountries(final HttpServletRequest request){
	    
        Language language = (Language) request.getAttribute( "LANGUAGE" );
        try
        {
            if ( language == null )
            {
                language = (Language) request.getAttribute( "LANGUAGE" );
            }

            if ( language == null )
            {
                language = languageService.getByCode( Constants.DEFAULT_LANGUAGE );
            }
            
            List<Country> countryList=countryService.getCountries( language );
            return countryList;
        }
        catch ( ServiceException e )
        {
            LOGGER.error( "Error while fetching country list ", e );

        }
        return Collections.emptyList();
    }
	
	@ModelAttribute("zoneList")
    public List<Zone> getZones(final HttpServletRequest request){
	    return zoneService.list();
	}
}
