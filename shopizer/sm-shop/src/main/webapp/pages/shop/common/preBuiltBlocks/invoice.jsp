<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
 <%@ taglib uri="/WEB-INF/shopizer-tags.tld" prefix="sm"%>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="row">
        <div class="col-xs-12">
    			<div class="col-xs-12" style="top:20px;">
    				<div class="alert alert-success fade in">
				    <h4><c:out value="${ordermessage}" /></h4>
				</div>
         			<p><c:out value="${ordersms}" /></p>
    			</div>
    		<div class="invoice-title">
    			<h2>Invoice</h2><h3 class="pull-right">Order #${requestScope.ORDER.id}</h3>
    		</div>
    		<hr>
    		<div class="row">
    			<div class="col-xs-6">
    				<address>
    				<strong>Billed To:</strong><br>
    					${requestScope.ORDER.billing.firstName} ${requestScope.ORDER.billing.lastName}<br>
    					${requestScope.ORDER.billing.city}<br>
    					${requestScope.ORDER.billing.country}<br>
    					${requestScope.ORDER.billing.postalCode}<br>
    					${requestScope.ORDER.customer.emailAddress}<br>
    					${requestScope.ORDER.billing.phone}<br>
    				</address>
    			</div>
    			<div class="col-xs-6 text-right">
    				<strong>Order Date:</strong><br>
    					<fmt:formatDate type="both" dateStyle="long" value="${requestScope.ORDER.datePurchased}" /><br><br>
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
    				<!-- <address>
    					<strong>Order Date:</strong><br>
    					March 7, 2014<br><br>
    				</address> -->
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
    							<c:forEach items="${requestScope.ORDER.products}" var="item">
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
    							<c:forEach items="${requestScope.ORDER.totals }" var="total" varStatus="i">
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
