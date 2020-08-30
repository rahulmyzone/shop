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

<section id="form"><!--form-->
		<div class="container">
			<div class="row">
				<div class="col-sm-4 col-sm-offset-1">
					<div id="loginError"></div>
					<div class="login-form"><!--login form-->
						<p><h2>Login to your account <b class="px-separator">or</b> <a href="/shop/customer/registration.html">Register Here</a></h2></p>
						<form:form action="/shop/customer/logon.html" method="POST"  commandName="securedCustomer">
							<form:input path="userName" id="signin_userName"/>
							<form:password path="password" id="signin_password"/>
							<form:hidden path="storeCode" id="signin_storeCode"/>
							<%-- <input type="text" placeholder="Username" value="${securedCustomer.userName}"/>
							<input type="password" placeholder="Password" value="${securedCustomer.password}"/> --%>
							<span>
								<input type="checkbox" class="checkbox"> 
								Keep me signed in
							</span>
								<%-- <form:button value="Login"></form:button> --%>
								<button type="button" id="login-button" class="btn btn-default">Login</button>
						</form:form>
					</div><!--/login form-->
				</div>
				
				<%-- <div class="col-sm-1">
					<h2 class="or">OR</h2>
				</div>
				<div class="col-sm-4">
					<div class="signup-form"><!--sign up form-->
						<h2>New User Signup!</h2>
						<form action="#">
							<!-- <input type="text" placeholder="Name"/>
							<input type="email" placeholder="Email Address"/>
							<input type="password" placeholder="Password"/> -->
							<button type="submit" class="btn btn-default">Signup</button>
						</form>
					</div><!--/sign up form-->
				</div> --%>
			</div>
		</div>
	</section><!--/form-->

<%-- <div class="container">
	<div class="row">
		<form class="form-signin mg-btm">
    	<h3 class="heading-desc">
		<button type="button" class="close pull-right" aria-hidden="true">×</button>
		Login to Bootsnipp</h3>
		<div class="social-box">
			<div class="row mg-btm">
             <div class="col-md-12">
                <a href="#" class="btn btn-primary btn-block">
                  <i class="icon-facebook"></i>    Login with Facebook
                </a>
			</div>
			</div>
			<div class="row">
			<div class="col-md-12">
                <a href="#" class="btn btn-info btn-block" >
                  <i class="icon-twitter"></i>    Login with Twitter
                </a>
            </div>
          </div>
		</div>
		<div class="main">	
        
		<input type="text" class="form-control" placeholder="Email" autofocus>
        <input type="password" class="form-control" placeholder="Password">
		 
        Are you a business? <a href=""> Get started here</a>
		<span class="clearfix"></span>	
        </div>
		<div class="login-footer">
		<div class="row">
                        <div class="col-xs-6 col-md-6">
                            <div class="left-section">
								<a href="">Forgot your password?</a>
								<a href="">Sign up now</a>
							</div>
                        </div>
                        <div class="col-xs-6 col-md-6 pull-right">
                            <button type="submit" class="btn btn-large btn-danger pull-right">Login</button>
                        </div>
                    </div>
		
		</div>
      </form>
	</div>
</div> --%>
					

<script>
/* $("#submitBtn").on("click",function(){
	var json = {};
	var to = $("#securedCustomer").serialize();
	var toSplit = to.split("&");
	for (var i = 0; i < toSplit.length; i++) {
	var s = toSplit[i].split("=");
	var key = s[0];
	var val = s[1];
	json[key]=val;
	}
	$.ajax({  
		 type: 'POST',  
		 url: getContextPath() + '/shop/customer/logon.html',  
		 data: json, 
		 contentType: 'application/x-www-form-urlencoded',
		 dataType: 'json', 
		 cache:false,
		 error: function(e) { 
			log('Error while adding to cart');
			 
		 },
		 success: function(cart) {
			if(cart.response.status == 0){
				window.location.href="http://localhost:8080/shop/cart/redirectCart.html"
			}
		 } 
	});
	
}); */

</script>

		
