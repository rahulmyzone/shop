package com.salesmanager.core.business.order.dao;

import java.util.List;

import com.salesmanager.core.business.catalog.promotions.model.OrderCode;
import com.salesmanager.core.business.generic.dao.SalesManagerEntityDao;
import com.salesmanager.core.business.merchant.model.MerchantStore;
import com.salesmanager.core.business.order.model.Order;
import com.salesmanager.core.business.order.model.OrderCriteria;
import com.salesmanager.core.business.order.model.OrderList;
import com.salesmanager.core.business.order.model.orderproduct.OrderProduct;

public interface OrderDao extends SalesManagerEntityDao<Long, Order> {
	
	OrderList listByStore(MerchantStore store, OrderCriteria criteria);
	
	List<OrderProduct> listByPromoCode(String code);

	Order getByCodeOrder(OrderCode code);
}