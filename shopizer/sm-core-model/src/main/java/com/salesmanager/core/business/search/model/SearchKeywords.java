package com.salesmanager.core.business.search.model;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONAware;
import org.json.simple.JSONObject;

public class SearchKeywords implements JSONAware{
	
	private List<String> keywords;
	
	private List<IndexProduct> products;

	public SearchKeywords(){
		this.keywords = new ArrayList<String>();
		products = new ArrayList<>();
	}
	
	public void setKeywords(List<String> keywords) {
		this.keywords = keywords;
	}

	public List<String> getKeywords() {
		return keywords;
	}
	
	public void addToIndexProducts(IndexProduct p){
		this.products.add(p);
	}
	
	public void addToKeywords(String kw){
		this.keywords.add(kw);
	}

	@SuppressWarnings("unchecked")
	@Override
	public String toJSONString() {
		JSONArray jsonArray = new JSONArray();
		if(products != null && !products.isEmpty()){
			JSONArray product = new JSONArray();
			for(IndexProduct kw : products) {
				product.add(kw.toJSONString());
			}
		}
		return jsonArray.toJSONString();
	}

	public List<IndexProduct> getProducts() {
		return products;
	}

	public void setProducts(List<IndexProduct> products) {
		this.products = products;
	}
	
}
