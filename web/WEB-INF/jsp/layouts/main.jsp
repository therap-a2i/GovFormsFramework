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

    <decorator:head/>
</head>

<body>

<div id="nojs" style="font-family: arial,serif; margin-bottom: 20px">
    JavaScript must be enabled in order for you to use this application. However, it seems
    JavaScript is either disabled or not supported by your browser. Enable JavaScript by changing your browser options,
    then <a href="">try again</a>.
</div>

<script language="javascript" type="text/javascript">
    $(document).ready(function() {
        $('input[type="submit"]').removeAttr('disabled');
        $("#form1").show();
        $("#nojs").hide();
    });
</script>

<decorator:body/>

</body>
</html>
