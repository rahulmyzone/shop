package com.salesmanager.core.business.catalog.promotions.model;

import java.util.List;

import com.salesmanager.core.business.common.model.EntityList;

public class PromotionalVoucherList extends EntityList{

	private List<PromotionalVoucher> promotionalVouchers;

	public List<PromotionalVoucher> getPromotionalVouchers() {
		return promotionalVouchers;
	}

	public void setPromotionalVouchers(List<PromotionalVoucher> promotionalVouchers) {
		this.promotionalVouchers = promotionalVouchers;
	}
}
