<%
response.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", -1);
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="/WEB-INF/shopizer-tags.tld" prefix="sm"%>

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
								
<sec:authorize access="!hasRole('AUTH_CUSTOMER') and fullyAuthenticated">
	<!-- no dual login -->
	<div id="signin" class="">
		<ul class="list-unstyled">
			<li><s:message code="label.security.loggedinas"
					text="You are logged in as" /> [<sec:authentication
					property="principal.username" />]. <s:message
					code="label.security.nologinacces.store"
					text="We can't display store logon box" /></li>
		</ul>
	</div>
</sec:authorize>
<sec:authorize access="hasRole('AUTH_CUSTOMER') and fullyAuthenticated">
	<%-- <a
		href="<c:url value="/shop/customer/review.html"/>?productId=${product.id}" />
	<button id="reviewButton" type="submit" class="btn btn-default">
		<s:message code="label.product.reviews.write" text="Write a review" />
	</button>
	</a> --%>
	<jsp:include
		page="/pages/shop/templates/prettydeal/components/reviews/review.jsp" />
</sec:authorize>
<sec:authorize
	access="!hasRole('AUTH_CUSTOMER') and !fullyAuthenticated">
	<p class="muted">
		<s:message code="label.product.reviews.logon.write"
			text="You have to be authenticated to write a review" />
	</p>
</sec:authorize>
<div id="reviewsDiv">
<c:if test="${reviews!=null}">
	<c:forEach items="${reviews}" var="review" varStatus="status">
		<div class="single-review" item-id="${review.id}">
			<div class="star-review ">
				<span class="green"><c:out value="${review.rating}"/><span class="star">★</span></span>
				<p>good looking product.</p>
				<div id="productRating<c:out value="${review.id}"/>"></div>
			</div>
			<div class="dec">
				<blockquote>
					<c:out value="${review.description}"/>
				</blockquote>
			</div>
			<div class="row">
				<div class="col-sm-6">
					<c:out value="${review.customer.firstName}" />&nbsp;<c:out value="${review.customer.lastName}"/>&nbsp;<c:out value="${rating.date}"/>&nbsp;<c:out value="${review.date}" />
				</div>
			</div>
		</div>
		<script>
			$(function() {
				$('#productRating<c:out value="${review.id}"/>').raty({
					readOnly : true,
					half : true,
					path : '<c:url value="/resources/img/stars/"/>',
					score : <c:out value="${review.rating}" />
				});
			});
		
			
		</script>
	</c:forEach>
</c:if>
</div>