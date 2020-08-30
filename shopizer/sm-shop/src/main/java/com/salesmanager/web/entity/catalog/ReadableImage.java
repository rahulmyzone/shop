package com.salesmanager.web.entity.catalog;

import java.io.Serializable;

import com.salesmanager.core.business.catalog.product.model.image.ProductImage.ImageType;
import com.salesmanager.web.entity.Entity;

public class ReadableImage extends Entity implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String imageName;
	private String imageUrl;
	private ImageType imageType;
	public void setImageName(String imageName) {
		this.imageName = imageName;
	}
	public String getImageName() {
		return imageName;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public ImageType getImageType() {
		return imageType;
	}
	public void setImageType(ImageType imageType) {
		this.imageType = imageType;
	}

}
