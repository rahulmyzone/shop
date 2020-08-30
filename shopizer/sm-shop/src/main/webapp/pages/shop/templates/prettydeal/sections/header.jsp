<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
 <%@ taglib uri="/WEB-INF/shopizer-tags.tld" prefix="sm"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%
List<String> cats = new ArrayList();
cats.add("Health & Fitness");
cats.add("Beauty & Wellness");
cats.add("Food & Drinks");
cats.add("Fun");
//cats.add("Entertainment Deals");
//cats.add("Electronics Deals");
cats.add("Handlooms");
request.setAttribute("cats", cats);
%>

<c:forEach items="${requestScope.cats}" var="cat">
	<sm:categoryGroup categoryName="${cat}"/>
</c:forEach>
<%-- <header class="navbar-fixed-top">
  <div class="main-header">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="logo top-left-row">
            <div class="mobile-nav">
              <div class="overlay"></div>
              
              <!-- Sidebar -->
              <nav class="navbar navbar-inverse navbar-fixed-top" id="sidebar-wrapper" role="navigation">
                <ul class="nav sidebar-nav">
                  <li> <a href="#">Home</a> </li>
                  <li> <a href="#">About</a> </li>
                  <li> <a href="#">Events</a> </li>
                  <li> <a href="#">Team</a> </li>
                  <li class="dropdown"> <a href="#" class="dropdown-toggle" data-toggle="dropdown">Works <span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                      <li class="dropdown-header">Dropdown heading</li>
                      <li><a href="#">Action</a></li>
                      <li><a href="#">Another action</a></li>
                      <li><a href="#">Something else here</a></li>
                      <li><a href="#">Separated link</a></li>
                      <li><a href="#">One more separated link</a></li>
                    </ul>
                  </li>
                  <li> <a href="#">Services</a> </li>
                  <li> <a href="#">Contact</a> </li>
                  <li> <a href="https://twitter.com/maridlcrmn">Follow me</a> </li>
                </ul>
              </nav>
              <button type="button" class="hamburger is-closed" data-toggle="offcanvas"> <span class="hamb-top"></span> <span class="hamb-middle"></span> <span class="hamb-bottom"></span> </button>
            </div>
            <a href="<c:out value="/" />" class="pull-left"> <img src="<c:url value="/resources/templates/prettydeal/img/logo.png" />" alt="logo"> </a>
            <div class="nav-dropdown-menu">
              <ul class="nav navbar-nav">
                <li class="dropdown"> <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="fa fa-bars" aria-hidden="true"></i></a>
                  <ul class="dropdown-menu">
                  	<c:forEach items="${requestScope.TOP_CATEGORIES}" var="cat">
                  		<li><a href='<c:url value="/shop/category/${cat.description.friendlyUrl}.html"/><sm:breadcrumbParam categoryId="${cat.id}"/>'><c:out value="${cat.description.name}"/></a></li>
                  		<li class="divider"></li>
                  	</c:forEach>
                    <!-- <li><a href="#">Action</a></li>
                    <li><a href="#">Another action</a></li>
                    <li><a href="#">Something else here</a></li>
                    <li class="divider"></li>
                    <li><a href="#">Separated link</a></li>
                    <li class="divider"></li>
                    <li><a href="#">One more separated link</a></li> -->
                  </ul>
                </li>
              </ul>
            </div>
          </div>
          <div class="animate-dropdown top-right-row"> 
          <sec:authorize access="!hasRole('AUTH_CUSTOMER') and !fullyAuthenticated">
	          <a id="signinDrop" role="button" href="#" class="login dropdown-toggle noboxshadow" data-toggle="modal" data-target="#myModal">
	            <div class="login-inner"> <img src="<c:url value="/resources/templates/prettydeal/img/usericon.png" />"  class="img-responsive pull-left" alt=""> SignUp / SignIn</div>
	          </a>
           </sec:authorize>
           
           <sec:authorize access="hasRole('AUTH_CUSTOMER') and fullyAuthenticated">
						<!-- logged in user -->
						<c:if test="${requestScope.CUSTOMER!=null}">
							<a id="signinDrop" role="button" href="#" data-toggle="dropdown" class="login dropdown-toggle noboxshadow">
	            				<div class="login-inner"> <img src="<c:url value="/resources/templates/prettydeal/img/usericon.png" />"  class="img-responsive pull-left" alt="">
	            					<c:if test="${not empty requestScope.CUSTOMER.billing.firstName}">
							       		<c:out value="${sessionScope.CUSTOMER.billing.firstName}"/>
							   		</c:if>
	            				</div>
	          				</a>
	          				<ul class="dropdown-menu">
								<li>
									<a onClick="javascript:location.href='<c:url value="/shop/customer/dashboard.html" />';" href="#"><i class="fa fa-user"></i><s:message code="label.customer.myaccount" text="My account"/></a>
								</li>
								<li class="divider"></li>
									<li>
										<a onClick="javascript:location.href='<c:url value="/shop/customer/j_spring_security_logout" />';" href="#"><i class="fa fa-power-off"></i><s:message code="button.label.logout" text="Logout"/></a>
									</li>
							</ul>
						</c:if>
					</sec:authorize>
					
						<c:if
							test="${not fn:contains(requestScope['javax.servlet.forward.servlet_path'], 'order') && not fn:contains(requestScope['javax.servlet.forward.servlet_path'], 'cart')}">
							<!-- not displayed in checkout (order) and cart -->
							<div class="dropdown dropdown-cart" id="miniCart">
								<a href="#" class="dropdown-toggle lnk-cart"
									data-toggle="dropdown">
									<div class="items-cart-inner">
										<span class="basket"> <img
											src="<c:url value="/resources/templates/prettydeal/img/cart.png" />"
											class="img-responsive pull-left" alt=""></span> <span
											class="basket-item-count"> <span id="open-cart" class="count"><s:message code="label.cart" text="Cart"/> <jsp:include page="/pages/shop/templates/prettydeal/components/cart/minicartinfo.jsp" /></span>
										</span>
									</div>
								</a>
								<ul class="dropdown-menu" id="minicartComponent">
									<li>
										<jsp:include page="/pages/shop/templates/prettydeal/components/cart/minicart.jsp" />
									</li>
								</ul>
							</div>
						</c:if>
					</div>
          <div class="search-area">
            <form>
              <div class="control-group">
                <ul class="categories-filter animate-dropdown list-inline">
                  <li class="dropdown"> <a class="dropdown-toggle" data-toggle="dropdown" href="">Categories <b class="caret"></b></a>
                    <ul class="dropdown-menu " role="menu">
                      <li class="menu-header">All Categories</li>
                      	<c:forEach items="${requestScope.CONTENT_PAGE}" var="content">
                      		<li><a href="<c:url value="/shop/pages/${content.seUrl}.html"/>">${content.name}</a></li>
						</c:forEach>
                    </ul>
                  </li>
                </ul>
                <div id="searchGroup" class="btn-group pull-right">
											<form id="searchForm" class="form-inline" method="post" action="<c:url value="/shop/search/search.html"/>">
												<input id="searchField" class="tt-query" name="q" type="text" placeholder="<s:message code="label.search.searchQuery" text="Search query" />" autocomplete="off" spellcheck="false" dir="auto" value="<c:out value="${q}"/>">
												<button id="searchButton" class="btn" type="submit"><s:message code="label.generic.search" text="Search" /></button>
											</form>
										</div>
                <input id="searchField1" name="q" type="text" class="search-field form-control tt-query" placeholder="Enter your keyword.....">
                <a class="search-button" href="#"><img src="<c:url value="/resources/templates/prettydeal/img/search.png" />" alt=""></a> </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</header> --%>
