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
<%@taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title><decorator:title default=""/></title>

    <script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript" src="../js/jquery.validate.js"></script>

    <link rel="stylesheet" type="text/css" href="../css/form.css" media="screen,projection"/>
    <link rel="stylesheet" type="text/css" href="../css/style_bn.css"/>

    <decorator:head/>
</head>

<body>

<script language="javascript" type="text/javascript">
    $(document).ready(function() {
        $("#nojs").hide();
        $('input[type="submit"]').removeAttr('disabled');
        $("#form1").show();
        $("#frqForm").show();

        jQuery.extend(jQuery.validator.messages, {
            required: "<fmt:message key='validate.required'/>",
            equalTo: "<fmt:message key='validate.match.password'/>"
        });

        <c:if test="${!empty param.message}">
            $('#ninefive_panel2').show();
        </c:if>

        setTimeout(function() {
            $('#ninefive_panel2').fadeOut('fast');
        }, 5000);
    });
</script>

<div id="wrapper">
    <div id="wrapper_inner">

        <div id="top">
            <div style="float:left;">
                <img src="../img/header_bangla.gif"/>
            </div>
            <div style="width: 300px;height:30px;float:right;margin-top:30px;text-align:center;"></div>
        </div>

        <div id="navigation">
            <div style="float: left; width: 25%; text-align: left;">
                <ul>
                    <li><a href="<c:url value="/formBuilder/index.htm"/>"><fmt:message key="label.home"/></a></li>
                </ul>
            </div>

            <div style="float: left; width: 40%">
                <ul>
                    <li style="background: none">
                        <%
                            String requestWithQueryString = request.getRequestURL()
                                    + (request.getQueryString() == null ? "" : "?" + request.getQueryString());
                            String localeBnUrl = "";
                            String localeEnUrl = "";
                            if (requestWithQueryString.contains("lang=")) {
                                localeBnUrl = requestWithQueryString.replaceFirst("lang=..", "lang=bn");
                                localeEnUrl = requestWithQueryString.replaceFirst("lang=..", "lang=en");
                            } else if (requestWithQueryString.contains("?")) {
                                localeBnUrl = requestWithQueryString + "&lang=bn";
                                localeEnUrl = requestWithQueryString + "&lang=en";
                            } else {
                                localeBnUrl = requestWithQueryString + "?lang=bn";
                                localeEnUrl = requestWithQueryString + "?lang=en";
                            }
                        %>
                        <a href="<%= localeBnUrl %>">বাংলা</a> <span style="color: #000">|</span>
                        <a href="<%= localeEnUrl %>">English</a>
                    </li>
                </ul>
            </div>

            <div style="float: right; width: 35%; text-align: right;">
                <ul>
                    <li>
                        <a href="http://www.youtube.com/watch?v=TKfp0jubykY" target="_blank"><fmt:message
                                key="help"/></a>
                    </li>
                    <c:if test="${empty sessionScope.user}">
                        <li>
                            <a href="<c:url value="/userMgt/login.htm"/>">
                                <fmt:message key="label.Login"/>
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${!empty sessionScope.user}">
                        <li>
                            <a href="<c:url value="/userMgt/changePassword.htm"/>">
                                <fmt:message key="label.changePassword"/>
                            </a>
                        </li>
                        <li style="color:#000;">
                            <a href="<c:url value="/userMgt/logout.htm"/>">
                                <fmt:message key="label.logout"/>
                            </a> (${sessionScope.user.userName})
                        </li>
                    </c:if>
                </ul>
            </div>

            <div style="clear: both"></div>
        </div>

        <div id="middlebar">

            <div id="sidebar">
                <p style="padding-left: 5px"><fmt:message key="label.menu"/></p>
                <ul>
                    <c:if test="${empty sessionScope.user}">
                        <li><a href="<c:url value="/userMgt/login.htm"/>"><fmt:message key="label.Login"/></a></li>
                    </c:if>
                    <c:if test="${!empty sessionScope.user && sessionScope.user.admin ==1}">
                        <li><fmt:message key="title.valueOptions"/></li>
                        <li><a href="<c:url value="/listBuilder/newList.htm"/>"><fmt:message key="label.new"/></a></li>
                        <li><a href="<c:url value="/listBuilder/list.htm"/>"><fmt:message key="label.list"/></a></li>
                    </c:if>
                    <c:if test="${!empty sessionScope.user && sessionScope.user != null}">
                        <li><fmt:message key="title.form"/></li>
                        <li><a href="<c:url value="/formBuilder/newForm.htm"/>"><fmt:message key="label.new"/></a></li>
                        <li><a href="<c:url value="/formBuilder/formList.htm"/>"><fmt:message key="label.list"/></a>
                        </li>
                    </c:if>
                    <c:if test="${!empty sessionScope.user && sessionScope.user.admin ==1}">
                        <li><fmt:message key="title.userForm"/></li>
                        <li><a href="<c:url value="/userMgt/newUser.htm"/>"><fmt:message key="label.new"/></a></li>
                        <li><a href="<c:url value="/userMgt/userList.htm"/>"><fmt:message key="label.list"/></a></li>
                    </c:if>
                </ul>
            </div>

            <div id="nojs" style="background: #ff6666;padding: 10px;font-family: arial,serif">
                JavaScript must be enabled in order for you to use this application.
                However, it seems JavaScript is either disabled or not supported by your browser.
                Enable JavaScript by changing your browser options, then <a href="">try again</a>.
            </div>

            <div id="ninefive_panel" style="background: #fff;border: none;">
                <div id="frqForm">
                    <div id="ninefive_panel2"
                         style="display: none;text-align: center;border:1px solid #aaa;padding:10px;margin: 10px;">
                        <fmt:message key="${param.message}"/>
                    </div>
                    <p style="padding-left: 5px"><decorator:title default=""/></p>

                    <decorator:body/>
                </div>
            </div>

        </div>

        <div id="footer">
            <p id="legal">
                <a href="http://www.a2i.pmo.gov.bd" target="_blank"><fmt:message key="footer.a2i"/>,</a>
                <a href="http://www.pmo.gov.bd" target="_blank"> <fmt:message key="footer.pmo"/></a>
            </p>
        </div>

    </div>
</div>

</body>
</html>
