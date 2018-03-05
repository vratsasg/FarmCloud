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
    <title>Agric Cloud </title>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">


    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
          integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/app.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/flaticon.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/_flaticon.scss">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/angular-bootstrap-datetimepicker/1.1.4/css/datetimepicker.min.css">

    <%--JQuery--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

    <%--AngularJS--%>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.5/angular.min.js"></script>
    <script src="https://npmcdn.com/@angular/router@0.2.0/angular1/angular_1_router.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-sanitize/1.5.5/angular-sanitize.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/ng-table/0.8.3/ng-table.min.js"></script>

    <%--ng-table--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ng-table/1.0.0/ng-table.min.css">

    <%--nvd3--%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.6/d3.min.js" charset="utf-8"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/nvd3/1.8.1/nv.d3.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-nvd3/1.0.7/angular-nvd3.js"></script>

    <%--Openlayers--%>
    <script src="http://openlayers.org/en/v3.16.0/build/ol.js" type="text/javascript"></script>
    <script src="http://tombatossals.github.io/angular-openlayers-directive/dist/angular-openlayers-directive.min.js"></script>

    <%--Bootstrap--%>
    <script src="<c:url value='/static/js/ui-bootstrap-tpls-1.3.3.min.js'/>"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"
            integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS"
            crossorigin="anonymous"></script>

    <%--momentjs--%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.13.0/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.13.0/moment-with-locales.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-moment/1.0.0-beta.6/angular-moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-bootstrap-datetimepicker/1.1.4/js/datetimepicker.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-bootstrap-datetimepicker/1.1.4/js/datetimepicker.templates.min.js"></script>

    <%--angular-toastr--%>
    <script src="https://cdn.jsdelivr.net/npm/angular-toastr@2/dist/angular-toastr.tpls.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/angular-toastr@2/dist/angular-toastr.css">

    <%--animate--%>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.5/angular-animate.js"></script>

    <script src="<c:url value='/static/js/app.js' />"></script>
    <%--Topbar--%>
    <script src="<c:url value='/static/js/shared/topbar/topbar.js' />"></script>
    <script src="<c:url value='/static/js/shared/topbar/topbar.service.js' />"></script>
    <%--Leftbar--%>
    <script src="<c:url value='/static/js/shared/leftbar/leftbar.js' />"></script>
    <script src="<c:url value='/static/js/shared/leftbar/leftbar.service.js' />"></script>

    <%--Components--%>
    <script src="<c:url value='/static/js/components/home/first-page.component.js' />"></script>
    <script src="<c:url value='/static/js/components/home/first-page.service.js' />"></script>
    <script src="<c:url value='/static/js/components/crop-app/crop-app.component.js' />"></script>
    <script src="<c:url value='/static/js/components/my-profile/my-profile.component.js' />"></script>
    <script src="<c:url value='/static/js/components/my-profile/my-profile.service.js' />"></script>
    <script src="<c:url value='/static/js/components/my-profile/station-coords.modal.component.js' />"></script>
    <script src="<c:url value='/static/js/shared/topbar/logout.modal.component.js' />"></script>
    <script src="<c:url value='/static/js/components/home/chart-graph/chart-graph.component.js' />"></script>
    <script src="<c:url value='/static/js/components/home/chart-graph/chart-graph.service.js' />"></script>
    <script src="<c:url value='/static/js/components/user-profile/user-profile.component.js' />"></script>
    <script src="<c:url value='/static/js/components/user-profile/user-profile.service.js' />"></script>
    <script src="<c:url value='/static/js/components/observable-property/observable-property.component.js'/>"></script>
    <script src="<c:url value='/static/js/components/observable-property/observable-property.service.js'/>"></script>
    <script src="<c:url value='/static/js/components/watering-property/watering-property.component.js'/>"></script>
    <script src="<c:url value='/static/js/components/watering-property/watering-property.service.js'/>"></script>

    <script src="<c:url value='/static/js/components/weather-api/weather-api.component.js'/>"></script>
    <script src="<c:url value='/static/js/components/weather-api/weather-api.service.js'/>"></script>
    <script src="<c:url value='/static/js/components/weather-api/weather-chart/weather-chart.component.js'/>"></script>
    <script src="<c:url value='/static/js/components/weather-api/weather-chart/weather-chart.service.js'/>"></script>
    
    <script src="<c:url value='/static/js/components/control-panel/control-panel.component.js'/>"></script>
    <script src="<c:url value='/static/js/components/control-panel/control-panel.service.js'/>"></script>
    <script src="<c:url value='/static/js/components/control-panel/irrigation.modal.component.js'/>"></script>
    <script src="<c:url value='/static/js/components/control-panel/measuring.modal.component.js'/>"></script>
    <script src="<c:url value='/static/js/components/control-panel/algorithm.modal.component.js'/>"></script>

    <script src="<c:url value='/static/js/components/watering-profile/watering-profile.component.js'/>"></script>
    <script src="<c:url value='/static/js/components/watering-profile/watering-profile.service.js'/>"></script>

</head>


<body ng-cloak>
<crop-app></crop-app>
</body>
</html>
