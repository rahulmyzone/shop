

<%@page import="com.salesmanager.web.constants.Constants"%>
<script type="text/css">
$(document).ready(function(){
$('.modal').on('show.bs.modal', function () {
        if ($(document).height() > $(window).height()) {
            $('body').addClass("modal-open-noscroll");
        }
        else {
            $('body').removeClass("modal-open-noscroll");
        }
    });
    $('.modal').on('hide.bs.modal', function () {
        $('body').removeClass("modal-open-noscroll");
    });

$('body').on('show.bs.modal', function () {
    if ($("body").innerHeight() > $(window).height()) {
        $("body").css("margin-right", "17px");
    }
}); 

$('body').on('hidden.bs.modal', function (e) {
    $("body").css("margin-right", "0px");
});

    $('.modal-footer button').click(function(){
		var button = $(this);

		if ( button.attr("data-dismiss") != "modal" ){
			var inputs = $('form input');
			var title = $('.modal-title');
			var progress = $('.progress');
			var progressBar = $('.progress-bar');

			inputs.attr("disabled", "disabled");

			button.hide();

			progress.show();

			progressBar.animate({width : "100%"}, 100);

			progress.delay(1000)
					.fadeOut(600);

			button.text("Close")
					.removeClass("btn-primary")
					.addClass("btn-success")
    				.blur()
					.delay(1600)
					.fadeIn(function(){
						title.text("Log in is successful");
						button.attr("data-dismiss", "modal");
					});
		}
	});

	$('#myModal').on('hidden.bs.modal', function (e) {
		var inputs = $('form input');
		var title = $('.modal-title');
		var progressBar = $('.progress-bar');
		var button = $('.modal-footer button');

		inputs.removeAttr("disabled");

		title.text("Log in");

		progressBar.css({ "width" : "0%" });

		button.removeClass("btn-success")
				.addClass("btn-primary")
				.text("Ok")
				.removeAttr("data-dismiss");
                
	});
});
    
</script>

<!-- Modal -->
<div class="modal fade bs-modal-sm" id="myModal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
  	<div id="cartShowLoading" class="loading-indicator" style="width:100%;display:none;position: fixed;top: 35%;"></div>
    <div class="modal-content">
        <br>
        <div class="bs-example bs-example-tabs">
            <ul id="myTab" class="nav nav-tabs">
              <li class="active"><a href="#signin" data-toggle="tab">Sign In</a></li>
              <li class=""><a href="#signup" data-toggle="tab">Register</a></li>
             <!--  <li class=""><a href="#why" data-toggle="tab">Why?</a></li> -->
            </ul>
        </div>
      <div class="modal-body">
        <div id="myTabContent" class="tab-content">
        <!-- <div class="tab-pane fade in" id="why">
        <p>We need this information so that you can receive access to the site and its content. Rest assured your information will not be sold, traded, or given to anyone.</p>
        <p></p><br> Please contact <a mailto:href="JoeSixPack@Sixpacksrus.com"></a>JoeSixPack@Sixpacksrus.com</a> for any other inquiries.</p>
        </div> -->
        <div class="tab-pane fade active in" id="signin">
        	<div id="loginError" class="alert alert-danger fade in" style="display:none;"></div>
            <form id="login" method="post" accept-charset="UTF-8" class="form-horizontal">
            <fieldset>
            <!-- Sign In Form -->
            <!-- Text input-->
            <div class="control-group">
              <label class="control-label" for="userid">Login:</label>
              <div class="controls">
             	 <input required="true" id="signin_userName" class="form-control input-medium" type="text" name="userName" size="30" placeholder="Email or Mobile"/>
              </div>
            </div>

            <!-- Password input-->
            <div class="control-group">
              <label class="control-label" for="passwordinput">Password:</label>
              <div class="controls">
              	<input required="true" id="signin_password" class="form-control input-medium" type="password" name="password" size="30" placeholder="********" />
              </div>
            </div>
            <div class="control-group">
            	<a href="#"  data-toggle="modal" data-target="#myModal1">Forgot Password</a>
            </div>

            <!-- Button -->
            <div class="control-group">
              <label class="control-label" for="signin"></label>
              <div class="controls">
              	<input id="signin_storeCode" name="storeCode" type="hidden" value='${sessionScope.MERCHANT_STORE.code}'/>
                <button type="submit" name="signin" style="width:100%" class="btn btn-primary" id="login-button">Login</button>
                <!-- <button id="signin" name="signin" class="btn btn-success">Sign In</button> -->
              </div>
            </div>
            </fieldset>
            </form>
        </div>
        <div class="tab-pane fade" id="signup">
            <form id="register" class="form-horizontal" method="post">
            <fieldset>
            <!-- Sign Up Form -->
            <div class="control-group">
              <label class="control-label" for="firstName">Name:</label>
              <div class="controls">
                <input id="firstName" name="billing.firstName" title="First name is required" class="form-control" type="text" placeholder="Your Name" class="input-large" required="true"/>
                <div id="firstNameError" class="help-inline" style="display:none;color:#a94442"></div>
              </div>
            </div>
            
            <div class="control-group">
              <label class="control-label" for="email">Email:</label>
              <div class="controls">
                <input id="email" name="emailAddress" class="form-control" title="Email address is required" type="text" placeholder="example@email.com" class="input-large" required="true">
                <div id="emailError" class="help-inline" style="display:none;color:#a94442"></div>
              </div>
            </div>
            
            <!-- Text input-->
            <div class="control-group">
              <label class="control-label" for="phone">Mobile Number:</label>
              <div class="controls">
                <input id="phone" name="billing.phone" title="Phone number is required" class="form-control" type="text" placeholder="Mobile Number" class="input-large" required="true">
                <div id="phoneError" class="help-inline" style="display:none;color:#a94442"></div>
              </div>
            </div>
            
            <!-- Password input-->
								<div class="control-group">
									<label class="control-label" for="gender">Gender:</label>
									<div class="controls">
										<select id="gender" name="gender"
											class="form-control form-control-lg">
											<option value="M">Male</option>
											<option value="F">Female</option>
										</select>
									</div>
								</div>

								<!-- Text input-->
            <div class="control-group">
              <label class="control-label" for="password">Password:</label>
              <div class="controls">
                <input id="password" title="A password is required" class="form-control" name="password" type="password" placeholder="********" class="input-large" required="true">
                <div id="passwordError" class="help-inline" style="display:none;color:#a94442"></div>
                <em>1-8 Characters</em>
              </div>
            </div>
            
            <!-- Button -->
            <div class="control-group">
              <label class="control-label" for="confirmsignup"></label>
              <div class="controls">
                <button id="confirmsignup" name="confirmsignup" style="width:100%" class="btn btn-primary">Sign Up</button>
              </div>
            </div>
            </fieldset>
            </form>
      </div>
    </div>
      </div>
      <div class="modal-footer">
      <center>
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </center>
      </div>
    </div>
  </div>
</div>
