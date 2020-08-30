<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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
 




			<%-- <c:if test="${page!=null}">
			<div class="row-fluid">
          		    <div class="span12">
          			    <span id="homeText"><c:out value="${page.description}" escapeXml="false"/></span>
          		    </div>
			</div>
			</c:if>
			
			<br/>
			<sm:shopProductGroup groupName="FEATURED_ITEM"/>
			<sm:shopProductGroup groupName="SPECIALS"/>
			
			<c:if test="${requestScope.FEATURED_ITEM!=null || requestScope.SPECIALS!=null}" >
			<div class="row-fluid">
				<div class="span12">
					<ul class="nav nav-tabs home" id="product-tab">
						<c:if test="${requestScope.FEATURED_ITEM!=null}" ><li class="active"><a href="#tab1"><s:message code="menu.catalogue-featured" text="Featured items" /></a></li></c:if>
						<c:if test="${requestScope.SPECIALS!=null}" ><li<c:if test="${requestScope.FEATURED_ITEM==null}"> class="active"</c:if>><a href="#tab2"><s:message code="label.product.specials" text="Specials" /></a></li></c:if>
					</ul>							 
					<div class="tab-content">
						<!-- one div by section -->
						<c:if test="${requestScope.FEATURED_ITEM!=null}" >
						
						<div class="tab-pane active" id="tab1">
									<ul class="thumbnails product-list">
									    <!-- Iterate over featuredItems -->
										<c:set var="ITEMS" value="${requestScope.FEATURED_ITEM}" scope="request" />
										<c:set var="FEATURED" value="true" scope="request" />
	                         			<jsp:include page="/pages/shop/templates/bootstrap/sections/productBox.jsp" />
									</ul>
									
						</div>
						</c:if>
						<c:if test="${requestScope.SPECIALS!=null}" >
						<div class="tab-pane <c:if test="${requestScope.FEATURED_ITEM==null}">active</c:if>" id="tab2">
									<ul class="thumbnails product-list">
										<!-- Iterate over featuredItems -->
                         				<c:set var="ITEMS" value="${requestScope.SPECIALS}" scope="request" />
	                         			<jsp:include page="/pages/shop/templates/bootstrap/sections/productBox.jsp" />
									</ul>
						</div>
						</c:if>

					</div>							
				</div>
			</div>
			</c:if> --%>
<%
List<String> groups = new ArrayList();
groups.add("Deals Of The Day");
groups.add("Beauty_&_Wellness");
groups.add("Health_&_Fitness");
groups.add("Food_&_Drinks");
//groups.add("Ent");
groups.add("Fun_");
groups.add("Handlooms_");
//groups.add("Hotels");
request.setAttribute("groups", groups);
%>

<c:forEach items="${requestScope.groups}" var="group">
<!-- ======== FEATURED PRODUCTS ======== -->
<sm:shopProductGroup groupName="${group}"/>
<c:if
	test="${requestScope[group]!=null}">
	<section class="section featured-product wow fadeInUp p-t-50">
		<div class="container">
			<div class="row">
				<h3 class="section-title">
				<c:set var="tokens" value="${fn:split(group, '_')}" scope="request"/>
					<span><c:forEach items="${tokens}" var="token">
						<c:out value="${token}"/>
					</c:forEach></span>
				</h3>
				<div
					class="owl-carousel home-owl-carousel custom-carousel owl-theme outer-top-xs">
					<c:set var="ITEMS" value="${requestScope[group]}"
						scope="request" />
					<c:set var="FEATURED" value="true" scope="request" />
					<jsp:include
						page="/pages/shop/templates/prettydeal/sections/productBox.jsp" />
				</div>
			</div>
		</div>
	</section>
</c:if>
</c:forEach>
<!-- ===== FEATURED PRODUCTS : END ======= -->