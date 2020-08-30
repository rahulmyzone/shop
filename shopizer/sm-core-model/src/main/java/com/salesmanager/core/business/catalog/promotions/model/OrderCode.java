package com.salesmanager.core.business.catalog.promotions.model;

import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.salesmanager.core.business.common.model.audit.AuditSection;
import com.salesmanager.core.business.common.model.audit.Auditable;
import com.salesmanager.core.business.generic.model.SalesManagerEntity;
import com.salesmanager.core.constants.SchemaConstant;

@Entity
@Table(name="codes", schema = SchemaConstant.SALESMANAGER_SCHEMA)
public class OrderCode extends SalesManagerEntity<Long, OrderCode> implements Auditable{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column (name ="CODE_ID" , unique=true , nullable=false )
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;
	
	@Column(name="code")
	private String code;
	
	@Column(name="issued")
	private boolean issued;
	
	@Column(name="redeamed")
	private boolean redeamed;
	

	@Embedded
	private AuditSection auditSection = new AuditSection();
	
	@Override
	public Long getId() {
		return id;
	}

	@Override
	public void setId(Long id) {
		this.id = id;
	}

	public String getCode() {
		return code;
	}

	public boolean isIssued() {
		return issued;
	}

	public boolean isRedeamed() {
		return redeamed;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public void setIssued(boolean issued) {
		this.issued = issued;
	}

	public void setRedeamed(boolean redeamed) {
		this.redeamed = redeamed;
	}

	@Override
	public AuditSection getAuditSection() {
		// TODO Auto-generated method stub
		return auditSection;
	}

	@Override
	public void setAuditSection(AuditSection audit) {
		auditSection = audit;		
	}

}
