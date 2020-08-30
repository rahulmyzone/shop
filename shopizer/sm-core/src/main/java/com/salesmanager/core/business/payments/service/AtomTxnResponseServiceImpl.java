package com.salesmanager.core.business.payments.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.salesmanager.core.business.generic.exception.ServiceException;
import com.salesmanager.core.business.generic.service.SalesManagerEntityServiceImpl;
import com.salesmanager.core.business.payments.dao.AtomTxnResponseDao;
import com.salesmanager.core.business.payments.model.AtomTxnResponse;

@Service("atomTxnResponseService")
public class AtomTxnResponseServiceImpl extends SalesManagerEntityServiceImpl<Long, AtomTxnResponse> implements AtomTxnResponseService{

	AtomTxnResponseDao atomTxnResponseDao;
	
	@Autowired
	public AtomTxnResponseServiceImpl(AtomTxnResponseDao atomTxnResponseDao) {
		super(atomTxnResponseDao);
		this.atomTxnResponseDao = atomTxnResponseDao;
	}

	@Override
	public void save(AtomTxnResponse entity) throws ServiceException {
		atomTxnResponseDao.save(entity);
		
	}

	@Override
	public void update(AtomTxnResponse entity) throws ServiceException {
		atomTxnResponseDao.update(entity);
	}

	@Override
	public void create(AtomTxnResponse entity) throws ServiceException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(AtomTxnResponse entity) throws ServiceException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public AtomTxnResponse refresh(AtomTxnResponse entity) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public AtomTxnResponse getById(Long id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<AtomTxnResponse> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public AtomTxnResponse getEntity(Class<? extends AtomTxnResponse> clazz, Long id) {
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
	public void updateAtomTxnResponse(AtomTxnResponse atomTxnResponse) throws ServiceException{
		if(atomTxnResponse.getId() == null){
			this.save(atomTxnResponse);
		}else{
			this.update(atomTxnResponse);
		}
	}

}
