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

                
          <div class="control-group">
            <label class="control-label"><s:message code="label.payment.atom.useAtom" text="Use Atom Payment" /></label>
            <div class="controls">
               <jsp:include page="/pages/shop/common/checkout/selectedPayment.jsp" />
            </div>
          </div>
          
         <%-- <div class="control-group">
         	<s:message code="label.checkout.atom" text="Please make your check or money order payable to:"/><br/>
			<c:out value="${requestScope.paymentMethod.informations.integrationKeys['address']}" escapeXml="false"/>
         </div> --%>