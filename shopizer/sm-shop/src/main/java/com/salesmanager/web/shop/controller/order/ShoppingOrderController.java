package com.salesmanager.web.shop.controller.order;

import java.io.ByteArrayOutputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.Validate;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.salesmanager.core.business.catalog.product.service.PricingService;
import com.salesmanager.core.business.catalog.promotions.model.PromotionalVoucher;
import com.salesmanager.core.business.catalog.promotions.model.PromotionalVoucher.PromotionType;
import com.salesmanager.core.business.catalog.promotions.service.PromotionalVoucherService;
import com.salesmanager.core.business.common.model.Billing;
import com.salesmanager.core.business.customer.model.Customer;
import com.salesmanager.core.business.customer.service.CustomerService;
import com.salesmanager.core.business.generic.exception.ServiceException;
import com.salesmanager.core.business.merchant.model.MerchantStore;
import com.salesmanager.core.business.order.model.Order;
import com.salesmanager.core.business.order.model.OrderTotal;
import com.salesmanager.core.business.order.model.OrderTotalSummary;
import com.salesmanager.core.business.order.model.orderproduct.OrderProductDownload;
import com.salesmanager.core.business.order.service.OrderService;
import com.salesmanager.core.business.order.service.orderproduct.OrderProductDownloadService;
import com.salesmanager.core.business.payments.dao.PaytmTxnReponseDao;
import com.salesmanager.core.business.payments.model.AtomTxnResponse;
import com.salesmanager.core.business.payments.model.PaymentMethod;
import com.salesmanager.core.business.payments.model.PaymentType;
import com.salesmanager.core.business.payments.model.PaytmTxnResponse;
import com.salesmanager.core.business.payments.model.Transaction;
import com.salesmanager.core.business.payments.service.AtomTxnResponseService;
import com.salesmanager.core.business.payments.service.PaymentService;
import com.salesmanager.core.business.payments.service.PaytmTxnResponseService;
import com.salesmanager.core.business.reference.country.model.Country;
import com.salesmanager.core.business.reference.country.service.CountryService;
import com.salesmanager.core.business.reference.language.model.Language;
import com.salesmanager.core.business.reference.zone.model.Zone;
import com.salesmanager.core.business.reference.zone.service.ZoneService;
import com.salesmanager.core.business.shipping.model.ShippingOption;
import com.salesmanager.core.business.shipping.model.ShippingQuote;
import com.salesmanager.core.business.shipping.model.ShippingSummary;
import com.salesmanager.core.business.shipping.service.ShippingService;
import com.salesmanager.core.business.shoppingcart.model.ShoppingCartItem;
import com.salesmanager.core.business.shoppingcart.service.ShoppingCartService;
import com.salesmanager.core.business.system.model.IntegrationConfiguration;
import com.salesmanager.core.business.system.model.IntegrationModule;
import com.salesmanager.core.modules.integration.payment.impl.PaytmCheckout;
import com.salesmanager.core.modules.integration.payment.model.PaymentModule;
import com.salesmanager.core.utils.ajax.AjaxResponse;
import com.salesmanager.web.admin.entity.userpassword.UserReset;
import com.salesmanager.web.constants.Constants;
import com.salesmanager.web.entity.customer.AnonymousCustomer;
import com.salesmanager.web.entity.customer.PersistableCustomer;
import com.salesmanager.web.entity.order.ReadableOrderTotal;
import com.salesmanager.web.entity.order.ReadableShippingSummary;
import com.salesmanager.web.entity.order.ReadableShopOrder;
import com.salesmanager.web.entity.order.ShopOrder;
import com.salesmanager.web.entity.shoppingcart.ShoppingCartData;
import com.salesmanager.web.populator.order.ReadableOrderTotalPopulator;
import com.salesmanager.web.populator.order.ReadableShippingSummaryPopulator;
import com.salesmanager.web.populator.order.ReadableShopOrderPopulator;
import com.salesmanager.web.shop.controller.AbstractController;
import com.salesmanager.web.shop.controller.ControllerConstants;
import com.salesmanager.web.shop.controller.customer.facade.CustomerFacade;
import com.salesmanager.web.shop.controller.order.facade.OrderFacade;
import com.salesmanager.web.shop.controller.shoppingCart.facade.ShoppingCartFacade;
import com.salesmanager.web.utils.EmailTemplatesUtils;
import com.salesmanager.web.utils.LabelUtils;
import com.salesmanager.web.utils.SMSTemplateUtils;


/**
 * Displays checkout form and deals with ajax user input
 * @author carlsamson
 *
 */
@SuppressWarnings("deprecation")
@Controller
@RequestMapping(Constants.SHOP_URI+"/order")
public class ShoppingOrderController extends AbstractController {
	
	private static final Logger LOGGER = LoggerFactory
	.getLogger(ShoppingOrderController.class);
	
	@Autowired
	private ShoppingCartFacade shoppingCartFacade;
	
    @Autowired
    private ShoppingCartService shoppingCartService;

	@Autowired
	private PaymentService paymentService;
	
	@Autowired
	private CustomerService customerService;
	
	@Autowired
	private ShippingService shippingService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private CountryService countryService;
	
	@Autowired
	private ZoneService zoneService;
	
	@Autowired
	private OrderFacade orderFacade;
	
	@Autowired
	private CustomerFacade customerFacade;
	
	@Autowired
	private LabelUtils messages;
	
	@Autowired
	private PricingService pricingService;
	
	@Autowired
	private PromotionalVoucherService promotionalVoucherService;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
    private AuthenticationManager customerAuthenticationManager;
	
	@Autowired
	private EmailTemplatesUtils emailTemplatesUtils;
	
	@Autowired
	private OrderProductDownloadService orderProdctDownloadService;
	
	@Autowired
	private AtomTxnResponseService atomTxnResponseService;
	
	@Autowired
	private PaytmTxnResponseService paytmTxnResponseService;
	
	@Autowired
	private SMSTemplateUtils smsTemplateUtils;
	
	/*
	 * Paytm response handle
	 */
	@RequestMapping(value="/txpResponse.html", method=RequestMethod.POST)
	public String txpResponse(@CookieValue("cart") String cookie, Model model, HttpServletRequest request, HttpServletResponse response, Locale locale) throws Exception {
		Language language = (Language)request.getAttribute("LANGUAGE");
		MerchantStore store = (MerchantStore)request.getAttribute(Constants.MERCHANT_STORE);
		Customer customer = (Customer)request.getSession().getAttribute(Constants.CUSTOMER);
		Transaction transaction = super.getSessionAttribute(Constants.INIT_TRANSACTION_KEY, request);
		ShopOrder order = super.getSessionAttribute(Constants.ORDER, request);
		try{
			PaymentModule module = paymentService.getPaymentModule("paytm");
			
			PaytmCheckout paytmCheckout = (PaytmCheckout) module;
			IntegrationConfiguration config = paymentService.getPaymentConfiguration(order.getPaymentModule(), store);
			IntegrationModule integrationModule = paymentService.getPaymentMethodByCode(store, order.getPaymentModule());
			TreeMap<String,String> parameters = new TreeMap<String,String>();
			String checksumHash = null;
			Enumeration<String> paramNames = request.getParameterNames();
			Map<String, String[]> mapData = request.getParameterMap();
			while(paramNames.hasMoreElements()) {
				String paramName = (String)paramNames.nextElement();
				if(paramName.equals("CHECKSUMHASH")){
					checksumHash = mapData.get(paramName)[0];
				}else{
					parameters.put(paramName,mapData.get(paramName)[0]);
				}
			}
			boolean flag = paytmCheckout.verifyChecksumHash(checksumHash, parameters, config, integrationModule);
			PaytmTxnResponse paytmTxnResponse = new PaytmTxnResponse();
			paytmTxnResponse.setChecksum(checksumHash);
			paytmTxnResponse.setBankName(request.getParameter("BANKNAME"));
			paytmTxnResponse.setBankTxnId(request.getParameter("BANKTXNID"));
			paytmTxnResponse.setCurrency(request.getParameter("CURRENCY"));
			paytmTxnResponse.setGatewayName(request.getParameter("GATEWAYNAME"));
			paytmTxnResponse.setMid(request.getParameter("MID"));
			paytmTxnResponse.setMerchantOrderId(request.getParameter("ORDERID"));
			paytmTxnResponse.setPaymentMode(request.getParameter("PAYMENTMODE"));
			paytmTxnResponse.setRespCode(request.getParameter("RESPCODE"));
			paytmTxnResponse.setRespMsg(request.getParameter("RESPMSG"));
			paytmTxnResponse.setStatus(request.getParameter("STATUS"));
			paytmTxnResponse.setTxnAmt(request.getParameter("TXNAMOUNT"));
			paytmTxnResponse.setTxnDate(request.getParameter("TXNDATE"));
			paytmTxnResponse.setTxnId(request.getParameter("TXNID"));
			paytmTxnResponseService.create(paytmTxnResponse);
			order.setPaytmTxnResponse(paytmTxnResponse);
			order.setPaymentType(PaymentType.PAYTM);
			if(flag && parameters.containsKey("RESPCODE")){
				if(parameters.get("RESPCODE").equals("01")){
					//Success
					return "redirect:/shop/order/commitOrderCheckout.html";
				}else{
					//failure
					model.addAttribute("transactionResponse","failure");
					return displayCheckout(cookie, model, request, response, locale);
				}
			}else{
				//Checksum Failed
				model.addAttribute("transactionResponse","failure");
				return displayCheckout(cookie, model, request, response, locale);
			}
		}catch (Exception e) {
			LOGGER.error("A critical error occured while performing transaction");
			e.printStackTrace();
			String defaultMessage = messages.getMessage("message.error", locale);
        	model.addAttribute("errorMessages", defaultMessage);
	        return "redirect:/shop/order/confirmation.html";
		}
	}
	
