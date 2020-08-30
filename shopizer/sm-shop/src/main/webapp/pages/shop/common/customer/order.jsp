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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="/WEB-INF/shopizer-tags.tld" prefix="sm"%>
 
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<script src="<c:url value="/resources/js/jquery.print.js" />"></script>

<script type="text/javascript">

function print() {
	$('#printableOrder').print();
}

</script>

<div id="printableOrder" class="container">
<c:set value="${order}" scope="request" var="ORDER"/>
<jsp:include page="/pages/shop/common/preBuiltBlocks/invoice.jsp"/>
<div class="row">
    	<div class="col-xs-12">
    		<input type="button" onclick="print();" value="<s:message code="label.generic.print" text="Print" />" name="Print" class="btn btn-large">
    		<a href="/shop/order/invoice.html?orderId=${order.id }"><button class="btn-danger btn pull-right" id="invdwl">Download Invoice</button></a>
    	</div>
</div>
</div>
<%-- <div class="row">
        <div class="col-xs-12">
    		<div class="invoice-title">
    			<h2>Invoice</h2><h3 class="pull-right">Order #${order.id}</h3>
    		</div>
    		<hr>
    		<div class="row">
    			<div class="col-xs-6">
    				<address>
    				<strong>Billed To:</strong><br>
    					${order.billing.firstName} ${order.billing.lastName}<br>
    					${order.billing.city}<br>
    					${order.billing.country}<br>
    					${order.billing.postalCode}<br>
    					${order.customer.emailAddress}<br>
    					${order.billing.phone}<br>
    				</address>
    			</div>
    			<div class="col-xs-6 text-right">
    				<strong>Order Date:</strong><br>
    					<fmt:formatDate type="both" dateStyle="long" value="${order.datePurchased}" /><br/><br/>
    			</div>
    		</div>
    		<div class="row">
    			<div class="col-xs-6">
    				<address>
    					<strong>Payment Method:</strong><br>
    					Paytm<br>
    				</address>
    			</div>
    			<div class="col-xs-6 text-right">
    			</div>
    		</div>
    	</div>
    </div>
    <div class="row">
    	<div class="col-xs-12">
    		<div class="panel panel-default">
    			<div class="panel-heading">
    				<h3 class="panel-title"><strong>Order summary</strong></h3>
    			</div>
    			<div class="panel-body">
    				<div class="table-responsive">
    					<table class="table table-condensed invoice-table">
    						<thead>
                                <tr>
                                	<td><strong>Code</strong></td>
        							<td><strong>Item</strong></td>
        							<td><strong>Coupon Code</strong></td>
        							<td><strong>Price</strong></td>
        							<td class="text-center"><strong>Quantity</strong></td>
        							<td class="text-right"><strong>Totals</strong></td>
                                </tr>
    						</thead>
    						<tbody>
    							<c:forEach items="${order.products}" var="item">
    								<tr>
    									<td>${item.sku}</td>
    									<td>${item.productName}</td>
    									<td>${item.code.code}</td>
	    								<td><i class="fa fa-inr"></i> ${item.price}</td>
	    								<td class="text-center">${item.orderedQuantity}</td>
	    								<td class="text-right"><i class="fa fa-inr"></i> ${item.subTotal}</td>
    								</tr>
    							</c:forEach>
    							<tr>
    								<td class="thick-line"></td>
		    						<td class="thick-line"></td>
		    						<td class="thick-line"></td>
		    						<td class="thick-line"></td>
		    						<td class="thick-line"></td>
		    						<td class="thick-line"></td>
    							</tr>
    							<c:forEach items="${order.totals }" var="total" varStatus="i">
    								<tr>
    									<td class="no-line"></td>
    									<td class="no-line"></td>
    									<td class="no-line"></td>
    									<td class="no-line"></td>
	    								<td class="text-center"><strong><s:message code="${total.code}"/></strong></td>
	    								<td class="text-right"><i class="fa fa-inr"></i> ${total.value }</td>
    								</tr>
    							</c:forEach>
    						</tbody>
    					</table>
    				</div>
    			</div>
    		</div>
    	</div>
    </div>
    <div class="row">
    	<div class="col-xs-12">
    		<a href="http://localhost:8080/shop/order/invoice.html?orderId=${order.id }"><button class="btn-danger btn pull-right" id="invdwl">Download Invoice</button></a>
    	</div>
    </div>
