<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%@ page session="false" %>				
				
<script>
	

	
</script>


<div class="tabbable">

  					
					<jsp:include page="/common/adminTabs.jsp" />



  					<div class="tab-content">

    					<div class="tab-pane active" id="catalogue-section">

								
								


								<div class="sm-ui-component">
				<h3>
						<c:out value="${group}" escapeXml="false"/>
				</h3>	
				<br/>
				<div class="alert alert-info">
					<s:message code="label.product.group.meassage" text="Drag and drop product from product list to the product group box"/>
				</div>			
		
      			<!-- Listing grid include -->
				 <c:set value="/admin/products/paging.html" var="pagingUrl" scope="request"/>
				 <c:url value="/admin/products/group/details/paging.html" var="containerFetchUrl" scope="request">
				 	<c:param name="code" value="${group}"></c:param>
				 </c:url>
				 <c:url value="/admin/products/group/details/removeItem.html" var="containerRemoveUrl" scope="request">
				 	<c:param name="code" value="${group}"></c:param>
				 </c:url>
				 <c:url value="/admin/products/group/details/addItem.html" var="containerAddUrl" scope="request">
				 	<c:param name="code" value="${group}"></c:param>
				 </c:url>
				 <c:set value="/admin/products/group/details/update.html" var="containerUpdateUrl" scope="request"/>
				 <c:set value="/admin/products/editProduct.html" var="editUrl" scope="request"/>
				 <c:url value="/admin/products/group/edit.html" var="reloadUrl" scope="request">
				 	<c:param name="code" value="${group}"></c:param>
				 </c:url>
				 <c:set var="componentTitleKey" value="label.product.customGroup.title" scope="request"/>
				 <c:set var="gridHeader" value="/pages/admin/products/featured-gridHeader.jsp" scope="request"/>
				 <c:set var="gridHeaderContainer" value="/pages/admin/products/product-gridHeader.jsp" scope="request"/>
				 <c:set var="canRemoveEntry" value="true" scope="request"/>

            	 <jsp:include page="/pages/admin/components/product-container.jsp"></jsp:include> 
				 <!-- End listing grid include -->


      					</div>
      					

      			     
      			     


      			     
      			     
    


   					</div>


  					</div>

				</div>