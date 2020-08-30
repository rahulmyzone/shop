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

	<div class="col-sm-4" data-id="${product.id}" item-price="${product.price}" item-name="${product.description.name}" item-order="${product.sortOrder}">
		<div class="product-image-wrapper">
			<div class="single-products">
				<div class="productinfo text-center">
					<c:if test="${product.description.highlights!=null && product.description.highlights!=''}">
						<div class="ribbon-wrapper-green">
							<div class="ribbon-green">
								<c:out value="${product.description.highlights}" />
							</div>
						</div>
					</c:if>
					<c:if test="${product.image!=null}">
						<a href="<c:url value="/shop/product/" /><c:out value="${product.description.friendlyUrl}"/>.html"><img src="<sm:shopProductImage imageName="${product.image.imageName}"  sku="${product.sku}"/>" class="product-img" /></a>
					</c:if>
						<h2>
							<c:out value="${product.finalPrice}"/>
						</h2>
					<p><a href="<c:url value="/shop/product/" /><c:out value="${product.description.friendlyUrl}"/>.html"><c:out value="${product.description.name}"/></a></p>
				</div>
				<c:if test="${requestScope.FEATURED==true}">
				<div class="product-overlay">
					<div class="overlay-content" >
						<c:choose>
							<c:when test="${product.discounted}">
								<del class="specialPrice" ><c:out value="${product.originalPrice}" /></del>
								&nbsp;<h2><c:out value="${product.finalPrice}" /></h2>
							</c:when>
							<c:otherwise>
								<h2>
									<c:out value="${product.finalPrice}"/>
								</h2>
							</c:otherwise>
						</c:choose>
						<p><c:out value="${product.description.name}"/></p>
						<a class="btn btn-default add-to-cart product-dtl-btn addToCart" href="javascript:void(0);" productId="${product.id}">
							<i class="fa fa-shopping-cart"></i><s:message code="button.label.addToCart" text="Get this deal" />
						</a>
						<a href='<c:url value="/shop/product/" />
							<c:out value="${product.description.friendlyUrl}"/>.html<sm:breadcrumbParam productId="${product.id}"/>' class="btn btn-default add-to-cart product-dtl-btn">
							<i class="fa fa-shopping-cart"></i><s:message code="button.label.view" text="Details"/>
						</a>
					</div>
				</div>
				</c:if>
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

	<%-- <div class="col-sm-4" data-id="${product.id}" item-price="${product.price}" item-name="${product.description.name}" item-order="${product.sortOrder}">
												<div class="box-style-1 white-bg object-non-visible animated object-visible fadeInUpSmall" data-animation-effect="fadeInUpSmall" data-effect-delay="0">
												    <c:if test="${product.description.highlights!=null && product.description.highlights!=''}">
												    <div class="ribbon-wrapper-green">
												    	<div class="ribbon-green">
												    		<c:out value="${product.description.highlights}" />
												    	</div>
											    	</div>
												    </c:if>                                     
													<div class="product-image"><c:if test="${product.image!=null}"><a href="<c:url value="/shop/product/" /><c:out value="${product.description.friendlyUrl}"/>.html"><img src="<sm:shopProductImage imageName="${product.image.imageName}"  sku="${product.sku}"/>" class="product-img" /></a></c:if></div>
													<div class="product-info">
														<a href="<c:url value="/shop/product/" /><c:out value="${product.description.friendlyUrl}"/>.html<sm:breadcrumbParam productId="${product.id}"/>"><h3 class="product-name" itemprop="name"><c:out value="${product.description.name}"/></h3></a>
													</div>
													<div data-animation-effect="fadeInUpSmall" data-effect-delay="0">
														<h4>
														<c:choose>
															<c:when test="${product.discounted}">
																<del><c:out value="${product.originalPrice}" /></del>&nbsp;<span class="specialPrice" itemprop="price"><c:out value="${product.finalPrice}" /></span>
															</c:when>
															<c:otherwise>
																<span itemprop="price"><c:out value="${product.finalPrice}" /></span>
															</c:otherwise>
														</c:choose>
														</h4>
													</div>
													<div class="product-actions">
													
															<a class="details" href="<c:url value="/shop/product/" /><c:out value="${product.description.friendlyUrl}"/>.html<sm:breadcrumbParam productId="${product.id}"/>"><s:message code="button.label.view" text="Details" /></a> 
															<c:choose>
																<c:when test="${requestScope.FEATURED==true}">
																	<c:if test="${requestScope.CONFIGS['displayAddToCartOnFeaturedItems']==true}"> 
																		| <a class="addToCart" href="javascript:void(0);" productId="${product.id}"><s:message code="button.label.addToCart" text="Add to cart" /></a>
																	</c:if>
																</c:when>
																<c:otherwise> 
																	| <a class="addToCart" href="javascript:void(0);" productId="${product.id}"><s:message code="button.label.addToCart" text="Add to cart" /></a>
																</c:otherwise>
															</c:choose>
													</div>
												</div>
										    </div> --%>
