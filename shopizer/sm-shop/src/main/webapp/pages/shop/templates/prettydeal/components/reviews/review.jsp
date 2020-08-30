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
<script src="<c:url value="/resources/js/jquery.raty.min.js" />"></script>

					<%-- <div id="review" class="row-fluid">

					<p class="lead"><s:message code="label.product.rate"/></p>
					<div id="store.success" class="alert alert-success"	style="<c:choose><c:when test="${success!=null}">display:block;</c:when><c:otherwise>display:none;</c:otherwise></c:choose>">
						<s:message code="message.productreview.created" text="You have successfully created a product review" />
					</div>
					
					<div class="span12 no_margin">
					<div class="span6">
						<table class="table" style="margin-bottom: 35px">
							<tbody>
								<tr>
								<c:if test="${product.image!=null}">
								<td>
									<img width="60" src="<c:url value="${product.image.imageUrl}"/>">
								</td>
								</c:if>
								<td>
									<table>
										<tr>
											<td style="border-top: none;"><c:out value="${product.description.name}" /></td>
										</tr>
										<tr>
											<td style="border-top: none;">
												<c:set var="HIDEACTION" value="TRUE" scope="request" />
												<!-- product rating -->
												<jsp:include page="/pages/shop/common/catalog/rating.jsp" />
											</td>
										</tr>
									</table>
								</td>
								<td>
									<c:out value="${product.finalPrice}"/>
								</td>
								</tr>
							</tbody>
						</table>
					
						<br/>


					<sec:authorize access="hasRole('AUTH_CUSTOMER') and fullyAuthenticated">
						<c:choose>
							<c:when test="${customerReview!=null}">
								<p>
									<s:message code="label.product.reviews.evaluated" text="You have evaluated this product"/>
											<br/>
											<div id="customerRating" style="width: 100px;"></div>
											<br/>
												<blockquote>
    												<p><c:out value="${customerReview.description}" escapeXml="false" /></p>
    												<small><c:out value="${customerReview.customer.firstName}" />&nbsp;<c:out value="${customerReview.customer.lastName}"/>&nbsp;<c:out value="${customerReview.date}" /></small>
   	 											</blockquote>
   	 											</p>
   	 											<script>
												  	$(function() {
														$('#customerRating').raty({ 
															readOnly: true, 
															half: true,
															path : '<c:url value="/resources/img/stars/"/>',
															score: <c:out value="${customerReview.rating}" />
														});
												  	});
								  			   </script>
								
								</p>
							</c:when>
							<c:otherwise>

						<c:url var="submitReview" value="/shop/customer/review/submit.html"/>
					    <form:form method="POST" commandName="review" action="${submitReview}">
					        <form:errors path="*" cssClass="alert alert-error" element="div" />
					    	<form:hidden id="rating" path="rating"/>
					    	<form:hidden path="productId"/>
							    <label><s:message code="label.generic.youropinion" text="Your opinion" /></label>
							    <form:textarea name="" rows="6" class="span6" path="description"/>
								<label>&nbsp;</label>
							    <span class="help-block"><s:message code="label.product.clickrate" text="Product rating (click on the stars to activate rating)" /></span>
							    <div id="rateMe" style="width: 100px;"></div>
										<script>
										$(function() {
											$('#rateMe').raty({ 
												readOnly: false, 
												half: true,
												path : '<c:url value="/resources/img/stars/"/>',
												score: 5,
												click: function(score, evt) {
													    $('#rating').val(score);
											    }
											});
										});	
										</script>
								<br/>
							    <button type="submit" class="btn"><s:message code="button.label.submit2" text="Submit"/></button>
					    </form:form>

						</c:otherwise>
						</c:choose>
					</sec:authorize>
						</div>
						<div class="span6">&nbsp;</div>
						</div>
						</div> --%>
			
			<div class="resbox-review-form" id="reviewContainer">
                <sec:authorize access="hasRole('AUTH_CUSTOMER') and fullyAuthenticated">
                	<c:url var="submitReview" value="/shop/customer/submit-review.html"/>
                	<form id="rwForm" method="POST" action="${submitReview}">
                	<h2>Write a Review</h2>
                	<div id="rateMe" style="width: 100px; padding-bottom: 12px;"></div>
                    <div id="quick_review_initial">
                   			<input name="review" autocomplete="off" type="text" class="form-control" placeholder="Write a review for ${product.manufacturer.description.name}">
	                    	<i class=" fa fa-pencil"></i>
	                    	<button type="submit" class="ui button red">Publish Review</button>
                    </div>
                    <input type="hidden" name="rating" id="rating" value="5"/>
                    <input type="hidden" name="productId" id="productId" value="${product.sku}"/>
                    </form>
                </sec:authorize>
                <sec:authorize access="!hasRole('AUTH_CUSTOMER') and !fullyAuthenticated">
                	<div id="quick_review_initial">
						<h2><s:message code="label.product.reviews.logon.write" text="You have to be authenticated to write a review" /></h2>
					</div>
				</sec:authorize>
            </div>
            
            
							<script>
							
							
								        
										$(function() {
											$("#rwForm").on("submit", function(event){
												event.preventDefault();
												$("#Customer-Reviews").showLoading();
												$.ajax({
										            url     : $(this).attr('action'),
										            type    : $(this).attr('method'),
										            dataType: 'json',
										            data    : $(this).serialize(),
										            contentType: 'application/x-www-form-urlencoded; charset=utf-8',
										            success : function( data ) {
										            			console.log(data);
										            			if(data.ajaxResponse==0){
										            				var template = Hogan.compile(document.getElementById("reviewTemplate").innerHTML);
										            				 $("#reviewsDiv").prepend(template.render(data));
										            				 $('#productRating'+data.id).raty({
										            						readOnly : true,
										            						half : true,
										            						path : '<c:url value="/resources/img/stars/"/>',
										            						score : data.rating
										            					});
										            				 $("#rwForm input[name='review']").val("");
										            			}
										            			$("#Customer-Reviews").hideLoading();
										                      },
										            error   : function( xhr, err ) {
										            			$("#Customer-Reviews").hideLoading();
										                        alert('System error in posting reviews. Please try again later.');     
										                      }
										        });
											});
											orderReviews("item-id");
											$('#rateMe').raty({ 
												readOnly: false, 
												half: true,
												path : '<c:url value="/resources/img/stars/"/>',
												score: 5,
												click: function(score, evt) {
													$('#rating').val(score);
											    }
											});
										});	
										
										function orderReviews(attribute) {
											  var $prods = $('#reviewsDiv');
											  var $data1 = $prods.clone();
											  
											  var $filteredData = $data1.children();
										      var $sortedData = $filteredData.sorted({
											      reversed:true, 
										    	  by: function(v) {
											        	if(attribute=='item-price') {
											        		return parseFloat($(v).attr(attribute));
											        	} else {
											        		return $(v).attr(attribute);
											        	}
											        }
											  });
											  $prods.html('');
											  $prods.append($sortedData);
										}
										</script>
<script type="text/html" id="reviewTemplate">
	<div class="single-review">
			<div class="star-review ">
				<span class="green">{{rating}}<span class="star">★</span></span>
				<p>good looking product.</p>
				<div id="productRating{{id}}></div>
			</div>
			<div class="dec">
				<blockquote>
					{{description}}
				</blockquote>
			</div>
			<div class="row">
				<div class="col-sm-6">
					{{customer.firstName}}&nbsp;{{customer.lastName}}&nbsp;{{date}}
				</div>
			</div>
		</div>
</script>