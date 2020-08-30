<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false" %>		


                 <div class="control-group">
                        <label class="required"><s:message code="module.payment.paytm.mid" text="Paytm MID"/></label>
	                        <div class="controls">
	                        		<form:input cssClass="input-large highlight" path="integrationKeys['mid']" />
	                        </div>
	                        <span class="help-inline">
	                        	<c:if test="${mid!=null}">
	                        	<span id="miderrors" class="error"><s:message code="module.payment.paytm.message.identifier" text="Field in error"/></span>
	                        	</c:if>
	                        </span>
                  </div>
                  
                   <div class="control-group">
                        <label class="required"><s:message code="module.payment.paytm.channelId" text="Paytm Channel id"/></label>
	                        <div class="controls">
									<form:input cssClass="input-large highlight" path="integrationKeys['channel_id']" />
	                        </div>
	                        <span class="help-inline">
	                        	<c:if test="${channel_id!=null}">
	                        		<span id="channel_iderrors" class="error"><s:message code="module.payment.paytm.message.channelId" text="Field in error"/></span>
	                        	</c:if>
	                        </span>
                  </div>
                  
                  <div class="control-group">
                        <label class="required"><s:message code="module.payment.paytm.merchantKey" text="Mrchant Key"/></label>
	                        <div class="controls">
									<form:input cssClass="input-large highlight" path="integrationKeys['merchant_key']" />
	                        </div>
	                        <span class="help-inline">
	                        	<c:if test="${merchant_key!=null}">
	                        		<span id="channel_iderrors" class="error"><s:message code="module.payment.paytm.message.merchantKey" text="Field in error"/></span>
	                        	</c:if>
	                        </span>
                  </div>

                   <div class="control-group">
                        <label class="required"><s:message code="module.payment.paytm.industryTypeId" text="Industry Type ID"/></label>
	                        <div class="controls">
									<form:input cssClass="input-large highlight" path="integrationKeys['industry_type_id']" />
	                        </div>
	                        <span class="help-inline">
	                        	<c:if test="${industry_type_id!=null}">
	                        		<span id="industry_type_iderrors" class="error"><s:message code="module.payment.paytm.message.industryTypeId" text="Field in error"/></span>
	                        	</c:if>
	                        </span>
                  </div>
                  
                  <div class="control-group">
                        <label class="required"><s:message code="module.payment.paytm.website" text="Website"/></label>
	                        <div class="controls">
									<form:input cssClass="input-large highlight" path="integrationKeys['website']" />
	                        </div>
	                        <span class="help-inline">
	                        	<c:if test="${website!=null}">
	                        		<span id="websiteerrors" class="error"><s:message code="module.payment.paytm.message.website" text="Field in error"/></span>
	                        	</c:if>
	                        </span>
                  </div>
                  
                   <div class="control-group">
                        <label class="required"><s:message code="module.payment.transactiontype" text="Transaction type"/></label>
	                        <div class="controls">
	                        		<form:radiobutton cssClass="input-large highlight" path="integrationKeys['transaction']" value="AUTHORIZE" />&nbsp;<s:message code="module.payment.transactiontype.preauth" text="Pre-authorization" /><br/>
	                        		<form:radiobutton cssClass="input-large highlight" path="integrationKeys['transaction']" value="AUTHORIZECAPTURE" />&nbsp;<s:message code="module.payment.transactiontype.sale" text="Sale" /></br>
	                        </div>
                  </div>