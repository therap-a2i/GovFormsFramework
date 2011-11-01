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
    <title>${form.title}</title>

    <script type="text/javascript">
        function search() {
            var colVal = document.forms[0].elements["colVal"].value;
            var colName = document.forms[0].elements["colName"].value;

            window.location = "entryList.htm?formId=${formId}&page=" + ${page}
                    + "&colName=" + colName + "&colVal=" + colVal;
        }

        function popitup(url) {
            window.open(url, 'name', 'height=600,width=800');
        }
    </script>

    <style type="text/css">
        tr.odd {
            background-color: #D3E5DA;
        }

        td {
            border: 1px solid #D3E5DA;
            padding: 5px;
            font-size: 10pt;
            font-weight: normal;
        }

        td a {
            font-size: 10pt;
            font-weight: normal;
            color: #ff0000;
        }
    </style>  
</head>

<body>

<form action="<c:url value="entryList.htm"/>">
    <fmt:message key="search"/>: <input type="text" name="colVal" value="${colVal}">
    <select name="colName">
        <option value="entry_date"><fmt:message key="form.entry.entry.date"/></option>
        <option value="entry_status"><fmt:message key="form.entry.entry.status"/></option>
        <c:forEach var="f" items="${form.fields}">
            <c:if test="${f.type != 'file' && f.type != 'section' && f.type != 'note' }">
                <option <c:if test="${f.colName == colName}">selected</c:if> value="${f.colName}">${f.label}</option>
            </c:if>
        </c:forEach>
    </select>
    <input type="hidden" name="formId" value="${formId}"/>
    <input type="hidden" name="sortCol" value="${sortCol}"/>
    <input type="hidden" name="sortDir" value="${sortDirX}"/>
    <input type="hidden" name="page" value="${page}"/>
    <input type="submit" value="<fmt:message key="search"/>"/>
</form>

<table width="100%" style="border:1px solid #D3E5DA;" cellspacing="0">
    <tr>
        <c:url var="entryListUrl"
               value="entryList.htm?formId=${form.formId}&entryId=${e['entry_id']}&page=${page}&colName=${colName}&colVal=${colVal}&sortDir=${sortDir}"/>
        <td><a href="${entryListUrl}&sortCol=entry_date"><fmt:message key="label.date"/></a></td>
        <td><a href="${entryListUrl}&sortCol=entry_time"><fmt:message key="label.time"/></a></td>
        <td><a href="${entryListUrl}&sortCol=entry_status"><fmt:message key="label.status"/></a></td>
        <td><b><fmt:message key="label.action"/></b></td>
        <c:forEach var="f" items="${form.fields}">
            <c:if test="${f.type != 'file' && f.type != 'section' && f.type != 'note' }">
                <td>
                    <a href="<c:url value="entryList.htm?formId=${form.formId}&entryId=${e['entry_id']}&page=${page}&colName=${colName}&colVal=${colVal}&sortCol=${f.colName}&sortDir=${sortDir}"/>">${f.label}</a>
                </td>
            </c:if>
        </c:forEach>
    </tr>

    <c:forEach var="e" items="${entries}" varStatus="st">
        <tr <c:if test="${st.count % 2 == 1}">class="odd"</c:if>>
            <td>${e['entry_date']}</td>
            <td>${e['entry_time']}</td>
            <td>${e['entry_status']}</td>
            <td>
                <c:url var="popupUrl" value="printHtml.htm?formId=${form.formId}&entryId=${e['entry_id']}"/>
                <a href="#" onclick="javascript: popitup('${popupUrl}');"><fmt:message key="label.print"/></a> |
                <c:url var="markCheckedUrl"
                       value="markChecked.htm?formId=${form.formId}&entryId=${e['entry_id']}&page=${page}&colName=${colName}&colVal=${colVal}&sortCol=${sortCol}&sortDir=${sortDirX}"/>
                <c:if test="${e['entry_status'] == 'Submitted' }">
                    <a href="${markCheckedUrl}&checked=true"><fmt:message key="label.checked"/></a>
                </c:if>
                <c:if test="${e['entry_status'] != 'Submitted' }">
                    <a href="${markCheckedUrl}&checked=false"><fmt:message key="label.unchecked"/></a>
                </c:if>
            </td>
            <c:forEach var="f" items="${form.fields}">
                <c:if test="${f.type != 'file' && f.type != 'section' && f.type != 'note' }">
                    <td>${e[f.colName]}</td>
                </c:if>
            </c:forEach>
        </tr>
    </c:forEach>
</table>

<c:forEach var="i" begin="1" end="${totalPages}" step="1" varStatus="status">
    <a href="<c:url value="entryList.htm?formId=${formId}&page=${i}&colName=${colName}&colVal=${colVal}&sortCol=${sortCol}&sortDir=${sortDirX}"/>">${i}</a> |
</c:forEach>

<br/>

<div style="text-align: center;">
    <a href="<c:url value="excelExport.htm?formId=${formId}&page=${page}&colName=${colName}&colVal=${colVal}&sortCol=${sortCol}&sortDir=${sortDirX}"/>">
        <fmt:message key="label.export.excel"/>
    </a>
</div>

</body>
</html>