	@RequestMapping(value="/txResponse.html", method=RequestMethod.POST)
	public String txResponse(@CookieValue("cart") String cookie, Model model, HttpServletRequest request, HttpServletResponse response, Locale locale) throws Exception {
		Language language = (Language)request.getAttribute("LANGUAGE");
		MerchantStore store = (MerchantStore)request.getAttribute(Constants.MERCHANT_STORE);
		Customer customer = (Customer)request.getSession().getAttribute(Constants.CUSTOMER);
		Transaction transaction = super.getSessionAttribute(Constants.INIT_TRANSACTION_KEY, request);
		try{
			if(transaction == null){
				LOGGER.error("User session expired! Cannot proceed with transaction.");
			}
			String txnId = request.getParameter("mer_txn");
			if(txnId == null){
				LOGGER.error("PG response is tampered.");
			}
			if(!txnId.equals(transaction.getMerchantTransactionId())){
				LOGGER.error("PG response is tampered.");
			}
			AtomTxnResponse atomTxnResponse = new AtomTxnResponse();
			if(request.getParameter("amt") != null){
				atomTxnResponse.setAmt(new BigDecimal(request.getParameter("amt")));
			}
			atomTxnResponse.setMmpTxn(request.getParameter("mmp_txn"));
			atomTxnResponse.setMertxn(request.getParameter("mer_txn"));
			atomTxnResponse.setProdId(request.getParameter("prod"));
			atomTxnResponse.setDate(request.getParameter("date"));
			atomTxnResponse.setBankTxn(request.getParameter("bank_txn"));
			atomTxnResponse.setfCode(request.getParameter("f_code"));
			atomTxnResponse.setClientCode(request.getParameter("clientcode"));
			atomTxnResponse.setBankName(request.getParameter("bank_name"));
			atomTxnResponse.setMerchantId(request.getParameter("merchant_id"));
			atomTxnResponse.setUdf9(request.getParameter("udf9"));
			atomTxnResponse.setDiscriminator(request.getParameter("discriminator"));
			atomTxnResponse.setSurcharge(request.getParameter("surcharge"));
			atomTxnResponse.setCardNumber(request.getParameter("CardNumber"));
			atomTxnResponse.setUdf1(request.getParameter("udf1"));
			atomTxnResponse.setUdf2(request.getParameter("udf2"));
			atomTxnResponse.setUdf3(request.getParameter("udf3"));
			atomTxnResponse.setUdf4(request.getParameter("udf4"));
			atomTxnResponse.setUdf5(request.getParameter("udf5"));
			atomTxnResponse.setUdf6(request.getParameter("udf6"));
			atomTxnResponse.setDescription(request.getParameter("desc"));
			atomTxnResponseService.save(atomTxnResponse);
			ShopOrder order = super.getSessionAttribute(Constants.ORDER, request);
			order.setAtomTxnResponse(atomTxnResponse);
			order.setPaymentType(PaymentType.ATOM);
			//super.setSessionAttribute(Constants.ATOM_RESPONSE, atomTxnResponse, request);
			if("Ok".equals(request.getParameter("f_code"))){
				return "redirect:/shop/order/commitOrderCheckout.html";
			}else{
				model.addAttribute("transactionResponse","failure");
				return displayCheckout(cookie, model, request, response, locale);
			}
		}catch (Exception e) {
			LOGGER.error("A critical error occured while performing transaction");
			e.printStackTrace();
			String defaultMessage = messages.getMessage("message.error", locale);
        	model.addAttribute("errorMessages", defaultMessage);
	        return "redirect:/shop/order/confirmation.html";
		}
	}
	
