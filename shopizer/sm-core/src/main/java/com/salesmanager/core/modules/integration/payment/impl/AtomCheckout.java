package com.salesmanager.core.modules.integration.payment.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.commons.httpclient.HttpClient;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import com.itextpdf.text.Document;
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
import com.thoughtworks.xstream.core.util.Base64Encoder;

public class AtomCheckout implements PaymentModule{

	@Override
	public void validateModuleConfiguration(IntegrationConfiguration integrationConfiguration, MerchantStore store)
			throws IntegrationException {
		// TODO Auto-generated method stub
		
	}
	@Override
	public Transaction initTransaction(MerchantStore store, Customer customer, BigDecimal amount, Payment payment,
			IntegrationConfiguration configuration, IntegrationModule module) throws IntegrationException {
		Transaction transaction = null;
		try{
			String b64ClientCode = new Base64Encoder().encode("shcil".getBytes("UTF-8"));
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");  
			String CurrDateTime = sdf.format(new Date()).toString();
			String txnId = new StringBuffer().append(String.valueOf(System.currentTimeMillis())).append(customer.getId()).toString();
			String config = module.getConfiguration();
			Map<String, ModuleConfig> configs = module.getModuleConfigs();
			ModuleConfig moduleConfig = configs.get("TEST");
			StringBuffer params = new StringBuffer();
			params.append("login="+configuration.getIntegrationKeys().get("username"));
			params.append("&");
			params.append("pass="+configuration.getIntegrationKeys().get("password"));
			params.append("&");
			params.append("prodid="+configuration.getIntegrationKeys().get("productId"));
			params.append("&");
			params.append("ttype="+configuration.getIntegrationKeys().get("ttype"));
			params.append("&");
			params.append("txncurr="+payment.getCurrency().getCode());
			params.append("&");
			params.append("txnscamt=0&");
			params.append("amt="+amount);
			params.append("&");
			params.append("clientcode="+b64ClientCode);
			params.append("&");
			params.append("date="+URLEncoder.encode(CurrDateTime, "UTF-8"));
			params.append("&");
			params.append("custacc="+customer.getId());
			params.append("&");
			params.append("txnid="+txnId);
			params.append("&");
			//Customer details
			//Customer Name
			if(customer.getBilling().getLastName()!= null){
				params.append("udf1="+URLEncoder.encode(customer.getBilling().getFirstName()+" "+customer.getBilling().getLastName(),"utf-8"));
			}else{
				params.append("udf1="+URLEncoder.encode(customer.getBilling().getFirstName(),"utf-8"));
			}
			params.append("&");
			//Customer Email Id
			params.append("udf2="+customer.getEmailAddress());
			params.append("&");
			//Customer Mobile Number
			params.append("udf3="+customer.getMobile());
			params.append("&");
			params.append("ru=http://"+store.getDomainName()+"/shop/order/txResponse.html");
			DefaultHttpClient client = new DefaultHttpClient();
			String url = moduleConfig.getHost()+"?"+params.toString();
			HttpGet request = new HttpGet(url);
			HttpResponse response = client.execute(request);
			
			StringBuilder responseStr = new StringBuilder();
			BufferedReader rd = new BufferedReader
					  (new InputStreamReader(response.getEntity().getContent()));
					    
					String line = "";
					while ((line = rd.readLine()) != null) {
						responseStr.append(line);
					}
			
			
			
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			InputSource isBuf = new InputSource();
			isBuf.setCharacterStream(new StringReader(responseStr.toString()));
			org.w3c.dom.Document doc = dBuilder.parse(isBuf);
			doc.getDocumentElement().normalize();

			NodeList nList = doc.getElementsByTagName("RESPONSE");
			String xmlURL = "";
			String xmlttype = "";
			String xmltempTxnId = "";
			String xmltoken = "";
			String xmltxnStage = "";
			for (int tempN = 0; tempN < nList.getLength(); tempN++) 
			{
				Node nNode = nList.item(tempN);
				if (nNode.getNodeType() == Node.ELEMENT_NODE) 
				{
				  Element eElement = (Element) nNode;
				  xmlURL = eElement.getElementsByTagName("url").item(0).getChildNodes().item(0).getNodeValue();
				  
				  NodeList aList = eElement.getElementsByTagName("param");
				  String vParamName;
				  for (int atrCnt = 0; atrCnt< aList.getLength();atrCnt++)
				  {
					  vParamName = aList.item(atrCnt).getAttributes().getNamedItem("name").getNodeValue();
					  
					  if (vParamName.equals("ttype") )
					  {
						  xmlttype = aList.item(atrCnt).getChildNodes().item(0).getNodeValue();
					  }
					  else if (vParamName.equals("tempTxnId") )
					  {
						  xmltempTxnId = aList.item(atrCnt).getChildNodes().item(0).getNodeValue();
					  }
					  else if (vParamName.equals("token") )
					  {
						  xmltoken = aList.item(atrCnt).getChildNodes().item(0).getNodeValue();
					  }
					  else if (vParamName.equals("txnStage") )
					  {
						  xmltxnStage = aList.item(atrCnt).getChildNodes().item(0).getNodeValue();
					  }
				  }
				}
			}
			Map<String, String> txDetails = new HashMap<String, String>();
			txDetails.put("url", moduleConfig.getHost());
			txDetails.put("ttype", xmlttype);
			txDetails.put("tempTxnId", xmltempTxnId);
			txDetails.put("token", xmltoken);
			txDetails.put("txnStage", xmltxnStage);
			txDetails.put("paymentType", PaymentType.ATOM.name());
			StringBuffer redirectUrl = new StringBuffer();
			redirectUrl.append(moduleConfig.getHost());
			redirectUrl.append("?");
			redirectUrl.append("ttype="+xmlttype);
			redirectUrl.append("&");
			redirectUrl.append("tempTxnId="+xmltempTxnId);
			redirectUrl.append("&");
			redirectUrl.append("token="+xmltoken);
			redirectUrl.append("&");
			redirectUrl.append("txnStage="+xmltxnStage);
			txDetails.put("redirecturl", redirectUrl.toString());
			transaction = new Transaction();
			transaction.setAmount(amount);
			transaction.setMerchantTransactionId(txnId);
			//transaction.setOrder(order);
			transaction.setTransactionDate(new Date());
			transaction.setTransactionType(TransactionType.INIT);
			transaction.setPaymentType(PaymentType.ATOM);
			transaction.setTransactionDetails(txDetails);
			
					
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
