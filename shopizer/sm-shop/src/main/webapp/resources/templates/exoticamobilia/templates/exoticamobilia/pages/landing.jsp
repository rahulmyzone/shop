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



<section id="slider"><!--slider-->
		<div class="container">
			<div class="row">
				<div class="col-sm-12">
					<div id="slider-carousel" class="carousel slide" data-ride="carousel">
						<ol class="carousel-indicators">
							<li data-target="#slider-carousel" data-slide-to="0" class="active"></li>
							<li data-target="#slider-carousel" data-slide-to="1"></li>
							<li data-target="#slider-carousel" data-slide-to="2"></li>
						</ol>
						
						<div class="carousel-inner">
							<div class="item active">
								<div class="col-sm-6">
									<h1><span>E</span>-SHOPPER</h1>
									<h2>Free E-Commerce Template</h2>
									<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. </p>
									<button type="button" class="btn btn-default get">Get it now</button>
								</div>
								<div class="col-sm-6">
									<img src="<c:url value="/resources/templates/exoticamobilia/img/home/girl1.jpg" />" class="girl img-responsive" alt="" />
									<img src="<c:url value="/resources/templates/exoticamobilia/img/home/pricing.png" />"  class="pricing" alt="" />
								</div>
							</div>
							<div class="item">
								<div class="col-sm-6">
									<h1><span>E</span>-SHOPPER</h1>
									<h2>100% Responsive Design</h2>
									<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. </p>
									<button type="button" class="btn btn-default get">Get it now</button>
								</div>
								<div class="col-sm-6">
									<img src="<c:url value="/resources/templates/exoticamobilia/img/home/girl2.jpg" />" class="girl img-responsive" alt="" />
									<img src="<c:url value="/resources/templates/exoticamobilia/img/home/pricing.png" />"  class="pricing" alt="" />
								</div>
							</div>
							
							<div class="item">
								<div class="col-sm-6">
									<h1><span>E</span>-SHOPPER</h1>
									<h2>Free Ecommerce Template</h2>
									<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. </p>
									<button type="button" class="btn btn-default get">Get it now</button>
								</div>
								<div class="col-sm-6">
									<img src="<c:url value="/resources/templates/exoticamobilia/img/home/girl3.jpg" />" class="girl img-responsive" alt="" />
									<img src="<c:url value="/resources/templates/exoticamobilia/img/home/pricing.png" />" class="pricing" alt="" />
								</div>
							</div>
							
						</div>
						
						<a href="#slider-carousel" class="left control-carousel hidden-xs" data-slide="prev">
							<i class="fa fa-angle-left"></i>
						</a>
						<a href="#slider-carousel" class="right control-carousel hidden-xs" data-slide="next">
							<i class="fa fa-angle-right"></i>
						</a>
					</div>
					
				</div>
			</div>
		</div>
	</section><!--/slider-->
	
 <!-- <div id="shop" class="">
 
       <div style="margin-top: 0px;" class="banner center-block"> -->

      <!-- Responsive slider - START -->
    	<%-- <div class="responsive-slider" data-spy="responsive-slider" data-autoplay="false">
        <div class="slides" data-group="slides">
      		<ul>
  	    	<li>
              <div class="slide-body" data-group="slide">
	                <img src="" id="slide1">

			                	<div class="bannerTextTitle bannerTextColor" style="width:500px; top:30px; left:20px;float:left;">
			                        <h2 class="bannerTextStyle helvetica-light bannerMarginBottom">
			                        	Furniture warehouse
			                        </h2>
			                        <p class="bannerTextParagraphStyle helvetica-light">Antic and exotic furnitures</p>
			                        <a class="white bannerRedBtn helvetica-light" href="/living-room-collections/asana-collection/" title="Shop the Suar Collection">Shop the Suar Collection <i class="fa fa-play"></i></a>
			                	</div>


					</div>
					
	                <!--<div class="caption header center" style="width:100% !important;">-->
	                <!--<div class="caption header" style="width:100% !important;height:60% !important;text-align: center; !important;">-->
	                  <!--<div class="header-white header-caption" style="padding: 30px 0 !important; font-size: 50px;">Mega centre de liquidation</div>-->
	                  <!--
	                  <div class="header-white header-caption" style="text-align: center;">Entrepot de meubles exotiques</div>
	                  <div class="sub-header sub-header-white header-caption" style="text-align: center;">
	                  		
	                  		<div style="width:100%;">
	                  			
	                  			Bois de rose - Acacia
	                  			<br>
	                  			Suar - Racine de teck - Mango
	                  			</br>
	                  			Recycles - Metal - et bien plus...</br>
	                  			
	                  		</div>

	                  </div>
	                  <div class="sub-sub-header sub-header-white header-caption" style="text-align: center;">
	                  <span style="background-color: #FFFF00;color:#000000">30% a 50%</span> de rabais sur tous les articles a prix regulier<br/>
	                  <span style="background-color: #FFFF00;color:#000000">Jusqu'a 70%</span> de rabais sur les articles de fin de ligne
	                  </div>
	                </div>
	                -->
                
	      		</div>
  	        </li>
  	    	<li>
              <div class="slide-body" data-group="slide">
                <img src="images/table-brune1.jpg">
              </div>
  	        </li>
  	    	<li>
              <div class="slide-body" data-group="slide">
                <img src="images/table-brune1.jpg">
              </div>
  	        </li>
  	       

  	    	</ul>
        </div> --%>

    	<!-- </div>

      Responsive slider - END
     </div>
			
	banner end
