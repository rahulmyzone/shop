$.fn.ForceNumericOnly =
function()
{
    return this.each(function()
    {
        $(this).keydown(function(e)
        {
            var key = e.charCode || e.keyCode || 0;
            // allow backspace, tab, delete, enter, arrows, numbers and keypad numbers ONLY
            // home, end, period, and numpad decimal
            return (
                key == 8 || 
                key == 9 ||
                key == 13 ||
                key == 46 ||
                key == 110 ||
                key == 190 ||
                (key >= 35 && key <= 40) ||
                (key >= 48 && key <= 57) ||
                (key >= 96 && key <= 105));
        });
    });
};
var trace = 1;


function validateEmail($email) {
	  var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
	  if ( $email.length > 0 && emailReg.test($email)) {
	    return true;
	  } else {
	    return false;
	  }
}

function emptyString($value) {
	return !$value || !/[^\s]+/.test($value);
}

function log(value) {
	if(trace==1) {
		//console.log(value);
	}
}

function loadProducts(url,divProductsContainer) {
	$(divProductsContainer).showLoading();

	$.ajax({
			type: 'POST',
			dataType: "json",
			url: url,
			success: function(productList) {

				buildProductsList(productList,divProductsContainer);
				callBackLoadProducts(productList);
				$(divProductsContainer).hideLoading();

			},
			error: function(jqXHR,textStatus,errorThrown) { 
				$(divProductsContainer).hideLoading();
				alert('Error ' + jqXHR + "-" + textStatus + "-" + errorThrown);
			}
			
	});
	
	
}


function searchProducts(url,divProductsContainer,q,filter) {
	
	$(divProductsContainer).showLoading();
	
	if(q==null || q=='') {
		return;
	}

    //category facets
	var facets = '\"facets\" : { \"categories\" : { \"terms\" : {\"field\" : \"categories\"}}}';
    var highlights = null;
	var queryStart = '{';

	var query = '\"query\":{\"query_string\" : {\"fields\" : [\"name^3\", \"description\", \"tags\"], \"query\" : \"*' + q + '*", \"use_dis_max\" : true }}';
	if(filter!=null && filter!='') {
		//query = '\"query\":{\"filtered\":{\"query\":{\"text\":{\"_all\":\"' + q + '\"}},' + filter + '}}';
		query = query + ',' + filter + '}}';
	}

	if(facets!=null && facets!='') {
		query = query + ',' + facets;
	}

	var queryEnd = '}';
	
	query = queryStart + query + queryEnd;

	$.ajax({
  			cache: false,
  			type:"POST",
  			dataType:"json",
  			url:url,
  			data:query,
  			contentType:"application/json;charset=UTF-8",
			success: function(productList) {

				buildProductsList(productList,divProductsContainer, null);
				callBackSearchProducts(productList);


			},
			error: function(jqXHR,textStatus,errorThrown) { 
				$(divProductsContainer).hideLoading();
				alert('Error ' + jqXHR + "-" + textStatus + "-" + errorThrown);
			}
			
	});
	
	
	
}

