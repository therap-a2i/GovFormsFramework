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
    <title><fmt:message key="title.formInfo"/>: ${form.title}</title>

    <style type="text/css">
        td {
            border: 1px solid #D3E5DA;
            padding: 5px;
            font-size: 10pt;
            font-weight: normal;
        }

        h3 {
            font-size: 12pt;
        }
    </style>
</head>

<body>

<h3><fmt:message key="label.tableName"/>: ${form.tableName}</h3>

<table width="100%" style="border:1px solid #D3E5DA;" cellspacing="0">
    <tr>
        <td><fmt:message key="label.fieldName"/></td>
        <td><fmt:message key="label.colName"/></td>
    </tr>

    <c:forEach var="f" items="${form.fields}">
        <c:if test="${f.type != 'file' && f.type != 'section' && f.type != 'note' }">
            <tr>
                <td>${f.label}</td>
                <td>${f.colName}</td>
            </tr>
        </c:if>
    </c:forEach>
</table>

</body>
</html>
