package com.salesmanager.core.business.catalog.promotions.dao;

import java.util.List;

import com.salesmanager.core.business.catalog.promotions.model.OrderCode;
import com.salesmanager.core.business.catalog.promotions.model.PromotionalVoucher;
import com.salesmanager.core.business.catalog.promotions.model.PromotionalVoucherList;
import com.salesmanager.core.business.generic.dao.SalesManagerEntityDao;
import com.salesmanager.core.business.merchant.model.MerchantStore;
import com.salesmanager.core.business.reference.language.model.Language;

public interface PromotionalVoucherDao extends SalesManagerEntityDao<Long, PromotionalVoucher>{

	List<PromotionalVoucher> listByStore(MerchantStore store, Language language);
	
	PromotionalVoucher getById(Long id, MerchantStore store);
	
	PromotionalVoucher getByCode(String code, MerchantStore store);
	
	PromotionalVoucher getByCodeAndProductId(String code, Long productId);
	
}
