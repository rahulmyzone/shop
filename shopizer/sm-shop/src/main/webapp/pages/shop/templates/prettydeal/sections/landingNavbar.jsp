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
<%@ taglib uri="/WEB-INF/shopizer-functions.tld" prefix="display" %> 

<!-- TT Typeahead js files -->
<%-- <script src="<c:url value="/resources/js/hogan.js" />"></script> --%>


<%-- <script type="text/javascript">

$(document).ready(function() { 

	$('#searchField').typeahead({
		name: 'shopizer-search',
		<c:if test="${requestScope.CONFIGS['useDefaultSearchConfig'][requestScope.LANGUAGE.code]==true}">
		  <c:if test="${requestScope.CONFIGS['defaultSearchConfigPath'][requestScope.LANGUAGE.code]!=null}">
		prefetch: '<c:out value="${requestScope.CONFIGS['defaultSearchConfigPath'][requestScope.LANGUAGE.code]}"/>',
		  </c:if>
	    </c:if>


	    remote: {
    		url: '<c:url value="/services/public/search/${requestScope.MERCHANT_STORE.code}/${requestScope.LANGUAGE.code}/autocomplete.html"/>?q=%QUERY',
        	filter: function (parsedResponse) {
            	// parsedResponse is the array returned from your backend
            	console.log(parsedResponse);

            	// do whatever processing you need here
            	return parsedResponse;
        	}
    	},
		template: [
		'<p class="name">{{name}}</p>',
		'<p class="description">{{description}}</p>'
		].join(''),
		engine: Hogan
		});
	
	
	

});

</script> --%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%-- <c:set var="req" value="${request}" />
 



            <!-- Start Navbar-->
            <div id="storeBar" class="row-fluid">

				<div class="span4 pull-left">
						<nav class="logo">
							 <c:choose>
	                		<c:when test="${not empty requestScope.MERCHANT_STORE.storeLogo}">
	                			<img class="logoImage" src="<sm:storeLogo/>"/>
	                		</c:when>
	                		<c:otherwise>
	                			<h1>
	                			<a href="<c:url value="/shop/"/>">
	                				<c:out value="${requestScope.MERCHANT_STORE.storename}"/>
	                			</a>  
	                			</h1>
	                		</c:otherwise>
	                	  </c:choose>  
						</nav>
				</div>
				<div class="span8 pull-right">

						<nav id="menu" class="pull-right">
                    					<ul id="mainMenu">
                    						<!-- request contains url and url contains /shop -->
											<li class="">  
	                    					       <a href="<c:url value="/shop"/>" class="current">          
	                    					            <span class="name"><s:message code="menu.home" text="Home"/></span>     
	                    								<span class="desc"><s:message code="menu.home" text="Home"/></span>                                  
	                    						   </a>                         
	                    					</li>
	
	                    		            
	                    		            <c:forEach items="${requestScope.TOP_CATEGORIES}" var="category">
	    										<li class="">
	    											<a href="<c:url value="/shop/category/${category.description.friendlyUrl}.html"/><sm:breadcrumbParam categoryId="${category.id}"/>" class="current"> 
	    												<span class="name">${category.description.name}</span>
	    												<span class="desc">${category.description.highlights}</span> 
	    											</a>
	    										</li> 
											</c:forEach>
                    		            </ul>
                    		            
                    		            <div id="searchGroup" class="btn-group pull-right">
											<form id="searchForm" class="form-inline" method="post" action="<c:url value="/shop/search/search.html"/>">
												<input id="searchField" class="tt-query" name="q" type="text" placeholder="<s:message code="label.search.searchQuery" text="Search query" />" autocomplete="off" spellcheck="false" dir="auto" value="<c:out value="${q}"/>">
												<button id="searchButton" class="btn" type="submit"><s:message code="label.generic.search" text="Search" /></button>
											</form>
										</div>
                    		            
                    		            
						</nav>


				</div>
            </div> --%>

			<!-- End Navbar-->
			