	@RequestMapping("/commitOrderCheckout.html")
	public String commitOrder(@CookieValue("cart") String cookie, Model model, HttpServletRequest request, HttpServletResponse response, Locale locale) throws Exception {

		MerchantStore store = (MerchantStore)request.getAttribute(Constants.MERCHANT_STORE);
		Language language = (Language)request.getAttribute("LANGUAGE");
		try {
				ShopOrder order = super.getSessionAttribute(Constants.ORDER, request);
				//basic stuff
				String shoppingCartCode  = (String)request.getSession().getAttribute(Constants.SHOPPING_CART);
				if(shoppingCartCode==null) {
					
					if(cookie==null) {//session expired and cookie null, nothing to do
						StringBuilder template = new StringBuilder().append(ControllerConstants.Tiles.Pages.timeout).append(".").append(store.getStoreTemplate());
						return template.toString();
					}
					String merchantCookie[] = cookie.split("_");
					String merchantStoreCode = merchantCookie[0];
					if(!merchantStoreCode.equals(store.getCode())) {
						StringBuilder template = new StringBuilder().append(ControllerConstants.Tiles.Pages.timeout).append(".").append(store.getStoreTemplate());
						return template.toString();
					}
					shoppingCartCode = merchantCookie[1];
				}
				com.salesmanager.core.business.shoppingcart.model.ShoppingCart cart = null;
			
			    if(StringUtils.isBlank(shoppingCartCode)) {
					StringBuilder template = new StringBuilder().append(ControllerConstants.Tiles.Pages.timeout).append(".").append(store.getStoreTemplate());
					return template.toString();	
			    }
			    cart = shoppingCartFacade.getShoppingCartModel(shoppingCartCode, store);

				Set<ShoppingCartItem> items = cart.getLineItems();
				List<ShoppingCartItem> cartItems = new ArrayList<ShoppingCartItem>(items);
				order.setShoppingCartItems(cartItems);

				//get payment methods
				List<PaymentMethod> paymentMethods = paymentService.getAcceptedPaymentMethods(store);
				boolean freeShoppingCart = shoppingCartService.isFreeShoppingCart(cart);

				//not free and no payment methods
				if(CollectionUtils.isEmpty(paymentMethods) && !freeShoppingCart) {
					LOGGER.error("No payment method configured");
					model.addAttribute("errorMessages", "No payments configured");
				}
				
				if(!CollectionUtils.isEmpty(paymentMethods)) {//select default payment method
					PaymentMethod defaultPaymentSelected = null;
					for(PaymentMethod paymentMethod : paymentMethods) {
						if(paymentMethod.isDefaultSelected()) {
							defaultPaymentSelected = paymentMethod;
							break;
						}
					}
					
					if(defaultPaymentSelected==null) {//forced default selection
						defaultPaymentSelected = paymentMethods.get(0);
						defaultPaymentSelected.setDefaultSelected(true);
					}
					
					
				}
				
				/*ShippingQuote quote = orderFacade.getShippingQuote(order.getCustomer(), cart, order, store, language);
				model.addAttribute("shippingQuote", quote);
				model.addAttribute("paymentMethods", paymentMethods);
				
				if(quote!=null) {
					List<Country> shippingCountriesList = orderFacade.getShipToCountry(store, language);
					model.addAttribute("countries", shippingCountriesList);
				} else {
					//get all countries
					List<Country> countries = countryService.getCountries(language);
					model.addAttribute("countries", countries);
				}*/
				
				//set shipping summary
				/*if(order.getSelectedShippingOption()!=null) {
					ShippingSummary summary = (ShippingSummary)request.getSession().getAttribute(Constants.SHIPPING_SUMMARY);
					@SuppressWarnings("unchecked")
					List<ShippingOption> options = (List<ShippingOption>)request.getSession().getAttribute(Constants.SHIPPING_OPTIONS);
					
					if(summary==null) {
						summary = orderFacade.getShippingSummary(quote, store, language);
						request.getSession().setAttribute(Constants.SHIPPING_SUMMARY, options);
					}
					
					if(options==null) {
						options = quote.getShippingOptions();
						request.getSession().setAttribute(Constants.SHIPPING_OPTIONS, options);
					}

					ReadableShippingSummary readableSummary = new ReadableShippingSummary();
					ReadableShippingSummaryPopulator readableSummaryPopulator = new ReadableShippingSummaryPopulator();
					readableSummaryPopulator.setPricingService(pricingService);
					readableSummaryPopulator.populate(summary, readableSummary, store, language);
					
					
					if(!CollectionUtils.isEmpty(options)) {
					
						//get submitted shipping option
						ShippingOption quoteOption = null;
						ShippingOption selectedOption = order.getSelectedShippingOption();

						//check if selectedOption exist
						for(ShippingOption shipOption : options) {
							if(!StringUtils.isBlank(shipOption.getOptionId()) && shipOption.getOptionId().equals(selectedOption.getOptionId())) {
								quoteOption = shipOption;
							}
						}
						if(quoteOption==null) {
							quoteOption = options.get(0);
						}
						
						readableSummary.setSelectedShippingOption(quoteOption);
						readableSummary.setShippingOptions(options);
						summary.setShippingOption(quoteOption.getOptionId());
						summary.setShipping(quoteOption.getOptionPrice());
					
					}

					order.setShippingSummary(summary);
				}*/
				
				OrderTotalSummary totalSummary = super.getSessionAttribute(Constants.ORDER_SUMMARY, request);
				
				if(totalSummary==null) {
					totalSummary = orderFacade.calculateOrderTotal(store, order, language);
					super.setSessionAttribute(Constants.ORDER_SUMMARY, totalSummary, request);
				}
				
				
				order.setOrderTotalSummary(totalSummary);
				
			
		        @SuppressWarnings("unused")
				Order modelOrder = this.commitOrder(order, request, locale);

	        
			} catch(ServiceException se) {


            	LOGGER.error("Error while creating an order ", se);
            	
            	String defaultMessage = messages.getMessage("message.error", locale);
            	model.addAttribute("errorMessages", defaultMessage);
            	
            	if(se.getExceptionType()==ServiceException.EXCEPTION_VALIDATION) {
            		if(!StringUtils.isBlank(se.getMessageCode())) {
            			String messageLabel = messages.getMessage(se.getMessageCode(), locale, defaultMessage);
            			model.addAttribute("errorMessages", messageLabel);
            		}
            	} else if(se.getExceptionType()==ServiceException.EXCEPTION_PAYMENT_DECLINED) {
            		String paymentDeclinedMessage = messages.getMessage("message.payment.declined", locale);
            		if(!StringUtils.isBlank(se.getMessageCode())) {
            			String messageLabel = messages.getMessage(se.getMessageCode(), locale, paymentDeclinedMessage);
            			model.addAttribute("errorMessages", messageLabel);
            		} else {
            			model.addAttribute("errorMessages", paymentDeclinedMessage);
            		}
            	}
            	
            	
            	
            	StringBuilder template = new StringBuilder().append(ControllerConstants.Tiles.Checkout.checkout).append(".").append(store.getStoreTemplate());
	    		return template.toString();
				
			} catch(Exception e) {
				LOGGER.error("Error while commiting order",e);
				throw e;		
				
			}

	        //redirect to completd
	        return "redirect:/shop/order/confirmation.html";
	}
	
	
	@SuppressWarnings("unused")
	@RequestMapping("/checkout.html")
	public String checkoutPage(@CookieValue("cart") String cookie, Model model, HttpServletRequest request, HttpServletResponse response, Locale locale) throws Exception{
		return displayCheckout(cookie, model, request, response, locale);
	}
	
