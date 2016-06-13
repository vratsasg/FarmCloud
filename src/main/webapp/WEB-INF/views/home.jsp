<%--
  Created by IntelliJ IDEA.
  User: George
  Date: 30/12/2015
  Time: 1:05 πμ
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html ng-app="myApp">
<head>
    <title>Aggric Cloud </title>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">


    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
          integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">


    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/app.css">


    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.5/angular.min.js"></script>
    <script src="<c:url value='/static/js/ui-bootstrap-tpls-1.3.3.min.js'/>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"
            integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS"
            crossorigin="anonymous"></script>
    <script src="<c:url value='/static/js/app.js' />"></script>
    <script src="<c:url value='/static/js/shared/topbar/topbar.js' />"></script>
    <script scr="<c:url value='/static/js/shared/leftbar/leftbar.js'/>"></script>

</head>


<body ng-cloak>
<topbar></topbar>
<leftbar></leftbar>
<div class="fullcont">
    <div class="container-fluid">
        <!--fixed width no full width container -->
        <div class="row row-offcanvas row-offcanvas-left" id="mynavbar2">
            <div class="row row-offcanvas row-offcanvas-right">

            </div>
        </div>
    </div>
</div>
</body>

</html>
