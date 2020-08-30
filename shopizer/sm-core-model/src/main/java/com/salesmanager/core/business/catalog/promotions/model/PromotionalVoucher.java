package com.salesmanager.core.business.catalog.promotions.model;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.TableGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

import org.hibernate.annotations.Cascade;

import com.salesmanager.core.business.catalog.category.model.Category;
import com.salesmanager.core.business.catalog.product.model.Product;
import com.salesmanager.core.business.common.model.audit.AuditListener;
import com.salesmanager.core.business.common.model.audit.AuditSection;
import com.salesmanager.core.business.common.model.audit.Auditable;
import com.salesmanager.core.business.customer.model.Customer;
import com.salesmanager.core.business.generic.model.SalesManagerEntity;
import com.salesmanager.core.business.merchant.model.MerchantStore;
import com.salesmanager.core.constants.SchemaConstant;

@Entity
@EntityListeners(value = AuditListener.class)
@Table(name = "PROMOTIONAL_VOUCHER", schema=SchemaConstant.SALESMANAGER_SCHEMA, uniqueConstraints=
@UniqueConstraint(columnNames = {"SKU", "PROMO_CODE"}))
public class PromotionalVoucher extends SalesManagerEntity<Long, PromotionalVoucher> implements Auditable{
	
	private static final long serialVersionUID = -6228066416290007047L;

	public enum PromotionType{PER_ORDER,PER_ITEM}
	
	public enum PromotionApplied{AMOUNT,PERCENT}
	
	@Id
	@Column(name = "PROMOTIONAL_VOUCHER_ID", unique=true, nullable=false)
	@TableGenerator(name = "TABLE_GEN", table = "SM_SEQUENCER", pkColumnName = "SEQ_NAME", valueColumnName = "SEQ_COUNT", pkColumnValue = "PRODUCT_SEQ_NEXT_VAL")
	@GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
	private Long id;
	
	@Column(name="SKU")
	private String sku;
	
	@Column(name="PROMO_CODE")
	private String promoCode;
	
	@Column(name="DESCRIPTION")
	private String description;
	
	@Column(name="PROMOTION_TYPE")
	@Enumerated(EnumType.ORDINAL)
	private PromotionType promotionType;
	
	@Column(name="PROMOTION_APPLIED")
	@Enumerated(EnumType.ORDINAL)
	private PromotionApplied promotionApplied;
	
	@Column(name="value")
	private BigDecimal value;
	
	@ManyToMany(fetch=FetchType.LAZY, cascade = {CascadeType.REFRESH})
	@JoinTable(name = "promotional_voucher_product", schema=SchemaConstant.SALESMANAGER_SCHEMA, joinColumns = { 
			@JoinColumn(name = "PROMOTIONAL_VOUCHER_ID", nullable = false, updatable = false) }
			, 
			inverseJoinColumns = { @JoinColumn(name = "PRODUCT_ID", 
					nullable = false, updatable = false) }
	)
	@Cascade({
		org.hibernate.annotations.CascadeType.DETACH,
		org.hibernate.annotations.CascadeType.LOCK,
		org.hibernate.annotations.CascadeType.REFRESH,
		org.hibernate.annotations.CascadeType.REPLICATE
		
	})
	private Set<Product> products;
	
	//@OneToMany(fetch = FetchType.LAZY, cascade = {CascadeType.REFRESH}, mappedBy = "promotionalVoucher")
	@ManyToMany(fetch=FetchType.LAZY, cascade = {CascadeType.REFRESH})
	@JoinTable(name = "promotional_voucher_customer", schema=SchemaConstant.SALESMANAGER_SCHEMA, joinColumns = { 
			@JoinColumn(name = "PROMOTIONAL_VOUCHER_ID", nullable = false, updatable = false) }
			, 
			inverseJoinColumns = { @JoinColumn(name = "CUSTOMER_ID", 
					nullable = false, updatable = false) }
	)
	@Cascade({
		org.hibernate.annotations.CascadeType.DETACH,
		org.hibernate.annotations.CascadeType.LOCK,
		org.hibernate.annotations.CascadeType.REFRESH,
		org.hibernate.annotations.CascadeType.REPLICATE
		
	})
	private Set<Customer> customers;
	