</div> -->



<section>
		<div class="container">
			<div class="row">
				<div class="col-sm-3">
					<div class="left-sidebar">
						<h2>Category</h2>
						<div class="panel-group category-products" id="accordian"><!--category-productsr-->
							<c:forEach items="${requestScope.TOP_CATEGORIES}" var="category">
										<c:choose>
											<c:when test="${fn:length(category.children)>0}">
												<div class="panel panel-default">
													<div class="panel-heading">
														<h4 class="panel-title">
															<a data-toggle="collapse" data-parent="#accordian" href='#cat_<c:out value="${category.id}"/>'>
																<span class="badge pull-right"><i class="fa fa-plus"></i></span>
																<c:out value="${category.description.name}"/>
															</a>
														</h4>
														<div id="cat_<c:out value="${category.id}"/>" class="panel-collapse collapse">
															<div class="panel-body">
																<ul>
																	<c:forEach items="${category.children}" var="childCategory">
																		<li><a href='<c:url value="/shop/category/${childCategory.description.friendlyUrl}.html"/><sm:breadcrumbParam categoryId="${childCategory.id}"/>'><c:out value="${childCategory.description.name}"/></a></li>
																	</c:forEach>
																</ul>
															</div>
														</div>
													</div>
												</div>
											</c:when>
											<c:otherwise>
												<div class="panel panel-default">
													<div class="panel-heading">
														<h4 class="panel-title"><a href='<c:url value="/shop/category/${category.description.friendlyUrl}.html"/><sm:breadcrumbParam categoryId="${category.id}"/>'><c:out value="${category.description.name}"/></a></h4>
													</div>
												</div>	
											</c:otherwise>
										</c:choose>
									</c:forEach>	
								</div>
						</div>
					
						<div class="brands_products"><!--brands_products-->
							<h2>Brands</h2>
							<div class="brands-name">
								<ul class="nav nav-pills nav-stacked">
									<li><a href="#"> <span class="pull-right">(50)</span>Acne</a></li>
									<li><a href="#"> <span class="pull-right">(56)</span>Grüne Erde</a></li>
									<li><a href="#"> <span class="pull-right">(27)</span>Albiro</a></li>
									<li><a href="#"> <span class="pull-right">(32)</span>Ronhill</a></li>
									<li><a href="#"> <span class="pull-right">(5)</span>Oddmolly</a></li>
									<li><a href="#"> <span class="pull-right">(9)</span>Boudestijn</a></li>
									<li><a href="#"> <span class="pull-right">(4)</span>Rösch creative culture</a></li>
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
					<sm:shopProductGroup groupName="FEATURED_ITEM"/>
					<sm:shopProductGroup groupName="SPECIALS"/>
					<div class="col-sm-9 padding-right">
						<div class="features_items">
							<h2 class="title text-center">Featured Deals</h2>
							<c:if test="${requestScope.FEATURED_ITEM != null}">
								<c:set var="ITEMS" value="${requestScope.FEATURED_ITEM}" scope="request" />
								<c:set var="FEATURED" value="true" scope="request" />
				                <jsp:include page="/pages/shop/templates/exoticamobilia/sections/productBox.jsp" />
							</c:if>
							
						</div>
						<div class="category-tab"><!--category-tab-->
							<div class="col-sm-12">
								<div class="recommended_items"><!--recommended_items-->
								<h2 class="title text-center">recommended deals</h2>
						
								<div id="recommended-item-carousel" class="carousel slide" data-ride="carousel">
									<div class="carousel-inner">
										<div class="item active">	
											<div class="col-sm-4">
												<div class="product-image-wrapper">
													<div class="single-products">
														<div class="productinfo text-center">
															<img src="images/home/recommend1.jpg" alt="" />
															<h2>$56</h2>
															<p>Easy Polo Black Edition</p>
															<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
														</div>
														
													</div>
												</div>
											</div>
											<div class="col-sm-4">
												<div class="product-image-wrapper">
													<div class="single-products">
														<div class="productinfo text-center">
															<img src="images/home/recommend2.jpg" alt="" />
															<h2>$56</h2>
															<p>Easy Polo Black Edition</p>
															<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
														</div>
														
													</div>
												</div>
											</div>
											<div class="col-sm-4">
												<div class="product-image-wrapper">
													<div class="single-products">
														<div class="productinfo text-center">
															<img src="images/home/recommend3.jpg" alt="" />
															<h2>$56</h2>
															<p>Easy Polo Black Edition</p>
															<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
														</div>
														
													</div>
												</div>
											</div>
										</div>
										<div class="item">	
											<div class="col-sm-4">
												<div class="product-image-wrapper">
													<div class="single-products">
														<div class="productinfo text-center">
															<img src="images/home/recommend1.jpg" alt="" />
															<h2>$56</h2>
															<p>Easy Polo Black Edition</p>
															<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
														</div>
														
													</div>
												</div>
											</div>
											<div class="col-sm-4">
												<div class="product-image-wrapper">
													<div class="single-products">
														<div class="productinfo text-center">
															<img src="images/home/recommend2.jpg" alt="" />
															<h2>$56</h2>
															<p>Easy Polo Black Edition</p>
															<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
														</div>
														
													</div>
												</div>
											</div>
											<div class="col-sm-4">
												<div class="product-image-wrapper">
													<div class="single-products">
														<div class="productinfo text-center">
															<img src="images/home/recommend3.jpg" alt="" />
															<h2>$56</h2>
															<p>Easy Polo Black Edition</p>
															<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
														</div>
														
													</div>
												</div>
											</div>
										</div>
									</div>
									 <a class="left recommended-item-control" href="#recommended-item-carousel" data-slide="prev">
										<i class="fa fa-angle-left"></i>
									  </a>
									  <a class="right recommended-item-control" href="#recommended-item-carousel" data-slide="next">
										<i class="fa fa-angle-right"></i>
									  </a>			
								</div>
							</div>
							</div>
						</div>
					</div>
					
				</div>
				
	</div>
