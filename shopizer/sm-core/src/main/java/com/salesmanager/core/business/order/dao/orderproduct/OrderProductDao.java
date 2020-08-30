package com.salesmanager.core.business.order.dao.orderproduct;

import com.salesmanager.core.business.catalog.promotions.model.OrderCode;
import com.salesmanager.core.business.generic.dao.SalesManagerEntityDao;
import com.salesmanager.core.business.order.model.orderproduct.OrderProduct;

public interface OrderProductDao extends SalesManagerEntityDao<Long, OrderProduct> {

	OrderProduct getByOrderCode(OrderCode code);
}