<span class="leftnavOverlay"></span>
<section id="top-banner-and-menu">
  <div class="container-fluid">
    <div class="row">
      <div id="mainslider" class="owl-carousel" >
        <div class="item" style="background-image:url(/resources/templates/prettydeal/img/home-banner.png);">
          <div class="container">
            <div class="caption bg-color vertical-center text-center">
              <div class="slider-header fadeInDown-1">PRETTY & COMFORTABLE</div>
              <div class="big-text fadeInDown-1"> Minimum 50% Off On 1 buy 1 </div>
              <div class="button-holder fadeInDown-3"> <a href="index.php?page=single-product" class="text-uppercase shop-now-button btn-outline hvr-sweep-to-right">Grab it Now</a> </div>
            </div>
          </div>
        </div>
        <div class="item" style="background-image:url(/resources/templates/prettydeal/img/home-banner.png);">
          <div class="container">
            <div class="caption bg-color vertical-center text-center">
              <div class="slider-header fadeInDown-1">PRETTY & COMFORTABLE</div>
              <div class="big-text fadeInDown-1"> Minimum 50% Off On Hotels </div>
              <div class="button-holder fadeInDown-3"> <a href="index.php?page=single-product" class="text-uppercase shop-now-button btn-outline hvr-sweep-to-right">Grab it Now</a> </div>
            </div>
          </div>
        </div>
        <div class="item" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/home-banner.png" />);">
          <div class="container">
            <div class="caption bg-color vertical-center text-center">
              <div class="slider-header fadeInDown-1">PRETTY & COMFORTABLE</div>
              <div class="big-text fadeInDown-1"> Minimum 40% Off On Hotels </div>
              <div class="button-holder fadeInDown-3"> <a href="index.php?page=single-product" class="text-uppercase shop-now-button btn-outline hvr-sweep-to-right">Grab it Now</a> </div>
            </div>
          </div>
        </div>
        <div class="item" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/home-banner.png" />);">
          <div class="container">
            <div class="caption bg-color vertical-center text-center">
              <div class="slider-header fadeInDown-1">PRETTY & COMFORTABLE</div>
              <div class="big-text fadeInDown-1"> Minimum 30% Off On Hotels </div>
              <div class="button-holder fadeInDown-3"> <a href="index.php?page=single-product" class="text-uppercase shop-now-button btn-outline hvr-sweep-to-right">Grab it Now</a> </div>
            </div>
          </div>
        </div>
      </div>
      <div class="container">
        <div id="mainslider1" class="owl-carousel">
          <div class="item"><span>1 buy 1</span></div>
          <div class="item"><span>50%off</span></div>
          <div class="item"><span>40%off</span></div>
          <div class="item"><span>30%off</span></div>
        </div>
      </div>
    </div>
  </div>
</section>

<section class="categorytabs p-t-50">
  <div class="container">
    <div class="row"> 
      <!-- Nav tabs -->
      
      <ul class="col-sm-3 nav nav-tabs text-uppercase responsive">
         <c:forEach items="${requestScope.cats}" var="cat" varStatus="s">
            <li>
            	<a href="<c:url value="/shop/category/${requestScope[cat].description.seUrl}.html"/><sm:breadcrumbParam categoryId="${requestScope[cat].id}"/>"><c:out value="${cat}"/></a>
            </li>
         </c:forEach>
      </ul>
      
      <!-- Tab panes -->
      <div class="col-sm-9 responsive">
      
          <div class="row">
            <div class="col-sm-5 col-md-4 category-product"> 
            <a href="">
              <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/iphone.png" />)"> 
              
              <div class="category-text">
                <h3>Pretty call</h3>
                <h2>25% Off</h2>
                <button>Check Offer</button>
              </div>
              </div>
              </a> </div> 
            <div class="col-sm-7 col-md-8 category-product category-big">
           <a href="">
                <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/peddler.png" />)"> 
           
                <div class="category-text">
                  <h3>Peddlers</h3>
                  <h2>Buffet for 2 at 340Rs</h2>
                  <button>Check Offer</button>
                </div>
               </div> </a>  </div>
      
          </div>
          <div class="row">
            <div class="col-sm-7 col-md-8 category-product category-big"> <a href="">
              <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/stay.png" />)"> 
              <div class="category-text">
                <h3>Pretty Stay</h3>
                <h2>25% Off</h2>
                <button>Check Offer</button>
              </div>
              </div>
              </a> </div>
            <div class="col-sm-5 col-md-4 category-product">
              <a href="">
                <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/paintball.png" />)">
                <div class="category-text">
                  <h3>Paintball</h3>
                  <h2>25% Off</h2>
                  <button>Check Offer</button>
                </div>
                </div>
                </a>
            </div>
          </div>
     
        
      </div>
    </div>
  </div>