</section>

<%-- <div class="main">
			<c:if test="${page!=null}">
			<div class="row">
				<div id="shop" class="col-md-12">
	          			    <h1 class="text-center title" id="homeText"><c:out value="${page.description}" escapeXml="false"/></h1>
	          			    <div class="separator"></div>
				</div>
				</div>
			</c:if>

			
			<br/>
			<sm:shopProductGroup groupName="FEATURED_ITEM"/>
			<sm:shopProductGroup groupName="SPECIALS"/>
			
			<div id="" class="container">
			<c:if test="${requestScope.FEATURED_ITEM!=null || requestScope.SPECIALS!=null}" >
			<div class="row-exoticamobilia row">
			     <div class="productItem tabs-style-2">
					<ul class="nav nav-tabs" id="product-tab">
						<c:if test="${requestScope.FEATURED_ITEM!=null}" ><li class="active "><a data-toggle="tab" href="#tab1"><s:message code="menu.catalogue-featured" text="Featured items" /></a></li></c:if>
						<c:if test="${requestScope.SPECIALS!=null}" ><li<c:if test="${requestScope.FEATURED_ITEM==null}"> class="active"</c:if>><a data-toggle="tab" href="#tab2"><s:message code="label.product.specials" text="Specials" /></a></li></c:if>
					</ul>
					</div>							
				<div class="tab-content padding-top-clear padding-bottom-clear">	 
						<!-- one div by section -->
						<c:if test="${requestScope.FEATURED_ITEM!=null}" >
							<div class="tab-pane fade <c:if test="${requestScope.FEATURED_ITEM!=null}" >active</c:if> in" id="tab1">
										    <!-- Iterate over featuredItems -->
											<c:set var="ITEMS" value="${requestScope.FEATURED_ITEM}" scope="request" />
											<c:set var="FEATURED" value="true" scope="request" />
		                         			<jsp:include page="/pages/shop/templates/exoticamobilia/sections/productBox.jsp" />
							</div>
						</c:if>
						<c:if test="${requestScope.SPECIALS!=null}" >
							<div class="tab-pane fade <c:if test="${requestScope.FEATURED_ITEM==null}" >active</c:if> in" id="tab2">
											<!-- Iterate over featuredItems -->
	                         				<c:set var="ITEMS" value="${requestScope.SPECIALS}" scope="request" />
		                         			<jsp:include page="/pages/shop/templates/exoticamobilia/sections/productBox.jsp" />
							</div>
						</c:if>	
				</div>					
			</div>
			</c:if>
			</div>
		
		
