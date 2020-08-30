

<%@page import="com.salesmanager.web.constants.Constants"%>
<script type="text/css">
$(document).ready(function(){
	$('#myModal1').on('hidden.bs.modal', function (e) {
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
<div class="modal fade bs-modal-sm" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
  	<div id="cartShowLoading" class="loading-indicator" style="width:100%;display:none;position: fixed;top: 35%;"></div>
    <div class="modal-content">
        <br>
        <div class="bs-example bs-example-tabs">
            <ul id="myTab" class="nav nav-tabs">
              <li class="active"><a href="#signin" data-toggle="tab">Sign In</a></li>
            </ul>
        </div>
      <div class="modal-body">
        <div id="myTabContent" class="tab-content">
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
            	<a href="#"  data-toggle="modal" data-target="#myModal">Forgot Password</a>
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
