
<%
	response.setCharacterEncoding("UTF-8");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", -1);
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/shopizer-tags.tld" prefix="sm"%>

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<script
	src="<c:url value="/resources/js/jquery.elevateZoom-3.0.8.min.js" />"></script>
<script src="<c:url value="/resources/js/jquery.raty.min.js" />"></script>

<script>

      jQuery(function($) {
    // Asynchronously Load the map API 
    var script = document.createElement('script');
    script.src = "//maps.googleapis.com/maps/api/js?sensor=false&callback=initialize&key=AIzaSyDVxV3ARNoD_FrC-15WIrW4UPsy2BZ6C5s";
    document.body.appendChild(script);
});

function initialize() {
    var map;
    var bounds = new google.maps.LatLngBounds();
    var myLatLng = {lat: ${product.manufacturer.latitude}, lng: ${product.manufacturer.longitude}};
    var mapOptions = {
        mapTypeId: 'roadmap',
        zoom:17,
        center: myLatLng
    };
                    
    // Display a map on the page
    map = new google.maps.Map(document.getElementById("map"), mapOptions);
    map.setTilt(45);
        
    // Multiple Markers
    var markers = [
        ['Sector 17', 30.7402727,76.7738928],
        ['${product.manufacturer.description.name}', ${product.manufacturer.latitude},${product.manufacturer.longitude}]
    ];
                        
        
    // Display multiple markers on a map
    var infoWindow = new google.maps.InfoWindow(), marker, i;
    
    // Loop through our array of markers & place each one on the map  
    for( i = 0; i < markers.length; i++ ) {
        var position = new google.maps.LatLng(markers[i][1], markers[i][2]);
        bounds.extend(position);
        marker = new google.maps.Marker({
            position: position,
            map: map,
            title: markers[i][0]
        });
     
        // Automatically center the map fitting all markers on the screen
        map.fitBounds(bounds);
    }

    
}
    </script>
