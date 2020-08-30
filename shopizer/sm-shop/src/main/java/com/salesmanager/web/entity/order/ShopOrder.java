package com.salesmanager.web.entity.order;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import com.salesmanager.core.business.catalog.promotions.model.PromotionalVoucher;
import com.salesmanager.core.business.order.model.OrderTotalSummary;
import com.salesmanager.core.business.payments.model.AtomTxnResponse;
import com.salesmanager.core.business.payments.model.PaytmTxnResponse;
import com.salesmanager.core.business.shipping.model.ShippingOption;
import com.salesmanager.core.business.shipping.model.ShippingSummary;
import com.salesmanager.core.business.shoppingcart.model.ShoppingCartItem;

/**
 * Orders saved on the website
 * @author Carl Samson
 *
 */
public class ShopOrder extends PersistableOrder implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private List<ShoppingCartItem> shoppingCartItems;//overrides parent API list of shoppingcartitem

	private OrderTotalSummary orderTotalSummary;//The order total displayed to the end user. That object will be used when committing the order
	
	@Transient
	private PromotionalVoucher promotionalVoucher;
	
	private ShippingSummary shippingSummary;
	private ShippingOption selectedShippingOption = null;//Default selected option
	
	
	private String paymentMethodType = null;//user selected payment type
	private Map<String,String> payment;//user payment information
	
	private AtomTxnResponse atomTxnResponse = null;
	
	private PaytmTxnResponse paytmTxnResponse = null;
	
	private String errorMessage = null;

	
	public void setShoppingCartItems(List<ShoppingCartItem> shoppingCartItems) {
		this.shoppingCartItems = shoppingCartItems;
	}
	public List<ShoppingCartItem> getShoppingCartItems() {
		return shoppingCartItems;
	}

	public void setOrderTotalSummary(OrderTotalSummary orderTotalSummary) {
		this.orderTotalSummary = orderTotalSummary;
	}
	public OrderTotalSummary getOrderTotalSummary() {
		return orderTotalSummary;
	}

	public ShippingSummary getShippingSummary() {
		return shippingSummary;
	}
	public void setShippingSummary(ShippingSummary shippingSummary) {
		this.shippingSummary = shippingSummary;
	}
	public ShippingOption getSelectedShippingOption() {
		return selectedShippingOption;
	}
	public void setSelectedShippingOption(ShippingOption selectedShippingOption) {
		this.selectedShippingOption = selectedShippingOption;
	}
	public String getErrorMessage() {
		return errorMessage;
	}
	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}
	public String getPaymentMethodType() {
		return paymentMethodType;
	}
	public void setPaymentMethodType(String paymentMethodType) {
		this.paymentMethodType = paymentMethodType;
	}
	public Map<String,String> getPayment() {
		return payment;
	}
	public void setPayment(Map<String,String> payment) {
		this.payment = payment;
	}
	public PromotionalVoucher getPromotionalVoucher() {
		return promotionalVoucher;
	}
	public void setPromotionalVoucher(PromotionalVoucher promotionalVoucher) {
		this.promotionalVoucher = promotionalVoucher;
	}
	public AtomTxnResponse getAtomTxnResponse() {
		return atomTxnResponse;
	}
	public void setAtomTxnResponse(AtomTxnResponse atomTxnResponse) {
		this.atomTxnResponse = atomTxnResponse;
	}
	public PaytmTxnResponse getPaytmTxnResponse() {
		return paytmTxnResponse;
	}
	public void setPaytmTxnResponse(PaytmTxnResponse paytmTxnResponse) {
		this.paytmTxnResponse = paytmTxnResponse;
	}



}
