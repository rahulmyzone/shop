package com.salesmanager.web.entity.catalog.manufacturer;

import java.io.Serializable;

import com.salesmanager.web.entity.catalog.CatalogEntity;

public class ManufacturerDescription extends CatalogEntity implements
		Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String address;

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

}
