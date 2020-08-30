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
<section class="inner-page-banner" style="background:url('<c:url value="/resources/templates/prettydeal/img/terms_of_use.jpg" />') center; background-size:cover;position: relative; z-index: 0;">
  <div class="container">
    <div class="page-title text-center"> 
    <h1 class="text-uppercase">Terms of use</h1>
    <p>Please review our terms of use</p>
    </div>
    </div>

</section>
<div class="container text-center-xs">
			<ol class="breadcrumb flat">
				<li><a href="/">Home</a></li>
				<li class="active">Terms</li>
			</ol>
		</div>


<!-- ======== terms ======== -->

<section class="section inner-page-section wow fadeInUp">
  <div class="container">
    <div class="row"> 
     <div class="col-md-12 terms-page"> 
    <h2>ACCEPTANCE OF TERMS OF USE</h2>
     <p>
     The Terms of Use administer the use of services and content provided by the site “prettydeal.in”. In order to use the site, you need to make sure you agree to abide by the Terms of Use. You acknowledge that you are legally eligible to avail the services of the site. You have read and understood the Terms and Conditions of the site. You are required to abide by the User Agreement. If you don’t want to, you will not be entitled to carry any sort of sale/purchase transaction through the site. Prettydeal holds the right to change/update the Terms and Conditions as and when required. You need to keep a check of the Terms of Use from time to time.
     </p>     
        <div class="terms-title">
        	<h2>DEFINITIONS</h2>
        </div>
		<p>
			<ul>
				<li>
					Deal- these are the services/products offered through the website, prettydeal.in
				</li>
				<li>
					Products- the goods and services provided on the site and are available for sale/use. 
				</li>
				<li>
					Site – signifies prettydeal.in
				</li>
				<li>
					User- signifies or relates to end customers that access the site and avail the services offered by it. 
				</li>
				<li>
					Merchant- relates to the legally eligible person that can sell their product or service through the website. 
				</li>
				<li>
					Voucher- it carries the specific/unique code that helps a user avail the discount on particular products/services offered by the merchant on the website.
				</li>
			</ul>
		</p>
		        
        <div class="terms-title">
        	<h2>REGISTRATION</h2>
        </div>
		<p>It is mandatory for a user to register on the site. It is the responsibility of the user to ensure their user ID and password is safe and secure. The user is responsible for all the transactions that are initiated from their user account. In case of any concern, related to fraud transactions from the user account, the user is advised to notify prettydeal.in immediately. The user must make sure that the information provided regarding the incident is authentic and true. 
The site holds certain personal information provided by the user, including the full name, phone number, e-mail address etc. This information is only used by prettydeal.in to serve the customer in a better manner and to provide them with necessary details regarding the products or services on the website. </p>        
         <div class="terms-title">
        	<h2>USER’S OBLIGATIONS</h2>
        </div>
		<p>The users are required to read the terms and conditions in detail, understand them and accept them. The users are obligated to provide authentic and complete information about them to prettydeal.in. The user should also not misinterpret the facts. It is the duty of the user to make sure they don’t carry out any activity which is not in public interest. Fraud activities or stealing an individual’s identity and misusing it, is offensive and punishable by law. The site is not supposed to be used to carry out any sort of illegal or fraudulent activities. Any content, video or text posted that violates the terms of the site, will immediately be taken down and required action will be taken against the culprit. The site will not entertain any kind of illegal or unethical behavior.</p>
		        
         <div class="terms-title">
        	<h2>Sensitive personal information</h2>
        </div>
        <p>
        	The following details collected from the user are simply to help them provide an easy access to the website:
        	<ul>
        	<li>
        		User’s full name
        	</li>
        	<li>
        		E-mail address and site password
        	</li>
        	<li>
        		User’s contact number
        	</li>
        	<li>
        		Net banking/credit card/debit card details (when a deal is purchased from the site) 
        	</li>
        	</ul>
			The site gets an access to above provided information when a user:
			<ul>
				<li>
					Visits the site
				</li>
				<li>
					Open or respond to emails
				</li>
				<li>
					Purchase deals from the site
				</li>
				<li>
					Use the vouchers provided by the site
				</li>
			</ul>
        </p>
        
         <div class="terms-title">
        	<h2>USE OF INFORMATION</h2>
        </div>
        <p>
        	<ul>
        		<li>
        			This information provided by the site is used to inform the user regarding the latest offers and deals updated on the site. 
        		</li>
        		<li>
        			Notify the user about updated/new policies. 
        		</li>
        		<li>
        			For processing the orders. 
        		</li>
        		<li>
        			To assist the user through queries and doubts. 
        		</li>
        		<li>
        			To create a means of communication with the user in order to provide additional information related to the site. 
        		</li>
        		<li>
        			To attain a better know-how about the user, their interests and preferences. 
        		</li>
        	</ul>
        </p>
        
         <div class="terms-title">
        	<h2>SECURITY OF PERSONAL INFORMATION</h2>
        </div>
        <p>
        	We understand the safety of user’s information. The information provided by the user is held the site alone. It is only the site that has an access to the provided information. Moreover, the information is not passed to anyone or any third party. The information will solely be used to communicate with the user in context with the query or doubt raised by them. The information will not be shared with third party, until and unless required and that too with the consent of the user. 
        </p>
        
         <div class="terms-title">
        	<h2>DISCLOSURE OF INFORMATION</h2>
        </div>
        <p>
        	<ul>
        		<li>
        			Prettydeal.in makes sure that the information provided by the user is kept safe and private. The site ensures that the information is not misused by any means. However, there might be a few reasons to disclose the information and they are:
        		</li>
        		<li>
        			With the trusted merchants or participating outlets so that user can be updated regarding the offers and services. 
        		</li>
        		<li>
        			To meet contractual obligations. 
        		</li>
        		<li>
        			With the concerned merchant for receiving due payments.
        		</li>
        	</ul> 
        </p>
        
 	</div>
    </div>
  </div>
</section>