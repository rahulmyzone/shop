package com.salesmanager.core.business.catalog.promotions.service;

import java.util.List;

import com.salesmanager.core.business.catalog.promotions.model.OrderCode;
import com.salesmanager.core.business.catalog.promotions.model.PromotionalVoucher;
import com.salesmanager.core.business.generic.exception.ServiceException;
import com.salesmanager.core.business.generic.service.SalesManagerEntityService;
import com.salesmanager.core.business.merchant.model.MerchantStore;
import com.salesmanager.core.business.reference.language.model.Language;

public interface PromotionalVoucherService extends SalesManagerEntityService<Long, PromotionalVoucher>{

	List<PromotionalVoucher> listByStore(MerchantStore store, Language language);
	
	PromotionalVoucher getById(Long id, MerchantStore store);
	PromotionalVoucher getByCode(String code, MerchantStore store);
	boolean isPromotionalVoucherApplicable(String code, Long productId);
	void saveOrUpdate(PromotionalVoucher promotionalVoucher) throws ServiceException;
}
