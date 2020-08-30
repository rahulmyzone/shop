package com.salesmanager.core.business.payments.service;

import com.salesmanager.core.business.generic.exception.ServiceException;
import com.salesmanager.core.business.generic.service.SalesManagerEntityService;
import com.salesmanager.core.business.payments.model.PaytmTxnResponse;

public interface PaytmTxnResponseService extends SalesManagerEntityService<Long, PaytmTxnResponse>{

	public void updatePaytmTxnResponse(PaytmTxnResponse paytmTxnResponse) throws ServiceException;
}
