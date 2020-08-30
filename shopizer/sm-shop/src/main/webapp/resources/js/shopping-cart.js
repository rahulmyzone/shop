
 

	$(function(){
		initBindings();
		initMiniCart();
		initCartBinding();

	});
	
	function initCartBinding(){
		$('#checkoutButton').click(function(e) {
			$.ajax({
				  type:'get',
				  url: getContextPath() + '/shop/cart/gotoCart.html',
				  contentType: 'application/x-www-form-urlencoded; charset=utf-8',
				   error: function(xhr) { 
							if(xhr.status==401) {
								
							}
							 
						 },
				  success: function(customer) {
							 var t = JSON.parse(customer);
							 if(t.response.status == 0 && t.response.gotoCart == 1){
								$("#signinDrop").click();
							 }else if(t.response.status == 0){
								 location.href=t.response.redirectUrl;
							 }
						} 
				})
			});
	}
	
	function initMiniCart() {
		var cartCode = getCartCode();
		log('Check for cart code ' + cartCode);
		if(cartCode!=null) {
			displayMiniCartSummary(cartCode);
		}
		
	}
	
	function removeCart() {
		
		var cartCode = getCartCode();
		if(cartCode!=null) {
			emptyCartLabel();
			$.cookie('cart',null, { expires: 1, path:'/' });
		}
		
	}
	
	function initBindings() {
		
		/** add to cart **/
		$(".addToCart").click(function(e){
			e.preventDefault();
			addToCart($(this).attr("productId"));
			flyCart($(this).parent().parent());
	    });
		
		
    	$("#open-cart").click(function(e) {
    		displayMiniCart();
    	});
		
	}
	
	/**
	 * Function used for adding a product to the Shopping Cart
	 */
	function addToCart(sku) {
		var qty = '#qty-productId-'+ sku;
		var quantity = $(qty).val();
		if(!quantity || quantity==null || quantity==0) {
			quantity = 1;
		}

		var formId = '#input-' + sku;
		var $inputs = $(formId).find(':input');
		
		var values = new Array();
		if($inputs.length>0) {//check for attributes
			i = 0;
			$inputs.each(function() { //attributes
				if($(this).hasClass('attribute')) {
			        if($(this).is(':checkbox')) {
			        	var checkboxSelected = $(this).is(':checked');
			        	if(checkboxSelected==true) {
							values[i] = $(this).val();
							i++;
						}
			        	
					} else if ($(this).is(':radio')) {
						var radioChecked = $(this).is(':checked');
						if(radioChecked==true) {
							values[i] = $(this).val(); 
							i++;
						}
					} else {
					   if($(this).val()) {
					       values[i] = $(this).val(); 
					       i++;
				       }
					}
				}
			});
		}

		var cartCode = getCartCode();

		
		/**
		 * shopping cart code identifier is <cart>_<storeId>
		 * need to check if the cookie is for the appropriate store
		 */
		
		//cart item
		var prefix = "{";
		var suffix = "}";
		var shoppingCartItem = '';

		if(cartCode!=null && cartCode != '') {
			shoppingCartItem = '"code":' + '"' + cartCode + '"'+',';
		}
		var shoppingCartItem = shoppingCartItem + '"quantity":' + quantity + ',';
		var shoppingCartItem = shoppingCartItem + '"productId":' + sku;
		
		
		var attributes = null;
		//cart attributes
		if(values.length>0) {
			attributes = '[';
			for (var i = 0; i < values.length; i++) {
				var shoppingAttribute= prefix + '"attributeId":' + values[i] + suffix ;
				if(values.length>1 && i < values.length-1){
					shoppingAttribute = shoppingAttribute + ',';
				}
				attributes = attributes + shoppingAttribute;
			}
			attributes = attributes + ']';
		}
		
		if(attributes!=null) {
			shoppingCartItem = shoppingCartItem + ',"shoppingCartAttributes":' + attributes;
		}
		
		var scItem = prefix + shoppingCartItem + suffix;

		/** debug add to cart **/
		//console.log(scItem);

		
		$.ajax({  
			 type: 'POST',  
			 url: getContextPath() + '/shop/cart/addShoppingCartItem.html',  
			 data: scItem, 
			 contentType: 'application/json;charset=utf-8',
			 dataType: 'json', 
			 cache:false,
			 error: function(e) { 
				alert('Error while adding to cart');
				//$('#pageContainer').hideLoading();
				 
			 },
			 success: function(cart) {

			     saveCart(cart.code);
			     
			     if(cart.message!=null) { 
			    	 //TODO error message
			    	 alert('Error while adding to cart ' + cart.message);
			     }
				 
				 displayShoppigCartItems(cart,'#cart-box');
				 displayTotals(cart);
				 //$('#pageContainer').hideLoading();
				 //flyCart(sku);
			 } 
		});
		
	}
	
