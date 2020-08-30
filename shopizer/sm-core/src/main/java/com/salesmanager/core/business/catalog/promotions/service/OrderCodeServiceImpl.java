package com.salesmanager.core.business.catalog.promotions.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itextpdf.text.pdf.PdfStructTreeController.returnType;
import com.salesmanager.core.business.catalog.promotions.dao.OrderCodeDao;
import com.salesmanager.core.business.catalog.promotions.model.OrderCode;
import com.salesmanager.core.business.catalog.promotions.model.PromotionalVoucher;
import com.salesmanager.core.business.generic.dao.SalesManagerEntityDao;
import com.salesmanager.core.business.generic.exception.ServiceException;
import com.salesmanager.core.business.generic.service.SalesManagerEntityServiceImpl;
import com.salesmanager.core.business.order.dao.OrderDao;
import com.salesmanager.core.business.order.model.Order;

@Service("orderCodeService")
public class OrderCodeServiceImpl extends SalesManagerEntityServiceImpl<Long, OrderCode> implements OrderCodeService{

	private OrderCodeDao orderCodeDao;

	@Autowired
	public OrderCodeServiceImpl(final OrderCodeDao orderCodeDao) {
		super(orderCodeDao);
		this.orderCodeDao = orderCodeDao;
	}

	@Override
	public OrderCode getOrderCode(boolean issued, boolean redeamed) {
		return this.orderCodeDao.getCode(issued, redeamed);
	}

}
