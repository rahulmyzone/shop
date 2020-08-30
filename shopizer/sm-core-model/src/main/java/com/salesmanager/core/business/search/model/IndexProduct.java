package com.salesmanager.core.business.search.model;

import java.util.List;

import org.apache.solr.client.solrj.beans.Field;
import org.apache.solr.common.SolrInputDocument;
import org.json.simple.JSONArray;
import org.json.simple.JSONAware;
import org.json.simple.JSONObject;

public class IndexProduct extends SolrInputDocument implements JSONAware {
	
	@Field("name")
	private String name;
	
	@Field("price")
	private Double price;
	
	@Field("cat")
	private List<String> categories;//category code
	
	@Field("manufacturer")
	private String manufacturer;//name of the manufacturer
	
	@Field("manufacturerId")
	private String manufacturerId;//name of the manufacturer
	
	@Field("available")
	private boolean available;
	
	@Field("description")
	private String description;
	
	@Field("tag")
	private List<String> tags;//keywords ?
	
	@Field("highlight")
	private String highlight;
	
	@Field("store")
	private String store;
	
	@Field("language")
	private String lang;
	
	@Field("id")
	private String id;//required by the search framework
	
	@Field("image")
	private String productImage;
	
	@Field("sku")
	private String sku;
	
	@Field("url")
	private String url;

	
	@SuppressWarnings("unchecked")
	@Override
	public String toJSONString() {
		JSONObject obj = new JSONObject();
		obj.put("name", this.getName());
		obj.put("price", this.getPrice());
		obj.put("description", this.getDescription());
		obj.put("highlight", this.getHighlight());
		obj.put("store", this.getStore());
		obj.put("manufacturer", this.getManufacturer());
		obj.put("lang", this.getLang());
		obj.put("manufacturerId", this.getManufacturerId());
		obj.put("id", this.getId());
		obj.put("image", this.getProductImage());
		if(categories!=null) {
			JSONArray categoriesArray = new JSONArray();
			for(String category : categories) {
				categoriesArray.add(category);
			}
			obj.put("categories", categoriesArray);
		}
		
		if(tags!=null) {
			JSONArray tagsArray = new JSONArray();
			for(String tag : tags) {
				tagsArray.add(tag);
			}
			obj.put("tags", tagsArray);
		}
		
		return obj.toJSONString();

	}
	
	public JSONObject toJSONObject() {
		JSONObject obj = new JSONObject();
		obj.put("name", this.getName());
		obj.put("price", this.getPrice());
		obj.put("description", this.getDescription());
		obj.put("highlight", this.getHighlight());
		obj.put("store", this.getStore().toUpperCase());
		obj.put("manufacturer", this.getManufacturer());
		obj.put("lang", this.getLang());
		obj.put("manufacturerId", this.getManufacturerId());
		obj.put("id", this.getId());
		obj.put("image", this.getProductImage());
		obj.put("sku", this.getSku().toUpperCase());
		obj.put("url", this.getUrl());
		if(categories!=null) {
			JSONArray categoriesArray = new JSONArray();
			for(String category : categories) {
				categoriesArray.add(category);
			}
			obj.put("categories", categoriesArray);
		}
		
		if(tags!=null) {
			JSONArray tagsArray = new JSONArray();
			for(String tag : tags) {
				tagsArray.add(tag);
			}
			obj.put("tags", tagsArray);
		}
		
		return obj;

	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}


	public List<String> getCategories() {
		return categories;
	}

	public void setCategories(List<String> categories) {
		this.categories = categories;
	}

	public boolean isAvailable() {
		return available;
	}

	public void setAvailable(boolean available) {
		this.available = available;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public List<String> getTags() {
		return tags;
	}

	public void setTags(List<String> tags) {
		this.tags = tags;
	}

	public String getHighlight() {
		return highlight;
	}

	public void setHighlight(String highlight) {
		this.highlight = highlight;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public Double getPrice() {
		return price;
	}

	public void setStore(String store) {
		this.store = store;
	}

	public String getStore() {
		return store;
	}

	public void setLang(String lang) {
		this.lang = lang;
	}

	public String getLang() {
		return lang;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getId() {
		return id;
	}

	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}

	public String getManufacturer() {
		return manufacturer;
	}

	public String getProductImage() {
		return productImage;
	}

	public void setProductImage(String productImage) {
		this.productImage = productImage;
	}

	public String getManufacturerId() {
		return manufacturerId;
	}

	public void setManufacturerId(String manufacturerId) {
		this.manufacturerId = manufacturerId;
	}

	public String getSku() {
		return sku;
	}

	public void setSku(String sku) {
		this.sku = sku;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}


}
