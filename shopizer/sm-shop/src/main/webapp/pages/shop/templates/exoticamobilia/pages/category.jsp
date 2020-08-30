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
 
 <script src="<c:url value="/resources/js/jquery.easing.1.3.js" />"></script>
 <script src="<c:url value="/resources/js/jquery.quicksand.js" />"></script>
 <script src="<c:url value="/resources/js/jquery-sort-filter-plugin.js" />"></script>
 <script src="<c:url value="/resources/js/jquery.alphanumeric.pack.js" />"></script>
 
 
 <script type="text/html" id="productBoxTemplate">
{{#products}}
<div class="col-sm-4" data-id="{{id}}" item-price="{{price}}" item-name="{{description.name}}" item-order="{{sortOrder}}">
		<div class="product-image-wrapper">
			<div class="single-products">
				<div class="productinfo text-center">
					{{#description.highlights}}  
						<div class="ribbon-wrapper-green">
							<div class="ribbon-green">
								<c:out value="{{description.highlights}}" />
							</div>
						</div>
					{{/description.highlights}}
					{{#image}} 
						<a href="/shop/product/{{description.friendlyUrl}}.html"><img src="{{image.imageUrl}}"  sku="{{product.sku}}" class="product-img"/>
					{{/image}}
						<h2>
							<c:out value="{{finalPrice}}"/>
						</h2>
					<p><a href="/shop/product/{{description.friendlyUrl}}.html">{{description.name}}</a></p>
				</div>
				<div class="product-overlay">
					<div class="overlay-content" >
							{{#discounted}}
								<del class="specialPrice" >{{originalPrice}}</del>
								&nbsp;
							{{/discounted}}
							<h2>{{product}}</h2>
							
						
						<p>{{description.name}}</p>
						<a class="btn btn-default add-to-cart product-dtl-btn addToCart" href="javascript:void(0);" productId="{{id}}">
							<i class="fa fa-shopping-cart"></i>Get this deal
						</a>
						<a href='/shop/product/{{description.friendlyUrl}}.html' class="btn btn-default add-to-cart product-dtl-btn">
							<i class="fa fa-shopping-cart"></i>Details
						</a>
					</div>
				</div>
			</div>
			
			<div class="choose">
				<ul class="nav nav-pills nav-justified">
					<li><a href="#"><i class="fa fa-plus-square"></i>Add to
							wishlist</a></li>
					<li><a href="#"></i>Add to
							compare</a></li>
				</ul>
			</div>
		</div>
	</div>
{{/products}}
</script>


 <!-- don't change that script except max_oroducts -->
 <script>
 
 var START_COUNT_PRODUCTS = 0;
 var MAX_PRODUCTS = 12;
 var filter = null;
 var filterValue = null;

 $(function(){
	 
    //price minimum/maximum
	$('.numeric').numeric();
    
    
	$('#filter').on('change', function() {
		visualize();
	});
	
	$('#priceFilterMinimum').on('blur', function() {
		visualize();
	});
	
	$('#priceFilterMaximum').on('blur', function() {
		visualize()	
	});
	
	 
	loadCategoryProducts();

 });
 
 
 	function visualize() {
 		var orderBy = $("#filter").val();
		var minimumPrice = $('#priceFilterMinimum').val();
		var maximumPrice = $('#priceFilterMaximum').val();
		
		//orderProducts(orderBy);
		orderProducts(orderBy, minimumPrice, maximumPrice);
 	}
 
	/** used for ordering and filtering **/
	//function orderProducts(attribute, minimum, maximum) {
	function orderProducts(attribute, minimumPrice, maximumPrice) {
		
		  if(minimumPrice==undefined) {
			  minimumPrice = '';
		  }
		  
		  if(maximumPrice==undefined) {
			  maximumPrice = ''; 
		  }
		
		  //log('Attribute ' + attribute + ' Minimum price ' + minimumPrice + ' Maximum price ' + maximumPrice);
		
		  if(minimumPrice == '' && maximumPrice == '') {
		  
			  if(attribute=='item-order') {	  
				  return;
			  }
		  }
		
		  // get the first collection
		  var $prods = $('#productsContainer');
		  

		  // clone applications to get a second collection
		  data = $('#hiddenProductsContainer').clone();
		  
		  //console.log('Data');
		  //console.log(data);
		  
		  
		  listedData = data.find('.productItem');
		  
		  //console.log('Listed Data');
		  //console.log(listedData);

		  filteredData = listedData;
		  var $sortedData = null;
	      
		  if(minimumPrice != '' || maximumPrice != '') {
			  //filter filteredData
			  if(minimumPrice == '') {
				  minimumPrice = '0';
			  }
			  filteredData = listedData.filter(function() {
				 
				   //log('Item price ' + $(this).attr('item-price'));
			  
				   var price = parseFloat($(this).attr('item-price'));
				   if(maximumPrice != '') {
					   return price >= parseFloat(minimumPrice) && price <= parseFloat(maximumPrice); 
				   } else {
					   return price >= parseFloat(minimumPrice);
				   }
				   
			  }); 
		  } 
		  
		  //console.log('After filtered Data');
		  //console.log(filteredData);

		  
		  if(attribute!='item-order') {	
		  
		  	$sortedData = filteredData.sorted({
		        by: function(v) {
		        	if(attribute=='item-price') {
		        		return parseFloat($(v).attr(attribute));
		        	} else {
		        		return $(v).attr(attribute);
		        	}
		        }
		 	 });
		  
		  } else {
			  $sortedData =  filteredData; 
		  }

		  // finally, call quicksand
		  $prods.quicksand($sortedData, {
		      duration: 800,
		      easing: 'easeInOutQuad'
		  });
		
		
	}
 
 	function loadCategoryProducts() {
 		var url = '<%=request.getContextPath()%>/services/public/products/page/' + START_COUNT_PRODUCTS + '/' + MAX_PRODUCTS + '/<c:out value="${requestScope.MERCHANT_STORE.code}"/>/<c:out value="${requestScope.LANGUAGE.code}"/>/<c:out value="${category.description.friendlyUrl}"/>.html';
	 	
 		if(filter!=null) {
 			url = url + '/filter=' + filter + '/filter-value=' + filterValue +'';
 		}
 		loadProducts(url,'#productsContainer');

 	}
 	
 	
 	function filterCategory(filterType,filterVal) {
	 		//reset product section
	 		$('#productsContainer').html('');
	 		$('#hiddenProductsContainer').html('');
	 		START_COUNT_PRODUCTS = 0;
	 		filter = filterType;
	 		filterValue = filterVal;
	 		loadCategoryProducts();
 	}
 	
 	function buildProductsList(productList, divProductsContainer) {
 		log('Products-> ' + productList.products.length);
		var productsTemplate = Hogan.compile(document.getElementById("productBoxTemplate").innerHTML);
		var productsRendred = productsTemplate.render(productList);
		$('#productsContainer').append(productsRendred);
		$('#hiddenProductsContainer').append(productsRendred);
		initBindings();
 	}
 
	function callBackLoadProducts(productList) {
			totalCount = productList.productCount;
			START_COUNT_PRODUCTS = START_COUNT_PRODUCTS + MAX_PRODUCTS;
			if(START_COUNT_PRODUCTS < totalCount && START_COUNT_PRODUCTS <= productList.productCount) {
					$("#button_nav").show();
			} else {
					$("#button_nav").hide();
			}
			$('#productsContainer').hideLoading();

			//visualize();
			
			var productQty = productList.productCount + ' <s:message code="label.search.items.found" text="item(s) found" />';
			$('#products-qty').html(productQty);


	}
	
 
 

</script>
	

<section>
		<div class="container">
			<jsp:include page="/pages/shop/templates/exoticamobilia/sections/breadcrumb.jsp" />
			<div class="row">
					
					<div class="col-sm-9 padding-right">
						<div id="productsContainer" class="features_items">
							
						</div>
						<!-- hidden -->
							<div id="hiddenProductsContainer" style="display:none;"></div>
					</div>
					<div class="col-sm-3">
						<div class="brands_products"><!--brands_products-->
							<h2>Brands</h2>
							<div class="brands-name">
								<ul class="nav nav-pills nav-stacked">
									<c:forEach items="${manufacturers}" var="manufacturer">
										<li><a href="javascript:filterCategory('BRAND','${manufacturer.id}')"> <span class="pull-right">(50)</span><c:out value="${manufacturer.description.name}" /></a></li>
									</c:forEach>
								</ul>
							</div>
						</div><!--/brands_products-->
						<div class="price-range"><!--price-range-->
							<h2>Price Range</h2>
							<div class="well text-center">
								 <input type="text" class="span2" value="" data-slider-min="0" data-slider-max="600" data-slider-step="5" data-slider-value="[250,450]" id="sl2" ><br />
								 <b class="pull-left">$ 0</b> <b class="pull-right">$ 600</b>
							</div>
						</div><!--/price-range-->
						<div class="shipping text-center"><!--shipping-->
							<img src="images/home/shipping.jpg" alt="" />
						</div><!--/shipping-->
					
					</div>
					
					
				</div>
				
	</div>
</section>