<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@ page session="false"%>
<div class="tabbable">
	<link
		href="<c:url value="/resources/css/bootstrap/css/datepicker.css" />"
		rel="stylesheet"></link>
	<script
		src="<c:url value="/resources/js/bootstrap/bootstrap-datepicker.js" />"></script>
	<jsp:include page="/common/adminTabs.jsp" />
	<div class="tab-content">
		<div class="tab-pane active" id="catalogue-section">
			<div class="sm-ui-component">

				<h3>
					<s:message code="label.promotions.vouchers"
						text="Promotional Vouchers" />
				</h3>
			</div>
		</div>
		<c:if test="${voucher.id!=null && voucher.id>0}">
			<c:set value="${voucher.id}" var="id" scope="request" />
			<jsp:include page="/pages/admin/promotions/promotions-menu.jsp" />
		</c:if>
		<c:url var="productVoucherSave"
			value="/admin/promotions/savePromotionalVoucher.html" />
		<form:form method="POST" enctype="multipart/form-data"
			commandName="voucher" action="${productVoucherSave}">
			<form:errors path="*" cssClass="alert alert-error" element="div" />
			<div id="store.success" class="alert alert-success"
				style="<c:choose><c:when test="${success!=null}">display:block;</c:when><c:otherwise>display:none;</c:otherwise></c:choose>">
				<s:message code="message.success" text="Request successfull" />
			</div>
			<div id="store.error" class="alert alert-error"
				style="display: none;">
				<s:message code="message.error" text="An error occured" />
			</div>
			<div class="control-group">
				<label><s:message code="label.promotional.sku" text="SKU" /></label>
				<div class="controls">
					<form:input cssClass="input-large highlight" path="sku" />
					<span class="help-inline"><s:message
							code="label.generic.alphanumeric" text="Alphanumeric" />
						<form:errors path="sku" cssClass="error" /></span>
				</div>
			</div>
			<div class="control-group">
				<label><s:message code="label.promotional.promocode="
						text="Promo Code" /></label>
				<div class="controls">
					<form:input cssClass="input-large highlight" path="promoCode" />
					<span class="help-inline"><s:message
							code="label.generic.all" text="All" />
						<form:errors path="promoCode" cssClass="error" /></span>
				</div>
			</div>
			<div class="control-group">
				<label><s:message code="label.promotional.description"
						text="Description" /></label>
				<div class="controls">
					<form:input cssClass="input-large highlight" path="description" />
					<span class="help-inline"><s:message
							code="label.generic.all" text="All" />
						<form:errors path="description" cssClass="error" /></span>
				</div>
			</div>
			<div class="control-group">
				<label><s:message code="label.promotional.value"
						text="Value" /></label>
				<div class="controls">
					<form:input cssClass="input-large highlight" path="value" />
					<span class="help-inline"><s:message
							code="label.generic.all" text="All" />
						<form:errors path="value" cssClass="error" /></span>
				</div>
			</div>
			<div class="control-group">
				<label><s:message code="label.promotional.applicationLimit"
						text="Application Limit" /></label>
				<div class="controls">
					<form:input cssClass="input-large highlight"
						path="applicationLimit" />
					<span class="help-inline"><s:message
							code="label.generic.all" text="All" />
						<form:errors path="applicationLimit" cssClass="error" /></span>
				</div>
			</div>
			<div class="control-group">
				<label><s:message code="label.promotional.promoValidTill"
						text="Validity" /></label>
				<div class="controls">
					<input id="promoValidTill" name="promoValidTill"
						value="${voucher.promoValidTill}" class="small" type="text"
						data-date-format="<%=com.salesmanager.core.constants.Constants.DEFAULT_DATE_FORMAT%>"
						data-datepicker="datepicker">
					<script type="text/javascript">
	                                 $('#dateAvailable').datepicker();
	                                 </script>

					<%-- <form:input cssClass="input-large highlight small" path="promoValidTill"/> --%>
					<span class="help-inline"><s:message
							code="label.generic.all" text="All" />
						<form:errors path="promoValidTill" cssClass="error" /></span>
				</div>
			</div>
			<div class="control-group">
				<label><s:message code="label.promotional.active"
						text="Active" /></label>
				<div class="controls">
					<form:checkbox path="active" />
				</div>
			</div>
			<div class="control-group">
				<label><s:message code="label.promotional.promotionType"
						text="Promotion Type" /></label>
				<form:select path="promotionType">
					<form:options items="${promotionTypes}" />
				</form:select>
			</div>
			<div class="control-group">
				<label><s:message code="label.promotional.promotionApplied"
						text="Promotion Applied" /></label>
				<form:select path="promotionApplied">
					<form:options items="${promotionApplied}" />
				</form:select>
			</div>
			<form:hidden path="id" />
			<button type="submit" class="btn btn-default pull-right">
				Submit</button>

		</form:form>
	</div>
</div>