	public String displayCheckout(String cookie, Model model, HttpServletRequest request, HttpServletResponse response, Locale locale) throws Exception {

		Language language = (Language)request.getAttribute("LANGUAGE");
		MerchantStore store = (MerchantStore)request.getAttribute(Constants.MERCHANT_STORE);
		Customer customer = (Customer)request.getSession().getAttribute(Constants.CUSTOMER);

		
		/**
		 * Shopping cart
		 * 
		 * ShoppingCart should be in the HttpSession
		 * Otherwise the cart id is in the cookie
		 * Otherwise the customer is in the session and a cart exist in the DB
		 * Else -> Nothing to display
		 */
		
		//check if an existing order exist
		ShopOrder order = null;
		order = super.getSessionAttribute(Constants.ORDER, request);
	
		//Get the cart from the DB
		String shoppingCartCode  = (String)request.getSession().getAttribute(Constants.SHOPPING_CART);
		com.salesmanager.core.business.shoppingcart.model.ShoppingCart cart = null;
	
	    if(StringUtils.isBlank(shoppingCartCode)) {
				
			if(cookie==null) {//session expired and cookie null, nothing to do
				return "redirect:/shop/cart/shoppingCart.html";
			}
			String merchantCookie[] = cookie.split("_");
			String merchantStoreCode = merchantCookie[0];
			if(!merchantStoreCode.equals(store.getCode())) {
				return "redirect:/shop/cart/shoppingCart.html";
			}
			shoppingCartCode = merchantCookie[1];
	    	
	    } 
	    
	    cart = shoppingCartFacade.getShoppingCartModel(shoppingCartCode, store);
	
	    if(cart==null && customer!=null) {
				cart=shoppingCartFacade.getShoppingCartModel(customer, store);
	    }
	    
	    super.setSessionAttribute(Constants.SHOPPING_CART, cart.getShoppingCartCode(), request);
	
	    if(shoppingCartCode==null && cart==null) {//error
				return "redirect:/shop/cart/shoppingCart.html";
	    }
			
	    if(customer!=null) {
			if(cart.getCustomerId()!=customer.getId().longValue()) {
					return "redirect:/shop/shoppingCart.html";
			}
	     } else {
				customer = orderFacade.initEmptyCustomer(store);
				AnonymousCustomer anonymousCustomer = (AnonymousCustomer)request.getAttribute(Constants.ANONYMOUS_CUSTOMER);
				if(anonymousCustomer!=null && anonymousCustomer.getBilling()!=null) {
					Billing billing = customer.getBilling();
					billing.setCity(anonymousCustomer.getBilling().getCity());
					Map<String,Country> countriesMap = countryService.getCountriesMap(language);
					Country anonymousCountry = countriesMap.get(anonymousCustomer.getBilling().getCountry());
					if(anonymousCountry!=null) {
						billing.setCountry(anonymousCountry);
					}
					Map<String,Zone> zonesMap = zoneService.getZones(language);
					Zone anonymousZone = zonesMap.get(anonymousCustomer.getBilling().getZone());
					if(anonymousZone!=null) {
						billing.setZone(anonymousZone);
					}
					if(anonymousCustomer.getBilling().getPostalCode()!=null) {
						billing.setPostalCode(anonymousCustomer.getBilling().getPostalCode());
					}
					customer.setBilling(billing);
				}
	     }
	
	     Set<ShoppingCartItem> items = cart.getLineItems();
	     if(CollectionUtils.isEmpty(items)) {
				return "redirect:/shop/shoppingCart.html";
	     }
		
	     if(order==null) {
			order = orderFacade.initializeOrder(store, customer, cart, language);
		  }

		boolean freeShoppingCart = shoppingCartService.isFreeShoppingCart(cart);
		boolean requiresShipping = shoppingCartService.requiresShipping(cart);
		
		/** shipping **/
		ShippingQuote quote = null;
		if(requiresShipping) {
			quote = orderFacade.getShippingQuote(customer, cart, order, store, language);
			model.addAttribute("shippingQuote", quote);
		}

		if(quote!=null) {

			if(StringUtils.isBlank(quote.getShippingReturnCode())) {
			
				if(order.getShippingSummary()==null) {
					ShippingSummary summary = orderFacade.getShippingSummary(quote, store, language);
					order.setShippingSummary(summary);
					request.getSession().setAttribute(Constants.SHIPPING_SUMMARY, summary);
				}
				if(order.getSelectedShippingOption()==null) {
					order.setSelectedShippingOption(quote.getSelectedShippingOption());
				}
				
				//save quotes in HttpSession
				List<ShippingOption> options = quote.getShippingOptions();
				request.getSession().setAttribute(Constants.SHIPPING_OPTIONS, options);
			
			}
			
			
			//get shipping countries
			List<Country> shippingCountriesList = orderFacade.getShipToCountry(store, language);
			model.addAttribute("countries", shippingCountriesList);
		} else {
			//get all countries
			List<Country> countries = countryService.getCountries(language);
			model.addAttribute("countries", countries);
		}
		
		if(quote!=null && quote.getShippingReturnCode()!=null && quote.getShippingReturnCode().equals(ShippingQuote.NO_SHIPPING_MODULE_CONFIGURED)) {
			LOGGER.error("Shipping quote error " + quote.getShippingReturnCode());
			model.addAttribute("errorMessages", quote.getShippingReturnCode());
		}
		
		if(quote!=null && !StringUtils.isBlank(quote.getQuoteError())) {
			LOGGER.error("Shipping quote error " + quote.getQuoteError());
			model.addAttribute("errorMessages", quote.getQuoteError());
		}
		
		if(quote!=null && quote.getShippingReturnCode()!=null && quote.getShippingReturnCode().equals(ShippingQuote.NO_SHIPPING_TO_SELECTED_COUNTRY)) {
			LOGGER.error("Shipping quote error " + quote.getShippingReturnCode());
			model.addAttribute("errorMessages", quote.getShippingReturnCode());
		}
		/** end shipping **/

		//get payment methods
		List<PaymentMethod> paymentMethods = paymentService.getAcceptedPaymentMethods(store);

		//not free and no payment methods
		if(CollectionUtils.isEmpty(paymentMethods) && !freeShoppingCart) {
			LOGGER.error("No payment method configured");
			model.addAttribute("errorMessages", "No payments configured");
		}
		
		if(!CollectionUtils.isEmpty(paymentMethods)) {//select default payment method
			PaymentMethod defaultPaymentSelected = null;
			for(PaymentMethod paymentMethod : paymentMethods) {
				if(paymentMethod.isDefaultSelected()) {
					defaultPaymentSelected = paymentMethod;
					break;
				}
			}
			
			if(defaultPaymentSelected==null) {//forced default selection
				defaultPaymentSelected = paymentMethods.get(0);
				defaultPaymentSelected.setDefaultSelected(true);
			}
			
			
		}
		
		if(cart.getPromotionalVoucher() != null){
			order.setPromotionalVoucher(cart.getPromotionalVoucher());
		}
		//order total
		OrderTotalSummary orderTotalSummary = orderFacade.calculateOrderTotal(store, order, language);
		order.setOrderTotalSummary(orderTotalSummary);
		
		items = new HashSet<>(order.getShoppingCartItems());
	    cart.setLineItems(items);
		//readable shopping cart items for order summary box
        ShoppingCartData shoppingCart = shoppingCartFacade.getShoppingCartData(cart);
        model.addAttribute( "cart", shoppingCart );
        
		//if order summary has to be re-used
		super.setSessionAttribute(Constants.ORDER_SUMMARY, orderTotalSummary, request);
		super.setSessionAttribute(Constants.ORDER, order, request);

		model.addAttribute("order",order);
		model.addAttribute("paymentMethods", paymentMethods);
		
		/** template **/
		StringBuilder template = new StringBuilder().append(ControllerConstants.Tiles.Checkout.checkout).append(".").append(store.getStoreTemplate());
		return template.toString();
	}
	