</div> --%>


	<%-- <div id="main-content" class="container clearfix row-fluid">
		



				<header class="page-header">
					<h1><s:message code="label.order.details" text="Order details" />&nbsp;#&nbsp;<c:out value="${order.id}"/></h1>
				</header>

				
				<div class="row-fluid">
				<!-- note class 'printable' - this area is printable only! -->

					<!-- Buttons -->
					<div class="alert-custom">

						<div class="row-fluid">

							<div class="col-md-8 col-sm-8 pull-left"><!-- left text -->

								
								          <c:if test="${downloads!=null}">
									          	<p class="nomargin">
									          	<c:choose>
									          		<c:when test="${order.orderStatus.value=='processed'}">
									          		    <strong><s:message code="label.checkout.downloads.completed" text="label.checkout.downloads.completed"/></strong><br/>
									          			<c:forEach items="${downloads}" var="download">
									          				<a href="<sm:orderProductDownload productDownload="${download}" orderId="${order.id}"/>"><c:out value="${download.fileName}" /></a>
									          			</c:forEach>
									          		</c:when>
									          		<c:otherwise>
														<s:message code="label.checkout.downloads.processing" text="*** An email with your file(s) download instructions will be sent once the payment for this order will be completed."/>
									          		</c:otherwise>
									          	</c:choose>
												</p>
									       </c:if>
								
								
							</div><!-- /left text -->

							
							<div class="col-md-4 col-sm-4 text-right pull-right">
								<input type="button" onclick="print();" value="<s:message code="label.generic.print" text="Print" />" name="Print" class="btn btn-large">
							</div>

						</div>

					</div>
					
					<div id="printableOrder" class="row-fluid">
					
					
					<div class="row-fluid">
					
						<div class="col-md-12 col-sm-12 pull-left">
						
							
							<h2><s:message code="label.entity.order" text="Order" />&nbsp;#&nbsp;<c:out value="${order.id}"/><br/></h2>
							<p class="lead">
							<fmt:formatDate type="both" dateStyle="long" value="${order.datePurchased}" /><br/>
							<s:message code="label.order.${order.orderStatus.value}" text="${order.orderStatus.value}" />
							</p>
						</div>
					</div>

					<!-- BILLING and SHIPPING ADDRESS -->
					<div class="row-fluid">
						<div class="col-md-6 col-sm-6">
							<c:if test="${not empty order.billing}">
							<h5><strong><s:message code="label.customer.billingaddress" text="Billing address" /></strong></h5>
							<p>
								<c:set var="address" value="${order.billing}" scope="request" />
								<c:set var="addressType" value="billing" scope="request" />
								<jsp:include page="/pages/shop/common/preBuiltBlocks/customerAddress.jsp"/>
							</p>
							</c:if>
						</div>
						
					</div>
		
					<!-- PRODUCTS TABLE -->
					<div id="cartContent">
						<!-- cart header -->
						<div class="item head">
							<span class="cartImage"></span>
							<span class="productName"><s:message code="label.productedit.productname" text="Product name" /></span>
							<span class="quantity"><s:message code="label.quantity" text="Quantity" /></span>
							<span class="totalPrice"><s:message code="label.generic.price" text="Price" /></span>
							<span class="subTotal"><s:message code="order.total.subtotal" text="Sub-total" /></span>
							<div class="clearfix"></div>
						</div>
						<!-- /cart header -->

						<!-- cart item -->
						<c:forEach items="${order.products}" var="product">
						<div class="item">
							<div class="cartImage">
							<c:if test="${not empty product.image}">
							<img width="60" src="<sm:shopProductImage imageName="${product.image}" sku="${product.sku}"/>"/>
							</c:if>
							</div>
							
							<span class="productName">
							<c:choose>
							<c:when test="${product.product!=null}">
								<a href="<c:url value="/shop/product/" /><c:out value="${product.product.description.friendlyUrl}"/>.html"><c:out value="${product.productName}"/></a>
							</c:when>
							<c:otherwise>
								<c:out value="${product.productName}"/>
							</c:otherwise>
							</c:choose>
							<br/>
								<c:if test="${product.attributes !=null}">
									<ul>
									<c:forEach items="${product.attributes}" var="attribute">
										<li><c:out value="${attribute.attributeName}"/>:&nbsp;<c:out value="${attribute.attributeValue}"/></li>
									</c:forEach>
									</ul>
								</c:if>
							</span>
							<div class="quantity"><c:out value="${product.orderedQuantity}"/></div>
							<div class="totalPrice"><c:out value="${product.price}"/></div>
							<div class="subTotal"><c:out value="${product.subTotal}"/></div>
							<div class="clearfix"></div>
						</div>
						</c:forEach>
						<!-- /cart item -->


						<!-- cart total -->
						<div class="total pull-right">
							<c:forEach items="${order.totals}" var="orderTotal" varStatus="counter">
								<small class="totalItem">
									<c:if test="${orderTotal.code=='refund'}"><font color="red"></c:if><s:message code="${orderTotal.code}" text="${orderTotal.code}"/>:<c:if test="${orderTotal.code=='refund'}"></font></c:if>
									<span <c:if test="orderTotal.code=='total'">class="totalToPay"</c:if>><strong><c:if test="${orderTotal.code=='refund'}"><font color="red"></c:if><sm:monetary value="${orderTotal.value}" /><c:if test="${orderTotal.code=='refund'}"></font></c:if></strong></span>
								</small>
								<br/>
							</c:forEach>
						</div>
						<!-- /cart total -->

						<div class="clearfix"></div>
					</div>
					<!-- /SUMMARY TABLE -->


				</div>

		



		</div>
	
	</div> --%>
	<!--close .container "main-content" -->
