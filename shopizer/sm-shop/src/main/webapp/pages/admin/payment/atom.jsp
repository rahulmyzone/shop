<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false" %>		


                 <div class="control-group">
                        <label class="required"><s:message code="module.payment.citrus.userid" text="Atom API user name"/></label>
	                        <div class="controls">
	                        		<form:input cssClass="input-large highlight" path="integrationKeys['username']" />
	                        </div>
	                        <span class="help-inline">
	                        	<c:if test="${username!=null}">
	                        	<span id="identifiererrors" class="error"><s:message code="module.payment.atom.message.identifier" text="Field in error"/></span>
	                        	</c:if>
	                        </span>
                  </div>
                  
                   <div class="control-group">
                        <label class="required"><s:message code="module.payment.citrus.apikey" text="Atom API Password"/></label>
	                        <div class="controls">
									<form:input cssClass="input-large highlight" path="integrationKeys['password']" />
	                        </div>
	                        <span class="help-inline">
	                        	<c:if test="${api!=null}">
	                        		<span id="apikeyerrors" class="error"><s:message code="module.payment.atom.message.password" text="Field in error"/></span>
	                        	</c:if>
	                        </span>
                  </div>

                   <div class="control-group">
                        <label class="required"><s:message code="module.payment.citrus.signature" text="Product ID"/></label>
	                        <div class="controls">
									<form:input cssClass="input-large highlight" path="integrationKeys['productId']" />
	                        </div>
	                        <span class="help-inline">
	                        	<c:if test="${signature!=null}">
	                        		<span id="apisignatureerrors" class="error"><s:message code="module.payment.atom.message.productId" text="Field in error"/></span>
	                        	</c:if>
	                        </span>
                  </div>
                  
                  <div class="control-group">
                        <label class="required"><s:message code="module.payment.atom.ttype" text="Transaction Type"/></label>
	                        <div class="controls">
									<form:input cssClass="input-large highlight" path="integrationKeys['ttype']" />
	                        </div>
	                        <span class="help-inline">
	                        	<c:if test="${ttype!=null}">
	                        		<span id="ttypeerrors" class="error"><s:message code="module.payment.atom.message.ttype" text="Field in error"/></span>
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