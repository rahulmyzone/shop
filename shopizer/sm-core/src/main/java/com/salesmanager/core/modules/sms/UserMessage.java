package com.salesmanager.core.modules.sms;

import java.io.Serializable;
import java.util.List;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name="MESSAGE")
public class UserMessage implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	
	private String authKey;
	
	
	private String sender;
	
	/*
	 * 1=Promotional
	 * 4=Transactional
	 */
	
	private String route;
	
	
	private String campaign;
	
	
	private String country = "91";
	

	private List<UserSMS> sms;
	


	@XmlElement(name="AUTHKEY")
	public String getAuthKey() {
		return authKey;
	}

	public void setAuthKey(String authKey) {
		this.authKey = authKey;
	}

	@XmlElement(name="SENDER")
	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	@XmlElement(name="ROUTE")
	public String getRoute() {
		return route;
	}

	public void setRoute(String route) {
		this.route = route;
	}

	@XmlElement(name="CAMPAIGN")
	public String getCampaign() {
		return campaign;
	}

	public void setCampaign(String campaign) {
		this.campaign = campaign;
	}

	@XmlElement(name="COUNTRY")
	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	@XmlElement(name="SMS")
	public List<UserSMS> getSms() {
		return sms;
	}

	public void setSms(List<UserSMS> sms) {
		this.sms = sms;
	}

	public static class UserSMS{
		
		
		private String message;
		
		private List<Address> addresses;

		@XmlAttribute(name="TEXT")
		public String getMessage() {
			return message;
		}

		public void setMessage(String message) {
			this.message = message;
		}

		@XmlElement(name="ADDRESS")
		public List<Address> getAddresses() {
			return addresses;
		}

		public void setAddresses(List<Address> addresses) {
			this.addresses = addresses;
		}

	}

	public static class Address{
		
		
		private String to;

		@XmlAttribute(name="TO")
		public String getTo() {
			return to;
		}

		public void setTo(String to) {
			this.to = to;
		}
		
	}
}