	@RequestMapping(value="/getShoppingCart.html", method=RequestMethod.GET, produces="application/json")
	public @ResponseBody ShoppingCartData getShoppingCart(@CookieValue("cart") String cookie, @RequestParam("code") String promoCode, HttpServletRequest request, HttpServletResponse response, Locale locale){
		MerchantStore store = (MerchantStore)request.getAttribute(Constants.MERCHANT_STORE);
		String shoppingCartCode  = (String)request.getSession().getAttribute(Constants.SHOPPING_CART);
		 Customer customer = getSessionAttribute(  Constants.CUSTOMER, request );
		ShoppingCartData shoppingCart = null;
		try{
			if(shoppingCartCode==null) {
				String merchantCookie[] = cookie.split("_");
				String merchantStoreCode = merchantCookie[0];
				if(!merchantStoreCode.equals(store.getCode())) {
					LOGGER.info("Cookie tampered detected !!!");
					//return resp.toJSONString();
				}
				shoppingCartCode = merchantCookie[1];
			}
			shoppingCart = shoppingCartFacade.getShoppingCartData(customer,store,shoppingCartCode);
		}catch (Exception e) {
			
		}
		
		return shoppingCart;
	}
	
	
	@RequestMapping("/commitPreAuthorized.html")
	public String commitPreAuthorizedOrder(Model model, HttpServletRequest request, HttpServletResponse response, Locale locale) throws Exception {
		
		MerchantStore store = (MerchantStore)request.getAttribute(Constants.MERCHANT_STORE);
		Language language = (Language)request.getAttribute("LANGUAGE");
		ShopOrder order = super.getSessionAttribute(Constants.ORDER, request);
		if(order==null) {
			StringBuilder template = new StringBuilder().append(ControllerConstants.Tiles.Pages.timeout).append(".").append(store.getStoreTemplate());
			return template.toString();	
		}
		

		
		try {
			
			OrderTotalSummary totalSummary = super.getSessionAttribute(Constants.ORDER_SUMMARY, request);
			
			if(totalSummary==null) {
				totalSummary = orderFacade.calculateOrderTotal(store, order, language);
				super.setSessionAttribute(Constants.ORDER_SUMMARY, totalSummary, request);
			}
			
			
			order.setOrderTotalSummary(totalSummary);
			
			//already validated, proceed with commit
			Order orderModel = this.commitOrder(order, request, locale);
			super.setSessionAttribute(Constants.ORDER_ID, orderModel.getId(), request);
			
			return "redirect://shop/order/confirmation.html";
			
		} catch(Exception e) {
			LOGGER.error("Error while commiting order",e);
			throw e;		
			
		}

	}
	
	
	private Order commitOrder(ShopOrder order, HttpServletRequest request, Locale locale) throws Exception, ServiceException {
		
		
			MerchantStore store = (MerchantStore)request.getAttribute(Constants.MERCHANT_STORE);
			Language language = (Language)request.getAttribute("LANGUAGE");
			
			
			String userName = null;
			String password = null;
			
			PersistableCustomer customer = order.getCustomer();
			
	        /** set username and password to persistable object **/
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			Customer authCustomer = null;
        	if(auth != null &&
	        		 request.isUserInRole("AUTH_CUSTOMER")) {
        		authCustomer = customerFacade.getCustomerByUserName(auth.getName(), store);
        		//set id and authentication information
        		customer.setUserName(authCustomer.getNick());
        		customer.setEncodedPassword(authCustomer.getPassword());
        		customer.setId(authCustomer.getId());
        		//customer.setBilling(authCustomer.getBilling());
        		//customer.setDelivery(authCustomer.getDelivery());
	        } else {
	        	//set customer id to null
	        	customer.setId(null);
	        }
		
	        //if the customer is new, generate a password
	        if(customer.getId()==null || customer.getId()==0) {//new customer
	        	password = UserReset.generateRandomString();
	        	String encodedPassword = passwordEncoder.encodePassword(password, null);
	        	customer.setEncodedPassword(encodedPassword);
	        }
	        
	        if(order.isShipToBillingAdress()) {
	        	customer.setDelivery(customer.getBilling());
	        }
	        


			Customer modelCustomer = null;
			try {//set groups
				if(authCustomer==null) {//not authenticated, create a new volatile user
					modelCustomer = customerFacade.getCustomerModel(customer, store, language);
					customerFacade.setCustomerModelDefaultProperties(modelCustomer, store);
					userName = modelCustomer.getNick();
					LOGGER.debug( "About to persist volatile customer to database." );
			        customerService.saveOrUpdate( modelCustomer );
				} else {//use existing customer
					modelCustomer = customerFacade.populateCustomerModel(authCustomer, customer, store, language);
				}
			} catch(Exception e) {
				throw new ServiceException(e);
			}
	        
           
	        
	        Order modelOrder = null;
	        Transaction initialTransaction = (Transaction)super.getSessionAttribute(Constants.INIT_TRANSACTION_KEY, request);
	        if(initialTransaction!=null) {
	        	modelOrder=orderFacade.processOrder(order, modelCustomer, initialTransaction, store, language);
	        } else {
	        	modelOrder=orderFacade.processOrder(order, modelCustomer, store, language);
	        }
	        
	        //save order id in session
	        super.setSessionAttribute(Constants.ORDER_ID, modelOrder.getId(), request);
	        //set a unique token for confirmation
	        super.setSessionAttribute(Constants.ORDER_ID_TOKEN, modelOrder.getId(), request);
	        

			//get cart
			String cartCode = super.getSessionAttribute(Constants.SHOPPING_CART, request);
			if(StringUtils.isNotBlank(cartCode)) {
				try {
					shoppingCartFacade.deleteShoppingCart(cartCode, store);
				} catch(Exception e) {
					LOGGER.error("Cannot delete cart " + cartCode, e);
					throw new ServiceException(e);
				}
			}
			if(order.getPaymentType() != null){
				if(order.getPaymentType() == PaymentType.ATOM && order.getAtomTxnResponse() != null){
					AtomTxnResponse atomTxnResponse = order.getAtomTxnResponse();
					atomTxnResponse.setOrder(modelOrder);
					this.atomTxnResponseService.update(atomTxnResponse);
				}else if(order.getPaymentType() == PaymentType.PAYTM && order.getPaytmTxnResponse() != null){
					PaytmTxnResponse paytmTxnResponse = order.getPaytmTxnResponse();
					paytmTxnResponse.setOrder(modelOrder);
					this.paytmTxnResponseService.update(paytmTxnResponse);
				}
			}
			/*AtomTxnResponse atomTxnResponse = super.getSessionAttribute(Constants.ATOM_RESPONSE, request);
			if(atomTxnResponse != null){
				atomTxnResponse.setOrder(modelOrder);
				this.atomTxnResponseService.update(atomTxnResponse);
			}*/
	        //cleanup the order objects
	        super.removeAttribute(Constants.ORDER, request);
	        super.removeAttribute(Constants.ORDER_SUMMARY, request);
	        super.removeAttribute(Constants.INIT_TRANSACTION_KEY, request);
	        super.removeAttribute(Constants.SHIPPING_OPTIONS, request);
	        super.removeAttribute(Constants.SHIPPING_SUMMARY, request);
	        super.removeAttribute(Constants.SHOPPING_CART, request);
	        //super.removeAttribute(Constants.ATOM_RESPONSE, request);
	        
	        

	        try {
		        //refresh customer --
	        	modelCustomer = customerFacade.getCustomerByUserName(modelCustomer.getNick(), store);
		        
	        	//if has downloads, authenticate
	        	
	        	//check if any downloads exist for this order6
	    		List<OrderProductDownload> orderProductDownloads = orderProdctDownloadService.getByOrderId(modelOrder.getId());
	    		if(CollectionUtils.isNotEmpty(orderProductDownloads)) {

		        	LOGGER.debug("Is user authenticated ? ",auth.isAuthenticated());
		        	if(auth != null &&
			        		 request.isUserInRole("AUTH_CUSTOMER")) {
			        	//already authenticated
			        } else {
				        //authenticate
				        customerFacade.authenticate(modelCustomer, userName, password);
				        super.setSessionAttribute(Constants.CUSTOMER, modelCustomer, request);
			        }
		        	//send new user registration template
					if(order.getCustomer().getId()==null || order.getCustomer().getId().longValue()==0) {
						//send email for new customer
						customer.setClearPassword(password);//set clear password for email
						customer.setUserName(userName);
						emailTemplatesUtils.sendRegistrationEmail( customer, store, locale, request.getContextPath() );
					}
	    		}
	    		
				//send order confirmation email
				emailTemplatesUtils.sendOrderEmail(modelCustomer, modelOrder, locale, language, store, request.getContextPath());
				smsTemplateUtils.sendOrderMessage(modelCustomer, modelOrder, locale, language, store, request.getContextPath());
		        
		        if(orderService.hasDownloadFiles(modelOrder)) {
		        	emailTemplatesUtils.sendOrderDownloadEmail(modelCustomer, modelOrder, store, locale, request.getContextPath());
		
		        }
	    		
	    		
	        } catch(Exception e) {
	        	LOGGER.error("Error while post processing order",e);
	        }
	        return modelOrder;
	}

@PreAuthorize("hasRole('AUTH_CUSTOMER')")
@RequestMapping(value="/applyPromotions.html", method=RequestMethod.POST, produces="application/json", consumes="application/x-www-form-urlencoded")
public @ResponseBody ShoppingCartData applyPromotion(@CookieValue("cart") String cookie, @RequestParam("code") String promoCode, HttpServletRequest request, HttpServletResponse response, Locale locale){
	MerchantStore store = (MerchantStore)request.getAttribute(Constants.MERCHANT_STORE);
	Language language = (Language)request.getAttribute("LANGUAGE");
	request.getAttribute(Constants.SHOPPING_CART);
	ShoppingCartData shoppingCart = null;
	try{
		String shoppingCartCode  = (String)request.getSession().getAttribute(Constants.SHOPPING_CART);
		if(shoppingCartCode==null) {
			
			if(cookie==null || StringUtils.isBlank(shoppingCartCode)) {
				LOGGER.info("Cookie Cleared !!!");
				shoppingCart = new ShoppingCartData();
				shoppingCart.setStatus(AjaxResponse.RESPONSE_STATUS_FAIURE);
				shoppingCart.setMessage("Server error while processing request.");
				return shoppingCart;
			}
			String merchantCookie[] = cookie.split("_");
			String merchantStoreCode = merchantCookie[0];
			if(!merchantStoreCode.equals(store.getCode())) {
				LOGGER.info("Cookie tampered detected !!!");
				shoppingCart = new ShoppingCartData();
				shoppingCart.setStatus(AjaxResponse.RESPONSE_STATUS_FAIURE);
				shoppingCart.setMessage("Server error while processing request.");
				return shoppingCart;
			}
			shoppingCartCode = merchantCookie[1];
		}
		com.salesmanager.core.business.shoppingcart.model.ShoppingCart cart = null;
	    
	    //Validate Promo code entered by user
	    //String promoCode = request.getParameter("code");
	    if(StringUtils.isBlank(promoCode)){
	    	LOGGER.info("promo code not entered by user");
	    	shoppingCart = new ShoppingCartData();
			shoppingCart.setStatus(AjaxResponse.RESPONSE_STATUS_FAIURE);
			shoppingCart.setMessage("Please enter promo code.");
			return shoppingCart;
	    }
	    
	    PromotionalVoucher voucher = this.promotionalVoucherService.getByCode(promoCode, store);
	    
	    if(voucher == null){
	    	LOGGER.info("Promo code not entered by user is invalid");
	    	shoppingCart = new ShoppingCartData();
			shoppingCart.setStatus(AjaxResponse.RESPONSE_STATUS_FAIURE);
			shoppingCart.setMessage("Invalid promo code.");
			return shoppingCart;
	    }
	    
	    cart = shoppingCartFacade.getShoppingCartModel(shoppingCartCode, store);
	    boolean promotionApplied = false;
	    ShopOrder order = super.getSessionAttribute(Constants.ORDER, request);
	    OrderTotalSummary orderTotalSummary = null;
	    if(order != null){
	    	//If promotional voucher is applied on entire cart
	    	if(voucher.getPromotionType() == PromotionType.PER_ORDER){
	    		for(ShoppingCartItem cartItem : order.getShoppingCartItems()){
	    			cartItem.setPromotionalVoucher(voucher);
	    			cartItem.setPromotionApplied(true);
	    			promotionApplied = true;
	    		}
	    	}else if(voucher.getPromotionType() == PromotionType.PER_ITEM){
	    		for(ShoppingCartItem cartItem : order.getShoppingCartItems()){
	    			if(promotionalVoucherService.isPromotionalVoucherApplicable(voucher.getPromoCode(), cartItem.getProductId())){
	    				cartItem.setPromotionalVoucher(voucher);
	    				cartItem.setPromotionApplied(true);
	    				promotionApplied = true;
	    			}
	    		}
	    	}
	    orderTotalSummary = orderFacade.calculateOrderTotal(store, order, language);
	    super.setSessionAttribute(Constants.ORDER_SUMMARY, orderTotalSummary, request);
	    Set<ShoppingCartItem> items = new HashSet<>(order.getShoppingCartItems());
	    cart.setLineItems(items);
	    if(promotionApplied){
	    	cart.setPromotionApplied(true);
	    		cart.setPromotionalVoucher(voucher);
	    }
	    shoppingCart = shoppingCartFacade.getShoppingCartData(cart);
	    }else{
	    	LOGGER.info("Limit reached for user to use promocode.");
	    	shoppingCart = new ShoppingCartData();
			shoppingCart.setStatus(AjaxResponse.RESPONSE_STATUS_FAIURE);
			shoppingCart.setMessage("Invalid promo code.");
			return shoppingCart;
	    }
	    
	}catch (Exception e) {
		LOGGER.error("Error while applying promotions", e);
	}
	return shoppingCart;
}

@PreAuthorize("hasRole('AUTH_CUSTOMER')")
@RequestMapping(value="/removePromotions.html", method=RequestMethod.POST, produces="application/json")
public @ResponseBody ShoppingCartData removePromotion(@CookieValue("cart") String cookie, @RequestParam("code") String promoCode, HttpServletRequest request, HttpServletResponse response, Locale locale){
	ShoppingCartData shoppingCart = null;
	MerchantStore store = (MerchantStore)request.getAttribute(Constants.MERCHANT_STORE);
	Language language = (Language)request.getAttribute("LANGUAGE");
	try{
		String shoppingCartCode  = (String)request.getSession().getAttribute(Constants.SHOPPING_CART);
		if(shoppingCartCode==null) {
			
			if(cookie==null || StringUtils.isBlank(shoppingCartCode)) {//session expired and cookie null, nothing to do
				LOGGER.info("Cookie Cleared !!!");
				shoppingCart = new ShoppingCartData();
				shoppingCart.setStatus(AjaxResponse.RESPONSE_STATUS_FAIURE);
				shoppingCart.setMessage("Server error while processing request.");
				return shoppingCart;
			}
			String merchantCookie[] = cookie.split("_");
			String merchantStoreCode = merchantCookie[0];
			if(!merchantStoreCode.equals(store.getCode())) {
				LOGGER.info("Cookie tampered detected !!!");
				shoppingCart = new ShoppingCartData();
				shoppingCart.setStatus(AjaxResponse.RESPONSE_STATUS_FAIURE);
				shoppingCart.setMessage("Server error while processing request.");
				return shoppingCart;
			}
			shoppingCartCode = merchantCookie[1];
		}
		com.salesmanager.core.business.shoppingcart.model.ShoppingCart cart = null;
		
	    //Validate Promo code entered by user
	    //String promoCode = request.getParameter("code");
	    if(StringUtils.isBlank(promoCode)){
	    	LOGGER.info("promo code not entered by user");
	    	shoppingCart = new ShoppingCartData();
			shoppingCart.setStatus(AjaxResponse.RESPONSE_STATUS_FAIURE);
			shoppingCart.setMessage("Please enter promo code.");
			return shoppingCart;
	    }
	    
	    PromotionalVoucher voucher = this.promotionalVoucherService.getByCode(promoCode, store);
	    
	    if(voucher == null){
	    	LOGGER.info("promo code invalid");
	    	shoppingCart = new ShoppingCartData();
			shoppingCart.setStatus(AjaxResponse.RESPONSE_STATUS_FAIURE);
			shoppingCart.setMessage("Please enter valid promo code.");
			return shoppingCart;
	    }
	    
	    cart = shoppingCartFacade.getShoppingCartModel(shoppingCartCode, store);
	    
	    ShopOrder order = super.getSessionAttribute(Constants.ORDER, request);
	    OrderTotalSummary orderTotalSummary = null;
	    if(order != null){
	    	//Delete promotional voucher reference from cart and cart items
	    	cart.setPromotionalVoucher(null);
	    	cart.setPromotionApplied(false);
	    	for(ShoppingCartItem cartItem : order.getShoppingCartItems()){
	    		cartItem.setPromotionalVoucher(null);
	    		cartItem.setPromotionApplied(false);
	    		cartItem.setDiscountedPrice(BigDecimal.ZERO);
	    	}
	    orderTotalSummary = orderFacade.calculateOrderTotal(store, order, language);
	    super.setSessionAttribute(Constants.ORDER_SUMMARY, orderTotalSummary, request);	
	    Set<ShoppingCartItem> items = new HashSet<>(order.getShoppingCartItems());
	    cart.setLineItems(items);
	    cart.setPromotionApplied(false);
	    cart.setPromotionalVoucher(null);
	    shoppingCart = shoppingCartFacade.getShoppingCartData(cart);
	    }
	    
		shoppingCart.setStatus(AjaxResponse.RESPONSE_OPERATION_COMPLETED);
	}catch (Exception e) {
		LOGGER.error("Error while applying promotions", e);
		shoppingCart.setStatus(AjaxResponse.RESPONSE_STATUS_FAIURE);
		shoppingCart.setMessage("System Error.");
	}
	return shoppingCart;
}
	
