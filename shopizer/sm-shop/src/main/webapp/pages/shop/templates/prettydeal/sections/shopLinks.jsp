<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%@ page session="false" %>

	<!-- required common scripts -->
	<script src="<c:url value="/resources/js/jquery-1.10.2.min.js" />"></script>
    <script src="<c:url value="/resources/js/jquery-ui.min.js" />"></script>
    <!-- specific css -->
    <link href="<c:url value="/resources/templates/prettydeal/css/bootstrap.min.css" />" rel="stylesheet">
    <%-- <link href="<c:url value="/resources/templates/prettydeal/css/font-awesome.min.css" />" rel="stylesheet"> --%>
    <link type="text/css" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
    
    <link href="<c:url value="/resources/templates/prettydeal/css/owl.carousel.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/templates/prettydeal/css/fonts.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/templates/prettydeal/css/animate.min.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/templates/prettydeal/css/hover-min.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/templates/prettydeal/css/bootstrap-select.min.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/templates/prettydeal/css/bootstrap-responsive-tabs.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/templates/prettydeal/css/style.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/templates/prettydeal/css/responsive.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/templates/prettydeal/css/freshslider.min.css" />" rel="stylesheet">
    
    <link type="text/css" rel="stylesheet" href="https://cdn.jsdelivr.net/jquery.jssocials/1.4.0/jssocials.css" />

	<link type="text/css" rel="stylesheet" href="https://cdn.jsdelivr.net/jquery.jssocials/1.4.0/jssocials-theme-minima.css" />
	<link href="https://fonts.googleapis.com/css?family=Lobster|Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i|Roboto+Condensed:300,300i,400,400i,700,700i" rel="stylesheet">
    
    
    
    <!-- generic and common css file -->
    <%-- <link href="<c:url value="/resources/css/sm.css" />" rel="stylesheet">--%>
    <link href="<c:url value="/resources/css/showLoading.css" />" rel="stylesheet"> 
    
    <!-- template css file -->
   <%--  <link href="<c:url value="/resources/templates/bootstrap/css/theme.css" />" rel="stylesheet"> --%>
    
    

    
	<c:if test="${requestScope.CONFIGS['google_analytics_url'] != null}">	
	<script type="text/javascript">
	//<![CDATA[ 
		  <!-- google analytics -->
	  	   var _gaq = _gaq || [];
	  	   _gaq.push(['_setAccount', '<c:out value="${requestScope.CONFIGS['google_analytics_url']}"/>']);
	  	   _gaq.push(['_trackPageview']);

	  	   (function() {
	    		var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
	    		ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
	   		 var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	  	   })();
	  	//]]> 
	</script>
	</c:if>
	
	