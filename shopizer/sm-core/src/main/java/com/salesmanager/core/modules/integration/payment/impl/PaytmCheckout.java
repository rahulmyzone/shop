package com.salesmanager.core.modules.integration.payment.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.paytm.merchant.CheckSumServiceHelper;
import com.salesmanager.core.business.customer.model.Customer;
import com.salesmanager.core.business.merchant.model.MerchantStore;
import com.salesmanager.core.business.order.model.Order;
import com.salesmanager.core.business.payments.model.Payment;
import com.salesmanager.core.business.payments.model.PaymentType;
import com.salesmanager.core.business.payments.model.Transaction;
import com.salesmanager.core.business.payments.model.TransactionType;
import com.salesmanager.core.business.shoppingcart.model.ShoppingCartItem;
import com.salesmanager.core.business.system.model.IntegrationConfiguration;
import com.salesmanager.core.business.system.model.IntegrationModule;
import com.salesmanager.core.business.system.model.ModuleConfig;
import com.salesmanager.core.modules.integration.IntegrationException;
import com.salesmanager.core.modules.integration.payment.model.PaymentModule;

public class PaytmCheckout implements PaymentModule{

	@Override
	public void validateModuleConfiguration(IntegrationConfiguration integrationConfiguration, MerchantStore store)
			throws IntegrationException {
		// TODO Auto-generated method stub
		
	}

	public boolean verifyChecksumHash(String checksumHash, TreeMap<String,String> params, IntegrationConfiguration configuration, IntegrationModule module){
		boolean flag = false; 
		try{
			flag = CheckSumServiceHelper.getCheckSumServiceHelper().verifycheckSum(configuration.getIntegrationKeys().get("merchant_key"), params, checksumHash);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
	
	@Override
	public Transaction initTransaction(MerchantStore store, Customer customer, BigDecimal amount, Payment payment,
			IntegrationConfiguration configuration, IntegrationModule module) throws IntegrationException {
		Transaction transaction = null;
		String checksum = null;
		TreeMap<String, String> params = new TreeMap<>();
		String txnId = new StringBuffer().append(String.valueOf(System.currentTimeMillis())).append(customer.getId()).toString();
		try{
			if(amount != null && (amount.equals(BigDecimal.ZERO) ||  amount.equals(new BigDecimal("0.00")))){
				params.put("NO_TXN","true");
			}else{
				String config = module.getConfiguration();
				Map<String, ModuleConfig> configs = module.getModuleConfigs();
				ModuleConfig moduleConfig = configs.get("TEST");
				params.put("ORDER_ID",txnId);
				params.put("CUST_ID",String.valueOf(customer.getId()));
				params.put("TXN_AMOUNT",String.valueOf(amount));
				params.put("MID", configuration.getIntegrationKeys().get("mid"));
				params.put("CHANNEL_ID", configuration.getIntegrationKeys().get("channel_id"));
				params.put("INDUSTRY_TYPE_ID", configuration.getIntegrationKeys().get("industry_type_id"));
				params.put("WEBSITE", configuration.getIntegrationKeys().get("website"));
				params.put("MOBILE_NO", customer.getMobile());
				params.put("EMAIL", customer.getEmailAddress());
				//params.put("ORDER_DETAILS", or);
				params.put("CALLBACK_URL", "http://"+store.getDomainName()+"/shop/order/txpResponse.html");
				params.put("paymentType", PaymentType.PAYTM.name());
				params.put("posturl", "https://pguat.paytm.com/oltp-web/processTransaction");
				params.put("CHECKSUMHASH", checksum);
				checksum = CheckSumServiceHelper.getCheckSumServiceHelper().genrateCheckSum(configuration.getIntegrationKeys().get("merchant_key"), params);
			}
			transaction = new Transaction();
			transaction.setAmount(amount);
			transaction.setMerchantTransactionId(txnId);
			transaction.setTransactionDate(new Date());
			transaction.setTransactionType(TransactionType.INIT);
			transaction.setPaymentType(PaymentType.PAYTM);
			transaction.setPaytmChecksum(checksum);
			transaction.setTransactionDetails(params);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return transaction;
	}

	@Override
	public Transaction authorize(MerchantStore store, Customer customer, List<ShoppingCartItem> items,
			BigDecimal amount, Payment payment, IntegrationConfiguration configuration, IntegrationModule module)
			throws IntegrationException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Transaction capture(MerchantStore store, Customer customer, Order order, Transaction capturableTransaction,
			IntegrationConfiguration configuration, IntegrationModule module) throws IntegrationException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Transaction authorizeAndCapture(MerchantStore store, Customer customer, List<ShoppingCartItem> items,
			BigDecimal amount, Payment payment, IntegrationConfiguration configuration, IntegrationModule module)
			throws IntegrationException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Transaction refund(boolean partial, MerchantStore store, Transaction transaction, Order order,
			BigDecimal amount, IntegrationConfiguration configuration, IntegrationModule module)
			throws IntegrationException {
		// TODO Auto-generated method stub
		return null;
	}

}
