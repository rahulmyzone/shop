package com.salesmanager.web.entity.catalog.product;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import com.salesmanager.core.utils.ajax.AjaxResponse;
import com.salesmanager.web.entity.customer.ReadableCustomer;

public class ReadableProductReview extends ProductReviewEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ReadableCustomer customer;
	private int ajaxResponse;
	private List<String> messages = new ArrayList<String>();
	public ReadableCustomer getCustomer() {
		return customer;
	}
	public void setCustomer(ReadableCustomer customer) {
		this.customer = customer;
	}
	public List<String> getMessages() {
		return messages;
	}
	public void setMessages(List<String> messages) {
		this.messages = messages;
	}
	public int getAjaxResponse() {
		return ajaxResponse;
	}
	public void setAjaxResponse(int ajaxResponse) {
		this.ajaxResponse = ajaxResponse;
	}

}