	@ManyToMany(fetch=FetchType.LAZY, cascade = {CascadeType.REFRESH})
	@JoinTable(name = "promotional_voucher_category", schema=SchemaConstant.SALESMANAGER_SCHEMA, joinColumns = { 
			@JoinColumn(name = "PROMOTIONAL_VOUCHER_ID", nullable = false, updatable = false) }
			, 
			inverseJoinColumns = { @JoinColumn(name = "CATEGORY_ID", 
					nullable = false, updatable = false) }
	)
	@Cascade({
		org.hibernate.annotations.CascadeType.DETACH,
		org.hibernate.annotations.CascadeType.LOCK,
		org.hibernate.annotations.CascadeType.REFRESH,
		org.hibernate.annotations.CascadeType.REPLICATE
		
	})
	private Set<Category> categories;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="MERCHANT_ID", nullable=false)
	private MerchantStore merchantStore;
	
	@Column(name="APPLICATION_LIMIT")
	private Integer applicationLimit;
	
	@Column(name="PROMO_VALID_TILL")
	@Temporal(TemporalType.TIMESTAMP)
	private Date promoValidTill;
	
	@Column(name="active")
	private boolean active;
	
	public void addToProducts(Product product){
		if(product != null){
			if(getProducts() == null){
				this.products = new HashSet<Product>();
			}
			getProducts().add(product);
		}
	}
	
	public void addToCategories(Category category){
		if(category != null){
			if(getProducts() == null){
				this.categories = new HashSet<Category>();
			}
			getCategories().add(category);
		}
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	@Embedded
	private AuditSection auditSection = new AuditSection();
	
	@Override
	public AuditSection getAuditSection() {
		return auditSection;
	}

	@Override
	public void setAuditSection(AuditSection audit) {
		this.auditSection = audit;
	}

	@Override
	public Long getId() {
		return id;
	}

	@Override
	public void setId(Long id) {
		this.id = id;
	}

	public String getPromoCode() {
		return promoCode;
	}

	public void setPromoCode(String promoCode) {
		this.promoCode = promoCode;
	}

	public PromotionType getPromotionType() {
		return promotionType;
	}

	public void setPromotionType(PromotionType promotionType) {
		this.promotionType = promotionType;
	}

	public PromotionApplied getPromotionApplied() {
		return promotionApplied;
	}

	public void setPromotionApplied(PromotionApplied promotionApplied) {
		this.promotionApplied = promotionApplied;
	}

	public Set<Product> getProducts() {
		return products;
	}

	public void setProducts(Set<Product> products) {
		this.products = products;
	}

	public Set<Customer> getCustomers() {
		return customers;
	}

	public void setCustomers(Set<Customer> customers) {
		this.customers = customers;
	}

	public Integer getApplicationLimit() {
		return applicationLimit;
	}

	public void setApplicationLimit(Integer applicationLimit) {
		this.applicationLimit = applicationLimit;
	}

	public Date getPromoValidTill() {
		return promoValidTill;
	}

	public void setPromoValidTill(Date promoValidTill) {
		this.promoValidTill = promoValidTill;
	}

	public String getSku() {
		return sku;
	}

	public void setSku(String sku) {
		this.sku = sku;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public MerchantStore getMerchantStore() {
		return merchantStore;
	}

	public void setMerchantStore(MerchantStore merchantStore) {
		this.merchantStore = merchantStore;
	}

	public Set<Category> getCategories() {
		return categories;
	}

	public void setCategories(Set<Category> categories) {
		this.categories = categories;
	}

	public BigDecimal getValue() {
		return value;
	}

	public void setValue(BigDecimal value) {
		this.value = value;
	}

}
