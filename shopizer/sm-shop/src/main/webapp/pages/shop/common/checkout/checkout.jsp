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
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="/WEB-INF/shopizer-tags.tld" prefix="sm" %> 
 
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<script src="<c:url value="/resources/js/jquery.maskedinput.min.js" />"></script>

<!-- subtotals template -->
<script type="text/html" id="subTotalsTemplate">
		{{#subTotals}}
			<tr class="subt"> 
				<td colspan="2">{{title}}</td> 
				<td><strong><i class="fa fa-inr"></i> {{total}}</strong></td> 
			</tr>
		{{/subTotals}}
</script>

<!-- total template -->
<script type="text/html" id="totalTemplate">
<span class="total-box-grand-total">
	<font class="total-box-label">
		<font class="total-box-price"><i class="fa fa-inr"></i> {{total}}</font>
	</font>
</span>
</script>

<!-- shipping template -->
<script type="text/html" id="shippingTemplate">

		<label class="control-label">
			<s:message code="label.shipping.options" text="Shipping options"/>
			{{#showHandling}}
				&nbsp;(<s:message code="label.shipping.handlingfees" text="Handling fees" />&nbsp;{{handlingText}})
			{{/showHandling}}			       				
		</label> 
		<div id="shippingOptions" class="controls">
			{{#shippingOptions}}	
				<label class="radio"> 
					<input type="radio" name="selectedShippingOption.optionId" class="shippingOption" id="{{optionId}}" value="{{optionId}}" {{#checked}} checked="checked"{{/checked}}> 
					{{optionName}} - {{optionPriceText}}
				</label>
			{{/shippingOptions}}						
		</div>

</script>


<script>

<!-- checkout form id -->
var checkoutFormId = '#checkoutForm';
var formErrorMessageId = '#formErrorMessage';


function isFormValid() {
	$(formErrorMessageId).hide();//reset error message
	var $inputs = $(checkoutFormId).find(':input');
	var valid = true;
	var firstErrorMessage = null;
	$inputs.each(function() {
		if($(this).hasClass('required')) {
			var fieldValid = isCheckoutFieldValid($(this));
			log($(this).attr('id') + ' Is valid ' + fieldValid);
			if(!fieldValid) {
				if(firstErrorMessage==null) {
					log('Title ' + $(this).attr('title'));
					if($(this).attr('title')) {
						firstErrorMessage = $(this).attr('title');
					}
				}
				valid = false;
			}
		}
		if($(this).hasClass('email')) {	
			var emailValid = validateEmail($(this).val());
			//console.log('Email is valid ? ' + emailValid);
			if(!emailValid) {
				if(firstErrorMessage==null) {
					firstErrorMessage = '<s:message code="messages.invalid.email" text="Invalid email address"/>';
					valid = false;
				}
			}
		}
	});
	if($(this).hasClass('billing-phone')) {	
		var phoneNumber = $(this).val();
		if(phoneNumber.length < 10){
			if(firstErrorMessage==null) {
				firstErrorMessage = '<s:message code="messages.invalid.phone" text="Invalid phone number"/>';
				valid = false;
			}
		}
	}
	//display - hide shipping
    if ($('#shipToBillingAdress').is(':checked')) {
	    $('#deliveryBox').hide();
    } else {
	    $('#deliveryBox').show();
    }
	
	//console.log('Form is valid ? ' + valid);
	if(valid==false) {//disable submit button
		if(firstErrorMessage!=null) {
			$(formErrorMessageId).addClass('alert-error alert-danger');
			$(formErrorMessageId).removeClass('alert-success');
			$(formErrorMessageId).html('<!--<img src="<c:url value="/resources/img/icon_error.png"/>" width="40"/>&nbsp;--><strong><font color="red">' + firstErrorMessage + '</font></strong>');
			$(formErrorMessageId).show();
		}
		$('#submitOrder').addClass('btn-disabled');
		$('#submitOrder').prop('disabled', true);
	} else {
		$(formErrorMessageId).removeClass('alert-error alert-danger');
		$(formErrorMessageId).addClass('alert-success');
		$(formErrorMessageId).html('<!--<img src="<c:url value="/resources/img/icon_success.png"/>" width="40"/>&nbsp;--><strong><s:message code="message.order.canprocess" text="The order can be completed"/></strong>');
		$(formErrorMessageId).show();
		$('#submitOrder').removeClass('btn-disabled');
		$('#submitOrder').prop('disabled', false);
	}
}

function setPaymentModule(module) {
	//console.log('Module - ' + module);
	$('#paymentModule').val(module);	
}

function isCheckoutFieldValid(field) {
	var validateField = true;
	var fieldId = field.prop('id');
	var value = field.val();
	if (fieldId.indexOf("creditcard") >= 0) {
		validateField = false;	//ignore credit card number field
	}
	if(!field.is(':visible')) {
		validateField = false; //ignore invisible fields
	}
	

	//shipping information
	<c:if test="${shippingQuote!=null}">
	if ($('#shipToBillingAdress').is(':checked')) {
		//validate shipping fields
		if (fieldId.indexOf("delivery") >= 0) {
			validateField = false; //ignore shipping fields when ship to billing
		}
	}
	</c:if>
	<c:if test="${fn:length(paymentMethods)>0}">
		//if any payment option need validation insert here
		//console.log($('input[name=paymentMethodType]:checked', checkoutFormId).val());
		if($('input[name=paymentMethodType]:checked', checkoutFormId).val()=='CREDITCARD') {
			if (fieldId.indexOf("creditcard") >= 0) {
				if(fieldId!='creditcard_card_number') {
					validateField = true;// but validate credit card fields when credit card is selected
				}
				if(fieldId=='creditcard_card_number') {
					return isCreditCardValid();// validate credit card number differently
				}
			}
		}
	</c:if>
	

	
	if(!validateField) {
		return true;
	}
	
	if(field.attr('type')=='checkbox') {
		if(field.is(":checked")) {
			return true;
		} else {
			return false;
		}
	}
	
	if(!emptyString(value)) {
		field.css('background-color', '#FFF');
		return true;
	} else {
		field.css('background-color', '#FFC');
		return false;
	}
}

$.fn.addItems = function(div, data, defaultValue) {
	//console.log('Populating div ' + div + ' defaultValue ' + defaultValue);
	var selector = div + ' > option';
	var defaultExist = false;
    $(selector).remove();
        return this.each(function() {
            var list = this;
            $.each(data, function(index, itemData) {
            	//console.log(itemData.code + ' ' + defaultValue);
            	if(itemData.code==defaultValue) {
            		defaultExist = true;
            	}
                var option = new Option(itemData.name, itemData.code);
                list.add(option);
            });
            if(defaultExist && (defaultValue!=null && defaultValue!='')) {
           	 	$(div).val(defaultValue);
            }
     });
};

$.fn.serializeObject = function()
{
   var o = {};
   var a = this.serializeArray();
   $.each(a, function() {
       if (o[this.name]) {
           if (!o[this.name].push) {
               o[this.name] = [o[this.name]];
           }
           o[this.name].push(this.value || '');
       } else {
           o[this.name] = this.value || '';
       }
   });
   return o;
};

function showErrorMessage(message) {
	
	
	showResponseErrorMessage(message);
	$('#submitOrder').addClass('btn-disabled');
	$('#submitOrder').prop('disabled', true);
	
	$(formErrorMessageId).addClass('alert-error alert-danger');
	$(formErrorMessageId).removeClass('alert-success');
	$(formErrorMessageId).html('<!--<img src="<c:url value="/resources/img/icon_error.png"/>" width="40"/>&nbsp;--><strong><font color="red">' + message + '</font></strong>');
	$(formErrorMessageId).show();
	
}

function showResponseErrorMessage(message) {
	
	$('#checkoutError').addClass('alert');
	$('#checkoutError').addClass('alert-error alert-danger');
	$('#checkoutError').html(message);
	
}

function resetErrorMessage() {
	
	$('#checkoutError').html('');
	$('#checkoutError').removeClass('alert');
	$('#checkoutError').removeClass('alert-error alert-danger');
	$('.error').html('');
	
}



/** 
 * Specify 
 * div list container
 * text div (shown or not)
 * selected countryCode
 * preselected value
 * callback to invoke
 */
function getZones(listDiv, textDiv, countryCode, defaultValue, callBackFunction){
	$.ajax({
	  type: 'POST',
	  url: '<c:url value="/shop/reference/provinces.html"/>',
	  data: 'countryCode=' + countryCode + '&lang=${requestScope.LANGUAGE.code}',
	  dataType: 'json',
	  success: function(response){
			var status = response.response.status;
			var data = response.response.data;
			//console.log(status);
			if((status==0 || status ==9999) && data) {

				//console.log(data);
				if(data && data.length>0) {
					$(listDiv).addClass('required');
					$(listDiv).show();  
					$(textDiv).removeClass('required');
					$(textDiv).hide();
					$(listDiv).addItems(listDiv, data, defaultValue);		
				} else {
					$(listDiv).removeClass('required');
					$(listDiv).hide();  
					$(textDiv).addClass('required');
					$(textDiv).show();
					if(defaultValue!=null || defaultValue !='') {
						$(textDiv).val(defaultValue);
					}
				}
			} else {
				$(listDiv).hide();             
				$(textDiv).show();
			}
			isFormValid();
			if(callBackFunction!=null) {
				callBackFunction();
			}
	  },
	    error: function(xhr, textStatus, errorThrown) {
	  	alert('error ' + errorThrown);
	  }

	});
	
}


function setCountrySettings(prefix, countryCode) {
	//add masks to your country
	//console.log('Apply mask ' + countryCode);
	
	var phoneSelector = '.' + prefix + '-phone';
	var postalCodeSelector = '.' + prefix + '-postalCode';
	
	if(countryCode=='CA') {//mask for canada
		$(phoneSelector).mask("?(999) 999-9999");
		$(postalCodeSelector).mask("?*** ***");
		return;
	}
	if(countryCode=='US') {// mask for united states
		$(phoneSelector).mask("?(999) 999-9999");
		$(postalCodeSelector).mask("?99999");
		return;
	}
	
	$(phoneSelector).unmask();
	$(postalCodeSelector).unmask();

	
}



function bindActions() {
	

    $(".shippingOption").click(function() {
    	calculateTotal();
    });
    
    <!-- shipping / billing decision -->
    $("#shipToBillingAdress").click(function() {
    	shippingQuotes();	
    	if ($('#shipToBillingAdress').is(':checked')) {
    		$('#deliveryBox').hide();
    		isFormValid();
    	} else {
    		$('#deliveryBox').show();
    		isFormValid();
    	}
    });
    
	$("#submitOrder").click(function(e) {
		e.preventDefault();//do not submit form
		resetErrorMessage();
		setCountrySettings('billing',$('.billing-country-list').val());
		setCountrySettings('delivery',$('.shipping-country-list').val());
		//$('#submitOrder').disable();
		$('#pageContainer').showLoading();
		var paymentSelection = $('input[name=paymentMethodType]:checked', checkoutFormId).val();
		if(paymentSelection.indexOf('PAYPAL')!=-1) {
			initPayment(paymentSelection);
		} else if(paymentSelection.indexOf('STRIPE')!=-1) {
			initStripePayment();
		}else if(paymentSelection.indexOf('ATOM')!=-1) {
			initPayment(paymentSelection);
		}else if(paymentSelection.indexOf('PAYTM')!=-1) {
			initPayment(paymentSelection);
		} else {
			//submit form
			$('#pageContainer').hideLoading();
			//$('#checkoutForm').submit();
			
		}
    });
}



function shippingQuotes(){
	resetErrorMessage();
	$('#pageContainer').showLoading();
	var data = $(checkoutFormId).serialize();
	//console.log(data);
	
	$.ajax({
	  type: 'POST',
	  url: '<c:url value="/shop/order/shippingQuotes.html"/>',
	  data: data,
	  cache: false,
	  dataType: 'json',
	  success: function(response){
		  
		    $('#pageContainer').hideLoading();
		  	if(response.errorMessage!=null && response.errorMessage!='') {
		  		showErrorMessage(response.errorMessage);
		  		return;
		  	}

			//console.log(response);
			
			$('#summary-table tr.subt').remove();
			$('#totalRow').html('');
			var subTotalsTemplate = Hogan.compile(document.getElementById("subTotalsTemplate").innerHTML);
			var totalTemplate = Hogan.compile(document.getElementById("totalTemplate").innerHTML);
			var quotesTemplate = Hogan.compile(document.getElementById("shippingTemplate").innerHTML);
			var subTotalsRendered = subTotalsTemplate.render(response);
			var totalRendred = totalTemplate.render(response);
			
			if(response.shippingSummary!=null) {
				//create extra fields
				summary = response.shippingSummary;
				for(var i = 0; i< summary.shippingOptions.length; i++) {
					if(summary.shippingOptions[i].optionId == summary.selectedShippingOption.optionId) {
						summary.shippingOptions[i].checked = true;
						break;
					}
				}
				if(summary.handling && summary.handling>0) {
					summary.showHandling = true;
				}
				
				//render summary
				$('#shippingSection').html('');
				var quotesRendered = quotesTemplate.render(response.shippingSummary);
				//console.log(quotesRendered);
				$('#shippingSection').html(quotesRendered);
				bindActions();
			} 
			$('#summaryRows').append(subTotalsRendered);
			$('#totalRow').html(totalRendred);
			isFormValid();
	  },
	    error: function(xhr, textStatus, errorThrown) {
	    	$('#pageContainer').hideLoading();
	  		alert('error ' + errorThrown);
	  }

	});
	
}
function initPayment(paymentSelection) {
	var url = '<c:url value="/shop/order/payment/init/"/>' + paymentSelection + '.html';
	var data = $(checkoutFormId).serialize();
	
	$.ajax({
		  type: 'POST',
		  url: url,
		  data: data,
		  cache: false,
		  dataType: 'json',
		  success: function(response){
			  	//$('#submitOrder').enable();
			    $('#pageContainer').hideLoading();
				var resp = response.response;
				var status = resp.status;
				if(status==0 || status ==9999) {
					if(resp.data[0].paymentType == 'ATOM'){
						location.href=resp.data[0].redirecturl;
					}else if(resp.data[0].paymentType == 'PAYTM'){
						$('body').append('<form id="paytmForm" method="POST"/>');
						$('#paytmForm').append('<input type="hidden" name="CALLBACK_URL" value="'+resp.data[0]['CALLBACK_URL']+'" />');
						$('#paytmForm').append('<input type="hidden" name="CHANNEL_ID" value="'+resp.data[0]['CHANNEL_ID']+'" />');
						$('#paytmForm').append('<input type="hidden" name="CUST_ID" value="'+resp.data[0]['CUST_ID']+'" />');
						$('#paytmForm').append('<input type="hidden" name="EMAIL" value="'+resp.data[0]['EMAIL']+'" />');
						$('#paytmForm').append('<input type="hidden" name="INDUSTRY_TYPE_ID" value="'+resp.data[0]['INDUSTRY_TYPE_ID']+'" />');
						$('#paytmForm').append('<input type="hidden" name="MID" value="'+resp.data[0]['MID']+'" />');
						$('#paytmForm').append('<input type="hidden" name="MOBILE_NO" value="'+resp.data[0]['MOBILE_NO']+'" />');
						$('#paytmForm').append('<input type="hidden" name="ORDER_ID" value="'+resp.data[0]['ORDER_ID']+'" />');
						$('#paytmForm').append('<input type="hidden" name="TXN_AMOUNT" value="'+resp.data[0]['TXN_AMOUNT']+'" />');
						$('#paytmForm').append('<input type="hidden" name="WEBSITE" value="'+resp.data[0]['WEBSITE']+'" />');
						$('#paytmForm').append('<input type="hidden" name="CHECKSUMHASH" value="'+resp.data[0]['CHECKSUMHASH']+'" />');
						$('#paytmForm').attr('action',resp.data[0]['posturl']);
						$('#paytmForm').submit();
					}
					if(resp.data[0]['NO_TXN'] != 'undefined' && resp.data[0]['NO_TXN'] == 'true'){
						$("#checkoutForm").submit();
					}
				} else if(status==-2) {
					
				    var globalMessage = '';
					for(var i = 0; i< resp.validations.length; i++) {
						var fieldName = resp.validations[i].field;
						var message = resp.validations[i].message;
						var f = $(document.getElementById('error-'+fieldName));
						if(f) {
							f.html(message);
						}
						globalMessage = globalMessage + message + '<br/>';
						
					}
					
					showResponseErrorMessage(globalMessage);
					
					
				} else {
					showResponseErrorMessage('<s:message code="error.code.99" text="An error message occured while trying to process the payment (99)"/>');
					
				}
		  },
		    error: function(xhr, textStatus, errorThrown) {
		    	$('#pageContainer').hideLoading();
		  		alert('error ' + errorThrown);
		  }

	});
	
}


function calculateTotal(){
	resetErrorMessage();
	$('#pageContainer').showLoading();
	var data = $(checkoutFormId).serialize();
	$.ajax({
	  type: 'POST',
	  url: '<c:url value="/shop/order/calculateOrderTotal.html"/>',
	  data: data,
	  cache: false,
	  dataType: 'json',
	  success: function(response){
		    $('#pageContainer').hideLoading();
		  	if(response.errorMessage!==null && response.errorMessage!=='') {
		  		showErrorMessage(response.errorMessage);
		  		return;
		  	}
			$('#summary-table tr.subt').remove();
			populateCartSummary(response);
			isFormValid();
	  },
	    error: function(xhr, textStatus, errorThrown) {
	    	$('#pageContainer').hideLoading();
	  		alert('error ' + errorThrown);
	  }

	});
}

$(document).ready(function() {
		$(".billing-phone").ForceNumericOnly();
		$("#billingPostalCode").ForceNumericOnly();
		
    	$("#clickAgreement").click(function(){
        	$("#customer-agreement-area").slideToggle("slow");
    	});

		<!-- 
			//can use masked input for phone (USA - CANADA)
		-->
		isFormValid();
		
		bindActions();

		$("input[type='text']").on("change keyup paste", function(){
			isFormValid();
		});
		
		$("input[type='checkbox']").on("change click", function(){
			isFormValid();
		});
		
		<c:if test="${order.customer.billing.country!=null}">
			$('.billing-country-list').val('${order.customer.billing.country}');
			setCountrySettings('billing','${order.customer.billing.country}');
		</c:if>
		<c:if test="${order.customer.delivery.country!=null}">
			$('.shipping-country-list').val('${order.customer.delivery.country}');
			setCountrySettings('delivery','${order.customer.delivery.country}');
		</c:if>

		<!-- customer state is text -->
		/* <c:if test="${order.customer.billing.stateProvince!=null && order.customer.billing.stateProvince!=null !=''}">
			$('#billingStateList').hide();          
			$('#billingStateProvince').show(); 
			$('#billingStateProvince').val('<c:out value="${order.customer.billing.stateProvince}"/>');
		</c:if> */
		<!-- customer state is a know state -->
		/* <c:if test="${order.customer.billing.stateProvince==null || order.customer.billing.stateProvince==''}">
			$('#billingStateList').show();           
			$('#billingStateProvince').hide();
			getZones('#billingStateList','#billingStateProvince','<c:out value="${order.customer.billing.country}" />','<c:out value="${order.customer.billing.zone}" />', null); 
		</c:if> */
		
		<c:if test="${order.customer.delivery.stateProvince!=null && order.customer.delivery.stateProvince!=''}">  
			$('#deliveryStateList').hide();          
			$('#deliveryStateProvince').show(); 
			$('#deliveryStateProvince').val('<c:out value="${order.customer.delivery.stateProvince}"/>');
		</c:if>
		
		<c:if test="${order.customer.delivery.stateProvince==null || order.customer.delivery.stateProvince==''}">  
			$('#deliveryStateList').show();          
			$('#deliveryStateProvince').hide();
			getZones('#deliveryStateList','#deliveryStateProvince','<c:out value="${order.customer.delivery.country}" />','<c:out value="${order.customer.billing.zone}" />', null);
		</c:if>

		/* $(".billing-country-list").change(function() {
			getZones('#billingStateList','#billingStateProvince',$(this).val(),'<c:out value="${order.customer.billing.zone}" />', shippingQuotes);
			setCountrySettings('billing',$(this).val());
	    }) */
	    
	    $(".shipping-country-list").change(function() {
			getZones('#deliveryStateList','#deliveryStateProvince',$(this).val(),'<c:out value="${order.customer.delivery.zone}" />', shippingQuotes);
			setCountrySettings('delivery',$(this).val());
	    })
	    
	   /*  $("#billingStateList").change(function() {
	    	shippingQuotes();	
	    }) */
	    
	    $("#shippingStateList").change(function() {
	    	shippingQuotes();		
	    })
	    
	    $('input[name=paymentMethodType]', checkoutFormId).click(function() {
	    	isFormValid();//change payment method
	    });
	    
		$("input[id=billingPostalCode]").blur(function() {
			//shippingQuotes();
		});
		
		$("input[id=shippingPostalCode]").blur(function() {
			if (!$('#shipToBillingAdress').is(':checked')) {
				shippingQuotes();
			}
		});
		

		
});




</script>
	
	
	
	
	
	<section id="top-banner-and-menu">
		<div class="container">
			<jsp:include page="/pages/shop/templates/exoticamobilia/sections"/>
<div id="main-content" class="container row-fluid">
	<h1 class="checkout-title"><s:message code="label.checkout" text="Checkout" /></h1>
	<div class="register-req">
		<sec:authorize access="!hasRole('AUTH_CUSTOMER') and !fullyAuthenticated">
			<p class="muted common-row"><s:message code="label.checkout.logon" text="Logon or signup to simplify the online purchase process!"/></p>
		</sec:authorize>
	</div>
   <c:set var="commitUrl" value="${pageContext.request.contextPath}/shop/order/commitOrder.html"/>
   <c:url value="/shop/order/applyPromotions.html" scope="request" var="promoPost"/>
   <c:url value="/shop/order/removePromotions.html" scope="request" var="removePromoPost"/>
   <form:form id="checkoutForm" method="POST" enctype="multipart/form-data" commandName="order" action="${commitUrl}">
	   

		<div class="row-fluid common-row" id="checkout">
				<div class="span12 col-md-12 no-padding">

					<!-- If error messages -->
					<div id="checkoutError"  class="<c:if test="${errorMessages!=null}">alert  alert-error alert-danger </c:if>">
						<c:if test="${errorMessages!=null}">
						<c:out value="${errorMessages}" />
						</c:if>
					</div>
					<div id="checkoutError"  class="<c:if test="${transactionResponse!=null}">alert  alert-error alert-danger </c:if>">
						<c:if test="${transactionResponse!=null}">
							<s:message code="error.payment.gateway"></s:message>
						</c:if>
					</div>
					<!--alert-error-->

					<!-- row fluid span -->
					<div class="row-fluid">
					<!-- left column -->
					<div class="span8 col-md-8 no-padding-left">

										<!-- Billing box -->
										<div id="shippingBox" class="checkout-box">
											<span class="box-title">
												<p class="p-title"><s:message code="label.customer.billinginformation" text="Billing information"/></p>
											</span>
											
											
					
											<!-- First name - Last name -->
											<div class="row-fluid common-row row">
													<div class="span4 col-md-4">
													
									  				   <div class="control-group form-group"> 
														<label><s:message code="label.generic.firstname" text="First Name"/></label>
									    					<div class="controls"> 
										    					<s:message code="NotEmpty.customer.firstName" text="First name is required" var="msgFirstName"/>
										      					<form:input id="customer.firstName" cssClass="input-large required form-control form-control-lg" path="customer.billing.firstName" title="${msgFirstName}"/>
										    					<form:errors path="customer.billing.firstName" cssClass="error" />
										    					<span id="error-customer.billing.firstName" class="error"></span>
									    					</div> 
									  				   </div> 
													</div>
													<div class="span4 col-md-4">
									  				   <div class="control-group form-group"> 
														<label><s:message code="label.generic.lastname" text="Last Name"/></label>
									    					<div class="controls"> 
										    					<s:message code="NotEmpty.customer.lastName" text="Last name is required" var="msgLastName"/>
										    					<form:input id="customer.lastName" cssClass="input-large required form-control form-control-lg"  maxlength="32" path="customer.billing.lastName" title="${msgLastName}" />
										    					<form:errors path="customer.billing.lastName" cssClass="error" />
										    					<span id="error-customer.billing.lastName" class="error"></span>
									    					</div> 
									  				   </div> 
													</div>
													
													<div class="span4 col-md-4">
										  				<div class="control-group form-group"> 
														<label><s:message code="label.generic.phone" text="Phone number"/></label>
										    				<div class="controls"> 
										    					<s:message code="NotEmpty.customer.billing.phone" text="Phone number is required" var="msgPhone"/>
										      					<form:input id="customer.billing.phone" cssClass="input-large required billing-phone form-control form-control-lg" path="customer.billing.phone" title="${msgPhone}"/>
										      					<form:errors path="customer.billing.phone" cssClass="error" />
												    			<span id="error-customer.billing.phone" class="error"></span> 
										    				</div> 
										  				</div>
										  			</div>
										  			<form:hidden id="customer.emailAddress" path="customer.emailAddress" title="${msgEmail}"/>
										  			<span id="error-customer.emailAddress" class="error"></span>
										  			<%-- <div class="span4 col-md-4">
									  				   <div class="control-group form-group"> 
														<label><s:message code="label.generic.email" text="Email address"/></label>
									    					<div class="controls">
										    					<s:message code="NotEmpty.customer.emailAddress" text="Email address is required" var="msgEmail"/> 
										    					<form:input id="customer.emailAddress" cssClass="input-large required email form-control form-control-lg" path="customer.emailAddress" title="${msgEmail}"/>
										    					<form:errors path="customer.emailAddress" cssClass="error" />
											    				<span id="error-customer.emailAddress" class="error"></span>
									    					</div> 
									  				   </div> 
													</div> --%>
											</div>
					
					
											<!-- email company -->
											<div class="row-fluid common-row row">
													<%-- <div class="span4 col-md-4">
									  				   <div class="control-group form-group"> 
														<label><s:message code="label.generic.email" text="Email address"/></label>
									    					<div class="controls">
										    					<s:message code="NotEmpty.customer.emailAddress" text="Email address is required" var="msgEmail"/> 
										    					<form:input id="customer.emailAddress" cssClass="input-large required email form-control form-control-lg" path="customer.emailAddress" title="${msgEmail}"/>
										    					<form:errors path="customer.emailAddress" cssClass="error" />
											    				<span id="error-customer.emailAddress" class="error"></span>
									    					</div> 
									  				   </div> 
													</div> --%>
													<%-- <div class="span4 col-md-4">
									  				   <div class="control-group form-group"> 
														<label><s:message code="label.customer.billing.company" text="Billing company"/></label>
									    					<div class="controls"> 
										      					<form:input id="customer.billing.company" cssClass="input-large form-control form-control-lg" path="customer.billing.company"/>
										      					<form:errors path="customer.billing.company" cssClass="error" />
												    			<span id="error-customer.billing.company" class="error"></span>
									    					</div> 
									  				   </div> 
													</div> --%>
													<div class="span4 col-md-4">
														<div class="control-group form-group"> 
															<label><s:message code="label.generic.city" text="City"/></label>
											    				<div class="controls"> 
											    					<s:message code="NotEmpty.customer.billing.city" text="City is required" var="msgCity"/>
											      					<form:select path="customer.billing.city" class="input-large form-control form-control-lg" id="customer.billing.city" title="${msgCity}">
												                    	<form:option value="Chandigarh" label="Chandigarh"></form:option>
												                    	<form:option value="Panchkula" label="Panchkula"></form:option>
												                    	<form:option value="Mohali" label="Mohali"></form:option>
												                    </form:select>
											      					<form:errors path="customer.billing.city" cssClass="error" />
												    				<span id="error-customer.billing.city" class="error"></span>
											    				</div> 
											  			</div>
											  		</div>
											  		<div class="span4 col-md-4">
											  			<div class="control-group form-group"> 
															<label><s:message code="label.generic.stateprovince" text="State / Province"/></label>
												    		<div class="controls"> 
												                    <s:message code="NotEmpty.customer.billing.stateProvince" text="State / Province is required" var="msgStateProvince"/>
												                    <form:select path="customer.billing.stateProvince" class="input-large form-control form-control-lg" id="billingStateProvince" title="${msgStateProvince}">
												                    	<form:option value="Chandigarh" label="Chandigarh"></form:option>
												                    	<form:option value="Punjab" label="Punjab"></form:option>
												                    	<form:option value="Haryana" label="Haryana"></form:option>
												                    </form:select>
												                    <%-- <form:input  class="input-large form-control form-control-lg" id="billingStateProvince"  maxlength="100" name="billingStateProvince" path="customer.billing.stateProvince" title="${msgStateProvince}"/> --%>
												                    <form:errors path="customer.billing.stateProvince" cssClass="error" />
													    			<span id="error-customer.billing.stateProvince" class="error"></span> 
												    		</div> 
											  			</div>
													</div>
													<div class="span4 col-md-4">
										  			<div class="control-group form-group"> 
														<label><s:message code="label.generic.country" text="Country"/></label>
										    				<div class="controls"> 
										       					<form:select cssClass="billing-country-list form-control form-control-lg" path="customer.billing.country">
											  							<form:option value="IN" label="India"></form:option>
										       					</form:select>
										    				</div> 
										  			</div>
										  			</div>
											  		<%-- <div class="span4 col-md-4">
											  			<div class="control-group form-group"> 
															<label><s:message code="label.generic.postalcode" text="Postal code"/></label>
											    				<div class="controls"> 
											    					<s:message code="NotEmpty.customer.billing.postalCode" text="Postal code is required" var="msgPostalCode"/>
											      					<form:input id="billingPostalCode" cssClass="input-large billing-postalCode form-control form-control-lg" path="customer.billing.postalCode" title="${msgPostalCode}"/>
																	<form:errors path="customer.billing.postalCode" cssClass="error" />
												    				<span id="error-customer.billing.postalCode" class="error"></span>
											    				</div> 
											  			</div>
													</div> --%>
											</div>
					
											<!--  street address -->
											<%-- <div class="row-fluid common-row row">
													<div class="span8 col-md-8">
										  			<div class="control-group form-group"> 
														<label><s:message code="label.generic.streetaddress" text="Street address"/></label>
										    				<div class="controls"> 
										    					<s:message code="NotEmpty.customer.billing.address" text="Address is required" var="msgAddress"/>
										      					<form:input id="customer.billing.address" cssClass="input-xxlarge required form-control form-control-lg" path="customer.billing.address" title="${msgAddress}"/>
										      					<form:errors path="customer.billing.address" cssClass="error" />
												    			<span id="error-customer.billing.address" class="error"></span>
										    				</div> 
										  			</div>
										  			</div> 
											</div> --%>
					
											<!-- city - postal code -->
											<!-- <div class="row-fluid common-row row"> -->
													<%-- <div class="span4 col-md-4">
											  			<div class="control-group form-group"> 
															<label><s:message code="label.generic.stateprovince" text="State / Province"/></label>
												    		<div class="controls"> 
													       			<form:select cssClass="zone-list form-control form-control-lg" id="billingStateList" path="customer.billing.zone"/>
												                    <s:message code="NotEmpty.customer.billing.stateProvince" text="State / Province is required" var="msgStateProvince"/>
												                    <form:select path="customer.billing.stateProvince" class="input-large form-control form-control-lg" id="billingStateProvince" title="${msgStateProvince}">
												                    	<form:option value="Chandigarh" label="Chandigarh"></form:option>
												                    	<form:option value="Punjab" label="Punjab"></form:option>
												                    	<form:option value="Haryana" label="Haryana"></form:option>
												                    </form:select>
												                    <form:input  class="input-large form-control form-control-lg" id="billingStateProvince"  maxlength="100" name="billingStateProvince" path="customer.billing.stateProvince" title="${msgStateProvince}"/>
												                    <form:errors path="customer.billing.stateProvince" cssClass="error" />
													    			<span id="error-customer.billing.stateProvince" class="error"></span> 
												    		</div> 
											  			</div>
													</div> --%>
													<%-- <div class="span4 col-md-4">
										  			<div class="control-group form-group"> 
														<label><s:message code="label.generic.country" text="Country"/></label>
										    				<div class="controls"> 
										       					<form:select cssClass="billing-country-list form-control form-control-lg" path="customer.billing.country">
											  							<form:option value="IN" label="India"></form:option>
										       					</form:select>
										    				</div> 
										  			</div>
										  			</div> --%>
										   <!-- </div> -->
										   
										   <!-- state province -->
										   <%-- <div class="row-fluid common-row row">
										   			<div class="span8 col-md-8">
										   			<div class="control-group form-group"> 
														<label><s:message code="label.generic.stateprovince" text="State / Province"/></label>
											    		<div class="controls"> 
												       			<form:select cssClass="zone-list form-control form-control-lg" id="billingStateList" path="customer.billing.zone"/>
											                    <s:message code="NotEmpty.customer.billing.stateProvince" text="State / Province is required" var="msgStateProvince"/>
											                    <form:input  class="input-large required form-control form-control-lg" id="billingStateProvince"  maxlength="100" name="billingStateProvince" path="customer.billing.stateProvince" title="${msgStateProvince}"/>
											                    <form:errors path="customer.billing.stateProvince" cssClass="error" />
												    			<span id="error-customer.billing.stateProvince" class="error"></span> 
											    		</div> 
											  		</div>
											  		</div>
										   </div> --%>
								
										  <!-- country - phone - ship checkbox -->
									       <%-- <div class="row-fluid common-row row">
									       			<div class="span4 col-md-4">
										  			<div class="control-group form-group"> 
														<label><s:message code="label.generic.country" text="Country"/></label>
										    				<div class="controls"> 
										       					<form:select cssClass="billing-country-list form-control form-control-lg" path="customer.billing.country">
											  							<form:options items="${countries}" itemValue="isoCode" itemLabel="name"/>
										       					</form:select>
										    				</div> 
										  			</div>
										  			</div>
											
													<div class="span4 col-md-4">
										  			<div class="control-group form-group"> 
														<label><s:message code="label.generic.phone" text="Phone number"/></label>
										    				<div class="controls"> 
										    					<s:message code="NotEmpty.customer.billing.phone" text="Phone number is required" var="msgPhone"/>
										      					<form:input id="customer.billing.phone" cssClass="input-large required billing-phone form-control form-control-lg" path="customer.billing.phone" title="${msgPhone}"/>
										      					<form:errors path="customer.billing.phone" cssClass="error" />
												    			<span id="error-customer.billing.phone" class="error"></span> 
										    				</div> 
										  			</div>
										  			</div>
													
									  	  </div> --%>
									  	  
									  	  <%-- <c:if test="${shippingQuote!=null}">
											<!-- display only if a shipping quote exist -->
											<div class="row-fluid common-row row">
										   	<div class="span8 col-md-8">
											<label id="useAddress" class="checkbox"> 
											<form:checkbox path="shipToBillingAdress" id="shipToBillingAdress"/>
											<s:message code="label.customer.shipping.shipaddress" text="Ship to this address" /></label>
											</div>
											</div>
									  	  </c:if> --%>
									</div>
									<!-- end billing box -->
					
									<%-- <c:if test="${shippingQuote!=null}">
									<br/>
									<!-- Shipping box -->
									<div id="deliveryBox" class="checkout-box">
											<span class="box-title">
												<p class="p-title"><s:message code="label.customer.shippinginformation" text="Shipping information"/></p>
											</span>
					
											<!-- First name - Last name -->
											<div class="row-fluid common-row row">
													<div class="span4 col-md-4">
									  				   <div class="control-group form-group"> 
														<label><s:message code="label.customer.shipping.firtsname" text="Shipping first name"/></label>
									    					<div class="controls"> 
									    					<s:message code="NotEmpty.customer.shipping.firstName" text="Shipping first name should not be empty" var="msgShippingFirstName"/>
									      					<form:input id="customer.delivery.name" cssClass="input-xxlarge required form-control form-control-lg" path="customer.delivery.firstName" title="${msgShippingFirstName}"/>
									    					</div> 
									  				   </div> 
													</div>
											</div>

											<div class="row-fluid common-row row">
													<div class="span4 col-md-4">
									  				   <div class="control-group"> 
														<label><s:message code="label.customer.shipping.lastname" text="Shipping last name"/></label>
									    					<div class="controls"> 
									    					<s:message code="NotEmpty.customer.shipping.lastName" text="Shipping last name should not be empty" var="msgShippingLastName"/>
									      					<form:input id="customer.delivery.name" cssClass="input-xxlarge required form-control form-control-lg" path="customer.delivery.lastName" title="${msgShippingLastName}"/>
									    					</div> 
									  				   </div> 
													</div>
											</div>					
					
											<!-- company -->
											<div class="row-fluid common-row row">
												<div class="span4 col-md-4">
									  				   <div class="control-group"> 
														<label><s:message code="label.customer.shipping.company" text="Shipping company"/></label>
									    					<div class="controls"> 
									      					<form:input id="customer.delivery.company" cssClass="input-large form-control form-control-lg" path="customer.delivery.company"/>
									    					</div> 
									  				   </div>
									  			</div> 
											</div>
					
											<!--  street address -->
											<div class="row-fluid common-row row">
												<div class="span8 col-md-8">
										  			<div class="control-group"> 
														<label><s:message code="label.customer.shipping.streetaddress" text="Shipping street address"/></label>
										    				<div class="controls"> 
										    					<s:message code="NotEmpty.customer.shipping.address" text="Shipping street address should not be empty" var="msgShippingAddress"/>
										      					<form:input id="customer.delivery.address" cssClass="input-xxlarge required form-control form-control-lg" path="customer.delivery.address" title="${msgShippingAddress}"/>
										    				</div> 
										  			</div> 
										  		</div>
											</div>
					
											<!-- city - postal code -->
											<div class="row-fluid common-row row">
													<div class="span4 col-md-4">
											  			<div class="control-group"> 
															<label><s:message code="label.customer.shipping.city" text="Shipping city"/></label>
											    				<div class="controls">
											    					<s:message code="NotEmpty.customer.shipping.city" text="Shipping city should not be empty" var="msgShippingCity"/> 
											      					<form:input id="customer.delivery.city" cssClass="input-large required form-control form-control-lg" path="customer.delivery.city" title="${msgShippingCity}"/>
											    				</div> 
											  			</div>
													</div>
													<div class="span4 col-md-4">
											  			<div class="control-group form-group"> 
															<label><s:message code="label.customer.shipping.postalcode" text="Shipping postal code"/></label>
											    				<div class="controls"> 
											    				    <s:message code="NotEmpty.customer.shipping.postalcode" text="Shipping postal code should not be empty" var="msgShippingPostal"/>
											      					<form:input id="deliveryPostalCode" cssClass="input-large required delivery-postalCode form-control form-control-lg" path="customer.delivery.postalCode" title="${msgShippingPostal}"/>
											    				</div> 
											  			</div>
													</div>
										   </div>
										   
										   <!-- state province -->
										   <div class="row-fluid common-row row">
										   			<div class="span8 col-md-8">
										   			<div class="control-group form group"> 
														<label><s:message code="label.customer.shipping.zone" text="Shipping state / province"/></label>
											    		<div class="controls"> 
												       			<form:select cssClass="zone-list form-control" id="deliveryStateList" path="customer.delivery.zone"/>
											                    <s:message code="NotEmpty.customer.shipping.stateProvince" text="Shipping State / Province is required" var="msgShippingState"/>
											                    <form:input  class="input-large required form-control form-control-lg" id="deliveryStateProvince"  maxlength="100" name="shippingStateProvince" path="customer.delivery.stateProvince" title="${msgShippingState}"/> 
											    		</div> 
											  		</div>
											  		</div>
										   </div>
								
										  <!-- country -->
									       <div class="row-fluid common-row row">
									       			<div class="span8 col-md-8">
										  			<div class="control-group form-group"> 
														<label><s:message code="label.customer.shipping.country" text="Shipping country"/></label>
										    				<div class="controls"> 
										       					<form:select cssClass="shipping-country-list form-control" path="customer.delivery.country">
											  							<form:options items="${countries}" itemValue="isoCode" itemLabel="name"/>
										       					</form:select>
										    				</div> 
										  			</div>
										  			</div>
									  	  </div>
									</div>
									</c:if>
									
									
									
									
									
									<!-- Shipping box -->
									<c:if test="${shippingQuote!=null}">
									 <br/> 
									<!-- Shipping -->
									<div class="checkout-box">
										<span class="box-title">
												<p class="p-title"><s:message code="label.shipping.fees" text="Shipping fees" /> </p>
										</span>
								
								        <c:choose>
								        <c:when test="${fn:length(shippingQuote.shippingOptions)>0}">
								        	<input type="hidden" name="shippingModule" value="${shippingQuote.shippingModuleCode}">
									        <div id="shippingSection" class="control-group"> 
							 					<label class="control-label">
							 						<s:message code="label.shipping.options" text="Shipping options"/>
							 						<c:if test="${shippingQuote.handlingFees!=null && shippingQuote.handlingFees>0}">
								       					&nbsp;(<s:message code="label.shipping.handlingfees" text="Handling fees" />&nbsp;<sm:monetary value="${shippingQuote.handlingFees}"/>)
								       				</c:if>
							 					</label> 
							 					<div id="shippingOptions" class="controls"> 
							 						<c:forEach items="${shippingQuote.shippingOptions}" var="option" varStatus="status">
														<label class="radio">
															<input type="radio" name="selectedShippingOption.optionId" class="shippingOption" id="${option.optionId}" value="${option.optionId}" <c:if test="${order.selectedShippingOption!=null && order.selectedShippingOption.optionId==option.optionId}">checked="checked"</c:if>> 
															${option.optionName} - ${option.optionPriceText}
														</label> 
													</c:forEach>
												</div> 
									       	</div>
								       	</c:when>
								       	<c:otherwise>
								       		<c:choose>
								       			<c:when test="${shippingQuote.freeShipping==true && shippingQuote.freeShippingAmount!=null}" >
								       				<s:message code="label.shipping.freeshipping.over" text="Free shipping for orders over"/>&nbsp;<strong><sm:monetary value="${shippingQuote.freeShippingAmount}"/></strong>
								       			</c:when>
								       			<c:otherwise>
								       				<c:choose>
								       				  <c:when test="${shippingQuote.shippingReturnCode=='ERROR'}">
								       					<font color="red"><c:out value="${shippingQuote.quoteError}" /></font>
								       				  </c:when>
								       				  <c:otherwise>
								       					<c:choose>
									       					<c:when test="${shippingQuote.shippingReturnCode=='NO_SHIPPING_MODULE_CONFIGURED'}">
									       						<font color="red"><s:message code="message.noshipping.configured" text="No shipping method configured"/></font>
									       					</c:when>
									       					<c:otherwise>
									       						<strong><s:message code="label.shipping.freeshipping" text="Free shipping!"/></strong>
									       					</c:otherwise>
								       					</c:choose>
								       				  </c:otherwise>
								       				</c:choose>
								       			</c:otherwise>								       	
								       		</c:choose>
								       	</c:otherwise>
								       	</c:choose> 
									</div>
									<!-- end shipping box -->
									</c:if> --%>
									<br/>
									<%-- <div class="checkout-box">
										<span class="box-title">
											<p class="p-title">Have Promo code? Apply here to get discounts.</p>
										</span>
										<div class="row-fluid common-row row">
													<div class="span6 col-md-6">
										  				   <div class="control-group form-group">
												      			<input id="promoCode" name="code" cssClass="input-large required form-control form-control-lg" placeholder="Promotional Code" autocomplete="off" value="${cart.voucherCode}"/>
												    			<c:if test="${cart.promotionApplied == false}">
												    				<button id="promobtn" type="button" class="btn btn-success prBtn" data-action="true">Apply</button>
												    			</c:if>
												    			<c:if test="${cart.promotionApplied == true}">
												    				<button id="promobtn" type="button" class="btn btn-danger prBtn" data-action="false">Remove</button>
												    			</c:if>
										  				   </div>
										  				   <div class="control-group form-group"> 
										  				   		<span id="error" class="error"></span>
										  				   </div>
													</div>
													<div class="span4 col-md-4">
													</div>
										</div>
									</div> --%>
									<c:if test="${fn:length(paymentMethods)>0}">
									<!-- payment box -->
									<div class="checkout-box">
										<span class="box-title">
											<p class="p-title"><s:message code="label.payment.module.title" text="Payment method" /></p>
										</span>

									    		<div class="tabbable"> 
												    	<ul class="nav nav-tabs">
												    		<c:forEach items="${paymentMethods}" var="paymentMethod">
												    			<li class="<c:choose><c:when test="${order.paymentMethodType!=null && order.paymentMethodType==paymentMethod.paymentType}">active</c:when><c:otherwise><c:if test="${order.paymentMethodType==null && paymentMethod.defaultSelected==true}">active</c:if></c:otherwise></c:choose>">
												    				<a href="#${paymentMethod.paymentType}" data-toggle="tab" class="paymentTab">
												    					<c:choose>
												    						<c:when test="${paymentMethod.paymentType=='ATOM' || paymentMethod.paymentType=='PAYTM'}">
												    							<c:if test="${paymentMethod.paymentType=='ATOM'}">
												    								<img src="<c:url value="/resources/img/payment/icons/visa-straight-64px.png"/>" width="40">
												    								<img src="<c:url value="/resources/img/payment/icons/mastercard-straight-64px.png"/>" width="40">
												    								<img src="<c:url value="/resources/img/payment/icons/american-express-straight-64px.png"/>" width="40">
												    							</c:if>
												    							<c:if test="${paymentMethod.paymentType=='PAYTM'}">
												    								<img src="<c:url value="/resources/img/payment/icons/paypal-straight-64px.png"/>" width="40">
												    							</c:if>
												    						</c:when>
												    						<c:otherwise>
												    							<h4><s:message code="payment.type.${paymentMethod.paymentType}" text="Payment method type [payment.type.${paymentMethod.paymentType}] not defined in payment.properties" /></h4>
												    						</c:otherwise>
												    					</c:choose>
												    				</a>
												    			</li>
												            </c:forEach>
												        </ul>
												        
											        		
												        
												        
									    				<div class="tab-content">
											    				<c:forEach items="${paymentMethods}" var="paymentMethod">
															    		<div class="tab-pane <c:choose><c:when test="${order.paymentMethodType!=null && order.paymentMethodType==paymentMethod.paymentType}">active</c:when><c:otherwise><c:if test="${order.paymentMethodType==null && paymentMethod.defaultSelected==true}">active</c:if></c:otherwise></c:choose>" id="${paymentMethod.paymentType}">
															    			<c:choose>
															    				<c:when test="${order.paymentMethodType!=null && order.paymentMethodType==paymentMethod.paymentType}">
															    						<c:set var="paymentModule" value="${order.paymentMethodType}" scope="request"/>
															    				</c:when>
															    				<c:otherwise>
															    						<c:if test="${order.paymentMethodType==null && paymentMethod.defaultSelected==true}">
															    							<c:set var="paymentModule" value="${paymentMethod.paymentMethodCode}" scope="request"/>
															    						</c:if>
															    				</c:otherwise>
															    			</c:choose>
															    			<c:set var="selectedPaymentMethod" value="${order.paymentMethodType}" scope="request"/>
															    			<c:set var="paymentMethod" value="${paymentMethod}" scope="request"/>
															    			<c:set var="pageName" value="${fn:toLowerCase(paymentMethod.paymentType)}" />
															    			<jsp:include page="/pages/shop/common/checkout/${pageName}.jsp" />
															    		</div>
											    				</c:forEach>
									    				
									    						<input type="hidden" id="paymentModule" name="paymentModule" value="<c:choose><c:when test="${order.paymentModule!=null}"><c:out value="${order.paymentModule}"/></c:when><c:otherwise><c:out value="${paymentModule}" /></c:otherwise></c:choose>"/>
									    				</div>
									 			</div>
									</div>
									<!-- end payment box -->
									</c:if>
									
									
							
									
									
					</div>
					<!-- end left column -->


					<!-- Order summary right column -->
					<div class="span4 col-md-4 no-padding" id="summaryBox">
					
										<!-- order summary box -->
										<div class="checkout-box" id="cartSummary">
											<div class="checkout-box">
											<span id="summaryBox" class="box-title">
												<h2><s:message code="label.order.summary" text="Order summary" /></h2>
											</span>
											<div class="table-responsive cart_info">
												<table id="summary-table" class="table table-condensed table-hover">
													<thead> 
														<tr class="cart_menu"> 
															<th width="45%"><s:message code="label.order.item" text="Item" /></th> 
															<!--<th width="15%"><s:message code="label.quantity" text="Quantity" /></th>--> 
															<th width="20%"><s:message code="label.order.price" text="Price" /></th>
															<!-- <th width="20%">Discount</th> -->
															<th width="20%"><s:message code="label.order.total" text="Total" /></th>  
														</tr> 
													</thead> 
										
													<tbody id="summaryRows"> 
													</tbody> 
												</table>
											</div>
											</div>
										</div>
										
										<!--  end order summary box -->
										<c:if test="${requestScope.CONFIGS['displayCustomerAgreement']==true}">
										<!-- customer agreement -->
										<div class="checkout-box" id="customerAgreementSection" class="">
											<label id="customerAgreement" class="checkbox"> 
											<s:message code="NotEmpty.customer.agreement" text="Please make sure you agree with terms and conditions" var="msgAgreement"/>
											<form:checkbox path="customerAgreed" id="customerAgreed" cssClass="required" title="${msgAgreement}"/>
											<a href="javascript:return false;" id="clickAgreement"><s:message code="label.customer.order.agreement" text="I agree with the terms and conditions" /></a>
											</label>
											<div id="customer-agreement-area">
														<c:choose>
															<c:when test="${requestScope.CONTENT['agreement']!=null}">
																<sm:pageContent contentCode="agreement"/>
															</c:when>
															<c:otherwise>
																<s:message code="message.content.missing.agreement" text="Content with code 'agreement' does not exist" />
															</c:otherwise>
														</c:choose>
											</div>
										</div>
										</c:if>
										
										<div id="formErrorMessage" class="alert">
										</div>
										<!-- Submit -->
										<div class="form-actions">
											<div class="pull-right"> 
												<button id="submitOrder" type="submit" class="btn btn-large btn-success 
												<c:if test="${errorMessages!=null}"> btn-disabled</c:if>" 
												<c:if test="${errorMessages!=null}"> disabled="true"</c:if>
												><s:message code="button.label.submitorder" text="Submit order"/></button>
			
												<!-- submit can be a post or a pre ajax query -->
											</div>
										</div> 
			
					</div>
					<!-- end right column -->

			    </div>
			    <!-- end row fluid span -->
			    </div>
			    <!-- end span 12 -->

		</div>
		<!-- end row fluid -->
			
	</form:form>
	
	</div>



		<script type="text/html" id="cartSummaryTemplate">
{{#shoppingCartItems}}
														<tr class="item"> 
															<td width="45%">
																{{quantity}} x {{name}}
															</td> 
															<td width="20%"><strong><i class="fa fa-inr"></i> {{productPrice}}</strong></td> 
															
															<td width="20%"><strong><i class="fa fa-inr"></i> {{subTotal}}</strong></td> 
														</tr>
													{{/shoppingCartItems}}
	</script>
<script type="text/html" id="cartSummarySubTotalTemplate">
{{#totals}}
	<tr class="subt"> 
		<td colspan="2">{{title}}</td> 
		<td><strong><i class="fa fa-inr"></i> {{value}}</strong></td> 
	</tr> 
{{/totals}}
</script>
<script type="text/html" id="cartSummaryTotalTemplate">
	<tr>
		<td colspan="2">
			<font class="total-box-label">
				<s:message code="order.total.total" text="Total"/>
			</font>
		</td>
		<td id="totalRow">
			<span class="total-box-grand-total">
				<font class="total-box-label">
					<font class="total-box-price"><i class="fa fa-inr"></i> {{total}}</font>
				</font>
			</span>
		</td>
	</tr>
</script>
		<script>
	$(document).ready(function(){
		$.ajax({
			  type:'get',
			  url: getContextPath() + '/shop/order/getShoppingCart.html',
			  data: {code:'123'},
			  contentType: 'charset=utf-8',
			   error: function(xhr) { 
						if(xhr.status==401) {//not authenticated
							removeUserName();
						}
						 
					 },
			  success: function(response) {
				  populateCartSummary(response);
				} 
			});
		
function populateCartSummary(cart){
	var summaryTemplate = Hogan.compile(document.getElementById("cartSummaryTemplate").innerHTML);
	var totalRendred = summaryTemplate.render(cart);
	$('#summaryRows').html('');
	$('#summaryRows').html(totalRendred);
	summaryTemplate = Hogan.compile(document.getElementById("cartSummarySubTotalTemplate").innerHTML);
	var subTotals = [];
	for(var t in cart.totals){
		if(cart.totals[t].code != 'order.total.total'){
			subTotals.push(cart.totals[t]);
		}
	}
	var totals = {};
	totals['totals'] = subTotals;
	totalRendred = summaryTemplate.render(totals);
	$('#summaryRows').append(totalRendred);
	summaryTemplate = Hogan.compile(document.getElementById("cartSummaryTotalTemplate").innerHTML);
	totalRendred = summaryTemplate.render(cart);
	$('#summaryRows').append(totalRendred);
}
$(".prBtn").click(function(){
		var btn = $(this);
		$("#summaryBox").showLoading();
		var successPromoSubmit= function successPromoSubmit(data){
			if(data.status == 0 || data.status == 9999){
				populateCartSummary(data);
				if($(btn).attr("data-action")=="true"){
					$(btn).removeClass("btn-success");
					$(btn).addClass("btn-danger");
					$(btn).html("Remove");
					$(btn).attr("data-action","false");
				}else{
					$(btn).removeClass("btn-danger");
					$(btn).addClass("btn-success");
					$(btn).html("Apply");
					$(btn).attr("data-action","true");
					$("#promoCode").val("");
				}
				
				$("#error").hide();
			}else if(data.status == -1){
				$("#error").html(data.message);
				$("#error").show();
			}
			$("#summaryBox").hideLoading();
		}
		
		var errorPromoSubmit = function errorPromoSubmit(data){
			$("#summaryBox").hideLoading();
		}
		if($(btn).attr("data-action")=="true"){
			$("#checkoutForm").attr("action",'${promoPost}');
		}else{
			$("#checkoutForm").attr("action",'${removePromoPost}');
		}
		ajaxFormSubmit($("#checkoutForm"),successPromoSubmit,errorPromoSubmit);
	});
});
		</script>
		
			<%-- <div class="shopper-informations">
				<div class="row">
					<div class="col-sm-3">
						<div class="shopper-info">
							<p>Shopper Information</p>
							<form>
								<input type="text" placeholder="Display Name">
								<input type="text" placeholder="User Name">
								<input type="password" placeholder="Password">
								<input type="password" placeholder="Confirm password">
							</form>
							<a class="btn btn-primary" href="">Get Quotes</a>
							<a class="btn btn-primary" href="">Continue</a>
						</div>
					</div>
					<div class="col-sm-5 clearfix">
						<div class="bill-to">
							<p>Bill To</p>
							<div class="form-one">
								<form>
									<input type="text" placeholder="Company Name">
									<input type="text" placeholder="Email*">
									<input type="text" placeholder="Title">
									<input type="text" placeholder="First Name *">
									<input type="text" placeholder="Middle Name">
									<input type="text" placeholder="Last Name *">
									<input type="text" placeholder="Address 1 *">
									<input type="text" placeholder="Address 2">
								</form>
							</div>
							<div class="form-two">
								<form>
									<input type="text" placeholder="Zip / Postal Code *">
									<select>
										<option>-- Country --</option>
										<option>United States</option>
										<option>Bangladesh</option>
										<option>UK</option>
										<option>India</option>
										<option>Pakistan</option>
										<option>Ucrane</option>
										<option>Canada</option>
										<option>Dubai</option>
									</select>
									<select>
										<option>-- State / Province / Region --</option>
										<option>United States</option>
										<option>Bangladesh</option>
										<option>UK</option>
										<option>India</option>
										<option>Pakistan</option>
										<option>Ucrane</option>
										<option>Canada</option>
										<option>Dubai</option>
									</select>
									<input type="password" placeholder="Confirm password">
									<input type="text" placeholder="Phone *">
									<input type="text" placeholder="Mobile Phone">
									<input type="text" placeholder="Fax">
								</form>
							</div>
						</div>
					</div>
					<div class="col-sm-4">
						<div class="order-message">
							<p>Shipping Order</p>
							<textarea name="message"  placeholder="Notes about your order, Special Notes for Delivery" rows="16"></textarea>
							<label><input type="checkbox"> Shipping to bill address</label>
						</div>	
					</div>					
				</div>
			</div> --%>
			<!-- <div class="review-payment">
				<h2>Review & Payment</h2>
			</div> -->

			<%-- <div class="table-responsive cart_info">
				<table class="table table-condensed">
					<thead>
						<tr class="cart_menu">
							<td class="image">Item</td>
							<td class="description"></td>
							<td class="price">Price</td>
							<td class="quantity">Quantity</td>
							<td class="total">Total</td>
							<td></td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="cart_product">
								<a href=""><img src="images/cart/one.png" alt=""></a>
							</td>
							<td class="cart_description">
								<h4><a href="">Colorblock Scuba</a></h4>
								<p>Web ID: 1089772</p>
							</td>
							<td class="cart_price">
								<p>$59</p>
							</td>
							<td class="cart_quantity">
								<div class="cart_quantity_button">
									<a class="cart_quantity_up" href=""> + </a>
									<input class="cart_quantity_input" type="text" name="quantity" value="1" autocomplete="off" size="2">
									<a class="cart_quantity_down" href=""> - </a>
								</div>
							</td>
							<td class="cart_total">
								<p class="cart_total_price">$59</p>
							</td>
							<td class="cart_delete">
								<a class="cart_quantity_delete" href=""><i class="fa fa-times"></i></a>
							</td>
						</tr>

						<tr>
							<td class="cart_product">
								<a href=""><img src="images/cart/two.png" alt=""></a>
							</td>
							<td class="cart_description">
								<h4><a href="">Colorblock Scuba</a></h4>
								<p>Web ID: 1089772</p>
							</td>
							<td class="cart_price">
								<p>$59</p>
							</td>
							<td class="cart_quantity">
								<div class="cart_quantity_button">
									<a class="cart_quantity_up" href=""> + </a>
									<input class="cart_quantity_input" type="text" name="quantity" value="1" autocomplete="off" size="2">
									<a class="cart_quantity_down" href=""> - </a>
								</div>
							</td>
							<td class="cart_total">
								<p class="cart_total_price">$59</p>
							</td>
							<td class="cart_delete">
								<a class="cart_quantity_delete" href=""><i class="fa fa-times"></i></a>
							</td>
						</tr>
						<tr>
							<td class="cart_product">
								<a href=""><img src="images/cart/three.png" alt=""></a>
							</td>
							<td class="cart_description">
								<h4><a href="">Colorblock Scuba</a></h4>
								<p>Web ID: 1089772</p>
							</td>
							<td class="cart_price">
								<p>$59</p>
							</td>
							<td class="cart_quantity">
								<div class="cart_quantity_button">
									<a class="cart_quantity_up" href=""> + </a>
									<input class="cart_quantity_input" type="text" name="quantity" value="1" autocomplete="off" size="2">
									<a class="cart_quantity_down" href=""> - </a>
								</div>
							</td>
							<td class="cart_total">
								<p class="cart_total_price">$59</p>
							</td>
							<td class="cart_delete">
								<a class="cart_quantity_delete" href=""><i class="fa fa-times"></i></a>
							</td>
						</tr>
						<tr>
							<td colspan="4">&nbsp;</td>
							<td colspan="2">
								<table class="table table-condensed total-result">
									<tr>
										<td>Cart Sub Total</td>
										<td>$59</td>
									</tr>
									<tr>
										<td>Exo Tax</td>
										<td>$2</td>
									</tr>
									<tr class="shipping-cost">
										<td>Shipping Cost</td>
										<td>Free</td>										
									</tr>
									<tr>
										<td>Total</td>
										<td><span>$61</span></td>
									</tr>
								</table>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="payment-options">
					<span>
						<label><input type="checkbox"> Direct Bank Transfer</label>
					</span>
					<span>
						<label><input type="checkbox"> Check Payment</label>
					</span>
					<span>
						<label><input type="checkbox"> Paypal</label>
					</span>
				</div> --%>
		</div>
	</section> <!--/#cart_items-->
	
