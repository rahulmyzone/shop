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
						<s:message code="menu.catalogue-featured" text="Featured items" />
				</h3>	
				<br/>
				<div class="alert alert-info">
					<s:message code="label.product.featured.meassage" text="Drag and drop product from product list to featured items box"/>
				</div>			
		
      			<!-- Listing grid include -->
				 <c:set value="/admin/promotions/products/paging.html?id=${voucher.id}" var="pagingUrl" scope="request"/>
				 <c:set value="/admin/promotions/products/paging.html?id=${voucher.id}" var="containerFetchUrl" scope="request"/>
				 <c:set value="/admin/promotions/products/remove.html?voucherId=${voucher.id}" var="containerRemoveUrl" scope="request"/>
				 <c:set value="FEATURED" var="removeEntity" scope="request"/>
				 <c:set value="/admin/promotions/products/addItem.html?id=${voucher.id}" var="containerAddUrl" scope="request"/>
				 <c:set value="/admin/catalogue/featured/update.html" var="containerUpdateUrl" scope="request"/>
				 <c:set value="/admin/products/editProduct.html" var="editUrl" scope="request"/>
				 <c:set value="/admin/promotions/products/list.html?id=${voucher.id}" var="reloadUrl" scope="request"/>
				 <c:set var="componentTitleKey" value="menu.catalogue-featured" scope="request"/>
				 <c:set var="gridHeader" value="/pages/admin/products/featured-gridHeader.jsp" scope="request"/>
				 <c:set var="gridHeaderContainer" value="/pages/admin/products/product-gridHeader.jsp" scope="request"/>
				 <c:set var="canRemoveEntry" value="true" scope="request"/>

            	 <jsp:include page="/pages/admin/components/product-container.jsp"></jsp:include> 
				 <!-- End listing grid include -->


      					</div>
   					</div>
  					</div>

				</div>