<section>

	<div class="container">
		<jsp:include
			page="/pages/shop/templates/exoticamobilia/sections/breadcrumb.jsp" />
		<div class="row">


			<div class="col-sm-12 padding-right">
				<div class="product-details">
					<!--product-details-->
					<div class="col-sm-4">
						<h4 class="product-man-title">${product.manufacturer.description.name}</h4>
						<div id="product-caraousal" class="carousel slide"
							data-ride="carousel">
							<!-- Indicators -->
							<ol class="carousel-indicators">
								<c:forEach items="${product.images }" var="image" varStatus="i">
									<c:choose>
										<c:when test="${i.index == 0}">
											<li data-target="#product-caraousal"
												data-slide-to="${i.index}" class="active"></li>
										</c:when>
										<c:otherwise>
											<li data-target="#product-caraousal"
												data-slide-to="${i.index}" li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</ol>
							<!-- Wrapper for slides -->
							<div id="product-slides" class="carousel-inner" role="listbox">
								<c:forEach items="${product.images }" var="image" varStatus="i">
									<c:choose>
										<c:when test="${i.index == 0}">
											<div class="item active">
												<a onClick="event.preventDefault();" href=""><img
													class="carousal-product-img" src="${image.imageUrl }"
													alt=""></a>
											</div>
										</c:when>
										<c:otherwise>
											<div class="item">
												<a onClick="event.preventDefault();" href=""><img
													class="carousal-product-img" src="${image.imageUrl }"
													alt=""></a>
											</div>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</div>

							<!-- Controls -->
							<a class="left item-control" href="#product-slides"
								data-slide="prev"> <i class="fa fa-angle-left"></i>
							</a> <a class="right item-control" href="#product-slides"
								data-slide="next"> <i class="fa fa-angle-right"></i>
							</a> <a href=""><img
								src="<c:url value="/resources/templates/exoticamobilia/img/product-details/share.png" />"
								class="share img-responsive" alt="" /></a>
						</div>
						<div class="product-information">
							${product.manufacturer.description.address}
						</div>
					</div>
					<div class="col-sm-8">
						<div class="product-information">
							<div class="col-sm-8">
								<div class="info-list">
									<h2>${product.description.name}</h2>
								</div>
								<p>Deal Code: ${product.sku}</p>
								<c:choose>
									<c:when test="${product.discounted}">
										<div class="box-1">
											<span class="dealprice"
												style="background: #000; font-size: 22px; color: #fff; border: 1px solid #000; width: 100%; padding: 10px; text-align: center; line-height: 20px;">Rs.7000.00</span>

											<div class=" col-md-12 price-list">
												<div class="col-md-6">Original Price</div>
												<div class="col-md-6">Savings</div>
											</div>
											<div class="col-md-12 price-list">
												<div class="col-md-6">
													<h4>${product.originalPrice}</h4>
												</div>
												<div class="col-md-6">
													<h4>Rs. 3,000.00</h4>
												</div>
											</div>
											<div class=" col-md-12 price-list">
												<label>Quantity:</label> <select>
													<option value="1">1</option>
													<option value="2">2</option>
													<option value="3">3</option>
													<option value="4">4</option>
												</select>
												<button type="button" class="btn btn-fefault cart"
													style="margin-top: 0px;">
													<i class="fa fa-shopping-cart"></i> Add to cart
												</button>
											</div>
										</div>
									</c:when>
									<c:otherwise>
										<div class="saveprice">
											<span itemprop="price"><c:out
													value="${product.finalPrice}" /></span>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
							<div class="col-sm-4">
								<div id="recommended-item-carousel12"
									class="carousel slide vertical" data-ride="carousel">
									<!-- Wrapper for slides -->
									<div class="carousel-inner">
										<c:forEach items="${cProducts}" var="p" varStatus="i">
											<c:choose>
												<c:when test="${i.index == 0}">
													<div class="item active">
														<c:set var="product" value="${p}" scope="request" />
														<c:set var="FEATURED" value="true" scope="request" />
														<jsp:include
															page="/pages/shop/templates/exoticamobilia/sections/productBox2.jsp" />
													</div>
												</c:when>
												<c:otherwise>
													<div class="item">
														<c:set var="product" value="${p}" scope="request" />
														<c:set var="FEATURED" value="true" scope="request" />
														<jsp:include
															page="/pages/shop/templates/exoticamobilia/sections/productBox2.jsp" />
													</div>
												</c:otherwise>
											</c:choose>

										</c:forEach>
									</div>

									<a class="left recommended-item-control"
										href="#recommended-item-carousel12" data-slide="prev"> <i
										class="fa fa-angle-left"></i>
									</a> <a class="right recommended-item-control"
										href="#recommended-item-carousel12" data-slide="next"> <i
										class="fa fa-angle-right"></i>
									</a>
								</div>
							</div>
							<div>
								<div id="map" style="height: 150px; width: 100%"></div>
							</div>
						</div>
					</div>


				</div>
			</div>
		</div>
		<div class="row">
			<div class="category-tab shop-details-tab">
				<div class="col-sm-12">
					<ul class="nav nav-tabs category-ul">
						<li class="active"><a href="#details" data-toggle="tab">Details</a></li>
						<li><a href="#reviews" data-toggle="tab">Reviews (5)</a></li>
					</ul>
				</div>
				<div class="col-sm-12 tab-content">
					<div class="tab-pane active in deal-detail" id="details">
							<c:out value="${product.description.description}"
								escapeXml="false" />
					</div>

					<div class="tab-pane fade" id="reviews">
						<div class="col-sm-12">
							<ul class="category-ul">
								<li><a href=""><i class="fa fa-user"></i>EUGEN</a></li>
								<li><a href=""><i class="fa fa-clock-o"></i>12:41 PM</a></li>
								<li><a href=""><i class="fa fa-calendar-o"></i>31 DEC
										2014</a></li>
							</ul>
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit,
								sed do eiusmod tempor incididunt ut labore et dolore magna
								aliqua.Ut enim ad minim veniam, quis nostrud exercitation
								ullamco laboris nisi ut aliquip ex ea commodo consequat.Duis
								aute irure dolor in reprehenderit in voluptate velit esse cillum
								dolore eu fugiat nulla pariatur.</p>
							<p>
								<b>Write Your Review</b>
							</p>

							<form action="#">
								<span> <input type="text" placeholder="Your Name" /> <input
									type="email" placeholder="Email Address" />
								</span>
								<textarea name=""></textarea>
								<b>Rating: </b> <img src="images/product-details/rating.png"
									alt="" />
								<button type="button" class="btn btn-default pull-right">
									Submit</button>
							</form>
						</div>
					</div>

				</div>
			</div>
			<!--/category-tab-->
			<div class="col-sm-12 recommended_items">
				<!--recommended_items-->
				<h2 class="title text-center">related deals</h2>
				<c:if test="${requestScope.RECOMMENDED_DEALS != null}">

					<c:set var="CITEMS" value="${requestScope.RECOMMENDED_DEALS}"
						scope="request" />
				</c:if>
				<c:if test="${relatedProducts != null}">
					<c:set var="CITEMS" value="${relatedProducts}" scope="request" />
				</c:if>
				<div id="recommended-item-carousel" class="carousel slide"
					data-ride="carousel">
					<!-- Wrapper for slides -->
					<div id="similar-product" class="carousel-inner" role="listbox">
						<c:forEach items="${CITEMS}" var="relProduct" varStatus="i">
							<c:choose>
								<c:when test="${i.index == 0}">
									<div class="item active">
										<c:forEach items="${relProduct}" var="p">
											<c:set var="product" value="${p}" scope="request" />
											<c:set var="FEATURED" value="false" scope="request" />
											<div class="col-sm-3">
											<jsp:include
												page="/pages/shop/templates/exoticamobilia/sections/productBox2.jsp" />
											</div>
										</c:forEach>
									</div>
								</c:when>
								<c:otherwise>
									<div class="item">
										<c:forEach items="${relProduct}" var="p">
											<c:set var="product" value="${p}" scope="request" />
											<c:set var="FEATURED" value="false" scope="request" />
											<div class="col-sm-3">
											<jsp:include
												page="/pages/shop/templates/exoticamobilia/sections/productBox2.jsp" />
											</div>
										</c:forEach>
									</div>
								</c:otherwise>
							</c:choose>

						</c:forEach>
					</div>

					<a class="left recommended-item-control"
						href="#recommended-item-carousel" data-slide="prev"> <i
						class="fa fa-angle-left"></i>
					</a> <a class="right recommended-item-control"
						href="#recommended-item-carousel" data-slide="next"> <i
						class="fa fa-angle-right"></i>
					</a>
				</div>
			</div>
			<!--/recommended_items-->

		</div>
	</div>

