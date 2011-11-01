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
    <title><fmt:message key="title.userForm"/></title>

    <script type="text/javascript">
        $(document).ready(function() {
            <c:if test="${userCmd.sysId != null}">
                $("#form1").validate();
            </c:if>
            <c:if test="${userCmd.sysId == null}">
                $("#form1").validate({
                    rules: { confirmPassword: {equalTo: "#password"}, userName: {remote:"uniqueUserName.htm"} },
                    messages: { userName: { remote: jQuery.format("<fmt:message key='validate.user.alreadyExists'/>")} }
                });
            </c:if>
        });
    </script>
</head>

<body>

<c:url var="createUserUrl" value="/userMgt/${formAction}.htm"/>
<form:form modelAttribute="userCmd" method="POST" action="${createUserUrl}" id="form1" enctype="multipart/form-data">
    <form:hidden path="sysId"/>

    <div>
        <form:errors cssClass="error"/>
    </div>

    <div class="label">
        <form:label path="userName"><fmt:message key="label.userName"/></form:label>
        <span class="required">*</span>
    </div>
    <div class="field">
        <c:if test="${userCmd.sysId == null}">
            <form:input path="userName" cssClass="required"/>
        </c:if>
        <c:if test="${userCmd.sysId != null}">
            <form:hidden path="userName"/> ${userCmd.userName}
        </c:if>
        <form:errors path="userName" cssClass="error"/>
    </div>
    <div class="clear"></div>

    <c:if test="${userCmd.sysId == null}">
        <div class="label">
            <form:label path="password"><fmt:message key="label.password"/></form:label>
            <span class="required">*</span>
        </div>
        <div class="field">
            <form:password path="password" cssClass="required"/>
            <form:errors path="password" cssClass="error"/>
        </div>
        <div class="clear"></div>

        <div class="label">
            <form:label path="confirmPassword"><fmt:message key="label.password.confirm"/></form:label>
            <span class="required">*</span>
        </div>
        <div class="field">
            <form:password path="confirmPassword" cssClass="required"/>
            <form:errors path="confirmPassword" cssClass="error"/>
        </div>
        <div class="clear"></div>
    </c:if>

    <div class="label">
        <form:label path="admin"><fmt:message key="label.admin"/></form:label>
        <span class="required">*</span>
    </div>
    <div class="field">
        <form:radiobuttons path="admin" items="${yesNoOption}" cssClass="required"/>
        <form:errors path="admin" cssClass="error"/>
    </div>
    <div class="clear"></div>

    <div class="label">
        <form:label path="name"><fmt:message key="label.fullName"/></form:label>
        <span class="required">*</span>
    </div>
    <div class="field">
        <form:input path="name" cssClass="required"/>
        <form:errors path="name" cssClass="error"/>
    </div>
    <div class="clear"></div>

    <div class="label">
        <form:label path="title"><fmt:message key="label.designation"/></form:label>
        <span class="required">*</span>
    </div>
    <div class="field">
        <form:input path="title" cssClass="required"/>
        <form:errors path="title" cssClass="error"/>
    </div>
    <div class="clear"></div>

    <div class="label">
        <form:label path="email"><fmt:message key="label.email"/></form:label>
        <span class="required">*</span>
    </div>
    <div class="field">
        <form:input path="email" cssClass="required"/>
        <form:errors path="email" cssClass="error"/>
    </div>
    <div class="clear"></div>

    <div class="label">
        <form:label path="mobile"><fmt:message key="label.mobile"/></form:label>
    </div>
    <div class="field">
        <form:input path="mobile" cssClass=""/>
        <form:errors path="mobile" cssClass="error"/>
    </div>
    <div class="clear"></div>

    <div class="label">
        <form:label path="active"><fmt:message key="label.active"/></form:label>
        <span class="required">*</span>
    </div>
    <div class="field">
        <form:radiobuttons path="active" items="${yesNoOption}" cssClass="required"/>
        <form:errors path="active" cssClass="error"/>
    </div>
    <div class="clear"></div>

    <div class="buttonDivLeft">
        <input type="button" value="<fmt:message key='button.back'/>" onclick="window.location='userList.htm';"/>
    </div>
    <div class="buttonDiv">
        <c:if test="${userCmd.sysId == null}">
            <input type="submit" value="<fmt:message key='button.submit'/>"/>
        </c:if>
        <c:if test="${userCmd.sysId != null }">
            <input type="submit" value="<fmt:message key='button.update'/>"/>
        </c:if>
    </div>
</form:form>

</body>
</html>
