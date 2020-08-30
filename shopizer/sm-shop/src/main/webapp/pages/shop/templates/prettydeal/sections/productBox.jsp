<%
response.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", -1);
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="/WEB-INF/shopizer-tags.tld" prefix="sm" %> 
 
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<c:forEach items="${requestScope.ITEMS}" var="product">
	<div class="item item-carousel">
      <div class="products">
          <div class="product-image">
            <div class="image tag-line"> 
            <a href="<c:url value="/shop/product/" /><c:out value="${product.description.friendlyUrl}"/>.html<sm:breadcrumbParam productId="${product.id}"/>">
            <img id="img_${product.id}" src='<sm:shopProductImage imageName="${product.image.imageName}" sku="${product.sku}"/>' alt="" class="img-responsive"/>
           	<c:choose>
           		<c:when test="${product.finalPriceObj.discountPercent gt 0}">
           			<div class="tag"><span><c:out value="${product.finalPriceObj.discountPercent}% Off"/></span></div>
           		</c:when>
           		<c:when test="${product.description.highlights != null && product.description.highlights != ''}">
           			<div class="tag"><span><c:out value="${product.description.highlights}"/></span></div>
           		</c:when>
           	</c:choose>
             </a> 
            </div>
           </div>
          <div class="product-info text-left">
            <c:forEach items="${product.categories}" var="c">
            	<h5><a href='<c:url value="/shop/category/${c.description.friendlyUrl}.html"/><sm:breadcrumbParam categoryId="${c.id}"/>'><c:out value="${c.description.name}"/></a></h5>
            </c:forEach>
            <h3 class="name"><a href="<c:url value="/shop/product/" /><c:out value="${product.description.friendlyUrl}"/>.html<sm:breadcrumbParam productId="${product.id}"/>">${product.manufacturer.description.name}</a></h3>
            <h4><i class="fa fa-inr"></i> <c:out value="${product.price}"/></h4>
            <div class="description">${product.description.name}</div>
             <a href="#" productId="${product.id}" class="addToCart product-btn hvr-sweep-to-right">Grab Now</a>
          </div>
        </div>
    </div>
</c:forEach>