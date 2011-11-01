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
    <title>${formCmd.title}</title>

    <script type="text/javascript">
        $(document).ready(function() {
            $("#form1").validate();

            $('#result').load('formBuilder/fieldTypes', function() {
                alert('Load was performed.');
            });
        });

        function getFileNames() {
        <c:forEach var="f" items="${formCmd.fields}" varStatus="status">
        <c:set var="indx" value="${status.count-1}" />
        <c:if test="${f.type == 'file'}">
            document.forms[0].elements["fields[${indx}].strVal"].value = 
                    document.forms[0].elements["fields[${indx}].byteVal"].value;
        </c:if>
        </c:forEach>
            return true;
        }

        function deleteField(formId, fieldId) {
            if (confirm("<fmt:message key='msg.confirm'/>")) {
                window.location = "deleteField.htm?formId=" + formId + "&fieldId=" + fieldId;
            }
        }

        function moveField(formId, fieldId, order) {
            window.location = "moveField.htm?formId=" + formId + "&fieldId=" + fieldId + "&order=" + order;
        }

        function editField(formId, fieldId) {
            window.location = "editField.htm?formId=" + formId + "&fieldId=" + fieldId;
        }

        function newField(formId, indx, order) {
            var type = document.forms[0].elements["newFieldType" + indx].value;
            window.location = "newField.htm?formId=" + formId + "&type=" + type + "&order=" + order;
        }
    </script>
</head>

<body>

