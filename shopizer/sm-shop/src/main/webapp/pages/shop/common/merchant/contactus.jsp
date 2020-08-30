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

<!--Set google map API key -->
<c:if test="${requestScope.CONFIGS['displayStoreAddress'] == true}">
<script type="text/javascript"
      src="https://maps.googleapis.com/maps/api/js?sensor=true">
</script>
</c:if>

<script type="text/javascript">

var RecaptchaOptions = {
	    theme : 'clean'
};


$(document).ready(function() {
	
	isFormValid();
	$("input[type='text']").on("change keyup paste", function(){
		isFormValid();
	});
	$("#comment").on("change keyup paste", function(){
		isFormValid();
	});
	
    $("#submitContact").click(function() {
    	sendContact();
    });

});


function sendContact(){
	$('#pageContainer').showLoading();
	$(".alert-error").hide();
	$(".alert-success").hide();
	var data = $('#contactForm').serialize();
	//console.log(data);
	$.ajax({
	  type: 'POST',
	  url: '<c:url value="/shop/store/${requestScope.MERCHANT_STORE.code}/contact"/>',
	  data: data,
	  cache: false,
	  dataType: 'json',
	  success: function(response){
		  
		    $('#pageContainer').hideLoading();
		  	if(response.errorMessage!=null && response.errorMessage!='') {
		  		$(".alert-error").show();
				$(".alert-success").hide();
		  		return;
		  	}

			$(".alert-error").hide();
			$(".alert-success").show();
	  },
	  error: function(xhr, textStatus, errorThrown) {
	    	$('#pageContainer').hideLoading();
	  		alert('error ' + errorThrown);
	  }

	});
	
}


 


 function isFormValid() {
		var $inputs = $('#contactForm').find(':input');
		var valid = true;
		var firstErrorMessage = null;
		$inputs.each(function() {
			if($(this).hasClass('required')) {				
				var fieldValid = isFieldValid($(this));
				if(!fieldValid) {
					valid = false;
				}
			}
			//if has class email
			if($(this).hasClass('email')) {	
				var emailValid = validateEmail($(this).val());
				//console.log('Email is valid ? ' + emailValid);
				if(!emailValid) {
					valid = false;
				}
			}
		});
		
		//console.log('Form is valid ? ' + valid);
		if(valid==false) {//disable submit button
			$('#submitContact').addClass('btn-disabled');
			$('#submitContact').prop('disabled', true);
		} else {
			$('#submitContact').removeClass('btn-disabled');
			$('#submitContact').prop('disabled', false);
		}
 }
 
 
 function isFieldValid(field) {
		var validateField = true;
		
		var fieldId = field.prop('id');
		var value = field.val();
		
		//console.log('Check id ' + fieldId + ' and value ' + value);
		if(!emptyString(value)) {
			field.css('background-color', '#FFF');
			return true;
		} else {
			field.css('background-color', '#FFC');
			return false;
		} 
 }



</script>


	<span class="leftnavOverlay"></span>
<section class="inner-page-banner" style="background:url('<c:url value="/resources/templates/prettydeal/img/contact-us.jpg" />') center; background-size:cover;position: relative; z-index: 0;">
  <div class="container">
    <div class="page-title text-center"> 
    <h1 class="text-uppercase">Contact us</h1>
    <p>Feel free to contact us</p>
    </div>
    </div>

</section>
<div class="container text-center-xs">
			<ol class="breadcrumb flat">
				<li><a href="#">Home</a></li>
				<li class="active">Contact us</li>
			</ol>
		</div>


<!-- ======== contact us ======== -->

