<%--
  Created by IntelliJ IDEA.
  User: George
  Date: 30/12/2015
  Time: 1:05 πμ
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Aggric Cloud </title>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">


    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
          integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">


    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/app.css">

</head>
<body ng-app="myApp" class="ng-cloak">

<div class="navbar navbar-fixed-top navbar-default" role="navigation" id="allheader">
    <div class="container-fluid">

        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar1">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <p class="pull-left visible-xs">
                <button type="button" class="btn btn-primary" id="menu_button" data-toggle="#mynavbar2">Menu</button>

            </p>
            <a class="navbar-brand" href="#">
                <img class="img-responsive" alt="Notifications" width="70" height="60"
                     src="${pageContext.request.contextPath}/static/images/logo.png">

                <h3 class="headerspan">Agric Cloud</h3>
            </a>
        </div>
        <div class="collapse navbar-collapse" id="myNavbar1">

            <ul class="nav navbar-nav navbar-right">
                <li role="presentation"><a href="#" onclick=""><b>${current_user.username}</b></a>
                </li>
                <li class="dropdown">
                    <a href="" onclick="" class="dropdown-toggle" id="notifanime"
                       data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span
                            class="glyphicon glyphicon-bell" aria-hidden="true"></span><span class="badge backg"
                                                                                             id="badge_counter"></span></a>


                </li>


                <li role="presentation"><a href="#" onclick="">Home</a>
                </li>
                <li role="presentation" data-toggle="modal" data-target="#myprofilemodal"><a href="#myprofilemodal">My
                    Profile</a>
                </li>
                <li role="presentation" data-toggle="modal" data-target="#logoutmodal"><a href="#logoutmodal">Logout</a>
                </li>

                <li role="presentation">
                    <a href="#" onclick=""><span class="glyphicon glyphicon-question-sign"
                                                 aria-hidden="true"></span></a>


                </li>


            </ul>
        </div>

    </div>
</div>


<div class="fullcont">
    <div class="container-fluid">
        <!--fixed width no full width container -->
        <div class="row row-offcanvas row-offcanvas-left" id="mynavbar2">
            <div class="row row-offcanvas row-offcanvas-right">
                <div class="col-sm-2 col-xs-4 sidebar-offcanvas" role="navigation">
                    <div class="sidebar-nav" id="sidebarleft">
                        <ul class="nav nav-pills nav-stacked ">
                            <li role="presentation" style="cursor: pointer;"><a onclick=""><span
                                    class="glyphicon glyphicon-apple" aria-hidden="true"></span>My Title</a>
                            </li>
                            <li role="presentation" style="cursor: pointer;"><a onclick=""> <span
                                    class="glyphicon glyphicon-grain" aria-hidden="true"> </span>My Title2
                            </a>
                            </li>
                            <li role="presentation" style="cursor: pointer;"><a onclick=""><span
                                    class="glyphicon glyphicon-scale" aria-hidden="true"></span>My Title3</a>
                            </li>
                            <li role="presentation" style="cursor: pointer;"><a onclick=""><span
                                    class="glyphicon glyphicon-tint" aria-hidden="true"></span>My Title4</a>
                            </li>
                            <li role="presentation" style="cursor: pointer;"><a onclick=""><span
                                    class="glyphicon glyphicon-leaf" aria-hidden="true"></span>My Title5</a>
                            </li>
                            <li role="presentation" style="cursor: pointer;"><a onclick=""><span
                                    class="glyphicon glyphicon-tree-conifer" aria-hidden="true"></span>My Title6</a>
                            </li>
                            <li role="presentation" style="cursor: pointer;"><a onclick=""><span
                                    class="glyphicon glyphicon-globe" aria-hidden="true"></span>My Title7</a>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="col-sm-10 col-xs-4 sidebar-offcanvas" ng-controller="homecontroller" role="navigation"
                     id="datacontent">

                    <h4><span class="glyphicon glyphicon-globe" aria-hidden="true"></span>Home</h4>
                    <hr id="headline">
                    <p>Welcome <b>${current_user.username}</b> you have to setup your crop </p>
                    <button class="btn btn-primary" id="addcropbutton" ng-click="showModal()">
                        <span class="glyphicon glyphicon-plus-sign" aria-hidden="true">
                        </span>Add Task
                    </button>
                </div>


            </div>
            <!--  row-offcanvas-right -->
        </div>
        <!-- row-offcanvas-left -->
    </div>
