package com.salesmanager.core.business.catalog.promotions.service;

import com.salesmanager.core.business.catalog.promotions.model.OrderCode;
import com.salesmanager.core.business.catalog.promotions.model.PromotionalVoucher;
import com.salesmanager.core.business.generic.service.SalesManagerEntityService;

public interface OrderCodeService extends SalesManagerEntityService<Long, OrderCode>{

	public OrderCode getOrderCode(boolean issued, boolean redeamed);
}
