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
<span class="leftnavOverlay"></span>
<section class="inner-page-banner" style="background:url('<c:url value="/resources/templates/prettydeal/img/terms_of_use.jpg" />') center; background-size:cover;position: relative; z-index: 0;">
  <div class="container">
    <div class="page-title text-center"> 
    <h1 class="text-uppercase">Refund Policy</h1>
    </div>
    </div>

</section>
<div class="container text-center-xs">
			<ol class="breadcrumb flat">
				<li><a href="/">Home</a></li>
				<li class="active">Refund Policy</li>
			</ol>
		</div>


<!-- ======== terms ======== -->

<section class="section inner-page-section wow fadeInUp">
  <div class="container">
    <div class="row"> 
     <div class="col-md-12 terms-page"> 
    <h2>Refund Policy</h2>
     <p>
     Our motto is customer satisfaction. In case, if you are not happy with the services provided, we will refund back the money, provided the reasons are genuine and proved after investigation. Please read the terms and conditions of each deal before buying it, it provides all the details about the services or the product you purchase and its redemption conditions.
     </p>
     <p>
     Please call us at +91 -  9888171749 from 10am to 6pm or write to us: <b>help@prettydeal.in</b>
     </p>
     <p>
     We will be refunding the amount under the below given conditions:
     	<ul>
     		<li>
     			Technical Issues: Double or duplicate order; double payment charged for the same order or in case of excess payment.
     		</li>
     		<li>
     			If you have any discrepancies with the services provided or product, provided reasons are genuine.
     		</li>
     		<li>
     			Booked deal of another branch by mistake and the same is not available in your city.
     		</li>
     	</ul>
     </p>
        <div class="terms-title">
        	<h2>Cancellation Eligibility</h2>
        </div>
		<p>
			<ul>
				<li>
					Please inform us within 24 hours of purchase for cancellation of order.
				</li>
				<li>
					Cancellation request can be genrated through our Contact Us form or direct email to <b>care@prettydeal.in</b>
				</li>
			</ul>
		</p>
        <div class="terms-title">
        	<h2>Exclusions</h2>
        </div>
		<p>
		No refund will be processed for consumed services.
		</p>        
         <div class="terms-title">
        	<h2>Refund Processing time</h2>
        </div>
		<p>
		Master/Visa Credit and Debit Cards: 7 Working Days.
		</p>
 	</div>
    </div>
  </div>
</section>