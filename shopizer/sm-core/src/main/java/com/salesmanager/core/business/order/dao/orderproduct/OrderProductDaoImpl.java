package com.salesmanager.core.business.order.dao.orderproduct;

import java.util.List;

import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import com.salesmanager.core.business.catalog.promotions.model.OrderCode;
import com.salesmanager.core.business.generic.dao.SalesManagerEntityDaoImpl;
import com.salesmanager.core.business.order.model.Order;
import com.salesmanager.core.business.order.model.orderproduct.OrderProduct;

@Repository("orderProductDao")
public class OrderProductDaoImpl extends SalesManagerEntityDaoImpl<Long, OrderProduct> implements OrderProductDao{

	
	public OrderProductDaoImpl() {
		super();
	}

	@Override
	public OrderProduct getByOrderCode(OrderCode code) {
		OrderProduct order = null;
		StringBuilder qs = new StringBuilder();
		qs.append("select distinct o from OrderProduct as o ");
		qs.append("where o.orderCode = :code");
    	String hql = qs.toString();
		Query q = super.getEntityManager().createQuery(hql);
    	q.setParameter("code", code);
    	List<OrderProduct> orders = q.getResultList();
    	if(orders != null && !orders.isEmpty()){
    		order = orders.get(0);
    	}
		return order;
	}
}
