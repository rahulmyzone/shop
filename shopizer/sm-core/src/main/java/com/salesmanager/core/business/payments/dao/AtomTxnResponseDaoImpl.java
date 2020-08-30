package com.salesmanager.core.business.payments.dao;

import org.springframework.stereotype.Repository;

import com.salesmanager.core.business.generic.dao.SalesManagerEntityDaoImpl;
import com.salesmanager.core.business.payments.model.AtomTxnResponse;

@Repository("atomTxnResponseDao")
public class AtomTxnResponseDaoImpl extends SalesManagerEntityDaoImpl<Long, AtomTxnResponse> implements AtomTxnResponseDao{

}
