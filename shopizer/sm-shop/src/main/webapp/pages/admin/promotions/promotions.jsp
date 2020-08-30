<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%@ page session="false" %>
<div class="tabbable">
   <jsp:include page="/common/adminTabs.jsp" />
	<div class="tab-content">
		<div class="tab-pane active" id="catalogue-section">
           <div class="sm-ui-component">
           		
           		<h3>
           			<s:message code="label.promotions.vouchers" text="Promotional Vouchers" />
				</h3>
				
				<br />
						<a href="/admin/promotions/createPromotionalVoucher.html?id=">Add New</a>
           			    <c:set value="/admin/promotions/page.html" var="pagingUrl" scope="request" />
						<c:set value="/admin/content/remove.html" var="removeUrl" scope="request" />
						<c:set value="/admin/content/pages/list.html" var="refreshUrl" scope="request" />
						<c:set value="/admin/promotions/createPromotionalVoucher.html" var="editUrl" scope="request"/>
						<c:set var="componentTitleKey" value="label.promotions.vouchers" scope="request" />
				
				<!-- Listing grid include -->

				<c:set var="entityId" value="id" scope="request"/>
				<c:set var="canRemoveEntry" value="true" scope="request" />
				<c:set var="gridHeader" value="/pages/admin/content/content-gridHeader.jsp" scope="request"/>
				<jsp:include page="/pages/admin/components/list.jsp"></jsp:include>
				<!-- End listing grid include -->
			

		</div>
	   </div>
	</div>
</div>	