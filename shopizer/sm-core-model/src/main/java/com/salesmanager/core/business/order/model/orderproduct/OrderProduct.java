package com.salesmanager.core.business.order.model.orderproduct;

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.TableGenerator;

import com.salesmanager.core.business.catalog.promotions.model.OrderCode;
import com.salesmanager.core.business.catalog.promotions.model.PromotionalVoucher;
import com.salesmanager.core.business.generic.model.SalesManagerEntity;
import com.salesmanager.core.business.order.model.Order;
import com.salesmanager.core.constants.SchemaConstant;

@Entity
@Table (name="ORDER_PRODUCT" , schema=SchemaConstant.SALESMANAGER_SCHEMA)
public class OrderProduct extends SalesManagerEntity<Long, OrderProduct> {
	private static final long serialVersionUID = 176131742783954627L;
	
	@Id
	@Column (name="ORDER_PRODUCT_ID")
	@TableGenerator(name = "TABLE_GEN", table = "SM_SEQUENCER", pkColumnName = "SEQ_NAME", valueColumnName = "SEQ_COUNT", pkColumnValue = "ORDER_PRODUCT_ID_NEXT_VALUE")
	@GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
	private Long id;

	@Column (name="PRODUCT_SKU")
	private String sku;

	@Column (name="PRODUCT_NAME" , length=64 , nullable=false)
	private String productName;

	@Column (name="PRODUCT_QUANTITY")
	private int productQuantity;

	@Column (name="ONETIME_CHARGE" , nullable=false )
	private BigDecimal oneTimeCharge;

	@Column(name="DISCOUNTED_PRICE")
	private BigDecimal discountedPrice;

	@Column(name="PROMOTION_APPLIED")
	private boolean promotionApplied;
	
	@ManyToOne(targetEntity = Order.class)
	@JoinColumn(name = "ORDER_ID", nullable = false)
	private Order order;
	
	@ManyToOne(targetEntity = OrderCode.class)
	@JoinColumn(name="CODE_ID")
	private OrderCode orderCode;

	@OneToMany(mappedBy = "orderProduct", cascade = CascadeType.ALL)
	private Set<OrderProductAttribute> orderAttributes = new HashSet<OrderProductAttribute>();

	@OneToMany(mappedBy = "orderProduct", cascade = CascadeType.ALL)
	private Set<OrderProductPrice> prices = new HashSet<OrderProductPrice>();

	@OneToMany(mappedBy = "orderProduct", cascade = CascadeType.ALL)
	private Set<OrderProductDownload> downloads = new HashSet<OrderProductDownload>();
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="PROMOTIONAL_VOUCHER_ID", nullable=true, insertable=true,updatable=true)
	private PromotionalVoucher promotionalVoucher;
	
	public OrderProduct() {
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}


	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getProductQuantity() {
		return productQuantity;
	}

	public void setProductQuantity(int productQuantity) {
		this.productQuantity = productQuantity;
	}



	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}


	public Set<OrderProductAttribute> getOrderAttributes() {
		return orderAttributes;
	}

	public void setOrderAttributes(Set<OrderProductAttribute> orderAttributes) {
		this.orderAttributes = orderAttributes;
	}

	public Set<OrderProductPrice> getPrices() {
		return prices;
	}

	public void setPrices(Set<OrderProductPrice> prices) {
		this.prices = prices;
	}

	public Set<OrderProductDownload> getDownloads() {
		return downloads;
	}

	public void setDownloads(Set<OrderProductDownload> downloads) {
		this.downloads = downloads;
	}


	public void setSku(String sku) {
		this.sku = sku;
	}

	public String getSku() {
		return sku;
	}

	public void setOneTimeCharge(BigDecimal oneTimeCharge) {
		this.oneTimeCharge = oneTimeCharge;
	}

	public BigDecimal getOneTimeCharge() {
		return oneTimeCharge;
	}

	public BigDecimal getDiscountedPrice() {
		return discountedPrice;
	}

	public void setDiscountedPrice(BigDecimal discountedPrice) {
		this.discountedPrice = discountedPrice;
	}

	public PromotionalVoucher getPromotionalVoucher() {
		return promotionalVoucher;
	}

	public void setPromotionalVoucher(PromotionalVoucher promotionalVoucher) {
		this.promotionalVoucher = promotionalVoucher;
	}

	public boolean isPromotionApplied() {
		return promotionApplied;
	}

	public void setPromotionApplied(boolean promotionApplied) {
		this.promotionApplied = promotionApplied;
	}

	public OrderCode getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(OrderCode orderCode) {
		this.orderCode = orderCode;
	}
	
}
