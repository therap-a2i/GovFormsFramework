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
    <title><fmt:message key="title.formDetails"/></title>

    <script type="text/javascript">
        $(document).ready(function() {
            $("#form1").validate();
        });

        function getFileName() {
            document.forms[0].elements["templateFileName"].value = 
                    document.forms[0].elements["pdfTemplate"].value;
            return true;
        }

        function deleteTemplate(formId) {
            if (confirm("<fmt:message key='msg.confirm'/>")) {
                window.location = "removeTemplate.htm?formId=" + formId;
            }
        }
    </script>
</head>

<body>

<c:url var="formDetailsUrl" value="/formBuilder/${formAction}.htm"/>
<form:form modelAttribute="formDetailsCmd" method="POST" action="${formDetailsUrl}" id="form1"
           enctype="multipart/form-data">

    <form:hidden path="id"/>
    <form:hidden path="formId"/>
    <form:hidden path="status"/>
    <form:hidden path="templateFileName"/>

    <div>
        <form:errors cssClass="error"/>
    </div>

    <div class="label">
        <form:label path="title"><fmt:message key="label.title"/></form:label>
    </div>
    <div class="field">
        <form:input path="title" cssClass="required"/>
        <form:errors path="title" cssClass="error"/>
    </div>
    <div class="clear"></div>

    <div class="label">
        <form:label path="subTitle"><fmt:message key="label.subtitle"/></form:label>
    </div>
    <div class="field">
        <form:input path="subTitle" cssClass=""/>
        <form:errors path="subTitle" cssClass="error"/>
    </div>
    <div class="clear"></div>

    <div class="label">
        <form:label path="detail"><fmt:message key="label.description"/></form:label>
    </div>
    <div class="field">
        <form:textarea path="detail" cssClass=""/>
        <form:errors path="detail" cssClass="error"/>
    </div>
    <div class="clear"></div>

    <div class="label">
        <form:label path="pdfTemplate"><fmt:message key="label.template.file"/></form:label>
    </div>
    <div class="field">
        <input type="file" name="pdfTemplate" class=""/>
        <form:errors path="pdfTemplate" cssClass="error"/>
        <br/>
        <a href="dloadTemplate.htm?formId=${formDetailsCmd.formId}">${formDetailsCmd.templateFileName}</a>
        <c:if test="${!empty formDetailsCmd.templateFileName}">
            <br/>
            <a href="#" onclick="deleteTemplate('${formDetailsCmd.formId}');"><fmt:message key="label.remove"/></a>
        </c:if>
    </div>
    <div class="clear"></div>

    <div class="buttonDivLeft">
        <input type="button" value="<fmt:message key='button.back'/>" onclick="window.location='formList.htm';"/>
    </div>
    <div class="buttonDiv">
        <c:if test="${formDetailsCmd.formId == null  && formDetailsCmd.status == 0}">
            <input type="submit" value="<fmt:message key='button.submit'/>" onclick="return getFileName();"/>
        </c:if>
        <c:if test="${formDetailsCmd.formId != null && formDetailsCmd.status > 0}">
            <input type="submit" value="<fmt:message key='button.update'/>" onclick="return getFileName();"/>
        </c:if>
    </div>
</form:form>

</body>
</html>
