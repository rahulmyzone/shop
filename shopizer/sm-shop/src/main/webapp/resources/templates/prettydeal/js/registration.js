$(function() {
	$("#confirmsignup").click(function(e) {
    	//log('Calling login');
    	e.preventDefault();
    	e.stopPropagation();
    	signup();
    });
});
function signup(){
	var data = $("#register").serialize();
	$(".help-inline").hide();
	$("#cartShowLoading").show();
	$.ajax({
        type: "POST",
        //my version
        url: getContextPath() + "/shop/customer/registerCustomer.html",
        data: data,
        cache:false,
     	 dataType:'json',
        'success': function(response) {
        	console.log(response);
        	t = response;
          // $('#signinPane').hideLoading();
			//log(response);
           if (response.response.status==0) {//success
       	   //SHOPPING_CART
       	   //log(response.response.SHOPPING_CART);
       	   if(response.response.SHOPPING_CART!=null && response.response.SHOPPING_CART != ""){
					 // log('saving cart ' + response.response.SHOPPING_CART);
       		  /** save cart in cookie **/
					  var cartCode = buildCartCode(response.response.SHOPPING_CART);
					  $.cookie('cart',cartCode, { expires: 1024, path:'/' });
 			      
       	   }
       	   console.log(response.response.data[0].url);
       	   location.href=getContextPath()+response.response.data[0].url;
       	   /*if(response.response.gotoCart != undefined){
       		   location.href= getContextPath() + "/shop/cart/redirectCart.html";
       	   }else{
       		   //redirect to the same url
       		   //log('Before redirection');
       		   location.href=  getContextPath();   
       	   }*/
           } else {
        	   for(var err in response.response.data[0]){
        		   var ele = '#'+err+'Error';
        		   $(ele).html(response.response.data[0][err]);
                   $(ele).show();
        	   }
        	   $("#cartShowLoading").hide();
           }
       }
   });
	
}
	/**
     * registration functionality for storefront
     */


$.fn.addZoneItems = function(div, data, defaultValue) {
	//console.log('Populating div ' + div + ' defaultValue ' + defaultValue);
	var selector = div + ' > option';
	var defaultExist = false;
    $(selector).remove();
        return this.each(function() {
            var list = this;
            $.each(data, function(index, itemData) {
            	//console.log(itemData.code + ' ' + defaultValue);
            	if(itemData.code==defaultValue) {
            		defaultExist = true;
            	}
                var option = new Option(itemData.name, itemData.code);
                list.add(option);
            });
            if(defaultExist && (defaultValue!=null && defaultValue!='')) {
           	 	$(div).val(defaultValue);
            }
     });
};


function getZones(countryCode, zoneCode){
	$("#registration_zones option").remove(); 
	var url=getContextPath() + '/shop/reference/provinces.html';
	var data='countryCode=' + countryCode + '&lang=' + getLanguageCode();
	
	$.ajax({
		  type: 'POST',
		  url: url,
		  data: data,
		  dataType: 'json',
		  success: function(responseObj){

			  if((responseObj.response.status == 0 || responseObj.response.status ==9999) && responseObj.response.data){
					$("#registration_zones option").remove();
					$('#registration_zones').show();  
					$('#hidden_registration_zones').hide();
					
					//var zone = $('#registration_zones');
					$('#registration_zones').addZoneItems('#registration_zones', responseObj.response.data, zoneCode);
			
			  } else {
				  $('#registration_zones').hide();  
				  $('#hidden_registration_zones').show();
			  }
		      },
			    error: function(xhr, textStatus, errorThrown) {
			  	alert('error ' + errorThrown);
			  }
		
		
	});

}




