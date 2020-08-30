package com.salesmanager.core.modules.sms;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;

import org.apache.commons.httpclient.NameValuePair;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service("smsService")
public class SMSServiceImpl implements SMSService{

	@Value(value="${usersms.conf.authKey}")
	private String authKey;
	
	@Value(value="${usersms.conf.web.url}")
	private String url;
	
	@Override
	public void sendSMS(UserMessage userMessage) {
		try {
			userMessage.setAuthKey(authKey);
			JAXBContext context = JAXBContext.newInstance(UserMessage.class);
			Marshaller marshaller = context.createMarshaller();
			marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
			StringWriter stringWriter = new StringWriter();
			marshaller.marshal(userMessage, stringWriter);
			String xml = stringWriter.toString();
			DefaultHttpClient client = new DefaultHttpClient();
			HttpPost post = new HttpPost(url	);
			List<BasicNameValuePair> urlParameters = new ArrayList<BasicNameValuePair>();
			urlParameters.add(new BasicNameValuePair("data", xml));
			post.setEntity(new UrlEncodedFormEntity(urlParameters, "UTF-8"));
			HttpResponse response = client.execute(post);
			StringBuilder responseStr = new StringBuilder();
			BufferedReader rd = new BufferedReader
					  (new InputStreamReader(response.getEntity().getContent()));
					    
					String line = "";
					while ((line = rd.readLine()) != null) {
						responseStr.append(line);
			}
		System.out.println(responseStr);
		} catch (JAXBException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

}
