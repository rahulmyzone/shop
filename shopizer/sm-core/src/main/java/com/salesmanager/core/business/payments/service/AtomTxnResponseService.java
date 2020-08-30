package com.salesmanager.core.business.payments.service;

import com.salesmanager.core.business.generic.exception.ServiceException;
import com.salesmanager.core.business.generic.service.SalesManagerEntityService;
import com.salesmanager.core.business.payments.model.AtomTxnResponse;

public interface AtomTxnResponseService extends SalesManagerEntityService<Long, AtomTxnResponse>{

	public void updateAtomTxnResponse(AtomTxnResponse atomTxnResponse) throws ServiceException;
}