<c:url var="formActionUrl" value="/formBuilder/${formAction}.htm"/>
<form:form modelAttribute="formCmd" method="POST" action="${formActionUrl}" id="form1" enctype="multipart/form-data">

    <form:hidden path="formId"/>

    <c:if test="${formAction == 'formDesign'}">
        <div style="float:right;margin:2px;padding:2px;">
            <span class="help">
                <select name="newFieldType0">
                    <option value="text">Text</option>
                    <option value="select">Select</option>
                    <option value="radio">Radio</option>
                    <option value="textarea">Text Area</option>
                    <option value="section">Section</option>
                    <option value="note">Note</option>
                </select>
                <a href="#" onclick="newField('${formCmd.formId}',0,0);"><fmt:message key="action.add"/></a>
            </span>
        </div>
        <div class="label"></div>
        <div class="field"></div>
        <div class="clear"></div>
    </c:if>

    <c:forEach var="f" items="${formCmd.fields}" varStatus="status">
        <c:set var="indx" value="${status.count-1}"/>
        <form:hidden path="fields[${indx}].fieldId"/>

        <c:if test="${formAction == 'formDesign'}">
            <div style="float:left;margin:2px;padding:2px;">
                 <span class="help">
                     <a href="#" onclick="editField('${formCmd.formId}','${f.fieldId}');">
                         <fmt:message key="action.edit"/>
                     </a> |
                     <a href="#" onclick="deleteField('${formCmd.formId}','${f.fieldId}');">
                         <fmt:message key="action.delete"/>
                     </a> |

                    <c:if test="${not status.first}">
                        <a href="#" onclick="moveField('${formCmd.formId}','${f.fieldId}',${f.fieldOrder-1});">
                            <fmt:message key="action.moveUp"/>
                        </a> |
                    </c:if>
                    <c:if test="${not status.last}">
                        <a href="#" onclick="moveField('${formCmd.formId}','${f.fieldId}',${f.fieldOrder+1});">
                            <fmt:message key="action.moveDown"/>
                        </a>
                    </c:if>
                </span>
            </div>

            <div style="float:right;margin:2px;padding:2px;">
                <span class="help">
                    <select name="newFieldType${indx+1}">
                       <option value="text">Text</option>
                       <option value="select">Select</option>
                       <option value="radio">Radio</option>
                       <option value="textarea">Text Area</option>
                       <option value="section">Section</option>
                       <option value="note">Note</option>
                    </select>
                    <a href="#" onclick="newField('${formCmd.formId}',${indx+1},${f.fieldOrder+1});">
                        <fmt:message key="action.add"/>
                    </a>
                </span>
            </div>

            <div class="clear" style="border:none;"></div>
        </c:if>

        <c:if test="${f.type == 'text'}">
            <div class="label">
                <form:label path="fields[${indx}].strVal">${f.label}</form:label>
                <c:if test="${f.required ==1}">
                    <span class="required">*</span>
                </c:if>
                <span class="help">${f.helpText}</span>
            </div>
            <div class="field">
                <form:input path="fields[${indx}].strVal" cssClass="medium ${f.cssClass}"/>
                <form:errors path="fields[${indx}].strVal" cssClass="error"/>
            </div>
            <div class="clear"></div>
        </c:if>

        <c:if test="${f.type == 'textarea'}">
            <div class="label">
                <form:label path="fields[${indx}].strVal">${f.label}</form:label>
                <c:if test="${f.required ==1}">
                    <span class="required">*</span>
                </c:if>
                <span class="help">${f.helpText}</span>
            </div>
            <div class="field">
                <form:textarea path="fields[${indx}].strVal" cssClass="${f.cssClass}"/>
                <form:errors path="fields[${indx}].strVal" cssClass="error"/>
            </div>
            <div class="clear"></div>
        </c:if>

        <c:if test="${f.type == 'select'}">
            <div class="label">
                <form:label path="fields[${indx}].strVal">${f.label}</form:label>
                <c:if test="${f.required ==1}">
                    <span class="required">*</span>
                </c:if>
                <span class="help">${f.helpText}</span>
            </div>
            <div class="field">
                <form:select path="fields[${indx}].strVal" items="${f.list}" cssClass="${f.cssClass}"/>
                <form:errors path="fields[${indx}].strVal" cssClass="error"/>
            </div>
            <div class="clear"></div>
        </c:if>

        <c:if test="${f.type == 'radio'}">
            <div class="label">
                <form:label path="fields[${indx}].strVal">${f.label}</form:label>
                <c:if test="${f.required ==1}">
                    <span class="required">*</span>
                </c:if>
                <span class="help">${f.helpText}</span>
            </div>
            <div class="field">
                <form:radiobuttons path="fields[${indx}].strVal" items="${f.list}" cssClass="${f.cssClass}"/>
                <form:errors path="fields[${indx}].strVal" cssClass="error"/>
            </div>
            <div class="clear"></div>
        </c:if>

        <c:if test="${f.type == 'file'}">
            <form:hidden path="fields[${indx}].strVal"/>
            <div class="label">
                <form:label path="fields[${indx}].byteVal">${f.label}</form:label>
                <c:if test="${f.required ==1}">
                    <span class="required">*</span>
                </c:if>
                <span class="help">${f.helpText}</span>
            </div>
            <div class="field">
                <input type="file" name="fields[${indx}].byteVal" class="${f.cssClass}"/>
                <form:errors path="fields[${indx}].byteVal" cssClass="error"/>
                <br><a href="<c:url value="/formBuilder/dloadTemplate?formId=${formCmd.entryId}"/>">${f.strVal}</a>
            </div>
            <div class="clear"></div>
        </c:if>

        <c:if test="${f.type == 'note'}">
            <div class="note"><h4>${f.label}</h4>${f.helpText}</div>
        </c:if>
        <c:if test="${f.type == 'section'}">
            <div class="section"><h3>${f.label}</h3>${f.helpText}</div>
        </c:if>
    </c:forEach>

    <div class="buttonDivLeft">
        <c:if test="${formAction == 'formDesign'}">
            <input type="button" value="<fmt:message key='button.back'/>" class="cancel"
                   onclick="window.location='formList.htm'"/>
        </c:if>
    </div>

    <div class="buttonDiv">
        <c:if test="${formAction == 'formDesign'}">
            <input type="submit" value="<fmt:message key='button.testSubmit'/>"/>
        </c:if>
        <c:if test="${formAction != 'formDesign'}">
            <input type="submit" value="<fmt:message key='button.submit'/>" onclick="getFileNames();"/>
        </c:if>
    </div>
</form:form>

</body>
</html>
