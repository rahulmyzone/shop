package com.salesmanager.core.business.catalog.product.model.description;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import com.salesmanager.core.business.catalog.product.model.Product;
import com.salesmanager.core.business.common.model.Description;

@Entity
@Table(name = "PRODUCT_DESCRIPTION", schema="SALESMANAGER", uniqueConstraints={
	@UniqueConstraint(columnNames={
			"PRODUCT_ID",
			"LANGUAGE_ID"
		})
	}
)
public class ProductDescription extends Description {
	private static final long serialVersionUID = -7991123535661321865L;
	
	@ManyToOne(targetEntity = Product.class)
	@JoinColumn(name = "PRODUCT_ID", nullable = false)
	private Product product;
	
	@Column(name = "PRODUCT_HIGHLIGHT")
	private String productHighlight;
	
	@Column(name = "PRODUCT_PRICE_HIGHLIGHT")
	private String productPriceHighlight;

	@Column(name = "DOWNLOAD_LNK")
	private String productExternalDl;

	@Column(name = "SEF_URL")
	private String seUrl;

	@Column(name = "META_TITLE")
	private String metatagTitle;

	@Column(name = "META_KEYWORDS")
	private String metatagKeywords;

	@Column(name = "META_DESCRIPTION")
	private String metatagDescription;

	public ProductDescription() {
	}

	public String getProductHighlight() {
		return productHighlight;
	}

	public void setProductHighlight(String productHighlight) {
		this.productHighlight = productHighlight;
	}

	public String getProductExternalDl() {
		return productExternalDl;
	}

	public void setProductExternalDl(String productExternalDl) {
		this.productExternalDl = productExternalDl;
	}

	public String getSeUrl() {
		return seUrl;
	}

	public void setSeUrl(String seUrl) {
		this.seUrl = seUrl;
	}

	public String getMetatagTitle() {
		return metatagTitle;
	}

	public void setMetatagTitle(String metatagTitle) {
		this.metatagTitle = metatagTitle;
	}

	public String getMetatagKeywords() {
		return metatagKeywords;
	}

	public void setMetatagKeywords(String metatagKeywords) {
		this.metatagKeywords = metatagKeywords;
	}

	public String getMetatagDescription() {
		return metatagDescription;
	}

	public void setMetatagDescription(String metatagDescription) {
		this.metatagDescription = metatagDescription;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public String getProductPriceHighlight() {
		return productPriceHighlight;
	}

	public void setProductPriceHighlight(String productPriceHighlight) {
		this.productPriceHighlight = productPriceHighlight;
	}

}
