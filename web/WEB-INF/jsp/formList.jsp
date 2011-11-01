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
    <title><fmt:message key="title.formList"/></title>

    <script type="text/javascript">
        function activate(formId) {
            if (confirm("<fmt:message key='msg.confirm'/>")) {
                window.location = "activate.htm?formId=" + formId;
            }
        }

        function deactivate(formId) {
            if (confirm("<fmt:message key='msg.confirm'/>")) {
                window.location = "deactivate.htm?formId=" + formId;
            }
        }

        function deleteForm(formId) {
            if (confirm("<fmt:message key='msg.confirm'/>")) {
                window.location = "deleteForm.htm?formId=" + formId;
            }
        }
    </script>
</head>

<body>

<c:forEach var="f" items="${forms}" varStatus="status">
    <div>
        <h2><c:out escapeXml="true" value="${f.title}"/></h2>

        <span class="help">
            ${f.detail}<br/>
            <fmt:message key="Status"/>: <fmt:message key="${f.statusStr}"/><br/>
            <c:if test="${sessionScope.user.admin ==1}">
                <a href="<c:url value="editForm.htm?formId=${f.formId}"/>"><fmt:message key="action.edit"/></a> |
                <c:if test="${f.status == 1}">
                    <a href="#" onclick="deleteForm('${f.formId}')"> <fmt:message key="action.delete"/></a> |
                </c:if>
                <c:if test="${f.status == 1 || f.status == 3}">
                    <a href="#" onclick="activate('${f.formId}')"><fmt:message key="action.activate"/></a> |
                </c:if>
                <c:if test="${f.status == 2}">
                    <a href="#" onclick="deactivate('${f.formId}')"><fmt:message key="action.deactivate"/></a> |
                </c:if>
            </c:if>
            <c:if test="${f.status == 2}">
                <a href="<c:url value="newEntry.htm?formId=${f.formId}"/>"><fmt:message key="title.newEntry"/></a> |
            </c:if>
            <c:if test="${f.status > 1}">
                <a href="<c:url value="entryList.htm?formId=${f.formId}"/>"><fmt:message key="title.entryList"/></a> |
                <a href="<c:url value="formInfo.htm?formId=${f.formId}"/>"><fmt:message key="title.formInfo"/></a> |
            </c:if>
            <c:if test="${f.status == 1}">
                <a href="<c:url value="design.htm?formId=${f.formId}"/>"><fmt:message key="action.design"/></a>
            </c:if>
        </span>
    </div>

    <div class="clear"></div>
</c:forEach>

</body>
</html>