</div>


<div class="modal fade" id="logoutmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">Log Out</h4>
            </div>
            <form class="form-horizontal" id="logout_form" action="logout" method="post">
                <div class="modal-body">

                    Are you sure you want to log out?

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary" name="event" value="LOGOUT" form="logout_form">Log
                        Out
                    </button>
                </div>
            </form>

        </div>

    </div>
</div>


<jsp:include page="Shared/footer.jsp"/>


<script type="text/ng-template" id="myModalAddCrop.html">
    <div class="modal-header">
        <h3 class="modal-title">Add Crop</h3>
    </div>

    <form ng-submit="submit()" name="addcropmyForm" class="form-horizontal">
        <div class="modal-body">

            <div class="row">
                <div class="col-sm-6">
                    <label for="idaddcropname">Crop Name *</label>
                    <input type="text" ng-model="crop.cropname" name="cropname" class="form-control"
                           id="idaddcropname"
                           oninput="" placeholder="Enter Crop's Name" required>

                    <div class="has-error" ng-show="addcropmyForm.$dirty">
                        <span ng-show="addcropmyForm.$dirty && addcropmyForm.cropname.$error.required">This is a required field</span>

                    </div>
                </div>
                <div class="col-sm-6">
                    <label for="idaddstationname">Station Name *</label>
                    <input type="text" ng-model="crop.stationname" class="form-control" name="addstationname"
                           id="idaddstationname"
                           oninput="" placeholder="Enter Station's Name" required/>

                    <div class="has-error" ng-show="addcropmyForm.$dirty">
                        <span ng-show="addcropmyForm.$dirty && addcropmyForm.addstationname.$error.required">This is a required field</span>

                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-6">
                    <label for="idcropdescription">Crop Description</label>
                    <input type="text" ng-model="crop.cropdescription" name="addcropdescr" class="form-control"
                           id="idcropdescription"
                           placeholder="Enter Crop's Description"/>
                </div>
                <div class="col-sm-6">
                    <label for="idstationdescription">Station Description</label>
                    <input type="text" ng-model="crop.stationdescription" name="stationdescription"
                           class="form-control"
                           id="idstationdescription"
                           placeholder="Enter Station's Description"/>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-6" ng-repeat="end in crop.devices">
                    <label for="idenddevice">End Device *</label>
                    <input type="text" ng-model="end.devname" name="enddevice" class="form-control"
                           id="idenddevice"
                           placeholder="Enter End Device Name" required/>

                    <div class="has-error" ng-show="addcropmyForm.$dirty">
                        <span ng-show="addcropmyForm.$dirty && addcropmyForm.enddevice.$error.required">This is a required field</span>

                    </div>
                </div>
            </div>

            <button class="btn btn-primary" id="addendDevice" type="button" ng-click="addenddevice()">
                        <span class="glyphicon glyphicon-plus-sign" aria-hidden="true">
                        </span>Add End Device
            </button>
        </div>


        <div class="modal-footer">

            <button class="btn btn-warning" type="button" ng-click="cancel()">Cancel</button>
            <button type="submit" class="btn btn-primary" ng-disabled="addcropmyForm.$invalid">Save</button>
        </div>

    </form>


</script>


<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.5/angular.min.js"></script>
<script src="<c:url value='/static/js/ui-bootstrap-tpls-1.3.3.min.js'/>"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"
        integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS"
        crossorigin="anonymous"></script>
<script src="<c:url value='/static/js/app.js' />"></script>
<script src="<c:url value='/static/js/service/home_service.js' />"></script>
<script src="<c:url value='/static/js/controller/home_controller.js'/>"></script>
</body>
</html>
