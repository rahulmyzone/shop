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

 
 <script>
 
 var START_COUNT_PRODUCTS = 0;
 var MAX_PRODUCTS = 9;
 var filter = null;
 var filterValue = null;
 var CURRPAGE_SIZE=9;
 var TOTAL=0;
 
 
 (function($) {
	  $.fn.serializeFilterForm = function() {
	    // perform a serialize form the non-checkbox fields
	    var values = $(this).find('select')
	                        .add(  $(this).find('input[type!=checkbox]') )
	                        .serialize();
	    // add values for checked and unchecked checkboxes fields
	    $(this).find('input[type=checkbox]').each(function() {
	      var chkVal = $(this).is(':checked') ? $(this).val() : "0";
		  if(chkVal != "0"){
	      values +=$(this).attr('name') + "=" + chkVal;
		  }
	    });
	    return values;
	  }
	})(jQuery);
 $(function(){
	 $('.flOpt').click(function(e) {
		    var name = e.currentTarget;
		    $(".flSlOpt").attr("data-value",name.getAttribute("data-value"));
		    orderProducts(getOrderBy());
	});
	 
	$("#ldMoreBtn").on("click",function(){
		CURRPAGE_SIZE=CURRPAGE_SIZE+1;
		START_COUNT_PRODUCTS=CURRPAGE_SIZE;
		loadCategoryProducts();
	});
	loadCategoryProducts();
	$(".brndChk").on("change",function(){
		filter1();
	});
 });
 $(document).ready(function(){
		$("#ranged-value").freshslider({
	        range: true,
	        step:50,
	        min:0,
	        max:1500,
	        value:[0, 1500],
	        onchange:function(low, high){
	            $("#low").val(low);
	            $("#high").val(high);
	       	}
	    });
	});
 
	<jsp:include page="/pages/shop/templates/prettydeal/sections/shop-listing.jsp" />
	 
		function filter1(){
		 var inps = $("#filters input[class=brndChk]:checked");
			var temp = {};
			var brands = [];
			$("#filters input[class=brndChk]:checked").each(function(i,j){
				brands.push($(j).val());
			});
			temp['BRAND']=brands;
			var prices = [];
			prices.push($("#low").val());
			prices.push($("#high").val());
			temp['PRICE']=prices;
			filterValue = JSON.stringify(temp);
			//if(brands.length == 0){
				//filterValue = null;
			//}
			filterCategory('BRAND',filterValue);
	}
		
	function orderProducts(attribute) {
		
		  if(attribute=='item-order') {
			  return;
		  }
		
		  // get the first collection
		  var $prods = $('#productsContainerDiv');

		  var $data = $prods.clone();
		  
		  var $filteredData = $data.children();
	      var $sortedData = $filteredData.sorted({
		        by: function(v) {
		        	if(attribute=='item-price') {
		        		return parseFloat($(v).attr(attribute));
		        	} else {
		        		return $(v).attr(attribute);
		        	}
		        }
		  });
		  // finally, call quicksand
		  /* $prods.quicksand($sortedData, {
		      duration: 800,
		      easing: 'easeInOutQuad'
		  }); */
		  $prods.html('');
		  $prods.append($sortedData);
	}
 
 	function loadCategoryProducts() {
 		$('#products-qty').hide();
 		$("#end_nav").hide();
 		var url = '<%=request.getContextPath()%>/services/public/products/page/' + START_COUNT_PRODUCTS + '/' + MAX_PRODUCTS + '/<c:out value="${requestScope.MERCHANT_STORE.code}"/>/<c:out value="${requestScope.LANGUAGE.code}"/>/<c:out value="${category.description.friendlyUrl}"/>.html';
	 	
 		if(filter!=null) {
 			url = url + '/filter=' + filterValue +'';
 		}
 		loadProducts(url,'#productsContainerDiv');
 	}
 	
 	
 	function filterCategory(filterType,filterVal) {
	 		//reset product section
	 		$('#productsContainerDiv').html('');
	 		START_COUNT_PRODUCTS = 0;
	 		filter = filterType;
	 		loadCategoryProducts();
 	}
 
	function callBackLoadProducts(productList) {
			totalCount = productList.productCount;
			START_COUNT_PRODUCTS = START_COUNT_PRODUCTS + MAX_PRODUCTS;
			if(START_COUNT_PRODUCTS < totalCount) {
					$("#ldMoreBtn").show();
			} else {
					$("#ldMoreBtn").hide();
					$("#end_nav").show();
			}
			//check option
			var orderBy = getOrderBy();
			$('#products-qty').show();
			var productQty = productList.productCount + ' <s:message code="label.search.items.found" text="item(s) found" />';
			$('#products-qty').html(productQty);

	}
	
	function getOrderBy() {
		var orderBy = $(".flSlOpt").attr("data-value");
		return orderBy;
	}
 
 
 
 
