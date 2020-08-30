package com.salesmanager.web.shop.model.filter;

import java.util.List;

/**
 * Used in Category and Search to filter display based on other
 * entities such as Manufacturer
 * @author Carl Samson
 *
 */
public class QueryFilter {
	
	/**
	 * used when filtering on an entity code (example property)
	 */
	private String filterCode;
	/**
	 * used when filtering on an entity id
	 */
	private Long filterId;
	
	private List<String> filterVal = null;
	private QueryFilterType filterType;
	public String getFilterCode() {
		return filterCode;
	}
	public void setFilterCode(String filterCode) {
		this.filterCode = filterCode;
	}
	public Long getFilterId() {
		return filterId;
	}
	public void setFilterId(Long filterId) {
		this.filterId = filterId;
	}
	public QueryFilterType getFilterType() {
		return filterType;
	}
	public void setFilterType(QueryFilterType filterType) {
		this.filterType = filterType;
	}
	public List<String> getFilterVal() {
		return filterVal;
	}
	public void setFilterVal(List<String> filterVal) {
		this.filterVal = filterVal;
	}
}