</section>

<%-- <section class="categorytabs p-t-50">
  <div class="container">
    <div class="row"> 
      <!-- Nav tabs -->
      
      <ul class="col-sm-3 nav nav-tabs text-uppercase responsive" role="tablist">
        <li role="presentation" class="active"> 
        <a href="#gym-spa" aria-controls="gym-spa" role="tab" data-toggle="tab">GYMS & SPA</a></li>
        <li role="presentation"> 
        <a href="#Beauty-Wellness" aria-controls="Beauty-Wellness " role="tab" data-toggle="tab">Beauty & Wellness </a>
        </li>
        <li role="presentation"> 
        <a href="#Food-Drinks" aria-controls="Food-Drinks " role="tab" data-toggle="tab">food & drinks </a></li>
        <li role="presentation"> 
        <a href="#Entertainment" aria-controls="Entertainment  " role="tab" data-toggle="tab">Entertainment </a></li>
        <li role="presentation">
        <a href="#Fun" aria-controls="Fun" role="tab" data-toggle="tab">Fun</a></li>
        <li role="presentation"> 
        <a href="#Electronics" aria-controls="Electronics" role="tab" data-toggle="tab">Electronics</a></li>
        <li role="presentation"> 
        <a href="#hotels" aria-controls="hotels" role="tab" data-toggle="tab">hotels</a></li>
      </ul>
      
      <!-- Tab panes -->
      <div class="col-sm-9 tab-content responsive">
        <div role="tabpanel" class="tab-pane active" id="gym-spa">
          <div class="row">
            <div class="col-sm-5 col-md-4 category-product"> 
            <a href="">
              <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/iphone.png" />)"> 
              
              <div class="category-text">
                <h3>Pretty call</h3>
                <h2>25% Off</h2>
                <button>Check Offer</button>
              </div>
              </div>
              </a> </div> 
            <div class="col-sm-7 col-md-8 category-product category-big">
           <a href="">
                <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/peddler.png" />)"> 
           
                <div class="category-text">
                  <h3>Peddlers</h3>
                  <h2>Buffet for 2 at 340Rs</h2>
                  <button>Check Offer</button>
                </div>
               </div> </a>  </div>
      
          </div>
          <div class="row">
            <div class="col-sm-7 col-md-8 category-product category-big"> <a href="">
              <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/stay.png" />)"> 
              <div class="category-text">
                <h3>Pretty Stay</h3>
                <h2>25% Off</h2>
                <button>Check Offer</button>
              </div>
              </div>
              </a> </div>
            <div class="col-sm-5 col-md-4 category-product">
              <a href="">
                <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/paintball.png" />)">
                <div class="category-text">
                  <h3>Paintball</h3>
                  <h2>25% Off</h2>
                  <button>Check Offer</button>
                </div>
                </div>
                </a>
            </div>
          </div>
        </div>
        <div role="tabpanel" class="tab-pane" id="Beauty-Wellness">
        
          <div class="row">
            <div class="col-sm-7 col-md-8 category-product category-big"> <a href="">
              <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/stay.png" />)"> 
              <div class="category-text">
                <h3>Pretty Stay</h3>
                <h2>25% Off</h2>
                <button>Check Offer</button>
              </div>
              </div>
              </a> </div>
            <div class="col-sm-5 col-md-4 category-product">
              <a href="">
                <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/paintball.png" />)">
                <div class="category-text">
                  <h3>Paintball</h3>
                  <h2>25% Off</h2>
                  <button>Check Offer</button>
                </div>
                </div>
                </a>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-5 col-md-4 category-product"> 
            <a href="">
              <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/iphone.png" />)"> 
              
              <div class="category-text">
                <h3>Pretty call</h3>
                <h2>25% Off</h2>
                <button>Check Offer</button>
              </div>
              </div>
              </a> </div> 
            <div class="col-sm-7 col-md-8 category-product category-big">
           <a href="">
                <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/peddler.png" />)"> 
           
                <div class="category-text">
                  <h3>Peddlers</h3>
                  <h2>Buffet for 2 at 340Rs</h2>
                  <button>Check Offer</button>
                </div>
               </div> </a>  </div>
      
          </div>
        </div>
        <div role="tabpanel" class="tab-pane" id="Food-Drinks">
        <div class="row">
            <div class="col-sm-5 col-md-4 category-product"> 
            <a href="">
              <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/iphone.png" />)"> 
              
              <div class="category-text">
                <h3>Pretty call</h3>
                <h2>25% Off</h2>
                <button>Check Offer</button>
              </div>
              </div>
              </a> </div> 
            <div class="col-sm-7 col-md-8 category-product category-big">
           <a href="">
                <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/peddler.png" />)"> 
           
                <div class="category-text">
                  <h3>Peddlers</h3>
                  <h2>Buffet for 2 at 340Rs</h2>
                  <button>Check Offer</button>
                </div>
               </div> </a>  </div>
      
          </div>
          <div class="row">
            <div class="col-sm-7 col-md-8 category-product category-big"> <a href="">
              <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/stay.png" />)"> 
              <div class="category-text">
                <h3>Pretty Stay</h3>
                <h2>25% Off</h2>
                <button>Check Offer</button>
              </div>
              </div>
              </a> </div>
            <div class="col-sm-5 col-md-4 category-product">
              <a href="">
                <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/paintball.png" />)">
                <div class="category-text">
                  <h3>Paintball</h3>
                  <h2>25% Off</h2>
                  <button>Check Offer</button>
                </div>
                </div>
                </a>
            </div>
          </div>
          
        </div>
        <div role="tabpanel" class="tab-pane" id="Entertainment">
        
          <div class="row">
            <div class="col-sm-7 col-md-8 category-product category-big"> <a href="">
              <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/stay.png" />)"> 
              <div class="category-text">
                <h3>Pretty Stay</h3>
                <h2>25% Off</h2>
                <button>Check Offer</button>
              </div>
              </div>
              </a> </div>
            <div class="col-sm-5 col-md-4 category-product">
              <a href="">
                <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/paintball.png" />)">
                <div class="category-text">
                  <h3>Paintball</h3>
                  <h2>25% Off</h2>
                  <button>Check Offer</button>
                </div>
                </div>
                </a>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-5 col-md-4 category-product"> 
            <a href="">
              <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/iphone.png" />)"> 
              
              <div class="category-text">
                <h3>Pretty call</h3>
                <h2>25% Off</h2>
                <button>Check Offer</button>
              </div>
              </div>
              </a> </div> 
            <div class="col-sm-7 col-md-8 category-product category-big">
           <a href="">
                <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/peddler.png" />)"> 
           
                <div class="category-text">
                  <h3>Peddlers</h3>
                  <h2>Buffet for 2 at 340Rs</h2>
                  <button>Check Offer</button>
                </div>
               </div> </a>  </div>
      
          </div>
         </div>
        <div role="tabpanel" class="tab-pane" id="Fun">
        
        <div class="row">
            <div class="col-sm-5 col-md-4 category-product"> 
            <a href="">
              <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/iphone.png" />)"> 
              
              <div class="category-text">
                <h3>Pretty call</h3>
                <h2>25% Off</h2>
                <button>Check Offer</button>
              </div>
              </div>
              </a> </div> 
            <div class="col-sm-7 col-md-8 category-product category-big">
           <a href="">
                <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/peddler.png" />)"> 
           
                <div class="category-text">
                  <h3>Peddlers</h3>
                  <h2>Buffet for 2 at 340Rs</h2>
                  <button>Check Offer</button>
                </div>
               </div> </a>  </div>
      
          </div>
          <div class="row">
            <div class="col-sm-7 col-md-8 category-product category-big"> <a href="">
              <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/stay.png" />)"> 
              <div class="category-text">
                <h3>Pretty Stay</h3>
                <h2>25% Off</h2>
                <button>Check Offer</button>
              </div>
              </div>
              </a> </div>
            <div class="col-sm-5 col-md-4 category-product">
              <a href="">
                <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/paintball.png" />)">
                <div class="category-text">
                  <h3>Paintball</h3>
                  <h2>25% Off</h2>
                  <button>Check Offer</button>
                </div>
                </div>
                </a>
            </div>
          </div>
          
        </div>
        <div role="tabpanel" class="tab-pane" id="Electronics">
        <div class="row">
            <div class="col-sm-5 col-md-4 category-product"> 
            <a href="">
              <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/iphone.png" />)"> 
              
              <div class="category-text">
                <h3>Pretty call</h3>
                <h2>25% Off</h2>
                <button>Check Offer</button>
              </div>
              </div>
              </a> </div> 
            <div class="col-sm-7 col-md-8 category-product category-big">
           <a href="">
                <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/peddler.png" />)"> 
           
                <div class="category-text">
                  <h3>Peddlers</h3>
                  <h2>Buffet for 2 at 340Rs</h2>
                  <button>Check Offer</button>
                </div>
               </div> </a>  </div>
      
          </div>
          <div class="row">
            <div class="col-sm-7 col-md-8 category-product category-big"> <a href="">
              <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/stay.png" />)"> 
              <div class="category-text">
                <h3>Pretty Stay</h3>
                <h2>25% Off</h2>
                <button>Check Offer</button>
              </div>
              </div>
              </a> </div>
            <div class="col-sm-5 col-md-4 category-product">
              <a href="">
                <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/paintball.png" />)">
                <div class="category-text">
                  <h3>Paintball</h3>
                  <h2>25% Off</h2>
                  <button>Check Offer</button>
                </div>
                </div>
                </a>
            </div>
          </div>
          </div>
        <div role="tabpanel" class="tab-pane" id="hotels">
        
          <div class="row">
            <div class="col-sm-7 col-md-8 category-product category-big"> <a href="">
              <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/stay.png" />)"> 
              <div class="category-text">
                <h3>Pretty Stay</h3>
                <h2>25% Off</h2>
                <button>Check Offer</button>
              </div>
              </div>
              </a> </div>
            <div class="col-sm-5 col-md-4 category-product">
              <a href="">
                <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/paintball.png" />)">
                <div class="category-text">
                  <h3>Paintball</h3>
                  <h2>25% Off</h2>
                  <button>Check Offer</button>
                </div>
                </div>
                </a>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-5 col-md-4 category-product"> 
            <a href="">
              <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/iphone.png" />)"> 
              
              <div class="category-text">
                <h3>Pretty call</h3>
                <h2>25% Off</h2>
                <button>Check Offer</button>
              </div>
              </div>
              </a> </div> 
            <div class="col-sm-7 col-md-8 category-product category-big">
           <a href="">
                <div class="category-image" style="background-image:url(<c:url value="/resources/templates/prettydeal/img/peddler.png" />)"> 
           
                <div class="category-text">
                  <h3>Peddlers</h3>
                  <h2>Buffet for 2 at 340Rs</h2>
                  <button>Check Offer</button>
                </div>
               </div> </a>  </div>
      
          </div>
        </div>
      </div>
    </div>
  </div>
</section> --%>