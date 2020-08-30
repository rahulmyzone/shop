<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%@ page session="false" %>


	
    <script src="<c:url value="/resources/js/json2.js" />"></script>
    <script src="<c:url value="/resources/js/jquery-cookie.js" />"></script>
    <script src="<c:url value="/resources/js/shopping-cart.js" />"></script>
    <script src="<c:url value="/resources/templates/prettydeal/js/registration.js" />"></script>
    <script src="<c:url value="/resources/js/login.js" />"></script>
    <script src="<c:url value="/resources/js/jquery.showLoading.min.js" />"></script>
    <script src="<c:url value="/resources/js/shop-functions.js" />"></script>
    <script src="<c:url value="/resources/templates/prettydeal/js/bootstrap.min.js" />"></script>
    <script src="<c:url value="/resources/templates/prettydeal/js/owl.carousel.min.js" />"></script> 
	<script src="<c:url value="/resources/templates/prettydeal/js/wow.min.js" />"></script> 
	<script src="<c:url value="/resources/templates/prettydeal/js/jquery.flip.min.js" />"></script>
	<script src="<c:url value="/resources/templates/prettydeal/js/bootstrap-select.min.js" />"></script>
	<script src="<c:url value="/resources/templates/prettydeal/js/responsive-tabs.js" />"></script>
	<script src="<c:url value="/resources/js/hogan.js" />"></script>
	<script src="<c:url value="/resources/templates/prettydeal/js/customscript.js" />"></script>
	<jsp:include page="/resources/js/functions.jsp" />
	<script src="<c:url value="/resources/js/jquery-sort-filter-plugin.js" />"></script>
	<script src="<c:url value="/resources/js/typeahead.min.js" />"></script>
	<script src="<c:url value="/resources/templates/prettydeal/js/freshslider.min.js" />"></script>
	 
	 <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery.jssocials/1.4.0/jssocials.min.js"></script>

		<script>
        $("#share").jsSocials({
        	showLabel: false,
            showCount: false,
            shares: ["twitter", "facebook","pinterest","whatsapp"]
        });
    </script>
        <%-- <script type="text/javascript">

            $('#product-tab a:first').tab('show');
            $('#product-tab a').click(function (e) {
            		e.preventDefault();
            		$(this).tab('show');
            }) 
            
            
        </script> --%>
     

    