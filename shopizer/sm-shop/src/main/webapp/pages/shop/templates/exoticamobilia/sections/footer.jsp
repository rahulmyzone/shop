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
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
 
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

	  <!-- footer -->
	  
	  <footer id="footer"><!--Footer-->
		<div class="footer-top">
			<div class="container">
				<div class="row">
					<div class="col-sm-2">
						<div class="companyinfo">
							<h2><span>e</span>-shopper</h2>
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit,sed do eiusmod tempor</p>
						</div>
					</div>
					<div class="col-sm-7">
						<div class="col-sm-3">
							<div class="video-gallery text-center">
								<a href="#">
									<div class="iframe-img">
										<img src="<c:url value="/resources/templates/exoticamobilia/img/home/iframe1.png" />" alt="" />
									</div>
									<div class="overlay-icon">
										<i class="fa fa-play-circle-o"></i>
									</div>
								</a>
								<p>Circle of Hands</p>
								<h2>24 DEC 2014</h2>
							</div>
						</div>
						
						<div class="col-sm-3">
							<div class="video-gallery text-center">
								<a href="#">
									<div class="iframe-img">
										<img src="<c:url value="/resources/templates/exoticamobilia/img/home/iframe2.png" />" alt="" />
									</div>
									<div class="overlay-icon">
										<i class="fa fa-play-circle-o"></i>
									</div>
								</a>
								<p>Circle of Hands</p>
								<h2>24 DEC 2014</h2>
							</div>
						</div>
						
						<div class="col-sm-3">
							<div class="video-gallery text-center">
								<a href="#">
									<div class="iframe-img">
										<img src="<c:url value="/resources/templates/exoticamobilia/img/home/iframe3.png" />" alt="" />
									</div>
									<div class="overlay-icon">
										<i class="fa fa-play-circle-o"></i>
									</div>
								</a>
								<p>Circle of Hands</p>
								<h2>24 DEC 2014</h2>
							</div>
						</div>
						
						<div class="col-sm-3">
							<div class="video-gallery text-center">
								<a href="#">
									<div class="iframe-img">
										<img src="<c:url value="/resources/templates/exoticamobilia/img/home/iframe4.png" />" alt="" />
									</div>
									<div class="overlay-icon">
										<i class="fa fa-play-circle-o"></i>
									</div>
								</a>
								<p>Circle of Hands</p>
								<h2>24 DEC 2014</h2>
							</div>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="address">
							<img src="<c:url value="/resources/templates/exoticamobilia/img/home/map.png" />" alt="" />
							<p>505 S Atlantic Ave Virginia Beach, VA(Virginia)</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="footer-widget">
			<div class="container">
				<div class="row">
					<div class="col-sm-2">
						<div class="single-widget">
							<h2>Service</h2>
							<ul class="nav nav-pills nav-stacked">
								<li><a href="#">Online Help</a></li>
								<li><a href="#">Contact Us</a></li>
								<li><a href="#">Order Status</a></li>
								<li><a href="#">Change Location</a></li>
								<li><a href="#">FAQ’s</a></li>
							</ul>
						</div>
					</div>
					<div class="col-sm-2">
						<div class="single-widget">
							<h2>Quock Shop</h2>
							<ul class="nav nav-pills nav-stacked">
								<li><a href="#">T-Shirt</a></li>
								<li><a href="#">Mens</a></li>
								<li><a href="#">Womens</a></li>
								<li><a href="#">Gift Cards</a></li>
								<li><a href="#">Shoes</a></li>
							</ul>
						</div>
					</div>
					<div class="col-sm-2">
						<div class="single-widget">
							<h2>Policies</h2>
							<ul class="nav nav-pills nav-stacked">
								<li><a href="#">Terms of Use</a></li>
								<li><a href="#">Privecy Policy</a></li>
								<li><a href="#">Refund Policy</a></li>
								<li><a href="#">Billing System</a></li>
								<li><a href="#">Ticket System</a></li>
							</ul>
						</div>
					</div>
					<div class="col-sm-2">
						<div class="single-widget">
							<h2>About Shopper</h2>
							<ul class="nav nav-pills nav-stacked">
								<li><a href="#">Company Information</a></li>
								<li><a href="#">Careers</a></li>
								<li><a href="#">Store Location</a></li>
								<li><a href="#">Affillate Program</a></li>
								<li><a href="#">Copyright</a></li>
							</ul>
						</div>
					</div>
					<div class="col-sm-3 col-sm-offset-1">
						<div class="single-widget">
							<h2>About Shopper</h2>
							<form action="#" class="searchform">
								<input type="text" placeholder="Your email address" />
								<button type="submit" class="btn btn-default"><i class="fa fa-arrow-circle-o-right"></i></button>
								<p>Get the most recent updates from <br />our site and be updated your self...</p>
							</form>
						</div>
					</div>
					
				</div>
			</div>
		</div>
		
		<div class="footer-bottom">
			<div class="container">
				<div class="row">
					<p class="pull-left">Copyright © 2013 E-SHOPPER Inc. All rights reserved.</p>
					<p class="pull-right">Designed by <span><a target="_blank" href="http://www.themeum.com">Themeum</a></span></p>
				</div>
			</div>
		</div>
		
	</footer>
      <%-- <footer id="footer">
            
            <div class="footer">
            
        		<div id="footer-section" class="container">
        
			        <div class="row">
			             <div class="col-md-6">
			                 <div class="logo">
						          <a class="store-name" href="<c:url value="/shop/"/>"><c:out value="${requestScope.MERCHANT_STORE.storename}"/></a>  
			                 </div>
			             </div>
			        </div>
           
           			<br/>
           			<div class="row">
          
        				<div class="col-md-12">
						    <div class="col-md-3 col-sm-6">
						       <c:if test="${not empty requestScope.CONTENT_PAGE}">
										<p class="lead"><s:message code="label.store.information.title" text="Informations"/></p>
										<!-- Pages -->
				                        <ul class="footerLiks">
				                        	<c:forEach items="${requestScope.CONTENT_PAGE}" var="content">
											   <li><a href="<c:url value="/shop/pages/${content.seUrl}.html"/>" class="current">${content.name}</a></li>
											</c:forEach>
											<c:if test="${requestScope.CONFIGS['displayContactUs']==true}">
												<li><a href="<c:url value="/shop/store/contactus.html"/>"><s:message code="label.customer.contactus" text="Contact us"/></a></li>
											</c:if>
										</ul>
				                 </c:if>
				

						   <c:if test="${requestScope.CONFIGS['facebook_page_url'] != null || requestScope.CONFIGS['twitter_handle'] != null || requestScope.CONFIGS['pinterest'] != null}">
							   <ul class="social-links circle">
							       <c:if test="${requestScope.CONFIGS['twitter_handle'] != null}">
								   <li class="twitter"><a target="_blank" href="<c:out value="${requestScope.CONFIGS['twitter_handle']}"/>"><i class="fa fa-twitter"></i></a></li>
								   </c:if>
								   <c:if test="${requestScope.CONFIGS['facebook_page_url'] != null}">
								   <li class="facebook"><a target="_blank" href="<c:out value="${requestScope.CONFIGS['facebook_page_url']}"/>"><i class="fa fa-facebook"></i></a></li>
								   </c:if>
								   <c:if test="${requestScope.CONFIGS['pinterest'] != null}">
								   <li class="pinterest"><a target="_blank" href="<c:out value="${requestScope.CONFIGS['pinterest']}"/>"><i class="fa fa-pinterest"></i></a></li>
								   </c:if>
							   </ul>
						   </c:if>

							<hr class="hidden-md hidden-lg hidden-sm">
				
					</div><!-- /.col-md-3 -->

		    		<div class="col-md-3 col-sm-6">
		    
				   		<c:if test="${requestScope.CONFIGS['displayStoreAddress'] == true}">  
				        
				        		<p class="lead"><s:message code="label.store.tofindus" text="Where to find us" /></p>            
								<ul class="list-icons">
										<jsp:include page="/pages/shop/common/preBuiltBlocks/storeAddress.jsp"/>
								
								</ul>
		                 </c:if>

						<c:if test="${not empty  requestScope.TOP_CATEGORIES}">
						<p class="lead">Top categories</p>
						<ul>
						<c:forEach items="${requestScope.TOP_CATEGORIES}" var="category">
				    					<li>
				    						<a href="<c:url value="/shop/category/${category.description.seUrl}.html"/><sm:breadcrumbParam categoryId="${category.id}"/>" class="current"> 
				    							<span class="name">${category.description.name}</span>
				    						</a>
				    					</li> 
						</c:forEach>
						</ul>
						</c:if>


						<hr class="hidden-md hidden-lg">

		    		</div><!-- /.col-md-3 -->

		    		<div class="col-md-2 col-sm-6">

             <div class="footer-content">
            <c:if test="${not empty  requestScope.TOP_CATEGORIES}">
            a verifier top categories EN/FR
			<p class="lead">Top categories</p>
			<ul class="nav nav-pills nav-stacked">  
			                <li class="<sm:activeLink linkCode="HOME" activeReturnCode="active"/>">
										<a class="dropdown-toggle" data-toggle="dropdown" href="<c:url value="/shop"/>"><s:message code="menu.home" text="Home"/></a>
							</li>
			<c:forEach items="${requestScope.TOP_CATEGORIES}" var="category">
	    					<li>
	    						<a href="<c:url value="/shop/category/${category.description.friendlyUrl}.html"/><sm:breadcrumbParam categoryId="${category.id}"/>" class="current"> 
	    							<span class="name">${category.description.name}</span>
	    						</a>
	    					</li> 
			</c:forEach>
			                <c:if test="${requestScope.CONFIGS['displayContactUs']==true}">
										<li class="<sm:activeLink linkCode="CONTACT" activeReturnCode="active"/>"><a class="dropdown-toggle" data-toggle="dropdown" href="<c:url value="/shop/store/contactus.html"/>"><s:message code="label.customer.contactus" text="Contact us"/></a></li>
							</c:if>
			</ul>
			</c:if> 
			<c:if test="${requestScope.CONFIGS['displayCustomerSection'] == true}">
                 <p class="lead"><s:message code="label.customer.myaccount" text="My Account" /></p>
 						 <ul class="nav nav-pills nav-stacked">  
                        	<sec:authorize access="hasRole('AUTH_CUSTOMER') and fullyAuthenticated">
                        		<li><a href="<c:url value="/shop/customer/account.html"/>"><s:message code="menu.profile" text="Profile"/></a></li>
                        		<li><a href="<c:url value="/shop/customer/billing.html"/>"><s:message code="label.customer.billingshipping" text="Billing & shipping information"/></a></li>
                        		<li><s:message code="label.order.recent" text="Recent orders"/></li>
                        	</sec:authorize>
                        	<sec:authorize access="!hasRole('AUTH_CUSTOMER') and fullyAuthenticated">
                        		<li>
									<s:message code="label.security.loggedinas" text="You are logged in as"/> [<sec:authentication property="principal.username"/>]. <s:message code="label.security.nologinacces.store" text="We can't display store logon box"/>
								</li>
                        	</sec:authorize>
                        	<sec:authorize access="!hasRole('AUTH_CUSTOMER') and !fullyAuthenticated">
								<li><a href="#"><s:message code="button.label.signin" text="Signin" /></a></li>
							</sec:authorize>
					</ul>
			</c:if>


			<hr class="hidden-md hidden-lg hidden-sm">
			</div>

		    </div><!-- /.col-md-2 -->



		    <div class="col-md-4 col-sm-6">
              	                <img src="<c:out value="/sm-shop/resources/templates/exoticamobilia/img/entrepot.JPG"/>" />


		    </div><!-- /.col-md-3 -->
	    </div>
            
         </div>   
       </div>
       </div>
  
		<div class="subfooter">
				<div class="container">
				   <div class="row">
					<div class="col-md-6"><sm:storeCopy/>&nbsp;-&nbsp;<s:message code="label.generic.providedby" /> <a href="http://www.shopizer.com" class="footer-href" target="_blank">Shopizer</a></div>
				    <div class="col-md-6">
				          <div id="navbar-collapse-2" class="collapse navbar-collapse">
				                <ul class="nav navbar-nav">
				                    <li class="<sm:activeLink linkCode="HOME" activeReturnCode="active"/>">
										<a class="dropdown-toggle" data-toggle="dropdown" href="<c:url value="/shop"/>"><s:message code="menu.home" text="Home"/></a>
							        </li>
							        <c:if test="${requestScope.CONFIGS['displayContactUs']==true}">
										<li class="<sm:activeLink linkCode="CONTACT" activeReturnCode="active"/>"><a class="dropdown-toggle" data-toggle="dropdown" href="<c:url value="/shop/store/contactus.html"/>"><s:message code="label.customer.contactus" text="Contact us"/></a></li>
							        </c:if>
				                </ul>
				          </div>	   
				    </div>
				 </div>
		    </div>
        </footer> --%>