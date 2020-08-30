<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false" %>



              <div class="btn-group" style="z-index:400000;">
                    <button class="btn btn-info dropdown-toggle" data-toggle="dropdown"><s:message code="label.promotions.configure" text="Options"/> ... <span class="caret"></span></button>
                     <ul class="dropdown-menu">
				    	<li><a href="<c:url value="/admin/promotions/createPromotionalVoucher.html" />?id=<c:out value="${id}"/>"><s:message code="label.promotions.details" text="Details" /></a></li>
				    	<li><a href="<c:url value="/admin/promotions/products/list.html" />?id=<c:out value="${id}"/>"><s:message code="label.promotions.products" text="Associated Products" /></a></li>
				    	<li><a href="<c:url value="/admin/promotions/createPromotionalVoucher.html" />?id=<c:out value="${id}"/>"><s:message code="label.promotions.customers" text="Associated Customers" /></a></li>
				    	<li><a href="<c:url value="/admin/promotions/categories/list.html" />?id=<c:out value="${id}"/>"><s:message code="label.promotions.categories" text="Associated Categories" /></a></li>
                     </ul>
              </div><!-- /btn-group -->
			  <br/>