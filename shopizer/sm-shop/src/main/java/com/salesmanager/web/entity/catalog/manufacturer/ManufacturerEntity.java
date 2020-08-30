package com.salesmanager.web.entity.catalog.manufacturer;

import java.io.Serializable;



public class ManufacturerEntity extends Manufacturer implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int order;
	private String latitude;
	private String longitude;

	public void setOrder(int order) {
		this.order = order;
	}
	public int getOrder() {
		return order;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}


}