</script>

 
	   <%-- <c:if test="${category.description.description!=null}">
	   		<!-- category description -->
		   	<div class="row-fluid">
		   	<p>
		   		<c:out value="${category.description.description}"/>
		   	</p>
		   	</div>
	   
	   </c:if> --%>

	<!-- <div class="row-fluid">
	
	
	   <div class="span12"> -->
	   

      	
      	<!-- left column -->
        <%-- <div class="span3">
          <div class="sidebar-nav">
          

            <br/>
          
            <ul class="nav nav-list">
              <c:if test="${parent!=null}">
              	<li class="nav-header"><c:out value="${parent.description.name}" /></li>
              </c:if>
              <c:forEach items="${subCategories}" var="subCategory">
              	<li>
              		<a href="<c:url value="/shop/category/${subCategory.description.friendlyUrl}.html"/><sm:breadcrumbParam categoryId="${subCategory.id}"/>"><c:out value="${subCategory.description.name}" />
              			<c:if test="${subCategory.productCount>0}">&nbsp;<span class="countItems">(<c:out value="${subCategory.productCount}" />)</span></c:if></a></li>
              </c:forEach>
            </ul>
          </div>
          
          <c:if test="${fn:length(manufacturers) > 0}">
          <br/>
          <div class="sidebar-nav">
            <ul class="nav nav-list">
              <li class="nav-header"><s:message code="label.manufacturer.brand" text="Brands" /></li>
              <c:forEach items="${manufacturers}" var="manufacturer">
              	<li>
              		<a href="javascript:filterCategory('BRAND','${manufacturer.id}')"><c:out value="${manufacturer.description.name}" /></a></li>
              </c:forEach>
            </ul>
          </div>          
          </c:if>
          
          
        </div> --%><!--/span-->
        
        <!-- right column -->
        <%-- <div class="span9">
        <p class="lead"><c:out value="${category.description.name}" /></p>
        <div class="products-title row-fluid">
    		<div class="span6">
        		<p><div id="products-qty"></div></p>
    		</div>
		    <div class="span6">
		        <div class="pull-right">
		            <p>
		            <ul class="nav nav-list">
	            		<li class="widget-header"><s:message code="label.generic.sortby" text="Sort by" />:
						<select id="filter">
							<option value="item-order"><s:message code="label.generic.default" text="Default" /></option>
							<option value="item-name"><s:message code="label.generic.name" text="Name" /></option>
							<option value="item-price"><s:message code="label.generic.price" text="Price" /></option>
						</select>
						</li>
					</ul>
		            </p>
		        </div>
		    </div>
		 </div>
        
        
			<!-- just copy that block for havimg products displayed -->
          	<!-- products are loaded by ajax -->
        	<ul id="productsContainer" class="thumbnails product-list"></ul>
			
			<nav id="button_nav" style="text-align:center;display:none;">
				<button class="btn btn-large" style="width:400px;" onClick="loadCategoryProducts();"><s:message code="label.product.moreitems" text="Display more items" />...</button>
			</nav>
			<span id="end_nav" style="display:none;"><s:message code="label.product.nomoreitems" text="No more items to be displayed" /></span>
          	<!-- end block -->
          
        </div> --%><!--/span-->
        
        <!-- </div>12
        
      </div> --><!-- row fluid -->
