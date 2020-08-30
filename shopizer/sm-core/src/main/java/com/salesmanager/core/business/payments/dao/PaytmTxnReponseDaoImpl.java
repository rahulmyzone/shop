package com.salesmanager.core.business.payments.dao;

import org.springframework.stereotype.Repository;

import com.salesmanager.core.business.generic.dao.SalesManagerEntityDaoImpl;
import com.salesmanager.core.business.payments.model.PaytmTxnResponse;

@Repository("paytmTxnReponseDao")
public class PaytmTxnReponseDaoImpl extends SalesManagerEntityDaoImpl<Long, PaytmTxnResponse> implements PaytmTxnReponseDao{

}
