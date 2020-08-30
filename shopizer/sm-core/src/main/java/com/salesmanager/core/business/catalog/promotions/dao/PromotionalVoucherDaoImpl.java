package com.salesmanager.core.business.catalog.promotions.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import org.hibernate.Hibernate;
import org.springframework.stereotype.Repository;

import com.mysema.query.jpa.JPQLQuery;
import com.mysema.query.jpa.impl.JPAQuery;
import com.salesmanager.core.business.catalog.promotions.model.OrderCode;
import com.salesmanager.core.business.catalog.promotions.model.PromotionalVoucher;
import com.salesmanager.core.business.customer.model.QCustomer;
import com.salesmanager.core.business.catalog.product.model.QProduct;
import com.salesmanager.core.business.catalog.promotions.model.QPromotionalVoucher;
import com.salesmanager.core.business.catalog.category.model.QCategory;
import com.salesmanager.core.business.catalog.product.model.Product;
import com.salesmanager.core.business.generic.dao.SalesManagerEntityDaoImpl;
import com.salesmanager.core.business.merchant.model.MerchantStore;
import com.salesmanager.core.business.reference.language.model.Language;

@Repository("promotionalVoucherDao")
public class PromotionalVoucherDaoImpl extends SalesManagerEntityDaoImpl<Long, PromotionalVoucher> implements PromotionalVoucherDao{


	public PromotionalVoucherDaoImpl() {
		super();
	}
	
	@Override
	public List<PromotionalVoucher> listByStore(MerchantStore store, Language language) {
		StringBuilder qs = new StringBuilder();
		qs.append("select distinct pv from PromotionalVoucher as pv ");
		qs.append("join fetch pv.merchantStore merch ");
		qs.append("left join fetch pv.products p ");
		qs.append("left join fetch pv.customers c ");
		qs.append("left join fetch pv.categories cat ");
		qs.append("where merch.id in (:id) ");
    	String hql = qs.toString();
		Query q = super.getEntityManager().createQuery(hql);

    	q.setParameter("id", store.getId());
    	List<PromotionalVoucher> promotionalVouchers = q.getResultList();
		return promotionalVouchers;
	}
	
	@Override
	public PromotionalVoucher getById(Long id, MerchantStore store){
		PromotionalVoucher voucher = null;//query.singleResult(qPromotionalVoucher);
		StringBuilder qs = new StringBuilder();
		qs.append("select distinct pv from PromotionalVoucher as pv ");
		qs.append("join fetch pv.merchantStore merch ");
		qs.append("left join fetch pv.products p ");
		qs.append("left join fetch p.descriptions de ");
		qs.append("left join fetch pv.customers c ");
		qs.append("left join fetch pv.categories cat ");
		qs.append("left join fetch cat.descriptions d ");
		qs.append("where pv.id in (:id) ");
		qs.append(" and merch.id in (:storeId)");
    	String hql = qs.toString();
		Query q = super.getEntityManager().createQuery(hql);

    	q.setParameter("id", id);
    	q.setParameter("storeId", store.getId());
    	List<PromotionalVoucher> promotionalVouchers = q.getResultList();
    	if(promotionalVouchers != null & !promotionalVouchers.isEmpty()){
    		voucher = promotionalVouchers.get(0);
    	}
		return voucher;
	}

	@Override
	public PromotionalVoucher getByCode(String code, MerchantStore store) {
		PromotionalVoucher voucher = null;//query.singleResult(qPromotionalVoucher);
		StringBuilder qs = new StringBuilder();
		qs.append("select distinct pv from PromotionalVoucher as pv ");
		qs.append("join fetch pv.merchantStore merch ");
		qs.append("left join fetch pv.products p ");
		qs.append("left join fetch p.descriptions de ");
		qs.append("left join fetch pv.customers c ");
		qs.append("left join fetch pv.categories cat ");
		qs.append("left join fetch cat.descriptions d ");
		qs.append("where pv.promoCode in (:promoCode) ");
		qs.append(" and merch.id in (:storeId)");
    	String hql = qs.toString();
		Query q = super.getEntityManager().createQuery(hql);

    	q.setParameter("promoCode", code);
    	q.setParameter("storeId", store.getId());
    	List<PromotionalVoucher> promotionalVouchers = q.getResultList();
    	if(promotionalVouchers != null & !promotionalVouchers.isEmpty()){
    		voucher = promotionalVouchers.get(0);
    	}
		return voucher;
	}

	@Override
	public PromotionalVoucher getByCodeAndProductId(String code, Long productId) {
		PromotionalVoucher voucher = null;
		StringBuilder qs = new StringBuilder();
		qs.append("select distinct pv from PromotionalVoucher as pv ");
		qs.append("join fetch pv.merchantStore merch ");
		qs.append("left join pv.products p ");
		qs.append("where pv.promoCode =:promoCode ");
		qs.append(" and p.id = :productId");
    	String hql = qs.toString();
		Query q = super.getEntityManager().createQuery(hql);
		q.setParameter("promoCode", code);
    	q.setParameter("productId", productId);
    	
    	List<PromotionalVoucher> promotionalVouchers = q.getResultList();
    	if(promotionalVouchers != null & !promotionalVouchers.isEmpty()){
    		voucher = promotionalVouchers.get(0);
    	}
		return voucher;
	}

}
