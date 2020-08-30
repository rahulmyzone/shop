package com.salesmanager.core.business.catalog.promotions.dao;

import javax.persistence.Query;

import com.salesmanager.core.business.catalog.promotions.model.OrderCode;
import com.salesmanager.core.business.catalog.promotions.model.PromotionalVoucher;
import com.salesmanager.core.business.generic.dao.SalesManagerEntityDao;

public interface OrderCodeDao extends SalesManagerEntityDao<Long, OrderCode>{

	public OrderCode getCode(boolean issued, boolean redeamed);
}
