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
    <title>${fieldCmd.type} <fmt:message key="field"/></title>

    <script type="text/javascript">
        $(document).ready(function() {
            $("#form1").validate();
        });
    </script>
</head>

<body>

<h1>${fieldCmd.type} <fmt:message key="field"/></h1>

<c:url var="formBuilderActionUrl" value="/formBuilder/${formAction}.htm"/>
<form:form modelAttribute="fieldCmd" method="POST" action="${formBuilderActionUrl}" id="form1"
           enctype="multipart/form-data">
    <form:hidden path="type"/>
    <form:hidden path="formIdStr"/>
    <form:hidden path="fieldId"/>
    <form:hidden path="fieldOrder"/>

    <div>
        <form:errors cssClass="error"/>
    </div>

    <div class="label">
        <form:label path="label"><fmt:message key="new.field.label"/></form:label>
    </div>
    <div class="field">
        <form:input path="label" cssClass="required"/>
        <form:errors path="label" cssClass="error"/>
    </div>
    <div class="clear"></div>

    <div class="label">
        <form:label path="helpText"><fmt:message key="new.field.help.text"/></form:label>
        <span class="help"><fmt:message key="new.field.help.text.desc"/></span>
    </div>
    <div class="field">
        <form:textarea path="helpText" cssClass=""/>
        <form:errors path="helpText" cssClass="error"/>
    </div>
    <div class="clear"></div>

    <c:if test="${fieldCmd.type != 'note' && fieldCmd.type != 'section'}">
        <div class="label">
            <form:label path="required"><fmt:message key="new.field.required"/></form:label>
        </div>
        <div class="field">
            <form:radiobuttons path="required" items="${yesNoOption}" cssClass="required"/>
            <form:errors path="required" cssClass="error"/>
        </div>
        <div class="clear"></div>
    </c:if>

    <c:if test="${fieldCmd.type == 'text'}">
        <div class="label">
            <form:label path="inputType"><fmt:message key="new.field.validation"/></form:label>
        </div>
        <div class="field">
            <form:select path="inputType" items="${inputType}" cssClass=""/>
            <form:errors path="inputType" cssClass="error"/>
        </div>
        <div class="clear"></div>
    </c:if>

    <c:if test="${fieldCmd.type == 'select' || fieldCmd.type == 'radio'}">
        <div class="label">
            <form:label path="listDataId"><fmt:message key="new.field.list.source"/></form:label>
        </div>
        <div class="field">
            <form:select path="listDataId" items="${listSrc}" cssClass=""/>
            <form:errors path="listDataId" cssClass="error"/>
        </div>
        <div class="clear"></div>
    </c:if>

    <div class="buttonDivLeft">
        <c:url var="windowLocation" value="design.htm?formId=${fieldCmd.formIdStr}"/>
        <input type="button" value="<fmt:message key="button.back"/>"
               onclick="window.location='${windowLocation}'"/>
    </div>
    <div class="buttonDiv">
        <c:if test="${fieldCmd.fieldId == null}">
            <input type="submit" value="<fmt:message key="button.submit"/>"/>
        </c:if>
        <c:if test="${fieldCmd.fieldId != null}">
            <input type="submit" value="<fmt:message key="button.update"/>"/>
        </c:if>
    </div>

</form:form>

</body>
</html>
