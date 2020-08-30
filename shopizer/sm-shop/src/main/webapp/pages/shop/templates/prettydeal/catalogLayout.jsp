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
 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
  
 <%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  
 <c:set var="lang" scope="request" value="${requestScope.locale.language}"/> 
 
 
 <html xmlns="http://www.w3.org/1999/xhtml"> 
 
 
     <head>
        	 	<meta charset="utf-8">
    			<title><c:out value="${requestScope.PAGE_INFORMATION.pageTitle}" /></title>
				<meta http-equiv="X-UA-Compatible" content="IE=edge">
				<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    			<meta name="description" content="<c:out value="${requestScope.PAGE_INFORMATION.pageDescription}" />">
    			<meta name="author" content="<c:out value="${requestScope.MERCHANT_STORE.storename}"/>">
				<meta name="robots" content="index, follow"/>
				<meta name="classification" content="Regional: India: ${requestScope.PAGE_INFORMATION.pageTitle}"/>
				<meta name="audience" content="all"/>
				<meta name="content-Language" content="English"/>
				<meta name="distribution" content="global"/>
				<c:choose>
					<c:when test="${product != null}">
						<meta name="keywords" content="${fn:substring(product.description.keyWords,0,fn:length(product.description.keyWords)-1)}" />	
					</c:when>
					<c:otherwise>
						<meta name="keywords" content="${requestScope.PAGE_INFORMATION.pageKeywords}"/>
					</c:otherwise>
				</c:choose>
				
				<meta property="og:locale" content="en_US" />
				<meta property="og:type" content="website" />
				<meta property="og:title" content="${requestScope.PAGE_INFORMATION.pageTitle}" />
				<meta property="og:description" content="${requestScope.PAGE_INFORMATION.pageDescription}" />
				<meta property="og:url" content="http://prettydeal.in" />
				<meta property="og:site_name" content="Prettydeal.in" />
				<c:choose>
					<c:when test="${product != null}">
						<meta property="og:image" content='<sm:shopProductImage imageName="${product.image.imageName}" sku="${product.sku}"/>' />
					</c:when>
					<c:otherwise>
						<meta property="og:image" content='<c:url value="/resources/templates/prettydeal/img/home-banner.png" />' />
					</c:otherwise>
				</c:choose>
				<meta name="twitter:card" content="summary_large_image"/>
				<meta name="twitter:description" content="${requestScope.PAGE_INFORMATION.pageDescription}"/>
				<meta name="twitter:title" content="${requestScope.PAGE_INFORMATION.pageTitle}"/>
				<meta name="twitter:site" content="@prettydeal"/>
				<c:choose>
					<c:when test="${product != null}">
						<meta name="twitter:image" content='<sm:shopProductImage imageName="${product.image.imageName}" sku="${product.sku}"/>'/>
					</c:when>
					<c:otherwise>
						<meta property="twitter:image" content='<c:url value="/resources/templates/prettydeal/img/home-banner.png" />' />
					</c:otherwise>
				</c:choose>

                <jsp:include page="/pages/shop/templates/prettydeal/sections/shopLinks.jsp" />
 	</head>
 
 	<body>
 	 
	<div id="pageContainer" class="container1">
				 <jsp:include page="/pages/shop/common/customer/modalLogin.jsp" />
				<tiles:insertAttribute name="header" ignore="true"/>

				<tiles:insertAttribute name="navbar" ignore="true"/>

				<tiles:insertAttribute name="body" ignore="true"/>

				<tiles:insertAttribute name="footer" ignore="true"/>
				<a href="#" class="go-top"></a>
	</div>
	<!-- end container -->
	   <jsp:include page="/pages/shop/templates/prettydeal/sections/jsLinks.jsp" />

<script type="text/javascript">

$(document).ready(function() { 
	$('#searchField').typeahead({
		name: 'shopizer-search',
		<c:if test="${requestScope.CONFIGS['useDefaultSearchConfig'][requestScope.LANGUAGE.code]==true}">
		  <c:if test="${requestScope.CONFIGS['defaultSearchConfigPath'][requestScope.LANGUAGE.code]!=null}">
		prefetch: '<c:out value="${requestScope.CONFIGS['defaultSearchConfigPath'][requestScope.LANGUAGE.code]}"/>',
		  </c:if>
	    </c:if>


	    remote: {
    		url: '<c:url value="/services/public/search/${requestScope.MERCHANT_STORE.code}/${requestScope.LANGUAGE.code}/autocomplete.html"/>?q=%QUERY',
        	filter: function (parsedResponse) {
            	return parsedResponse;
        	}
    	},
		template: [
		'<p class="name">{{name}}</p>',
		'<p class="description">{{description}}</p>'
		].join(''),
		engine: Hogan
		});
});

</script>
 	</body>
 
 </html>
 
