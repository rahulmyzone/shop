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
<span class="leftnavOverlay"></span>
<section class="inner-page-banner" style="background:url('<c:url value="/resources/templates/prettydeal/img/about-bg.png" />') center; background-size:cover;position: relative; z-index: 0;">
  <div class="container">
    <div class="page-title text-center"> 
    <h1 class="text-uppercase">About us</h1>
    </div>
    </div>

</section>
<div class="container text-center-xs">
			<ol class="breadcrumb flat">
				<li><a href="#">Home</a></li>
				<li class="active">About us</li>
			</ol>
		</div>


<!-- ======== About us ======== -->

<section class="section inner-page-section wow fadeInUp">
  <div class="container">
    <div class="row"> 
     <div class="col-md-12"> 
  <h3 class="inner-page-title"><span>What we are</span></h3>
  <p>
  PrettyDeal is that platform which will bring forth the best of deals that your tricity has in store for you but you simply miss out. Beware you might be spending higher for something that you can avail for much less. Encompassing the most favorite junctions, best hang out places, lavish outlets; we club what's most appealing and can create best experiences for our customers in the tricity. Binge into your favorite cuisine at an exclusive food outlet, pamper yourself at the most sorted and luxurious spa, be a fitness freak and join the topmost available gym in the city, check into the leading salons for that ideal and perfect look and much more to emphasis the interests and tastes of varied customers in the TriCity. We at PrettyDeals make sure that the Tricity customers are obliged with the most premier and incomparable deals and offer that can bring about that special smile on their faces. 
  </p>
  <p>We believe in providing the customers with deals that are best suited as per their demands and wishes. We ensure that they pay less for more services and experiences. We assure our deals would be something that you just canât resist to buy; rather, you will simply take on the site over and again for such classy and exclusive deals. Another important aspect we keep in mind are your interests, be it food, fitness, luxury, travel, entertainment. We have deals that would help you to avail the best of services, then be it a gym, restaurant, spa, salon, cinema halls, PVRs, we cover all. </p>
 <p>We are proud of the team that unites to assist you well. A team comprising of todayâs youth generation, we are splendid technologists, prominent marketers, expert Relationship Managers. Despite being from varied backgrounds, we make sure you enjoy your deal. We utilize our diversity in creating that "WOW" and magnificent aura for our customers.  We believe in spreading happiness and achieving the best for our customers. Our customerâs smile and satisfaction is the best reward that we can be endowed with.  </p>

<p>PrettyDeal is the best available option in the TriCity that you can rely on for those loved deals. Explore the site to avail the deal that you are looking for. In case you still need assistance, drop in your query to us at care@prettydeal.in and detail about what you are looking for. We would really appreciate your suggestions for our work and efforts.</p> 
  </div>
  </div>
      <%-- <div class="row"> 
      <div class="col-md-12 list-items"> 
      <h3>What is Lorem Ipsum? </h3>
      <ul class="list-unstyled">
        <li>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took</li>
        <li>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took Lorem Ipsum is simply dummy text of the printing</li>
        <li>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer tooke printing</li>
        <li>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took Lorem Ipsum is simply dummy text of the printing</li>
        <li>Lorem Ipsum is simply dummy text of the printing Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took</li>
        <li>Lorem Ipsum is simply dummy text of the printing Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took</li>
        <li>Lorem Ipsum is simply dummy text of the printing Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took</li>
        <li>Lorem Ipsum is simply dummy text of the printing Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took ever since the 1500s, when an unknown printer took</li>
      </ul>      
    
</div>
</div> --%>
  </div>
</section>

<!-- ===== About us end ======= -->


<!-- ======== Our Partners ======== -->

<section class="section our-partners wow fadeInUp p-t-50">
  <div class="container">
    <div class="row"> 
  <h3 class="section-title"><span>Our Partners</span></h3>
  <div class="owl-carousel partners-owl-carousel custom-carousel owl-theme outer-top-xs">
    <div class="item item-carousel">
      <div class="partners">
          <img src='<c:url value="/resources/templates/prettydeal/img/partners1.png" />' alt="" class="img-responsive">
        </div>
    </div>
    <!-- /.item -->
     <div class="item item-carousel">
      <div class="partners">
          <img src='<c:url value="/resources/templates/prettydeal/img/partners2.png" />' alt="" class="img-responsive">
        </div>
    </div>
    <!-- /.item -->
     <div class="item item-carousel">
      <div class="partners">
          <img src='<c:url value="/resources/templates/prettydeal/img/partners3.png" />' alt="" class="img-responsive">
        </div>
    </div>
    <!-- /.item -->
     <div class="item item-carousel">
      <div class="partners">
          <img src='<c:url value="/resources/templates/prettydeal/img/partners4.png" />' alt="" class="img-responsive">
        </div>
    </div>
    <!-- /.item -->
     <div class="item item-carousel">
      <div class="partners">
          <img src='<c:url value="/resources/templates/prettydeal/img/partners5.png" />' alt="" class="img-responsive">
        </div>
    </div>
    <!-- /.item -->
     <div class="item item-carousel">
      <div class="partners">
          <img src='<c:url value="/resources/templates/prettydeal/img/partners1.png" />' alt="" class="img-responsive">
        </div>
    </div>
    <!-- /.item -->
    

   
    
  </div>
  </div>
  </div>
</section>