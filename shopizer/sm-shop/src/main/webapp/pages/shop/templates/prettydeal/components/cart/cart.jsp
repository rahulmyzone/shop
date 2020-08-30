<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="/WEB-INF/shopizer-tags.tld" prefix="sm"%>

<script
	src="<c:url value="/resources/js/jquery.alphanumeric.pack.js" />"></script>



<c:url value="/shop/cart/removeShoppingCartItem.html"
	var="removeShoppingCartItemUrl" />

<section id="top-banner-and-menu">
  <div class="container-fluid">
    <div class="row">
      <div id="mainslider" class="owl-carousel" >
        <div class="item" style="background-image:url(/resources/templates/prettydeal/img/home-banner.png);">
          <div class="container">
            <div class="caption bg-color vertical-center text-center">
              <div class="slider-header fadeInDown-1">PRETTY & COMFORTABLE</div>
              <div class="big-text fadeInDown-1"> Minimum 50% Off On 1 buy 1 </div>
              <div class="button-holder fadeInDown-3"> <a href="index.php?page=single-product" class="text-uppercase shop-now-button btn-outline hvr-sweep-to-right">Grab it Now</a> </div>
            </div>
          </div>
        </div>
        <div class="item" style="background-image:url(/resources/templates/prettydeal/img/home-banner.png);">
          <div class="container">
            <div class="caption bg-color vertical-center text-center">
              <div class="slider-header fadeInDown-1">PRETTY & COMFORTABLE</div>
              <div class="big-text fadeInDown-1"> Minimum 50% Off On Hotels </div>
              <div class="button-holder fadeInDown-3"> <a href="index.php?page=single-product" class="text-uppercase shop-now-button btn-outline hvr-sweep-to-right">Grab it Now</a> </div>
            </div>
          </div>
        </div>
        <div class="item" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/home-banner.png" />);">
          <div class="container">
            <div class="caption bg-color vertical-center text-center">
              <div class="slider-header fadeInDown-1">PRETTY & COMFORTABLE</div>
              <div class="big-text fadeInDown-1"> Minimum 40% Off On Hotels </div>
              <div class="button-holder fadeInDown-3"> <a href="index.php?page=single-product" class="text-uppercase shop-now-button btn-outline hvr-sweep-to-right">Grab it Now</a> </div>
            </div>
          </div>
        </div>
        <div class="item" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/home-banner.png" />);">
          <div class="container">
            <div class="caption bg-color vertical-center text-center">
              <div class="slider-header fadeInDown-1">PRETTY & COMFORTABLE</div>
              <div class="big-text fadeInDown-1"> Minimum 30% Off On Hotels </div>
              <div class="button-holder fadeInDown-3"> <a href="index.php?page=single-product" class="text-uppercase shop-now-button btn-outline hvr-sweep-to-right">Grab it Now</a> </div>
            </div>
          </div>
        </div>
      </div>
      <div class="container">
        <div id="mainslider1" class="owl-carousel">
          <div class="item"><span>1 buy 1</span></div>
          <div class="item"><span>50%off</span></div>
          <div class="item"><span>40%off</span></div>
          <div class="item"><span>30%off</span></div>
        </div>
      </div>
    </div>
  </div>
</section>



