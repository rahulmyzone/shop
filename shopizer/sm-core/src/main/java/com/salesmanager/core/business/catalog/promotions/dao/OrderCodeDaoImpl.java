package com.salesmanager.core.business.catalog.promotions.dao;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.salesmanager.core.business.catalog.promotions.model.OrderCode;
import com.salesmanager.core.business.catalog.promotions.model.PromotionalVoucher;
import com.salesmanager.core.business.generic.dao.SalesManagerEntityDaoImpl;
import com.salesmanager.core.business.order.dao.OrderDao;
import com.salesmanager.core.business.order.dao.OrderDaoImpl;
import com.salesmanager.core.business.order.dao.orderproduct.OrderProductDao;
import com.salesmanager.core.business.order.model.Order;
import com.salesmanager.core.business.order.model.orderproduct.OrderProduct;

@Repository("orderCodeDao")
public class OrderCodeDaoImpl extends SalesManagerEntityDaoImpl<Long, OrderCode> implements OrderCodeDao{

	@Autowired
	private OrderProductDao orderProductDao;
	
	@Override
	public OrderCode getCode(boolean issued, boolean redeamed) {
		OrderCode code = null;
		int i = 0;
		List<Long> ids = new ArrayList<Long>();
		while(i==0){
			StringBuilder qs = new StringBuilder();
			qs.append("Select distinct c from OrderCode as c ");
			qs.append("where c.issued = :issued");
			qs.append(" and c.redeamed = :redeamed");
			if(!ids.isEmpty()){
				StringBuilder s = new StringBuilder();
				for(Long l : ids){
					s.append(l);
					s.append(",");
				}
				qs.append(" and c.id not in (");
				s = s.delete(s.length()-1, s.length());
				qs.append(s);
				qs.append(")");
			}
			Query q = super.getEntityManager().createQuery(qs.toString(), OrderCode.class);
			q.setParameter("issued", issued);
			q.setParameter("redeamed", redeamed);
			q.setMaxResults(1);
			code = (OrderCode)q.getSingleResult();
			OrderProduct order = orderProductDao.getByOrderCode(code);
			if(order == null){
				i = 1;
			}
			ids.add(code.getId());
		}
		
		return code;
	}
}