	@RequestMapping("/commitOrder.html")
	public String commitOrder(@CookieValue("cart") String cookie, @Valid @ModelAttribute(value="order") ShopOrder order, BindingResult bindingResult, Model model, HttpServletRequest request, HttpServletResponse response, Locale locale) throws Exception {

		MerchantStore store = (MerchantStore)request.getAttribute(Constants.MERCHANT_STORE);
		Language language = (Language)request.getAttribute("LANGUAGE");
		//validate if session has expired
		

			
		try {
				
				//basic stuff
				String shoppingCartCode  = (String)request.getSession().getAttribute(Constants.SHOPPING_CART);
				if(shoppingCartCode==null) {
					
					if(cookie==null) {//session expired and cookie null, nothing to do
						StringBuilder template = new StringBuilder().append(ControllerConstants.Tiles.Pages.timeout).append(".").append(store.getStoreTemplate());
						return template.toString();
					}
					String merchantCookie[] = cookie.split("_");
					String merchantStoreCode = merchantCookie[0];
					if(!merchantStoreCode.equals(store.getCode())) {
						StringBuilder template = new StringBuilder().append(ControllerConstants.Tiles.Pages.timeout).append(".").append(store.getStoreTemplate());
						return template.toString();
					}
					shoppingCartCode = merchantCookie[1];
				}
				com.salesmanager.core.business.shoppingcart.model.ShoppingCart cart = null;
			
			    if(StringUtils.isBlank(shoppingCartCode)) {
					StringBuilder template = new StringBuilder().append(ControllerConstants.Tiles.Pages.timeout).append(".").append(store.getStoreTemplate());
					return template.toString();	
			    }
			    cart = shoppingCartFacade.getShoppingCartModel(shoppingCartCode, store);

				Set<ShoppingCartItem> items = cart.getLineItems();
				List<ShoppingCartItem> cartItems = new ArrayList<ShoppingCartItem>(items);
				order.setShoppingCartItems(cartItems);

				//get payment methods
				List<PaymentMethod> paymentMethods = paymentService.getAcceptedPaymentMethods(store);
				boolean freeShoppingCart = shoppingCartService.isFreeShoppingCart(cart);

				//not free and no payment methods
				if(CollectionUtils.isEmpty(paymentMethods) && !freeShoppingCart) {
					LOGGER.error("No payment method configured");
					model.addAttribute("errorMessages", "No payments configured");
				}
				
				if(!CollectionUtils.isEmpty(paymentMethods)) {//select default payment method
					PaymentMethod defaultPaymentSelected = null;
					for(PaymentMethod paymentMethod : paymentMethods) {
						if(paymentMethod.isDefaultSelected()) {
							defaultPaymentSelected = paymentMethod;
							break;
						}
					}
					
					if(defaultPaymentSelected==null) {//forced default selection
						defaultPaymentSelected = paymentMethods.get(0);
						defaultPaymentSelected.setDefaultSelected(true);
					}
					
					
				}
				
				ShippingQuote quote = orderFacade.getShippingQuote(order.getCustomer(), cart, order, store, language);
				model.addAttribute("shippingQuote", quote);
				model.addAttribute("paymentMethods", paymentMethods);
				
				if(quote!=null) {
					List<Country> shippingCountriesList = orderFacade.getShipToCountry(store, language);
					model.addAttribute("countries", shippingCountriesList);
				} else {
					//get all countries
					List<Country> countries = countryService.getCountries(language);
					model.addAttribute("countries", countries);
				}
				
				//set shipping summary
				if(order.getSelectedShippingOption()!=null) {
					ShippingSummary summary = (ShippingSummary)request.getSession().getAttribute(Constants.SHIPPING_SUMMARY);
					@SuppressWarnings("unchecked")
					List<ShippingOption> options = (List<ShippingOption>)request.getSession().getAttribute(Constants.SHIPPING_OPTIONS);
					
					if(summary==null) {
						summary = orderFacade.getShippingSummary(quote, store, language);
						request.getSession().setAttribute(Constants.SHIPPING_SUMMARY, options);
					}
					
					if(options==null) {
						options = quote.getShippingOptions();
						request.getSession().setAttribute(Constants.SHIPPING_OPTIONS, options);
					}

					ReadableShippingSummary readableSummary = new ReadableShippingSummary();
					ReadableShippingSummaryPopulator readableSummaryPopulator = new ReadableShippingSummaryPopulator();
					readableSummaryPopulator.setPricingService(pricingService);
					readableSummaryPopulator.populate(summary, readableSummary, store, language);
					
					
					if(!CollectionUtils.isEmpty(options)) {
					
						//get submitted shipping option
						ShippingOption quoteOption = null;
						ShippingOption selectedOption = order.getSelectedShippingOption();

						//check if selectedOption exist
						for(ShippingOption shipOption : options) {
							if(!StringUtils.isBlank(shipOption.getOptionId()) && shipOption.getOptionId().equals(selectedOption.getOptionId())) {
								quoteOption = shipOption;
							}
						}
						if(quoteOption==null) {
							quoteOption = options.get(0);
						}
						
						readableSummary.setSelectedShippingOption(quoteOption);
						readableSummary.setShippingOptions(options);
						summary.setShippingOption(quoteOption.getOptionId());
						summary.setShipping(quoteOption.getOptionPrice());
					
					}

					order.setShippingSummary(summary);
				}
				
				OrderTotalSummary totalSummary = super.getSessionAttribute(Constants.ORDER_SUMMARY, request);
				
				if(totalSummary==null) {
					totalSummary = orderFacade.calculateOrderTotal(store, order, language);
					super.setSessionAttribute(Constants.ORDER_SUMMARY, totalSummary, request);
				}
				
				
				order.setOrderTotalSummary(totalSummary);
				
			
				orderFacade.validateOrder(order, bindingResult, new HashMap<String,String>(), store, locale);
		        
		        if ( bindingResult.hasErrors() )
		        {
		            LOGGER.info( "found {} validation error while validating in customer registration ",
		                         bindingResult.getErrorCount() );
		    		StringBuilder template = new StringBuilder().append(ControllerConstants.Tiles.Checkout.checkout).append(".").append(store.getStoreTemplate());
		    		return template.toString();
	
		        }
		        
		        @SuppressWarnings("unused")
				Order modelOrder = this.commitOrder(order, request, locale);

	        
			} catch(ServiceException se) {


            	LOGGER.error("Error while creating an order ", se);
            	
            	String defaultMessage = messages.getMessage("message.error", locale);
            	model.addAttribute("errorMessages", defaultMessage);
            	
            	if(se.getExceptionType()==ServiceException.EXCEPTION_VALIDATION) {
            		if(!StringUtils.isBlank(se.getMessageCode())) {
            			String messageLabel = messages.getMessage(se.getMessageCode(), locale, defaultMessage);
            			model.addAttribute("errorMessages", messageLabel);
            		}
            	} else if(se.getExceptionType()==ServiceException.EXCEPTION_PAYMENT_DECLINED) {
            		String paymentDeclinedMessage = messages.getMessage("message.payment.declined", locale);
            		if(!StringUtils.isBlank(se.getMessageCode())) {
            			String messageLabel = messages.getMessage(se.getMessageCode(), locale, paymentDeclinedMessage);
            			model.addAttribute("errorMessages", messageLabel);
            		} else {
            			model.addAttribute("errorMessages", paymentDeclinedMessage);
            		}
            	}
            	
            	
            	
            	StringBuilder template = new StringBuilder().append(ControllerConstants.Tiles.Checkout.checkout).append(".").append(store.getStoreTemplate());
	    		return template.toString();
				
			} catch(Exception e) {
				LOGGER.error("Error while commiting order",e);
				throw e;		
				
			}

	        //redirect to completd
	        return "redirect:/shop/order/confirmation.html";
	}
	
	

	
	/**
	 * Recalculates shipping and tax following a change in country or province
	 * @param order
	 * @param request
	 * @param response
	 * @param locale
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/shippingQuotes.html"}, method=RequestMethod.POST)
	public @ResponseBody ReadableShopOrder calculateShipping(@ModelAttribute(value="order") ShopOrder order, HttpServletRequest request, HttpServletResponse response, Locale locale) throws Exception {
		
		Language language = (Language)request.getAttribute("LANGUAGE");
		MerchantStore store = (MerchantStore)request.getAttribute(Constants.MERCHANT_STORE);
		String shoppingCartCode  = getSessionAttribute(Constants.SHOPPING_CART, request);
		
		Validate.notNull(shoppingCartCode,"shoppingCartCode does not exist in the session");
		
		ReadableShopOrder readableOrder = new ReadableShopOrder();
		try {

			//re-generate cart
			com.salesmanager.core.business.shoppingcart.model.ShoppingCart cart = shoppingCartFacade.getShoppingCartModel(shoppingCartCode, store);
	
			
			
			ReadableShopOrderPopulator populator = new ReadableShopOrderPopulator();
			populator.populate(order, readableOrder, store, language);
			
			boolean requiresShipping = shoppingCartService.requiresShipping(cart);
			
			/** shipping **/
			ShippingQuote quote = null;
			if(requiresShipping) {
				quote = orderFacade.getShippingQuote(order.getCustomer(), cart, order, store, language);
			}

