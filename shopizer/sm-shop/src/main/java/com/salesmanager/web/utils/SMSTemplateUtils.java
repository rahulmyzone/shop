package com.salesmanager.web.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import com.salesmanager.core.business.customer.model.Customer;
import com.salesmanager.core.business.merchant.model.MerchantStore;
import com.salesmanager.core.business.order.model.Order;
import com.salesmanager.core.business.order.model.orderproduct.OrderProduct;
import com.salesmanager.core.business.reference.language.model.Language;
import com.salesmanager.core.modules.sms.SMSService;
import com.salesmanager.core.modules.sms.UserMessage;
import com.salesmanager.core.modules.sms.UserMessage.Address;
import com.salesmanager.core.modules.sms.UserMessage.UserSMS;
import com.salesmanager.web.entity.catalog.product.ReadableProduct;
import com.salesmanager.web.entity.customer.PersistableCustomer;

@Component
public class SMSTemplateUtils {

	private static final Logger LOGGER = LoggerFactory.getLogger(SMSTemplateUtils.class);
	
	@Autowired
	private SMSService smsService;
	
	@Async
	public void sendOrderMessage(Customer customer, Order order, Locale customerLocale, Language language, MerchantStore merchantStore, String contextPath) {
			   /** issue with putting that elsewhere **/ 
		LOGGER.info( "Sending welcome email to customer" );
	       try {
	    	   for(OrderProduct product : order.getOrderProducts()){
	    		   UserMessage message = new UserMessage();
		    	   message.setSender("PRETTY");
		    	   message.setRoute("4");
		    	   message.setCampaign("Order");
		    	   message.setCountry("91");
		    	   StringBuffer sb = new StringBuffer();
		    	   sb.append("Congratulations ");
		    	   sb.append(customer.getBilling().getFirstName());
		    	   sb.append("! ");
		    	   sb.append("Your order is successful for ");
		    	   sb.append(product.getProductName());
		    	   sb.append(". Your Coupon code is ");
		    	   sb.append(product.getOrderCode().getCode());
		    	   sb.append(" Please show this sms to merchant to avail deal. Prettydeal.in");
		    	   UserSMS sms = new UserSMS();
		    	   sms.setMessage(sb.toString());
		    	   List<UserSMS> list = new ArrayList<UserMessage.UserSMS>();
		    	   Address address = new Address();
		    	   address.setTo(customer.getMobile());
		    	   List<Address> addresses = new ArrayList<>();
		    	   addresses.add(address);
		    	   sms.setAddresses(addresses);
		    	   list.add(sms);
		    	   message.setSms(list);
		    	   System.out.println(message);
		    	   smsService.sendSMS(message);
	    	   }
	    	   
	       }catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Async
	public void sendRegistrationMessage(
		PersistableCustomer customer, MerchantStore merchantStore,
			Locale customerLocale, String contextPath) {
			   /** issue with putting that elsewhere **/ 
		LOGGER.info( "Sending welcome email to customer" );
	       try {
	    	   UserMessage message = new UserMessage();
	    	   message.setSender("PRETTY");
	    	   message.setRoute("4");
	    	   message.setCampaign("Order");
	    	   message.setCountry("91");
	    	   StringBuffer sb = new StringBuffer();
	    	   sb.append("Hey ");
	    	   sb.append(customer.getBilling().getFirstName());
	    	   sb.append("! ");
	    	   sb.append("Thank you for joining Prettydeal.in. The best place where you can find Tricity's best deals. Stay updated and Keep Saving.");
	    	   UserSMS sms = new UserSMS();
	    	   sms.setMessage(sb.toString());
	    	   List<UserSMS> list = new ArrayList<UserMessage.UserSMS>();
	    	   Address address = new Address();
	    	   address.setTo(customer.getBilling().getPhone());
	    	   List<Address> addresses = new ArrayList<>();
	    	   addresses.add(address);
	    	   sms.setAddresses(addresses);
	    	   list.add(sms);
	    	   message.setSms(list);
	    	   smsService.sendSMS(message);
	       }catch (Exception e) {
			e.printStackTrace();
		}
	}
}