function flyCart(product){
	var cart = $('#miniCart');
    var imgtodrag = $(product).find("img");
    var height = $(imgtodrag).height();
    var width = $(imgtodrag).width();
    if (imgtodrag) {
        var imgclone = imgtodrag.clone()
            .offset({
            top: imgtodrag.offset().top,
            left: imgtodrag.offset().left
        })
            .css({
            	'opacity': '0.5',
                'position': 'absolute',
                'height': height+'px',
                'width': width+'px',
                'z-index': '100'
        })
            .appendTo($('body'))
            .animate({
            	'top': cart.offset().top + 10,
                'left': cart.offset().left + 10,
                'width': 75,
                'height': 75
        }, 1000, 'easeInOutExpo');

        setTimeout(function () {
            cart.effect("highlight", {
                times: 2
            }, 500);
        }, 1000);

        imgclone.animate({
            	'width': 0,
                'height': 0
        }, function () {
            $(this).detach()
        });
    }
}
	
function removeLineItem(lineItemId){
	$( "#shoppingCartRemoveLineitem_"+lineItemId).submit();		
}

function updateLineItem(lineItemId,actionURL){
	$("#shoppingCartLineitem_"+lineItemId).attr('action', actionURL);
	$( "#shoppingCartLineitem_"+lineItemId).submit();	
}

//update full cart
function updateCart(cartDiv) {
	$('.alert-error').hide();
	$('.quantity').removeClass('required');
	$('#mainCartTable').showLoading();
	var inputs = $(cartDiv).find('.quantity');
	var cartCode = getCartCode();
	if(inputs !=null && cartCode!=null) {
		var items = new Array();
		for(var i = 0; i< inputs.length; i++) {
			var item = new Object();
			var qty = inputs[i].value;
			if(qty =='' || qty<1) {
				$('#' + inputs[i].id).addClass('required');
				$('#mainCartTable').hideLoading();
				return;
			}
			var id = inputs[i].id;

			item.id = id;
			item.quantity = qty;
			item.code=cartCode;
			items[i] = item;
		}
		//update cart
		json_data = JSON.stringify(items);

		$.ajax({  
			 type: 'POST',  
			 url: getContextPath() + '/shop/cart/updateShoppingCartItem.html',
			 data: json_data,
			 contentType: 'application/json;charset=utf-8',
			 dataType: 'json', 
			 cache:false,
			 error: function(e) { 
				 console.log('error ' + e);
				 $('#mainCartTable').hideLoading();
			 },
			 success: function(response) {
				 $('#mainCartTable').hideLoading();
				 if(response.response.status==-1) {
					 $('.alert-error').show();
				 } else {
					 location.href= getContextPath() + '/shop/cart/shoppingCart.html';
				 }
			} 
		});
		
	}	
}

function displayMiniCart(){
	var cartCode = getCartCode();
	
	log('Display cart content');
	$('#shoppingcartProducts').html('');
	///$('#cart-box').addClass('loading-indicator-overlay');/** manage manually cart loading**/
	$('#shoppingcart').showLoading();

	$.ajax({  
		 type: 'GET',  
		 url: getContextPath() + '/shop/cart/displayMiniCartByCode.html?shoppingCartCode='+cartCode,  
		 cache:false,
		 error: function(e) { 
			// $('#cart-box').removeClass('loading-indicator-overlay');/** manage manually cart loading**/
			 $('#shoppingcart').hideLoading();
			 //nothing
			 
		 },
		 success: function(miniCart) {
			 //if($.isEmptyObject(miniCart)){
			 if(miniCart.code=null) {
				 emptyCartLabel();
			 }
			 else{
				 displayShoppigCartItems(miniCart,'#cart-box');//cart content
				 displayTotals(miniCart);//header
			 }
			 $('#shoppingcart').hideLoading();
			 $("#cart-total").show();
		} 
	});
}



 /**
  * JS function responsible for removing give line item from
  * the Cart.
  * For more details see MiniCartController.
  * 
  * Controller will return JSON as response and it will be parsed to update
  * mini-cart section.
  * @param lineItemId
  */