			if(quote!=null) {
				if(StringUtils.isBlank(quote.getShippingReturnCode())) {
					ShippingSummary summary = orderFacade.getShippingSummary(quote, store, language);
					order.setShippingSummary(summary);//for total calculation
					
					
					ReadableShippingSummary readableSummary = new ReadableShippingSummary();
					ReadableShippingSummaryPopulator readableSummaryPopulator = new ReadableShippingSummaryPopulator();
					readableSummaryPopulator.setPricingService(pricingService);
					readableSummaryPopulator.populate(summary, readableSummary, store, language);
					
					readableSummary.setSelectedShippingOption(quote.getSelectedShippingOption());

					//save quotes in HttpSession
					List<ShippingOption> options = quote.getShippingOptions();
					readableSummary.setShippingOptions(options);
					
					readableOrder.setShippingSummary(readableSummary);
					request.getSession().setAttribute(Constants.SHIPPING_SUMMARY, summary);
					request.getSession().setAttribute(Constants.SHIPPING_OPTIONS, options);
				
				}

				if(quote.getShippingReturnCode()!=null && quote.getShippingReturnCode().equals(ShippingQuote.NO_SHIPPING_MODULE_CONFIGURED)) {
					LOGGER.error("Shipping quote error " + quote.getShippingReturnCode());
					readableOrder.setErrorMessage(messages.getMessage("message.noshipping", locale));
				}
				
				if(quote.getShippingReturnCode()!=null && quote.getShippingReturnCode().equals(ShippingQuote.NO_SHIPPING_TO_SELECTED_COUNTRY)) {
					LOGGER.error("Shipping quote error " + quote.getShippingReturnCode());
					readableOrder.setErrorMessage(messages.getMessage("message.noshipping", locale));
				}
				
				if(!StringUtils.isBlank(quote.getQuoteError())) {
					LOGGER.error("Shipping quote error " + quote.getQuoteError());
					readableOrder.setErrorMessage(messages.getMessage("message.noshippingerror", locale));
				}
				
				
			}
			