<section id="cart_items">
	<div class="container">
		<div class="breadcrumbs">
			<ol class="breadcrumb">
				<li><a href="#">Home</a></li>
				<li class="active">Shopping Cart</li>
			</ol>
		</div>
		<h1 class="cart-title">
			<s:message code="label.cart.revieworder" text="Review your order" />
		</h1>
		<div id="store.error" class="alert alert-error" style="display: none;">
			<s:message code="message.error.shoppingcart.update"
				text="An error occurred while updating the shopping cart" />
		</div>
		<br />
		<div class="table-responsive cart_info">
			<table id="mainCartTable" class="table table-striped ">

				<c:if test="${not empty cart}">
					<c:choose>
						<c:when test="${not empty cart.shoppingCartItems}">

							<c:forEach items="${cart.shoppingCartItems}"
								var="shoppingCartItem" varStatus="itemStatus">
								<c:if test="${itemStatus.index eq 0}">
									<thead>
										<tr class="cart_menu">
											<th colspan="2" width="55%"><s:message
													code="label.generic.item.title" text="Item" /></th>
											<th colspan="2" width="15%"><s:message
													code="label.quantity" text="Quantity" /></th>
											<th width="15%"><s:message code="label.generic.price"
													text="Price" /></th>
											<th width="15%"><s:message code="label.order.total"
													text="Total" /></th>
										</tr>
									</thead>
									<tbody>
								</c:if>
								<form:form action="${updateShoppingCartItemUrl}"
									id="shoppingCartLineitem_${shoppingCartItem.id}">
									<tr>
										<td width="10%"><c:if
												test="${shoppingCartItem.image!=null}">
												<img width="60"
													src="<c:url value="${shoppingCartItem.image}"/>">
											</c:if></td>

										<td style="border-left: none;"><strong>${shoppingCartItem.name}</strong>
											<c:if
												test="${fn:length(shoppingCartItem.shoppingCartAttributes)>0}">
												<br />
												<ul>
													<c:forEach
														items="${shoppingCartItem.shoppingCartAttributes}"
														var="option">
														<li>${option.optionName}- ${option.optionValue}</li>
													</c:forEach>
												</ul>
											</c:if></td>
										<td><input type="text"
											class="input-small quantity form-control"
											placeholder="<s:message code="label.quantity" text="Quantity"/>"
											value="${shoppingCartItem.quantity}" name="quantity"
											id="${shoppingCartItem.id}"
											<c:if test="${shoppingCartItem.productVirtual==true}">readonly</c:if>>
										</td>
										<td style="border-left: none;"><button class="close"
												onclick="javascript:updateLineItem('${shoppingCartItem.id}','${removeShoppingCartItemUrl}');">&times;</button>
										</td>

										<td><strong>${shoppingCartItem.price}</strong></td>
										<td><strong>${shoppingCartItem.subTotal}</strong></td>


										<input type="hidden" name="lineItemId" id="lineItemId"
											value="${shoppingCartItem.id}" />


									</tr>
								</form:form>


							</c:forEach>
							<c:forEach items="${cart.totals}" var="total">
								<tr class="subt">
									<td colspan="2">&nbsp;</td>
									<td colspan="3"><strong><s:message
												code="${total.code}" text="label [${total.code}] not found" /></strong></td>
									<td><strong><sm:monetary value="${total.value}" /></strong></td>
								</tr>
							</c:forEach>
							<tr>
								<c:if test="${not empty cart}">
									<c:if test="${not empty cart.shoppingCartItems}">
										<td colspan="4">&nbsp;</td>
										<td><button type="button" class="btn"
												onClick="javascript:updateCart('#mainCartTable');">
												<s:message code="label.order.recalculate" text="Racalculate" />
											</button></td>
										<td>
											<button id="checkoutButton" type="button"
												class="btn btn-success" onclick="viewShoppingCartPage1();">
												<s:message code="label.cart.placeorder"
													text="Place your order" />
											</button>
										</td>
									</c:if>
								</c:if>
							</tr>
						</c:when>
						<c:otherwise>
							<tr>
								<td><s:message code="cart.empty"
										text="Your Shopping cart is empty" /></td>
							</tr>
						</c:otherwise>
					</c:choose>
				</c:if>


				</tbody>
			</table>
		</div>
	</div>
</section>
<!--/#cart_items-->

<%-- <section id="do_action">
	<div class="container">
		<div class="heading">
			<h3>What would you like to do next?</h3>
			<p>Choose if you have a discount code or reward points you want
				to use or would like to estimate your delivery cost.</p>
		</div>
		<div class="row">
			<div class="col-sm-12">
				<div class="chose_area">
					<ul class="user_option">
						<li><input type="checkbox"> <label>Use Coupon
								Code</label></li>
						<li><input type="checkbox"> <label>Use Gift
								Voucher</label></li>
						<li><input type="checkbox"> <label>Estimate
								Shipping & Taxes</label></li>
					</ul>
					<ul class="user_info">
						<li class="single_field"><label>Country:</label> <select>
								<option>United States</option>
								<option>Bangladesh</option>
								<option>UK</option>
								<option>India</option>
								<option>Pakistan</option>
								<option>Ucrane</option>
								<option>Canada</option>
								<option>Dubai</option>
						</select></li>
						<li class="single_field"><label>Region / State:</label> <select>
								<option>Select</option>
								<option>Dhaka</option>
								<option>London</option>
								<option>Dillih</option>
								<option>Lahore</option>
								<option>Alaska</option>
								<option>Canada</option>
								<option>Dubai</option>
						</select></li>
						<li class="single_field zip-field"><label>Zip Code:</label> <input
							type="text"></li>
					</ul>
					<a class="btn btn-default update" href="">Get Quotes</a> <a
						class="btn btn-default check_out" href="">Continue</a>
				</div>
			</div>

			<div class="col-sm-6">
				<div class="total_area">
					<ul>
						<li>Cart Sub Total <span>$59</span></li>
						<li>Eco Tax <span>$2</span></li>
						<li>Shipping Cost <span>Free</span></li>
						<li>Total <span>$61</span></li>
					</ul>
					<a class="btn btn-default update" href="">Update</a> <a
						class="btn btn-default check_out" href="">Check Out</a>
				</div>
			</div>
		</div>
	</div>
</section> --%>

<c:if test="${empty cart}">
	<!-- load cart with cookie -->
	<script>
		$(document)
				.ready(
						function() {
							var cartCode = getCartCode();
							if (cartCode != null) {
								console.log('cart code ' + cartCode);
								location.href = '<c:url value="/shop/cart/shoppingCartByCode.html" />?shoppingCartCode='
										+ cartCode;
							}

						});
	</script>
</c:if>

<script>
	$(document).ready(function() {
		$('.quantity').numeric();
		$("input[type='text']").keypress(function(e) {
			if (e.which == 13) {
				e.preventDefault();
			}
		});
		/* $('#checkoutButton').click(function(e) {
			location.href = '<c:url value="/shop/order/checkout.html"/>';
		}); */
	});
	function viewShoppingCartPage1(){
		window.location.href=getContextPath() + '/shop/cart/redirectCart.html';
		
	}
</script>