<section class="section inner-page-section wow fadeInUp p-t-50">
  <div class="main-container container text-center-xs">
		<!-- Nested Row Starts -->
			<div class="row">
			<!-- Mainarea Starts -->
				<div class="col-sm-8 col-xs-12">
					<h1 class="main-heading-1 text-spl-color text-uppercase text-normal">Get in Touch</h1>
					<p class="lead">
						You can contact us any way that is convenient for you. <br>
						We are available 24/7 via phone or email.
					</p>
					<p class="text-medium">
						You can also use a quick contact form below or visit our office personally.
					</p>
				<!-- Contact Form Wrap Starts -->
					<div class="contact-form-wrap">
						<form:form action="#" method="POST" id="contactForm" class="contact-form" name="contactForm" commandName="contact">
						<!-- Nested Row Starts -->
							<div id="store.success" class="alert alert-success" style="display:none;"><s:message code="message.email.success" text="Your message has been sent"/></div>
							<div id="store.error" class="alert alert-error" style="display:none;"><s:message code="message.email.success" text="An error occurred while sending your message, pleas try again later"/></div>
                            <form:errors id="contactForm" path="*" cssClass="alert alert-error" element="div" />
							<div class="row">
							<!-- First Name Filed Starts -->
								<div class="col-sm-6 col-xs-12">
									<div class="form-group">
										<label for="fname" class="sr-only">First Name: </label>
										<form:input path="name" cssClass="form-control flat" id="name" title="${msgName}" required="required" placeholder="Your First Name"/>
										<!-- <input type="text" class="form-control flat" name="fname" id="fname" required="required" placeholder="Your First Name"> -->
									</div>
								</div>
							<!-- First Name Filed Ends -->
							<!-- Last Name Filed Starts -->
								<div class="col-sm-6 col-xs-12">
									<div class="form-group">
										<label for="lname" class="sr-only">Last Name: </label>
										<%-- <form:input path="lastName" cssClass="form-control flat" id="name" title="${msgName}" required="required" placeholder="Your First Name"/> --%>
										<input type="text" class="form-control flat" name="lname" id="lname" required="required" placeholder="Your Last Name">
									</div>
								</div>
							<!-- Last Name Filed Ends -->
							<!-- E-mail Filed Starts -->
								<div class="col-xs-12">
									<div class="form-group">
										<label for="email" class="sr-only">Email ID: </label>
										<input type="text" class="form-control flat" name="email" id="email" required="required" placeholder="Your E-mail">
									</div>
								</div>
							<!-- E-mail Filed Ends -->
							<!-- Message Filed Starts -->
								<div class="col-xs-12">
									<div class="form-group">
										<label for="message" class="sr-only">Message: </label>
										<textarea class="form-control flat" rows="8" name="message" id="message" required placeholder="Message"></textarea>
									</div>
								</div>
							<!-- Message Filed Ends -->
							<!-- Send Button Starts -->
								<div class="col-xs-12">
									<input type="submit" class="btn btn-secondary btn-big animation" value="Send Message">
								</div>
							<!-- Send Button Ends -->
							</div>
						<!-- Nested Row Ends -->
						</form:form>
					<!-- Contact Form Ends -->
					</div>
				<!-- Contact Form Wrap Ends -->
				</div>
			<!-- Mainarea Ends -->
			<!-- Spacer For Extra Small Screen Starts -->
				<div class="col-xs-12 hidden visible-xs">
					<p class="spacer-small"></p>
				</div>
			<!-- Spacer For Extra Small Screen Ends -->
			<!-- Sidearea Starts -->
				<div class="col-sm-4 col-xs-12">
				<!-- Headquarters Starts -->
					<div class="sblock-2">
						<h3>Our Office</h3>
						<ul class="list-unstyled address-list">
							<li class="clearfix">
								<i class="fa fa-map-marker pull-left"></i> 
								<span class="pull-left">Address : 4700 chandigarh Blvd #175, <br>chandigarh, FL 32839, india.</span>
							</li>
							<li>
								<i class="fa fa-phone"></i> 
								+1800 - 111 - 3333
							</li>
							<li>
								<i class="fa fa-envelope"></i> 
								<a href="mailto:yourfriend@lawattorny">yourfriend@lawattorny</a>
							</li>
						</ul>
						<h3 class="sub-heading-2 text-normal">Follow Us</h3>
					<ul class="list-unstyled list-inline contact-sm-links animation">
						<li><a href="#"><i class="fa fa-facebook"></i></a></li>
						<li><a href="#"><i class="fa fa-twitter"></i></a></li>
						<li><a href="#"><i class="fa fa-google-plus"></i></a></li>
						<li><a href="#"><i class="fa fa-instagram"></i></a></li>
						<li><a href="#"><i class="fa fa-pinterest-p"></i></a></li>
					</ul>
					</div>
				<!-- Headquarters Ends -->
				<!-- Branch Office Starts -->
					<%-- <div class="sblock-2">
						<h3>Branch Office</h3>
						<ul class="list-unstyled address-list">
							<li class="clearfix">
								<i class="fa fa-map-marker pull-left"></i> 
								<span class="pull-left">Address : 4700 chandigarh Blvd #175</span>
							</li>
							<li>
								<i class="fa fa-phone"></i> 
								+1800 - 111 - 3333
							</li>
							<li>
								<i class="fa fa-envelope"></i> 
								<a href="mailto:yourfriend@lawattorny">yourfriend@lawattorny</a>
							</li>
						</ul>
				
				<!-- Branch Office Ends -->
				<!-- Follow Us Starts -->
					<h3 class="sub-heading-2 text-normal">Follow Us</h3>
					<ul class="list-unstyled list-inline contact-sm-links animation">
						<li><a href="#"><i class="fa fa-facebook"></i></a></li>
						<li><a href="#"><i class="fa fa-twitter"></i></a></li>
						<li><a href="#"><i class="fa fa-google-plus"></i></a></li>
						<li><a href="#"><i class="fa fa-instagram"></i></a></li>
						<li><a href="#"><i class="fa fa-pinterest-p"></i></a></li>
					</ul>
				<!-- Follow Us Ends -->
                	</div> --%>
				</div>
			<!-- Sidearea Ends -->
			</div>
		<!-- Nested Row Ends -->
		</div>
</section>

<!-- ===== contact end ======= -->
<div class="contact-page-map  p-t-50">
<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d27431.344718481723!2d76.73498787446066!3d30.74880223649123!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x390fed0be66ec96b%3A0xa5ff67f9527319fe!2sChandigarh!5e0!3m2!1sen!2sin!4v1484070511362" width="100%" height="300" frameborder="0" style="border:0" allowfullscreen></iframe>
</div>
