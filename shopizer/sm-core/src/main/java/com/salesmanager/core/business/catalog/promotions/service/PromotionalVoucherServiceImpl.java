package com.salesmanager.core.business.catalog.promotions.service;

import java.util.List;

import org.apache.commons.lang.Validate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.salesmanager.core.business.catalog.promotions.dao.PromotionalVoucherDao;
import com.salesmanager.core.business.catalog.promotions.model.OrderCode;
import com.salesmanager.core.business.catalog.promotions.model.PromotionalVoucher;
import com.salesmanager.core.business.generic.exception.ServiceException;
import com.salesmanager.core.business.generic.service.SalesManagerEntityServiceImpl;
import com.salesmanager.core.business.merchant.model.MerchantStore;
import com.salesmanager.core.business.reference.language.model.Language;

@Service
public class PromotionalVoucherServiceImpl extends SalesManagerEntityServiceImpl<Long, PromotionalVoucher> implements PromotionalVoucherService{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(PromotionalVoucherServiceImpl.class);
	
	@Autowired
	private PromotionalVoucherDao promotionsDao;

	@Autowired
	public PromotionalVoucherServiceImpl(PromotionalVoucherDao promotionalVoucherDao) {
		super(promotionalVoucherDao);
	}

	@Override
	public List<PromotionalVoucher> listByStore(MerchantStore store, Language language) {
		return promotionsDao.listByStore(store, language);
	}
	
	@Override
	public PromotionalVoucher getById(Long id, MerchantStore store){
		return promotionsDao.getById(id, store);
	}
	
	@Override
	public void saveOrUpdate(PromotionalVoucher promotionalVoucher) throws ServiceException{
		LOGGER.debug("Saving Promotional Voucher");
		Validate.notNull(promotionalVoucher,"promotionalVoucher cannot be null");
		Validate.notNull(promotionalVoucher.getValue(),"value cannot be null");
		Validate.notNull(promotionalVoucher.getSku(),"sku cannot be null");
		Validate.notNull(promotionalVoucher.getPromoCode(),"PromoCode cannot be null");
		
		if(promotionalVoucher.getId() != null && promotionalVoucher.getId() != 0){
			super.update(promotionalVoucher);
		}else{
			super.save(promotionalVoucher);
		}
	}

	@Override
	public PromotionalVoucher getByCode(String code, MerchantStore store) {
		LOGGER.debug("Getting Promotional Voucher by code");
		return promotionsDao.getByCode(code, store);
	}

	@Override
	public boolean isPromotionalVoucherApplicable(String code, Long productId) {
		PromotionalVoucher p = promotionsDao.getByCodeAndProductId(null, productId);
		if(p !=  null){
			return true;
		}
		return false;
	}

}
