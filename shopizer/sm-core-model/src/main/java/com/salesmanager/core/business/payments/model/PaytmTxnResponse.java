package com.salesmanager.core.business.payments.model;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.TableGenerator;

import org.json.simple.JSONAware;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.salesmanager.core.business.common.model.audit.AuditListener;
import com.salesmanager.core.business.common.model.audit.AuditSection;
import com.salesmanager.core.business.common.model.audit.Auditable;
import com.salesmanager.core.business.generic.model.SalesManagerEntity;
import com.salesmanager.core.business.order.model.Order;
import com.salesmanager.core.constants.SchemaConstant;

@Entity
@EntityListeners(value = AuditListener.class)
@Table(name = "PAYTM_TRANSACTION_RESPONSE", schema= SchemaConstant.SALESMANAGER_SCHEMA)
public class PaytmTxnResponse extends SalesManagerEntity<Long, PaytmTxnResponse> implements Serializable, Auditable, JSONAware {


	private static final Logger LOGGER = LoggerFactory.getLogger(AtomTxnResponse.class);
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "PAYTM_TXN_RESPONSE_ID")
	@TableGenerator(name = "TABLE_GEN", table = "SM_SEQUENCER", pkColumnName = "SEQ_NAME", valueColumnName = "SEQ_COUNT", pkColumnValue = "PAYTM_TXN_SEQ_NEXT_VAL")
	@GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
	private Long id;
	
	@Column(name="BANKNAME")
	private String bankName;
	
	@Column(name="BANK_TXN_ID")
	private String bankTxnId;
	
	@Column(name="CURRENCY")
	private String currency;
	
	@Column(name="GATEWAY_NAME")
	private String gatewayName;
	
	@Column(name="MID")
	private String mid;
	
	@Column(name="MERCHANT_ORDER_ID")
	private String merchantOrderId;
	
	@Column(name="PAYMENT_MODE")
	private String paymentMode;
	
	@Column(name="RESP_CODE")
	private String respCode;
	
	@Column(name="RESP_MSG")
	private String respMsg;
	
	@Column(name="STATUS")
	private String status;
	
	@Column(name="TXN_AMOUNT")
	private String txnAmt;
	
	@Column(name="TXN_DATE")
	private String txnDate;
	
	@Column(name="TXN_ID")
	private String txnId;
	
	@Column(name="CHECKSUMHASH")
	private String checksum;
	
	@Column(name="CHECKSUM_VERIFIED")
	private boolean checkSumVerified;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="ORDER_ID", nullable=true)
	private Order order;
	
	@Embedded
	private AuditSection auditSection = new AuditSection();
	
	
	@Override
	public String toJSONString() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public AuditSection getAuditSection() {
		return this.auditSection;
	}

	@Override
	public void setAuditSection(AuditSection audit) {
		this.auditSection = audit;
	}

	@Override
	public Long getId() {
		return this.id;
	}

	@Override
	public void setId(Long id) {
		this.id = id;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getBankTxnId() {
		return bankTxnId;
	}

	public void setBankTxnId(String bankTxnId) {
		this.bankTxnId = bankTxnId;
	}

	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	public String getGatewayName() {
		return gatewayName;
	}

	public void setGatewayName(String gatewayName) {
		this.gatewayName = gatewayName;
	}

	public String getMid() {
		return mid;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}

	public String getMerchantOrderId() {
		return merchantOrderId;
	}

	public void setMerchantOrderId(String merchantOrderId) {
		this.merchantOrderId = merchantOrderId;
	}

	public String getPaymentMode() {
		return paymentMode;
	}

	public void setPaymentMode(String paymentMode) {
		this.paymentMode = paymentMode;
	}

	public String getRespCode() {
		return respCode;
	}

	public void setRespCode(String respCode) {
		this.respCode = respCode;
	}

	public String getRespMsg() {
		return respMsg;
	}

	public void setRespMsg(String respMsg) {
		this.respMsg = respMsg;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getTxnAmt() {
		return txnAmt;
	}

	public void setTxnAmt(String txnAmt) {
		this.txnAmt = txnAmt;
	}

	public String getTxnDate() {
		return txnDate;
	}

	public void setTxnDate(String txnDate) {
		this.txnDate = txnDate;
	}

	public String getTxnId() {
		return txnId;
	}

	public void setTxnId(String txnId) {
		this.txnId = txnId;
	}

	public String getChecksum() {
		return checksum;
	}

	public void setChecksum(String checksum) {
		this.checksum = checksum;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public boolean isCheckSumVerified() {
		return checkSumVerified;
	}

	public void setCheckSumVerified(boolean checkSumVerified) {
		this.checkSumVerified = checkSumVerified;
	}

}