<span class="leftnavOverlay"></span>
<section class="categories">
  <div class="container">
    <div class="row">
      <div class="col-sm-12">
      	<jsp:include page="/pages/shop/templates/bootstrap/sections/breadcrumb.jsp" />
         <div class="row">
           <div class="col-sm-8">
        <h1 class="categories-heading"><c:forEach items="${category.description.name}" var="c">${c}</c:forEach></h1>
        <h5 class="product-qty"><div id="products-qty"></div></h5>
        </div>
          <div class="col-sm-4">
        <div class="sort-fliter">
  		 <span class="sort-label">Sort:</span>
          <dl id="SelectFliter" class="fliterdropdown">
            <dt><a class="flSlOpt" data-value="item-order"><span><s:message code="label.generic.default" text="Default" /></span> <i class="fa fa-angle-down" aria-hidden="true"></i>
			</a></dt>
            <dd>
              <ul id="filter" class="selectDropdown list-unstyled"  style="display:none;">
                <li><a class="flOpt" href="javascript:;" data-value="item-order"><span><s:message code="label.generic.default" text="Default" /></span></a></li>
		    	<li><a class="flOpt" href="javascript:;" data-value="item-name"><span><s:message code="label.generic.name" text="Name" /></span></a></li>
		   	    <li><a class="flOpt" href="javascript:;" data-value="item-price"><span><s:message code="label.generic.price" text="Price" /></span></a></li>
		   	    <li><a class="flOpt" href="javascript:;" data-value="item-discount"><span><s:message code="label.generic.discount" text="Discount" /></span></a></li>
              </ul>
            </dd>
          </dl>
        </div>
        </div>
        </div>
      </div>
      <div class="col-sm-12">
        <div class="nav-side-menu sidebartabs"> 
     
       <div class="toggle-btn" data-toggle="collapse" data-target="#menu-content">
         <img src="<c:url value="/resources/templates/prettydeal/img/filterIcon.png" />" alt=""> <span class="currentFilters"> Apply Filters</span>
       </div>
        <form id="filters" method="post" action="/">
          <div class="menu-list">
            <ul id="menu-content" class="menu-content collapse out">
              <li  data-toggle="collapse" data-target="#categories1" class="active"> <span>Brand </span> <i class="fa fa-minus"></i> </li>
              <ul class="sub-menu collapse in" id="categories1">
	                <c:if test="${fn:length(manufacturers) > 0}">
	                	<c:forEach items="${manufacturers}" var="manufacturer">
		                <li class="active">
		                  <div class="checkbox">
		                    <label>
		                      <input class="brndChk" name="BRAND" type="checkbox" value="<c:out value="${manufacturer.id}"/>">
		                      <span class="cr"><i class="cr-icon glyphicon glyphicon-ok"></i></span> <c:out value="${manufacturer.description.name}"/> </label>
		                  </div>
		                </li>
		                </c:forEach>
	                </c:if>
              </ul>
              <li  data-toggle="collapse" data-target="#categories2" class="collapsed"> <span>Price range </span> <i class="fa fa-minus"></i> </li>
              <ul class="sub-menu collapse in" id="categories2">
               <li class="active">
               		<div class="row">
					    <div class="col-xs-12">
					    	<div id="ranged-value" style="margin: 20px;margin-left: 0px;"0></div>
					    	<input id="low" name="min" type="hidden"/>
               				<input id="high" name="max" type="hidden"/>
					    </div>
					</div>
					<div class="row" style="padding-bottom: 10px;">
						<div class="col-xs-12">
							<div class="text-right">
					            <button type="button" onclick="filter1();" class="btn btn-primary">Update</button>
					        </div>
						</div>
					</div>
                </li>
               </ul>
            </ul>
          </div>
          </form>
        </div>
        <div class="categories-product-right" >
        	<div id="productsContainerDiv">
        	</div>
	        <div class="col-md-12 text-center clearfix">
	        	<button id="ldMoreBtn" class="btn load-more-btn"><s:message code="label.product.moreitems" text="Display more items" />...</button>
	        	<span id="end_nav" style="display:none;"><h4><s:message code="label.product.nomoreitems" text="No more items to be displayed" /></h4></span>
	        </div>
        
         </div>
      </div>
    </div>
  </div>
</section>
<script type="text/html" id="productBox">
	<div class="col-sm-6 col-md-4 itemBox" item-name="{{description.name}}" item-price="{{price}}" item-order="{{sortOrder}}" item-discount="{{finalPriceObj.discountPercent}}">
		<div class="products">
		  <div class="product-image">
		    <div class="image"> 
		    <a href="<c:url value="/shop/product/" />{{description.friendlyUrl}}.html<sm:breadcrumbParam/>#">
		    <img src="http://${MERCHANT_STORE.domainName}{{image.imageUrl}}" alt="" class="img-responsive">
				{{#description.highlights}}
					<div class="tag"><span>
						{{description.highlights}}
					</span></div>
				{{/description.highlights}}
		     </a> 
		    </div>
		   </div>
		  <div class="product-info text-left">
		    {{#categories}}
			<a href="/shop/category/{{description.friendlyUrl}}.html<sm:breadcrumbParam/>#"><h5>{{description.name}}</h5></a>
			{{/categories}}
		    <h3 class="name"><a href="<c:url value="/shop/product/" />{{description.friendlyUrl}}.html">{{manufacturer.description.name}}</a></h3>
		    <h4>{{finalPrice}}</h4>
		    <div class="description">{{description.name}}</div>
		     <a href="#" productId="{{id}}" class="addToCart product-btn hvr-sweep-to-right">Grab Now</a>
		  </div>
		</div>
	</div>
</script>