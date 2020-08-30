<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%@ page session="false" %>

		<link href="<c:url value="/resources/templates/exoticamobilia/css/bootstrap.min.css" />" rel="stylesheet" type="text/css">
		<link href="<c:url value="/resources/templates/exoticamobilia/css/font-awesome.min.css" />" rel="stylesheet" type="text/css">
		<link href="<c:url value="/resources/templates/exoticamobilia/css/prettyPhoto.css" />" rel="stylesheet" type="text/css">
		<link href="<c:url value="/resources/templates/exoticamobilia/css/price-range.css" />" rel="stylesheet" type="text/css">
		<link href="<c:url value="/resources/templates/exoticamobilia/css/animate.css" />" rel="stylesheet" type="text/css">
		<link href="<c:url value="/resources/templates/exoticamobilia/css/main.css" />" rel="stylesheet" type="text/css">
		<link href="<c:url value="/resources/templates/exoticamobilia/css/responsive.css" />" rel="stylesheet" type="text/css">
		
		<!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->       
    <link rel="shortcut icon" href="<c:url value="/resources/templates/exoticamobilia/img/ico/favicon.ico" />">
	<link rel="shortcut icon" sizes="144x144" href="<c:url value="/resources/templates/exoticamobilia/img/ico/apple-touch-icon-144-precomposed.png" />">
	<link rel="shortcut icon" sizes="72x72" href="<c:url value="/resources/templates/exoticamobilia/img/ico/apple-touch-icon-72-precomposed.png" />">
	<link rel="shortcut icon" href="<c:url value="/resources/templates/exoticamobilia/img/ico/apple-touch-icon-57-precomposed.png" />">
		
		<!--<script src="<c:url value="/resources/js/jquery-1.10.2.min.js" />"></script>-->
		<script src="<c:url value="/resources/templates/exoticamobilia/js/jquery-1.11.1.min.js" />"></script>
		<!-- WEB FONTS -->
		<!--<link href="<c:url value="/resources/templates/bootstrap3/css/css.css" />" rel="stylesheet" type="text/css">-->
		
		<!-- CORE CSS -->
		<%-- <link href="<c:url value="/resources/templates/exoticamobilia/css/bootstrap.css" />" rel="stylesheet" type="text/css"> --%>

		<!-- more fonts, cursor up -->
        <%-- <link href="<c:url value="/resources/templates/exoticamobilia/css/fontello.css" />" rel="stylesheet" type="text/css">
        <link href="<c:url value="/resources/templates/exoticamobilia/css/magnific-popup.css" />" rel="stylesheet" type="text/css"> --%>
        <!--<link href="<c:url value="/resources/templates/exoticamobilia/css/owl.css" />" rel="stylesheet" type="text/css">-->
		<!--
		<link href="<c:url value="/resources/templates/exoticamobilia/css/magnific-popup.css" />" rel="stylesheet" type="text/css">
        <link href="<c:url value="/resources/templates/exoticamobilia/css/animations.css" />" rel="stylesheet" type="text/css">
		-->
		<%-- <link href="<c:url value="/resources/templates/exoticamobilia/css/responsive-slider.css" />" rel="stylesheet" type="text/css"> --%>
		<link rel="shortcut icon" href="<c:url value="/resources/templates/exoticamobilia/img/favicon.ico"/> "> 
		
		<!--  Theme -->

		<%-- <link href="<c:url value="/resources/templates/exoticamobilia/css/style.css" />" rel="stylesheet" type="text/css">
		<link href="<c:url value="/resources/templates/exoticamobilia/css/template.css" />" rel="stylesheet" type="text/css">
		<link href="<c:url value="/resources/templates/exoticamobilia/font-awesome-4.2.0/css/font-awesome.css" />" rel="stylesheet" type="text/css"> --%>
		
		
		<%-- <link href="<c:url value="/resources/templates/exoticamobilia/css/dark_gray.css" />" rel="stylesheet" type="text/css"> --%>
		
	
	
    
    	<!-- generic and common css file -->
    	<%-- <link href="<c:url value="/resources/css/sm.css" />" rel="stylesheet">
    	<link href="<c:url value="/resources/css/showLoading.css" />" rel="stylesheet"> --%>
    
    	<!-- ////////////// -->

    <!-- mini shopping cart template -->
    <script type="text/html" id="miniShoppingCartTemplate">
		{{#shoppingCartItems}}
			<tr id="{{productId}}" class="cart-product">
				<td>
			{{#image}}
					<img width="40" src="{{contextPath}}{{image}}">
			{{/image}}
			{{^image}}
					&nbsp
			{{/image}}
				</td>
				<td>{{quantity}}</td>
				<td>{{name}}</td>
				<td>{{price}}</td>
				<td><button productid="{{productId}}" class="close removeProductIcon" onclick="removeItemFromMinicart('{{id}}')">x</button></td>
			</tr>
		{{/shoppingCartItems}}
	</script>
	
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
	
	