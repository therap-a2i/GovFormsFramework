<%--
	Copyright (C) 2011 Therap (BD) Ltd.
	
	This code is free software: you can redistribute it and/or modify it
	under the terms of the GNU Lesser General Public License as published
	by the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.
	
	This code is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
	GNU Lesser General Public License for more details.
	
	You should have received a copy of the GNU Lesser General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/lgpl-3.0.html>.
--%>
<%--
    Author: Asif Ali
    Email: asif@therapbd.com
    Company: Therap (BD) Ltd.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title><fmt:message key="label.changePassword"/></title>

    <script>
        $(document).ready(function() {
            $("#form1").validate();
        });
    </script>
</head>

<body>

<c:url var="changePassUrl" value="/userMgt/${formAction}.htm"/>
<form:form modelAttribute="userCmd" method="POST" action="${changePassUrl}" id="form1">
    <div>
        <form:errors cssClass="error"/>
    </div>

    <div class="label">
        <form:label path="oldPassword"><fmt:message key="change.password.current.password"/></form:label>
        <span class="required">*</span>
    </div>
    <div class="field">
        <form:password path="oldPassword" cssClass="required"/>
        <form:errors path="oldPassword" cssClass="error"/>
    </div>
    <div class="clear"></div>

    <div class="label">
        <form:label path="password"><fmt:message key="change.password.new.password"/></form:label>
        <span class="required">*</span>
    </div>
    <div class="field">
        <form:password path="password" cssClass="required"/>
        <form:errors path="password" cssClass="error"/>
    </div>
    <div class="clear"></div>

    <div class="label">
        <form:label path="confirmPassword"><fmt:message key="change.password.confirm.new.password"/></form:label>
        <span class="required">*</span>
    </div>
    <div class="field">
        <form:password path="confirmPassword" cssClass="required"/>
        <form:errors path="confirmPassword" cssClass="error"/>
    </div>
    <div class="clear"></div>

    <div class="buttonDiv">
        <input type="submit" value="<fmt:message key="label.changePassword"/>"/>
    </div>

</form:form>
</body>
</html>