function removeItemFromMinicart(e,lineItemId){
	e.preventDefault();
	shoppingCartCode = getCartCode();
	$('#shoppingcart').showLoading();
	$.ajax({  
		 type: 'GET',
		 cache:false,
		 url: getContextPath() + '/shop/cart/removeMiniShoppingCartItem.html?lineItemId='+lineItemId + '&shoppingCartCode=' + shoppingCartCode,  
		 error: function(e) { 
			 console.log('error ' + e);
			 $('#shoppingcart').hideLoading();
		 },
		 success: function(miniCart) {
			 if(miniCart == ''){
				 location.href = "/";
			 }
			 if(miniCart==null || miniCart=='') {
				 emptyCartLabel();
			 } else {
				 if(miniCart.shoppingCartItems!=null) {
					 displayShoppigCartItems(miniCart,'#cart-box');
					 displayTotals(miniCart);
				 } else {
					 emptyCartLabel();
				 }
			 }
			 $('#shoppingcart').hideLoading();
		} 
	});
}

function displayMiniCartSummary(code){
	$.ajax({  
		 type: 'GET',  
		 url: getContextPath() + '/shop/cart/displayMiniCartByCode.html?shoppingCartCode='+code,  
		 error: function(e) { 
			// do nothing
			console('error while getting cart');
			 
		 },
		 success: function(cart) {
			 if(cart==null || cart=='') {
					emptyCartLabel();
					$.cookie('cart',null, { expires: 1, path:'/' });
			 } else {
				 displayTotals(cart);
			 }
		} 
	});
}





function viewShoppingCartPage(){
	window.location.href=getContextPath() + '/shop/cart/shoppingCart.html';
	
}

 
function displayShoppigCartItems(cart, div) {
	
	 
	//set cart contextPath
	cart.contextPath=getContextPath(); 
	var template = Hogan.compile(document.getElementById("miniShoppingCartTemplate").innerHTML);
	
    
	 $(div).html('');
	 if(cart.shoppingCartItems==null) {
		 emptyCartLabel();
		 return;
	 }
	 
	 $('#cartMessage').hide();
	 $('#shoppingcart').show();
	 //call template defined in template directory
	 $(div).append(template.render(cart));


}

function displayTotals(cart) {
	if(cart.quantity==0) {
		emptyCartLabel();
	} else {
		cartInfoLabel(cart);
		$("#cart-discount").hide();
		$("#cart-voucher").hide();
		if(cart.promotionApplied == true){
			$("#cart-discount").show();
			$("#cart-voucher").show();
			//$("#voucher").html(cartVoucher(cart));
			//$("#discount").html(cartDiscount(cart));
		}
		$('#total-box').html(cartSubTotal(cart));
	}


}

function emptyCartLabel(){
	log('Display empty cart');
	$("#cartMessage").html(getEmptyCartLabel());
	//var labelItem = getItemLabel(0);
	$("#cartinfo").html('');
	$('#shoppingcart').hide();
	$('#cartMessage').show();
}


/** returns the cart code **/
function getCartCode() {
	
	var cart = $.cookie('cart'); //should be [storecode_cartid]
	var code = new Array();
	
	if(cart!=null) {
		code = cart.split('_');
		if(code[0]==getMerchantStoreCode()) {
			return code[1];
		}
	}
}

function buildCartCode(code) {
	var cartCode = getMerchantStoreCode() + '_' + code;
	return cartCode;
}

function saveCart(code) {
	var cartCode = buildCartCode(code);
	$.cookie('cart',cartCode, { expires: 1024, path:'/' });
}


