package com.salesmanager.core.business.payments.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.salesmanager.core.business.generic.exception.ServiceException;
import com.salesmanager.core.business.generic.service.SalesManagerEntityServiceImpl;
import com.salesmanager.core.business.payments.dao.PaytmTxnReponseDao;
import com.salesmanager.core.business.payments.model.PaytmTxnResponse;

@Service("paytmTxnResponseService")
public class PaytmTxnResponseServiceImpl extends SalesManagerEntityServiceImpl<Long, PaytmTxnResponse> implements PaytmTxnResponseService{

	private PaytmTxnReponseDao paytmTxnReponseDao;
	
	@Autowired
	public PaytmTxnResponseServiceImpl(PaytmTxnReponseDao paytmTxnReponseDao) {
		super(paytmTxnReponseDao);
		this.paytmTxnReponseDao = paytmTxnReponseDao;
	}

	@Override
	public void save(PaytmTxnResponse entity) throws ServiceException {
		this.paytmTxnReponseDao.save(entity);
		
	}

	@Override
	public void update(PaytmTxnResponse entity) throws ServiceException {
		this.paytmTxnReponseDao.update(entity);;
	}

	@Override
	public void create(PaytmTxnResponse entity) throws ServiceException {
		this.save(entity);
	}

	@Override
	public void delete(PaytmTxnResponse entity) throws ServiceException {
		this.paytmTxnReponseDao.delete(entity);
		
	}

	@Override
	public PaytmTxnResponse refresh(PaytmTxnResponse entity) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public PaytmTxnResponse getById(Long id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PaytmTxnResponse> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public PaytmTxnResponse getEntity(Class<? extends PaytmTxnResponse> clazz, Long id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Long count() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void flush() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void clear() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updatePaytmTxnResponse(PaytmTxnResponse paytmTxnResponse) throws ServiceException {
		if(paytmTxnResponse != null){
			if(paytmTxnResponse.getId() == null){
				this.save(paytmTxnResponse);
			}else{
				this.update(paytmTxnResponse);
			}
		}
	}

	public PaytmTxnReponseDao getPaytmTxnReponseDao() {
		return paytmTxnReponseDao;
	}

	public void setPaytmTxnReponseDao(PaytmTxnReponseDao paytmTxnReponseDao) {
		this.paytmTxnReponseDao = paytmTxnReponseDao;
	}

}