</section>

<%-- <div id="shop" class="container">
            
            
            <jsp:include page="/pages/shop/templates/exoticamobilia/sections/breadcrumb.jsp" />
            
            <section class="main-container">
					
					
				<div class="container no-left-padding no-right-padding">	
					<div class="row">
					
						<div class="main col-md-12">
						
						
							<!-- page-title start -->
							<h1 class="page-title margin-top-clear">${product.description.name}</h1>
							<!-- page-title end -->
							
							<div class="row">

							<div class="col-md-4">
								
								<ul role="tablist" class="nav nav-pills white space-top">
									<li class="active">
										<a title="images" data-toggle="tab" role="tab" href="#product-images">
											<i class="fa fa-camera pr-5"></i> <s:message code="label.generic.pictures" text="Pictures" />
										</a>
									</li>
									<li>
										<a title="video" data-toggle="tab" role="tab" href="#product-video">
											<i class="fa fa-video-camera pr-5"></i> <s:message code="label.generic.videos" text="Videos" />
										</a>
									</li>
								</ul>
								<div class="tab-content clear-style">
								    <c:if test="${product.image!=null}">
									<div id="product-images" class="tab-pane active">
										
										
											<div style="width: 360px;" class="owl-item">
													<div id="largeImg" class="overlay-container image-container">
																<img src="<c:url value="${product.image.imageUrl}"/>" alt="<c:out value="${product.description.name}"/>">
																<a href="<sm:shopProductImage imageName="${product.image.imageName}" sku="${product.sku}" size="LARGE"/>" class="popup-img overlay" title="<c:out value="${product.description.name}"/>"><i class="fa fa-search-plus"></i></a>
													</div>
											</div>

											<c:if test="${product.images!=null && fn:length(product.images)>1}">
											<div id="imageGallery" class="row">
												<c:forEach items="${product.images}" var="thumbnail">	
												<div class="col-xs-6 col-md-3">
													<a href="javascript:;"" class="thumbImg thumbnail" imgId="im-<c:out value="${thumbnail.id}"/>" title="<c:out value="${thumbnail.imageName}"/>" rel="<c:url value="${thumbnail.imageUrl}"/>"><img src="<c:url value="${thumbnail.imageUrl}"/>"  alt="<c:url value="${thumbnail.imageName}"/>" ></a>
												</div>
												</c:forEach>
											</div>
											</c:if>
									</div>

									
									
									</c:if>
									
									<div class="tab-pane" id="product-video">
										<div class="embed-responsive embed-responsive-16by9">
												<!-- TODO -->
											    <iframe class="embed-responsive-item" src="<c:url value="/resources/templates/exoticamobilia/img/vimeo.html" />"></iframe>
												<p><a href="http://vimeo.com/29198414">Test Video</a> from <a href="http://vimeo.com/staff">Vimeo</a> on <a href="https://vimeo.com/">Vimeo</a>.</p>
										</div>
									</div>
									<hr>
									<span itemprop="offerDetails" itemscope itemtype="http://data-vocabulary.org/Offer">
									<meta itemprop="seller" content="${requestScope.MERCHANT_STORE.storename}"/>
									<meta itemprop="currency" content="<c:out value="${requestScope.MERCHANT_STORE.currency.code}" />" />
									<span id="productPrice" class="price">
										<c:choose>
											<c:when test="${product.discounted}">
													<del><c:out value="${product.originalPrice}" /></del>&nbsp;<span class="specialPrice"><span itemprop="price"><c:out value="${product.finalPrice}" /></span></span>
											</c:when>
											<c:otherwise>
													<span itemprop="price"><c:out value="${product.finalPrice}" /></span>
											</c:otherwise>
										</c:choose>
									</span>
								   <c:if test="${not product.productVirtual}">
								   <address>
								   		<strong><s:message code="label.product.available" text="Availability"/></strong>:&nbsp;<span><c:choose><c:when test="${product.quantity>0}"><span itemprop="availability" content="in_stock">${product.quantity}</span></c:when><c:otherwise><span itemprop="availability" content="out_of_stock"><s:message code="label.product.outofstock" text="Out of stock" /></c:otherwise></c:choose></span><br>								
								   </address>
							      </c:if>
								  </span>
								  <jsp:include page="/pages/shop/common/catalog/addToCartProduct.jsp" />
									
								</div>
						</div>

					<!--</div>-->
					
					<aside class="col-md-8">
								<div class="sidebar">
										<div class="side product-item vertical-divider-left">
											<div class="productItem tabs-style-2">
												<!-- Nav tabs -->
												<ul role="tablist" class="nav nav-tabs">
													<li class="active"><a data-toggle="tab" role="tab" href="#h2tab1" aria-expanded="true"><i class="fa fa-file-text-o pr-5"></i><s:message code="label.productedit.productdesc" text="Product description" /></a></li>
													<li class=""><a data-toggle="tab" role="tab" href="#h2tab2" aria-expanded="false"><i class="fa fa-files-o pr-5"></i><s:message code="label.product.attribute.specifications" text="Specifications" /></a></li>
													<li class=""><a data-toggle="tab" role="tab" href="#h2tab3"><i class="fa fa-star pr-5"></i><s:message code="label.product.customer.reviews" text="Customer reviews" /></a></li>
												</ul>
												<!-- Tab panes -->
												<div class="tab-content padding-top-clear padding-bottom-clear">
													<div id="h2tab1" class="tab-pane fade  active in">
														<h4 class="space-top"></h4>
														
														<c:out value="${product.description.description}" escapeXml="false"/>
														
														<p>
															<dl class="dl-horizontal">
																<dt><s:message code="label.product.weight" text="Weight" />:</dt>
																<dd><fmt:formatNumber value="${product.productWeight}" maxFractionDigits="2"/>&nbsp;<s:message code="label.generic.weightunit.${requestScope.MERCHANT_STORE.weightunitcode}" text="Pounds" /></dd>
																<dt><s:message code="label.product.height" text="Height" />:</dt>
																<dd><fmt:formatNumber value="${product.productHeight}" maxFractionDigits="2"/>&nbsp;<s:message code="label.generic.sizeunit.${requestScope.MERCHANT_STORE.seizeunitcode}" text="Inches" /></dd>
																<dt><s:message code="label.product.length" text="Length" />:</dt>
																<dd><fmt:formatNumber value="${product.productLength}" maxFractionDigits="2"/>&nbsp;<s:message code="label.generic.sizeunit.${requestScope.MERCHANT_STORE.seizeunitcode}" text="Inches" /></dd>
																<dt><s:message code="label.product.width" text="Width" />:</dt>
																<dd><fmt:formatNumber value="${product.productWidth}" maxFractionDigits="2"/>&nbsp;<s:message code="label.generic.sizeunit.${requestScope.MERCHANT_STORE.seizeunitcode}" text="Inches" /></dd>
															</dl>
														</p>
													</div>
													<div id="h2tab2" class="tab-pane fade">

														<!--  read only properties -->
														
															<h4 class="space-top"><s:message code="label.product.attribute.specifications" text="Specifications" /></h4>
														    
														
															<dl class="dl-horizontal">
															
															<c:if test="${attributes!=null}">
															<c:forEach items="${attributes}" var="attribute" varStatus="status">
						                        				<dt><c:out value="${attribute.name}"/></dt>
																<dd><c:out value="${attribute.readOnlyValue.description}" /></dd>
															</c:forEach>
															</c:if>
															</dl>
													  
														
														
													</div>
													<div id="h2tab3" class="tab-pane fade">
														<!-- comments start -->
															<h4 class="space-top">
																<s:message code="label.product.customer.reviews" text="Customer reviews" />
															</h4>

														<!-- reviews -->
														<jsp:include page="/pages/shop/common/catalog/reviews.jsp" />


													
												</div>
											</div>
										</div>
									</div>
				    </aside>
				</div>
			</div>
		</section>
		
		<!-- Related items -->
        <c:if test="${relatedProducts!=null}">	
		<div class="section clearfix main-container">
				<div class="container no-left-padding no-right-padding">
					<div class="row">
						<div class="col-md-12">
							<h2><s:message code="label.product.related.title" text="Related items"/></h2>
							<!--<p>Voici quelques suggestions de produits additionnels</p>-->
							<!-- Iterate over featuredItems -->
                         	<c:set var="ITEMS" value="${relatedProducts}" scope="request" />
	                        
						</div>
					</div>
				</div>
		</div>
		</c:if>
		
		</div> --%>