<header class="navbar-fixed-top">
  <div class="main-header">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="logo top-left-row">
            <div class="mobile-nav">
              <div class="overlay"></div>
              
              <!-- Sidebar -->
              <nav class="navbar navbar-inverse navbar-fixed-top" id="sidebar-wrapper" role="navigation">
                <ul class="nav sidebar-nav">
                  <li> <a href="#">Home</a> </li>
                  <li> <a href="#">About</a> </li>
                  <li> <a href="#">Events</a> </li>
                  <li> <a href="#">Team</a> </li>
                  <li class="dropdown"> <a href="#" class="dropdown-toggle" data-toggle="dropdown">Works <span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                      <li class="dropdown-header"+>Dropdown heading</li>
                      <li><a href="#">Action</a></li>
                    </ul>
                  </li>
                  <li> <a href="#">Services</a> </li>
                  <li> <a href="#">Contact</a> </li>
                  <li> <a href="https://twitter.com/maridlcrmn">Follow me</a> </li>
                </ul>
              </nav>
              <button type="button" class="hamburger is-closed" data-toggle="offcanvas"> <span class="hamb-top"></span> <span class="hamb-middle"></span> <span class="hamb-bottom"></span> </button>
            </div>
            <a href="/" class="pull-left"> <img src="<c:url value="/resources/templates/prettydeal/img/logo.png" />" alt="logo"> </a>
            <div class="nav-dropdown-menu">
              <ul class="nav navbar-nav">
                <li class="dropdown"> <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="fa fa-bars" aria-hidden="true"></i></a>
                  <ul class="dropdown-menu">
                   <c:forEach items="${requestScope.cats}" var="cat" varStatus="s">
                   		<li><a href="<c:url value="/shop/category/${requestScope[cat].description.seUrl}.html"/><sm:breadcrumbParam categoryId="${requestScope[cat].id}"/>"><c:out value="${cat}"/></a></li>
                   		<c:if test="${s.index < requestScope.cats.size()-1}">
                   			<li class="divider"></li>
                   		</c:if>
                   </c:forEach>
                  </ul>
                </li>
              </ul>
            </div>
          </div>
          <div class="animate-dropdown top-right-row"> 
          <div class="dropdown-login"> 
           <sec:authorize access="!hasRole('AUTH_CUSTOMER') and !fullyAuthenticated">
	          <a id="signinDrop" role="button" href="#" class="login " data-toggle="modal" data-target="#myModal">
	          	<div class="login-inner"> <img src="<c:url value="/resources/templates/prettydeal/img/usericon.png" />"  class="img-responsive pull-left" alt=""> SignUp / SignIn</div>
	          </a>
           </sec:authorize>
          	
            <sec:authorize access="hasRole('AUTH_CUSTOMER') and fullyAuthenticated">
            	<a href="#" class="login" data-toggle="dropdown">
            		<div class="login-inner"> <img src="<c:url value="/resources/templates/prettydeal/img/usericon.png" />"  class="img-responsive pull-left" alt="">
            			<c:if test="${not empty requestScope.CUSTOMER.billing.firstName}">
							Hey <c:out value="${sessionScope.CUSTOMER.billing.firstName}"/>!
						</c:if>
            		</div>
            	</a>
	            <ul class="dropdown-menu">
	           		<li>
		                <a onClick="event.preventDefault();javascript:location.href='<c:url value="/shop/customer/dashboard.html" />';" href="#"><s:message code="label.customer.myaccount" text="My account"/></a>
		            </li>
		            <li>
		               <a onClick="event.preventDefault();javascript:location.href='<c:url value="/shop/customer/j_spring_security_logout" />';" href="#"></i><s:message code="button.label.logout" text="Logout"/></a>
	                </li>
	             </ul>
             </sec:authorize>
             </div>
            <c:if test="${not fn:contains(requestScope['javax.servlet.forward.servlet_path'], 'order') && not fn:contains(requestScope['javax.servlet.forward.servlet_path'], 'cart')}">
							<!-- not displayed in checkout (order) and cart -->
							<div class="dropdown dropdown-cart" id="miniCart">
								<a href="#" class="dropdown-toggle lnk-cart"
									data-toggle="dropdown">
									<div class="items-cart-inner">
										<span class="basket"> <img
											src="<c:url value="/resources/templates/prettydeal/img/cart.png" />"
											class="img-responsive pull-left" alt=""></span> <span
											class="basket-item-count"> <span id="open-cart" class="count"><s:message code="label.cart" text="Cart"/> <jsp:include page="/pages/shop/templates/prettydeal/components/cart/minicartinfo.jsp" /></span>
										</span>
									</div>
								</a>
								<ul class="dropdown-menu" id="minicartComponent">
									<li>
										<jsp:include page="/pages/shop/templates/prettydeal/components/cart/minicart.jsp" />
									</li>
								</ul>
							</div>
			</c:if>
          </div>
          <div class="search-area">
          <%-- <form id="searchForm" class="form-inline" method="post" action="<c:url value="/shop/search/search.html"/>">
												<input id="searchField" class="tt-query" name="q" type="text" placeholder="<s:message code="label.search.searchQuery" text="Search query" />" autocomplete="off" spellcheck="false" dir="auto" value="<c:out value="${q}"/>">
												<button id="searchButton" class="btn" type="submit"><s:message code="label.generic.search" text="Search" /></button>
											</form> --%>
            <form id="searchForm" class="form-inline" method="get" action="<c:url value="/shop/search/search.html"/>">
              <div class="control-group">
                <input id="searchField1" name="q" class="tt-query search-field form-control" placeholder="Enter your keyword....." autocomplete="off" spellcheck="false" dir="auto" value="<c:out value="${q}"/>">
                <a class="search-button" href="#"><img src="<c:url value="/resources/templates/prettydeal/img/search.png" />" alt=""></a> </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</header>
			<!-- header -->
			<%-- <div id="mainmenu" class="row-fluid">
				
					<ul class="nav nav-pills pull-left" id="linkMenuLinks">
						<li class="active"><a href="<c:url value="/shop"/>"><s:message code="menu.home" text="Home"/></a></li>
						<c:forEach items="${requestScope.CONTENT_PAGE}" var="content">
    							<li class="">
    								<a href="<c:url value="/shop/pages/${content.seUrl}.html"/>" class="current"> 
    									<span class="name">${content.name}</span> 
    								</a>
    							</li>
						</c:forEach>
						<c:if test="${requestScope.CONFIGS['displayContactUs']==true}">
						<li><a href="<c:url value="/shop/store/contactus.html"/>"><s:message code="label.customer.contactus" text="Contact us"/></a></li>
						</c:if>
					</ul>
					

					<c:if test="${not fn:contains(requestScope['javax.servlet.forward.servlet_path'], 'order') && not fn:contains(requestScope['javax.servlet.forward.servlet_path'], 'cart')}">
					<!-- not displayed in checkout (order) and cart -->
 					<div id="miniCart" style="padding-top: 8px;padding-bottom:10px;" class="btn-group pull-right">
            					&nbsp;&nbsp;&nbsp;
            					<i class="icon-shopping-cart icon-black"></i>
            					<a style="box-shadow:none;color:FF8C00;" href="#" data-toggle="dropdown" class="open noboxshadow dropdown-toggle" id="open-cart"><s:message code="label.mycart" text="My cart"/></a>
								<jsp:include page="/pages/shop/common/cart/minicartinfo.jsp" />
            				
		            			<ul class="dropdown-menu minicart" id="minicartComponent">
		              				<li>
										<jsp:include page="/pages/shop/common/cart/minicart.jsp" />
		              				</li>	
		            			</ul>
					</div>
					</c:if>
					
					<!-- If display customer section -->
					<c:if test="${requestScope.CONFIGS['displayCustomerSection'] == true}">
					<sec:authorize access="hasRole('AUTH_CUSTOMER') and fullyAuthenticated">
						<!-- logged in user -->
						<c:if test="${requestScope.CUSTOMER!=null}">
							<ul class="logon-box pull-right">
							<li id="fat-menu" class="dropdown">
							<a class="dropdown-toggle noboxshadow" data-toggle="dropdown" href="#">
							   <s:message code="label.generic.welcome" text="Welcome" /> 
							   <c:if test="${not empty requestScope.CUSTOMER.billing.firstName}">
							       <c:out value="${sessionScope.CUSTOMER.billing.firstName}"/>
							   </c:if><b class="caret"></b>
							 </a>
								<ul class="dropdown-menu">
									<li>
										<a onClick="javascript:location.href='<c:url value="/shop/customer/dashboard.html" />';" href="#"><i class="fa fa-user"></i><s:message code="label.customer.myaccount" text="My account"/></a>
									</li>
									<li class="divider"></li>
									<li>
										<a onClick="javascript:location.href='<c:url value="/shop/customer/j_spring_security_logout" />';" href="#"><i class="fa fa-power-off"></i><s:message code="button.label.logout" text="Logout"/></a>
									</li>
								</ul>
							</li>
							</ul>
						</c:if>
					</sec:authorize>
					<sec:authorize access="!hasRole('AUTH_CUSTOMER') and fullyAuthenticated">
						<!-- no dual login -->
						<ul class="logon-box pull-right">
							<li>
								<s:message code="label.security.loggedinas" text="You are logged in as"/> [<sec:authentication property="principal.username"/>]. <s:message code="label.security.nologinacces.store" text="We can't display store logon box"/>
							</li>
						</ul>
					</sec:authorize>
					<sec:authorize access="!hasRole('AUTH_CUSTOMER') and !fullyAuthenticated">
					<!-- login box -->
					<ul class="pull-right" style="list-style-type: none;padding-top: 8px;z-index:500000;">
					  <li id="fat-menu" class="dropdown">
					    <a href="#" id="signinDrop" role="button" class="dropdown-toggle noboxshadow" data-toggle="dropdown"><s:message code="button.label.signin" text="Signin" /><b class="caret"></b></a>
					
					
							<div id="signinPane" class="dropdown-menu" style="padding: 15px; padding-bottom: 0px;">
								<div id="loginError" class="alert alert-error" style="display:none;"></div>
								<!-- form id must be login, form fields must be userName, password and storeCode -->
								<form id="login" method="post" accept-charset="UTF-8">
									<div class="control-group">
	                        				<label><s:message code="label.username" text="Username" /></label>
					                        <div class="controls">
												<input id="signin_userName" style="margin-bottom: 15px;" type="text" name="userName" size="30" />
											</div>
									</div>
									<div class="control-group">
	                        				<label><s:message code="label.password" text="Password" /></label>
					                        <div class="controls">
												<input id="signin_password" style="margin-bottom: 15px;" type="password" name="password" size="30" />
											</div>
									</div>
									<input id="signin_storeCode" name="storeCode" type="hidden" value="<c:out value="${requestScope.MERCHANT_STORE.code}"/>"/>					 
									<button type="submit" style="width:100%" class="btn btn-large" id="login-button"><s:message code="button.label.login" text="Login" /></button>
									
								</form>
								<a onClick="javascript:location.href='<c:url value="/shop/customer/registration.html" />';" href="" role="button" class="" data-toggle="modal"><s:message code="label.register.notyetregistered" text="Not yet registered ?" /></a>
							</div>
					  </li>
					</ul>
					</sec:authorize>
					</c:if>


			</div> --%>
			<!-- End main menu -->
			