</div> --%>
<!-- </div> -->

				<!-- <div class="col-sm-9 padding-right">
					<div class="features_items">features_items
						<h2 class="title text-center">Features Items</h2>
					
					<div class="category-tab">category-tab
						<div class="col-sm-12">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#tshirt" data-toggle="tab">T-Shirt</a></li>
								<li><a href="#blazers" data-toggle="tab">Blazers</a></li>
								<li><a href="#sunglass" data-toggle="tab">Sunglass</a></li>
								<li><a href="#kids" data-toggle="tab">Kids</a></li>
								<li><a href="#poloshirt" data-toggle="tab">Polo shirt</a></li>
							</ul>
						</div>
						<div class="tab-content">
							<div class="tab-pane fade active in" id="tshirt" >
								<div class="col-sm-3">
									<div class="product-image-wrapper">
										<div class="single-products">
											<div class="productinfo text-center">
												<img src="images/home/gallery1.jpg" alt="" />
												<h2>$56</h2>
												<p>Easy Polo Black Edition</p>
												<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
											</div>
											
										</div>
									</div>
								</div>
								<div class="col-sm-3">
									<div class="product-image-wrapper">
										<div class="single-products">
											<div class="productinfo text-center">
												<img src="images/home/gallery2.jpg" alt="" />
												<h2>$56</h2>
												<p>Easy Polo Black Edition</p>
												<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
											</div>
											
										</div>
									</div>
								</div>
								<div class="col-sm-3">
									<div class="product-image-wrapper">
										<div class="single-products">
											<div class="productinfo text-center">
												<img src="images/home/gallery3.jpg" alt="" />
												<h2>$56</h2>
												<p>Easy Polo Black Edition</p>
												<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
											</div>
											
										</div>
									</div>
								</div>
								<div class="col-sm-3">
									<div class="product-image-wrapper">
										<div class="single-products">
											<div class="productinfo text-center">
												<img src="images/home/gallery4.jpg" alt="" />
												<h2>$56</h2>
												<p>Easy Polo Black Edition</p>
												<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
											</div>
											
										</div>
									</div>
								</div>
							</div>
							
							<div class="tab-pane fade" id="blazers" >
								<div class="col-sm-3">
									<div class="product-image-wrapper">
										<div class="single-products">
											<div class="productinfo text-center">
												<img src="images/home/gallery4.jpg" alt="" />
												<h2>$56</h2>
												<p>Easy Polo Black Edition</p>
												<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
											</div>
											
										</div>
									</div>
								</div>
								<div class="col-sm-3">
									<div class="product-image-wrapper">
										<div class="single-products">
											<div class="productinfo text-center">
												<img src="images/home/gallery3.jpg" alt="" />
												<h2>$56</h2>
												<p>Easy Polo Black Edition</p>
												<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
											</div>
											
										</div>
									</div>
								</div>
								<div class="col-sm-3">
									<div class="product-image-wrapper">
										<div class="single-products">
											<div class="productinfo text-center">
												<img src="images/home/gallery2.jpg" alt="" />
												<h2>$56</h2>
												<p>Easy Polo Black Edition</p>
												<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
											</div>
											
										</div>
									</div>
								</div>
								<div class="col-sm-3">
									<div class="product-image-wrapper">
										<div class="single-products">
											<div class="productinfo text-center">
												<img src="images/home/gallery1.jpg" alt="" />
												<h2>$56</h2>
												<p>Easy Polo Black Edition</p>
												<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
											</div>
											
										</div>
									</div>
								</div>
							</div>
							
							<div class="tab-pane fade" id="sunglass" >
								<div class="col-sm-3">
									<div class="product-image-wrapper">
										<div class="single-products">
											<div class="productinfo text-center">
												<img src="images/home/gallery3.jpg" alt="" />
												<h2>$56</h2>
												<p>Easy Polo Black Edition</p>
												<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
											</div>
											
										</div>
									</div>
								</div>
								<div class="col-sm-3">
									<div class="product-image-wrapper">
										<div class="single-products">
											<div class="productinfo text-center">
												<img src="images/home/gallery4.jpg" alt="" />
												<h2>$56</h2>
												<p>Easy Polo Black Edition</p>
												<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
											</div>
											
										</div>
									</div>
								</div>
								<div class="col-sm-3">
									<div class="product-image-wrapper">
										<div class="single-products">
											<div class="productinfo text-center">
												<img src="images/home/gallery1.jpg" alt="" />
												<h2>$56</h2>
												<p>Easy Polo Black Edition</p>
												<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
											</div>
											
										</div>
									</div>
								</div>
								<div class="col-sm-3">
									<div class="product-image-wrapper">
										<div class="single-products">
											<div class="productinfo text-center">
												<img src="images/home/gallery2.jpg" alt="" />
												<h2>$56</h2>
												<p>Easy Polo Black Edition</p>
												<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
											</div>
											
										</div>
									</div>
								</div>
							</div>
							
							<div class="tab-pane fade" id="kids" >
								<div class="col-sm-3">
									<div class="product-image-wrapper">
										<div class="single-products">
											<div class="productinfo text-center">
												<img src="images/home/gallery1.jpg" alt="" />
												<h2>$56</h2>
												<p>Easy Polo Black Edition</p>
												<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
											</div>
											
										</div>
									</div>
								</div>
								<div class="col-sm-3">
									<div class="product-image-wrapper">
										<div class="single-products">
											<div class="productinfo text-center">
												<img src="images/home/gallery2.jpg" alt="" />
												<h2>$56</h2>
												<p>Easy Polo Black Edition</p>
												<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
											</div>
											
										</div>
									</div>
								</div>
								<div class="col-sm-3">
									<div class="product-image-wrapper">
										<div class="single-products">
											<div class="productinfo text-center">
												<img src="images/home/gallery3.jpg" alt="" />
												<h2>$56</h2>
												<p>Easy Polo Black Edition</p>
												<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
											</div>
											
										</div>
									</div>
								</div>
								<div class="col-sm-3">
									<div class="product-image-wrapper">
										<div class="single-products">
											<div class="productinfo text-center">
												<img src="images/home/gallery4.jpg" alt="" />
												<h2>$56</h2>
												<p>Easy Polo Black Edition</p>
												<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
											</div>
											
										</div>
									</div>
								</div>
							</div>
							
							<div class="tab-pane fade" id="poloshirt" >
								<div class="col-sm-3">
									<div class="product-image-wrapper">
										<div class="single-products">
											<div class="productinfo text-center">
												<img src="images/home/gallery2.jpg" alt="" />
												<h2>$56</h2>
												<p>Easy Polo Black Edition</p>
												<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
											</div>
											
										</div>
									</div>
								</div>
								<div class="col-sm-3">
									<div class="product-image-wrapper">
										<div class="single-products">
											<div class="productinfo text-center">
												<img src="images/home/gallery4.jpg" alt="" />
												<h2>$56</h2>
												<p>Easy Polo Black Edition</p>
												<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
											</div>
											
										</div>
									</div>
								</div>
								<div class="col-sm-3">
									<div class="product-image-wrapper">
										<div class="single-products">
											<div class="productinfo text-center">
												<img src="images/home/gallery3.jpg" alt="" />
												<h2>$56</h2>
												<p>Easy Polo Black Edition</p>
												<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
											</div>
											
										</div>
									</div>
								</div>
								<div class="col-sm-3">
									<div class="product-image-wrapper">
										<div class="single-products">
											<div class="productinfo text-center">
												<img src="images/home/gallery1.jpg" alt="" />
												<h2>$56</h2>
												<p>Easy Polo Black Edition</p>
												<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
											</div>
											
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>/category-tab
					
					<div class="recommended_items">recommended_items
						<h2 class="title text-center">recommended items</h2>
						
						<div id="recommended-item-carousel" class="carousel slide" data-ride="carousel">
							<div class="carousel-inner">
								<div class="item active">	
									<div class="col-sm-4">
										<div class="product-image-wrapper">
											<div class="single-products">
												<div class="productinfo text-center">
													<img src="images/home/recommend1.jpg" alt="" />
													<h2>$56</h2>
													<p>Easy Polo Black Edition</p>
													<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
												</div>
												
											</div>
										</div>
									</div>
									<div class="col-sm-4">
										<div class="product-image-wrapper">
											<div class="single-products">
												<div class="productinfo text-center">
													<img src="images/home/recommend2.jpg" alt="" />
													<h2>$56</h2>
													<p>Easy Polo Black Edition</p>
													<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
												</div>
												
											</div>
										</div>
									</div>
									<div class="col-sm-4">
										<div class="product-image-wrapper">
											<div class="single-products">
												<div class="productinfo text-center">
													<img src="images/home/recommend3.jpg" alt="" />
													<h2>$56</h2>
													<p>Easy Polo Black Edition</p>
													<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
												</div>
												
											</div>
										</div>
									</div>
								</div>
								<div class="item">	
									<div class="col-sm-4">
										<div class="product-image-wrapper">
											<div class="single-products">
												<div class="productinfo text-center">
													<img src="images/home/recommend1.jpg" alt="" />
													<h2>$56</h2>
													<p>Easy Polo Black Edition</p>
													<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
												</div>
												
											</div>
										</div>
									</div>
									<div class="col-sm-4">
										<div class="product-image-wrapper">
											<div class="single-products">
												<div class="productinfo text-center">
													<img src="images/home/recommend2.jpg" alt="" />
													<h2>$56</h2>
													<p>Easy Polo Black Edition</p>
													<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
												</div>
												
											</div>
										</div>
									</div>
									<div class="col-sm-4">
										<div class="product-image-wrapper">
											<div class="single-products">
												<div class="productinfo text-center">
													<img src="images/home/recommend3.jpg" alt="" />
													<h2>$56</h2>
													<p>Easy Polo Black Edition</p>
													<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
												</div>
												
											</div>
										</div>
									</div>
								</div>
							</div>
							 <a class="left recommended-item-control" href="#recommended-item-carousel" data-slide="prev">
								<i class="fa fa-angle-left"></i>
							  </a>
							  <a class="right recommended-item-control" href="#recommended-item-carousel" data-slide="next">
								<i class="fa fa-angle-right"></i>
							  </a>			
						</div>
					</div>/recommended_items
					
				</div>
			</div>
		</div> -->
	