			//set list of shopping cart items for core price calculation
			List<ShoppingCartItem> items = new ArrayList<ShoppingCartItem>(cart.getLineItems());
			order.setShoppingCartItems(items);
			
			OrderTotalSummary orderTotalSummary = orderFacade.calculateOrderTotal(store, order, language);
			super.setSessionAttribute(Constants.ORDER_SUMMARY, orderTotalSummary, request);
			
			
			ReadableOrderTotalPopulator totalPopulator = new ReadableOrderTotalPopulator();
			totalPopulator.setMessages(messages);
			totalPopulator.setPricingService(pricingService);

			List<ReadableOrderTotal> subtotals = new ArrayList<ReadableOrderTotal>();
			for(OrderTotal total : orderTotalSummary.getTotals()) {
				if(!total.getOrderTotalCode().equals("order.total.total")) {
					ReadableOrderTotal t = new ReadableOrderTotal();
					totalPopulator.populate(total, t, store, language);
					subtotals.add(t);
				} else {//grand total
					ReadableOrderTotal ot = new ReadableOrderTotal();
					totalPopulator.populate(total, ot, store, language);
					readableOrder.setGrandTotal(ot.getTotal());
				}
			}
			
			
			readableOrder.setSubTotals(subtotals);
		
		} catch(Exception e) {
			LOGGER.error("Error while getting shipping quotes",e);
			readableOrder.setErrorMessage(messages.getMessage("message.error", locale));
		}
		
		return readableOrder;
	}

	/**
	 * Calculates the order total following price variation like changing a shipping option
	 * @param order
	 * @param request
	 * @param response
	 * @param locale
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/calculateOrderTotal.html"}, method=RequestMethod.POST)
	public @ResponseBody ReadableShopOrder calculateOrderTotal(@ModelAttribute(value="order") ShopOrder order, HttpServletRequest request, HttpServletResponse response, Locale locale) throws Exception {
		
		Language language = (Language)request.getAttribute("LANGUAGE");
		MerchantStore store = (MerchantStore)request.getAttribute(Constants.MERCHANT_STORE);
		String shoppingCartCode  = getSessionAttribute(Constants.SHOPPING_CART, request);
		
		Validate.notNull(shoppingCartCode,"shoppingCartCode does not exist in the session");
		
		ReadableShopOrder readableOrder = new ReadableShopOrder();
		try {

			//re-generate cart
			com.salesmanager.core.business.shoppingcart.model.ShoppingCart cart = shoppingCartFacade.getShoppingCartModel(shoppingCartCode, store);

			ReadableShopOrderPopulator populator = new ReadableShopOrderPopulator();
			populator.populate(order, readableOrder, store, language);

			if(order.getSelectedShippingOption()!=null) {
						ShippingSummary summary = (ShippingSummary)request.getSession().getAttribute(Constants.SHIPPING_SUMMARY);
						@SuppressWarnings("unchecked")
						List<ShippingOption> options = (List<ShippingOption>)request.getSession().getAttribute(Constants.SHIPPING_OPTIONS);
						
						
						order.setShippingSummary(summary);//for total calculation
						
						
						ReadableShippingSummary readableSummary = new ReadableShippingSummary();
						ReadableShippingSummaryPopulator readableSummaryPopulator = new ReadableShippingSummaryPopulator();
						readableSummaryPopulator.setPricingService(pricingService);
						readableSummaryPopulator.populate(summary, readableSummary, store, language);
						
						
						if(!CollectionUtils.isEmpty(options)) {
						
							//get submitted shipping option
							ShippingOption quoteOption = null;
							ShippingOption selectedOption = order.getSelectedShippingOption();

							
							
							//check if selectedOption exist
							for(ShippingOption shipOption : options) {
								if(!StringUtils.isBlank(shipOption.getOptionId()) && shipOption.getOptionId().equals(selectedOption.getOptionId())) {
									quoteOption = shipOption;
								}
							}
							
							if(quoteOption==null) {
								quoteOption = options.get(0);
							}
							
							
							readableSummary.setSelectedShippingOption(quoteOption);
							readableSummary.setShippingOptions(options);
							

							summary.setShippingOption(quoteOption.getOptionId());
							summary.setShipping(quoteOption.getOptionPrice());
						
						}

						
						readableOrder.setShippingSummary(readableSummary);

			}
			
			//set list of shopping cart items for core price calculation
			List<ShoppingCartItem> items = new ArrayList<ShoppingCartItem>(cart.getLineItems());
			order.setShoppingCartItems(items);
			
			OrderTotalSummary orderTotalSummary = orderFacade.calculateOrderTotal(store, order, language);
			super.setSessionAttribute(Constants.ORDER_SUMMARY, orderTotalSummary, request);
			
			
			ReadableOrderTotalPopulator totalPopulator = new ReadableOrderTotalPopulator();
			totalPopulator.setMessages(messages);
			totalPopulator.setPricingService(pricingService);

			List<ReadableOrderTotal> subtotals = new ArrayList<ReadableOrderTotal>();
			for(OrderTotal total : orderTotalSummary.getTotals()) {
				if(!total.getOrderTotalCode().equals("order.total.total")) {
					ReadableOrderTotal t = new ReadableOrderTotal();
					totalPopulator.populate(total, t, store, language);
					subtotals.add(t);
				} else {//grand total
					ReadableOrderTotal ot = new ReadableOrderTotal();
					totalPopulator.populate(total, ot, store, language);
					readableOrder.setGrandTotal(ot.getTotal());
				}
			}
			
			
			readableOrder.setSubTotals(subtotals);
		
		} catch(Exception e) {
			LOGGER.error("Error while getting shipping quotes",e);
			readableOrder.setErrorMessage(messages.getMessage("message.error", locale));
		}
		
		return readableOrder;
	}
	
	@PreAuthorize("hasRole('AUTH_CUSTOMER')")
	@RequestMapping(value="/invoice.html", method=RequestMethod.GET, produces="application/json")
	public void generateInvoice(@RequestParam("orderId") String sId, HttpServletRequest request, HttpServletResponse response, Locale locale){

		try {
			
		Long id = Long.parseLong(sId);
		
		MerchantStore store = (MerchantStore)request.getAttribute(Constants.MERCHANT_STORE);
		Order order = orderService.getById(id);
		
		if(order.getMerchant().getId().intValue()!=store.getId().intValue()) {
			throw new Exception("Invalid order");
		}
		

		Language lang = store.getDefaultLanguage();
		
		

		ByteArrayOutputStream stream  = orderService.generateInvoice(store, order, lang);
		StringBuilder attachment = new StringBuilder();
		//attachment.append("attachment; filename=");
		attachment.append(order.getId());
		attachment.append(".pdf");
		
        response.setHeader("Content-disposition", "attachment;filename=" + attachment.toString());

        //Set the mime type for the response
        response.setContentType("application/pdf");

		
		response.getOutputStream().write(stream.toByteArray());
		
		response.flushBuffer();
			
			
		} catch(Exception e) {
			LOGGER.error("Error while printing a report",e);
		}
			
		
	}

}
