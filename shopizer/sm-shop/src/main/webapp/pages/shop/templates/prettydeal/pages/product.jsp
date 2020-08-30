<%@page import="com.salesmanager.web.util.Utility"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.salesmanager.web.entity.catalog.product.ReadableProduct"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.collections4.ListUtils"%>
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

<script src="<c:url value="/resources/js/jquery.elevateZoom-3.0.8.min.js" />"></script>
<script src="<c:url value="/resources/js/jquery.raty.min.js" />"></script>
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.css" media="screen">
<script src="//cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.js"></script>


			<script>
				$(document).ready(function(){
				    $(".fancybox").fancybox({
				        openEffect: "none",
				        closeEffect: "none"
				    });
					$("#mapLink").click(function(event){
						event.preventDefault();
						goToByScroll("map");
					});
					
				});
			</script>
            
            <%-- <div class="row-fluid">

                <div itemscope class="span12" itemtype="http://data-vocabulary.org/Product">
                    	<!-- Image column -->
						<div id="img" class="span4 productMainImage">
							<c:if test="${product.image!=null}">
							<span id="mainImg"><img id="im-<c:out value="${product.image.id}"/>" alt="<c:out value="${product.description.name}"/>" src="<c:url value="${product.image.imageUrl}"/>" data-zoom-image="<sm:shopProductImage imageName="${product.image.imageName}" sku="${product.sku}" size="LARGE"/>"></span>												
							<script>
								$(function() {
									setImageZoom('im-<c:out value="${product.image.id}"/>');
								});	
							</script>
							<c:if test="${product.images!=null && fn:length(product.images)>1}">
								<ul id="imageGallery" class="thumbnails small">
									<c:forEach items="${product.images}" var="thumbnail">								
									<li class="span2">
										<a href="#img" class="thumbImg" title="<c:out value="${thumbnail.imageName}"/>"><img id="im-<c:out value="${thumbnail.id}"/>" src="<c:url value="${thumbnail.imageUrl}"/>" data-zoom-image="<sm:shopProductImage imageName="${thumbnail.imageName}" sku="${product.sku}" size="LARGE"/>" alt="<c:url value="${thumbnail.imageName}"/>" ></a>
									</li>
									</c:forEach>								
								</ul>
							</c:if>
							</c:if>
						</div>
						
						<!-- Google rich snippets (http://blog.hubspot.com/power-google-rich-snippets-ecommerce-seo-ht) -->
						<!-- Product description column -->
						<div class="span8">
							<p class="lead"><strong>${product.description.name}</strong></p>
							
							
							<!-- product rating -->
							<jsp:include page="/pages/shop/common/catalog/rating.jsp" />
							
							
							<address>
								<strong><s:message code="label.product.brand" text="Brand"/></strong> <span itemprop="brand"><c:out value="${product.manufacturer.description.name}" /></span><br>
								<strong><s:message code="label.product.code" text="Product code"/></strong> <span itemprop="identifier" content="mpn:${product.sku}">${product.sku}</span><br>								
							</address>
							<span itemprop="offerDetails" itemscope itemtype="http://data-vocabulary.org/Offer">
							<meta itemprop="seller" content="${requestScope.MERCHANT_STORE.storename}"/>
							<meta itemprop="currency" content="<c:out value="${requestScope.MERCHANT_STORE.currency.code}" />" />
							<h3 id="productPrice">
									<c:choose>
										<c:when test="${product.discounted}">
												<del><c:out value="${product.originalPrice}" /></del>&nbsp;<span class="specialPrice"><span itemprop="price"><c:out value="${product.finalPrice}" /></span></span>
										</c:when>
										<c:otherwise>
												<span itemprop="price"><c:out value="${product.finalPrice}" /></span>
										</c:otherwise>
									</c:choose>
							</h3>
							<c:if test="${not product.productVirtual}">
							<address>
								<strong><s:message code="label.product.available" text="Availability"/></strong> <span><c:choose><c:when test="${product.quantity>0}"><span itemprop="availability" content="in_stock">${product.quantity}</span></c:when><c:otherwise><span itemprop="availability" content="out_of_stock"><s:message code="label.product.outofstock" text="Out of stock" /></c:otherwise></c:choose></span><br>								
							</address>
							</c:if>
							</span>
							<p>
								<jsp:include page="/pages/shop/common/catalog/addToCartProduct.jsp" />
							</p>
						</div>

					</div>
			 </div> --%>
			 <%-- <div class="row-fluid">
                    <div class="span12">

							<ul class="nav nav-tabs" id="productTabs">
								<li class="active"><a href="#description"><s:message code="label.productedit.productdesc" text="Product description" /></a></li>
								<c:if test="${attributes!=null}"><li><a href="#specifications"><s:message code="label.product.attribute.specifications" text="Specifications" /></a></li></c:if>
								<li><a href="#reviews"><s:message code="label.product.customer.reviews" text="Customer reviews" /></a></li>
							</ul>							 
							<div class="tab-content">
								<div class="tab-pane active" id="description">
									<c:out value="${product.description.description}" escapeXml="false"/>
								</div>	
								<div class="tab-pane" id="specifications">
									<!--  read only properties -->
									<c:if test="${attributes!=null}">
										<table>
										<c:forEach items="${attributes}" var="attribute" varStatus="status">
										<tr>
	                        				<td><c:out value="${attribute.name}"/> : </td>
											<td><c:out value="${attribute.readOnlyValue.description}" /></td>
										</tr>
									</c:forEach>
									</table>
								  </c:if>
								</div>
								<div class="tab-pane" id="reviews">

									<!-- reviews -->
									<jsp:include page="/pages/shop/common/catalog/reviews.jsp" />


								</div>						
                        </div>	
                        <br/>
                        <br/>
                        <!-- Related items -->
                        <c:if test="${relatedProducts!=null}">	
                        			<h1><s:message code="label.product.related.title" text="Related items"/></h1>				
									<ul class="thumbnails product-list">
										<!-- Iterate over featuredItems -->
                         				<c:set var="ITEMS" value="${relatedProducts}" scope="request" />
	                         			<jsp:include page="/pages/shop/templates/bootstrap/sections/productBox.jsp" />
									</ul>
						</c:if>
						
						
                    </div>
                </div> --%>
<span class="leftnavOverlay"></span>
<section class="single-product-details">
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <jsp:include page="/pages/shop/templates/prettydeal/sections/breadcrumb.jsp" />
      </div>
      <div class="col-md-12 product-price-details">
        <p><c:out value="${product.description.name}"/></p>
      </div>
      <div class="col-sm-6 single-product-slider">
        <div class="row">
          <div class="col-md-12">
          <c:if test="${product.images!=null && fn:length(product.images)>1}">
            <div id="single-product-gallery" class="owl-carousel" >
	            <c:forEach items="${product.images}" var="thumbnail">
	            	<c:if test="${thumbnail.imageType != 'MENU'}">
	            		<div class="item">
			             	<img id="im-<c:out value="${thumbnail.id}"/>" src='<sm:shopProductImage imageName="${thumbnail.imageName}" sku="${product.sku}" size="LARGE"/>' alt="<c:url value="${thumbnail.imageName}"/>" />
			            </div>
	            	</c:if>
	            </c:forEach>
            </div>
           </c:if>
          </div>
          <div class="col-xs-10 col-xs-offset-1">
          <c:if test="${product.images!=null && fn:length(product.images)>1}">
	            <div id="single-product-gallery-thumbs" class="owl-carousel">
			            <c:forEach items="${product.images}" var="thumbnail">
			            	<c:if test="${thumbnail.imageType != 'MENU'}">
				              	<div class="item">
				             		 <img id="img-<c:out value="${thumbnail.id}"/>" src='<sm:shopProductImage imageName="${thumbnail.imageName}" sku="${product.sku}" size="SMALL"/>' alt="<c:url value="${thumbnail.imageName}"/>" />
				              	</div>
			              	</c:if>
		            	</c:forEach>
	            </div>
           </c:if>
          </div>
        </div>
      </div>
      <div class="col-sm-6 single-product-details">
        <h2><c:out value="${product.manufacturer.description.name}" />

        </h2>
        <div id="share"></div>
        <c:if test="${product.manufacturer.description.address != ''}">
        	<div class="location"><i class="fa fa-map-marker" aria-hidden="true"></i>
        		<c:if test="${product.manufacturer.latitude != '' && product.manufacturer.longitude != ''}">
        			<a id="mapLink" href="#">MAP</a>
        		</c:if>
        	<c:out value="${product.manufacturer.description.address }" escapeXml="false"/></div>
        </c:if>
        
        	<c:forEach items="${product.categories}" var="cat" varStatus="c">
        		<a class="category-name" href="<c:url value="/shop/category/${cat.description.friendlyUrl}.html"/><sm:breadcrumbParam categoryId="${cat.id}"/>"><c:out value="${cat.description.name}"/></a>
        		<c:if test="${c.index < product.categories.size()-1}"><c:out value=","/></c:if>
        	</c:forEach>
       
        <p class="item-id"><s:message code="label.product.code" text="Product code"/>: <span itemprop="identifier" content="mpn:${product.sku}"><c:out value="${product.sku}" /></span></p>
        <jsp:include
						page="/pages/shop/templates/prettydeal/components/reviews/rating.jsp" />
        <div class="quantity"><span>Quantity: </span>
        	<select>
            <option selected="">1</option>
            <option>2</option>
            <option>3</option>
            <option>4</option>
            <option>5</option>
          </select>
        </div>
        <div class="price-panel">
          <div class="item-price">
            <h1><i class="fa fa-inr"></i> <c:out value="${product.price}"/></h1>
          </div>
          <div class="price-discount col-md-12">
          <c:if test="${product.originalPrice eq null && product.finalPriceObj.savings eq null}">
          	<div class="discount-offer text-center">
          		<p><c:out value="${product.description.productPriceHighlight}"/></p>
          	</div>
          </c:if>
          <c:if test="${not (product.originalPrice eq null && product.finalPriceObj.savings eq null)}">
          	<div class="actual-price" >
	            <div class="col-xs-6 text-right">
	              <div class="row">Actual Price:</div>
	            </div>
            	<div class="col-xs-6 text-left"><i class="fa fa-inr"></i> ${product.originalPrice}</div>
            </div>
            <div class="you-save"> 
            	<div class="col-xs-6 text-right">
              		<div class="row">You Save:</div>
            	</div>
           		<div class="col-xs-6 text-left"><i class="fa fa-inr"></i> <c:out value="${product.finalPriceObj.savings}"/></div>
            </div>
          </c:if>
          </div>
        </div>
        <button class="btn btn-block addToCart addToCartButton" productid="${product.id}">GRAB NOW</button>
        <div class="tags">
        <c:set var="tokens" value="${fn:split(product.description.keyWords, ',')}" scope="request"/>
          <c:if test="${fn:length(tokens) gt 1}">
	          <h3>Tags</h3>
	          <ul class="list-inline">
	          	<c:forEach items="${tokens}" var="tag">
	          		<li> <a href="#">#<c:out value="${tag}"/> </a> </li>
	          	</c:forEach>
	          </ul>
          </c:if>
        </div>
      </div>
    </div>
  </div>
</section>


<section class="single-product-tabs">
  <div class="container">
    <div class="row">
      <div class="col-md-8"> 
        
        <!-- Nav tabs -->
        <ul class="nav nav-tabs responsive-tabs" id="resTabs" role="tablist">
          <li role="presentation" class="active"><a href="#offer" aria-controls="offer" role="tab" data-toggle="tab">Offer Details</a></li>
          
          <c:if test="${product.menuImages.size() > 0}">
          	<li role="presentation"><a href="#menu" aria-controls="Menu" role="tab" data-toggle="tab">Menu</a></li>
          </c:if>
          <li role="presentation" id="review-tab"><a href="#Customer-Reviews" aria-controls="Customer-Reviews" role="tab" data-toggle="tab">Customer Reviews</a></li>
        </ul>
        
        <!-- Tab panes -->
        <div class="tab-content">
          <div role="tabpanel" class="tab-pane active" id="offer">
            <div class="row">
              <div class="col-sm-12">
                <c:out value="${product.description.description}" escapeXml="false"/>
              </div>
            </div>
          </div>
          <c:if test="${product.menuImages.size() > 0}">
	          <div role="tabpanel" class="tab-pane" id="menu">
					<div class="row">
						<div class='list-group gallery'>
							
								<c:forEach items="${product.menuImages}" var="img">
									<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
						                <a class="thumbnail fancybox" rel="ligthbox" href="${img.imageUrl}">
							              	<img class="img-responsive" alt="" src="<c:out value="${img.imageUrl}"/>" />
							                <div class='text-right'>
							                  	<small class='text-muted'><c:out value="${img.imageName}"/></small>
							               	</div>
						                </a>
					            	</div>
								</c:forEach>
				            
						</div>
					</div>
	          </div>
          </c:if>
          <div role="tabpanel" class="tab-pane" id="Customer-Reviews">
				<jsp:include
						page="/pages/shop/templates/prettydeal/components/reviews/reviews.jsp" />
          </div>
        </div>
      </div>
      <sm:shopProductGroup groupName="MORE_FROM_MANUFACTURER" productId="${product.id}" split="true" splitLength="2"/>
      <c:if test="${requestScope.MORE_FROM_MANUFACTURER ne null}">
      <div class="col-md-4 more-deals-sidebar">
        <h3><c:out value="More Deals from ${product.manufacturer.description.name}"/></h3>
        <div class="col-md-10 col-md-offset-1">
          <div class="row">
            <div id="More-Deals" class="owl-carousel" >
            	<c:set var="ITEMS" value="${requestScope.MORE_FROM_MANUFACTURER_SPLITTED[0]}"
						scope="request" />
					<c:set var="FEATURED" value="true" scope="request" />
					<jsp:include
						page="/pages/shop/templates/prettydeal/sections/productBox.jsp" />
            </div>
            <div id="More-Deals-two" class="owl-carousel">
              <c:set var="ITEMS" value="${requestScope.MORE_FROM_MANUFACTURER_SPLITTED[1]}"
						scope="request" />
					<c:set var="FEATURED" value="true" scope="request" />
					<jsp:include
						page="/pages/shop/templates/prettydeal/sections/productBox.jsp" />
            </div>
          </div>
        </div>
      </div>
      </c:if>
    </div>
  </div>
</section>
<c:if test="${product.manufacturer.latitude != '' && product.manufacturer.longitude != ''}">
<section class="section map wow fadeInUp p-t-50">
	<div class="container">
		<div class="row">
			<div id="map" style="width:100%; height:450px;"/>
<script>
jQuery(function($) {
    // Asynchronously Load the map API 
    var script = document.createElement('script');
    script.src = "//maps.googleapis.com/maps/api/js?callback=initialize&key=AIzaSyDVxV3ARNoD_FrC-15WIrW4UPsy2BZ6C5s";
    document.body.appendChild(script);
});
var latitude = [];
var longitude = [];
if('${product.manufacturer.latitude}'.indexOf(",")){
	latitude = '${product.manufacturer.latitude}'.split(",");
}else{
	latitude[0] = '${product.manufacturer.latitude}';
}

if('${product.manufacturer.longitude}'.indexOf(",")){
	longitude = '${product.manufacturer.longitude}'.split(",");
}else{
	longitude[0] = '${product.manufacturer.longitude}';
}
var markers = []
for(var v in latitude){
	var m = [];
	m.push("${product.manufacturer.description.name}");
	m.push(latitude[v]);
	m.push(longitude[v]);
	markers.push(m);
}

function initialize() {
    var map;
    var bounds = new google.maps.LatLngBounds();
    var mapOptions = {
        mapTypeId: 'roadmap',
        zoom:17
    };
                    
    // Display a map on the page
    map = new google.maps.Map(document.getElementById("map"), mapOptions);
    map.setTilt(45);
        
    var infoWindow = new google.maps.InfoWindow(), marker, i;
    
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
		</div>
	</div>
</section>
</c:if>

<sm:shopProductGroup groupName="RELATED_ITEM" productId="${product.id}" />

<c:if test="${requestScope.RELATED_ITEM != null}">
<section class="section Trending-deals wow fadeInUp p-t-50">
  <div class="container">
    <div class="row">
      <h3 class="section-title"><span>Related Deals</span></h3>
      <div class="owl-carousel home-owl-carousel custom-carousel owl-theme outer-top-xs">
      		<c:set var="ITEMS" value="${requestScope.RELATED_ITEM}"
						scope="request" />
					<c:set var="FEATURED" value="true" scope="request" />
					<jsp:include
						page="/pages/shop/templates/prettydeal/sections/productBox.jsp" />
      </div>
    </div>
  </div>
</section>
</c:if>

