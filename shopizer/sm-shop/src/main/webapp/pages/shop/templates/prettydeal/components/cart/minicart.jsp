
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
<%@ taglib uri="/WEB-INF/shopizer-tags.tld" prefix="sm"%>

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<script type="text/html" id="miniShoppingCartTemplate">
{{#shoppingCartItems}}
<div class="row">
			<table class="table">
				<tr>
					<td>
						<div class="image">
							<a href="#"><img width="40" src="{{contextPath}}{{image}}" alt=""></a>
						</div>
					</td>
					<td><p class="name">x{{quantity}}</p></td>
					<td><h3 class="name">
				<a href="/shop/product/{{seUrl}}.html">{{name}}</a>
			</h3>
						<div class="price"><i class="fa fa-inr"></i> {{productPrice}}</div></td>
					<td><div class="action">
							<a productid="{{productId}}" onclick="removeItemFromMinicart(event,'{{id}}')" href="#"><i class="fa fa-trash class"></i></a>
						</div></td>

				</tr>
			</table>
		</div>
{{/shoppingCartItems}}
</script>
<div id="cartMessage" class="text" style="display:none;color: black;"></div>
<div id="shoppingcart">
	<div class="cart-item product-summary" id="cart-box">
	</div>
	<div  id="cart-voucher" class="clearfix cart-total" >
		<div class="pull-right" id="voucher"></div>
	</div>
	<div  id="cart-discount" class="clearfix cart-total" >
		<div class="pull-right" id="discount"></div>
	</div>
	<div  id="cart-total" class="clearfix cart-total" >
		<div class="pull-right" id="total-box"></div>
		<div class="clearfix"></div>
		<a href="#"
			onclick="viewShoppingCartPage();" class="btn btn-upper btn-primary btn-block m-t-20"><s:message code="label.checkout" text="Checkout"/></a>
	</div>
</div>
