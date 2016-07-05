<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>

<head>
    <title>Aggric Cloud </title>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
          integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/app.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"
            integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS"
            crossorigin="anonymous"></script>
    <%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>--%>
    <script src="<c:url value='/static/js/js-libraries/bootbox.min.js'/>"></script>
</head>

<body>
<jsp:include page="Shared/navbar.jsp"/>
<div class="fullcont">
    <div class="container">
        <div class="row">
            <div id="leftstart" class="col-sm-8">
                <p class="headerp">...a web application for watering crops</p>

                <div id="myCarousel" class="carousel slide" data-ride="carousel">
                    <!-- Indicators -->
                    <ol class="carousel-indicators">
                        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                        <li data-target="#myCarousel" data-slide-to="1"></li>
                    </ol>

                    <!-- Wrapper for slides -->
                    <div class="carousel-inner" role="listbox">
                        <div class="item active">
                            <img src="${pageContext.request.contextPath}/static/images/carous2.jpg" alt="Chania"
                                 width="460" height="345">
                        </div>

                        <div class="item">
                            <img src="${pageContext.request.contextPath}/static/images/carous4.jpg" alt="Flower"
                                 width="460" height="345">

                        </div>
                    </div>

                    <!-- Left and right controls -->
                    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>


                <div class="row">
                    <div class="col-md-3">
                        <div class="animated1">
                            <h3>Monitoring</h3>

                            <p>Anytime Anywhere Monitoring enviromental parameters (luminosity, moisture, temperature,
                                humidity) in real time.</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="animated2">
                            <h3>Evaluating Data</h3>

                            <p>Graphs and pies for viewing the data p.e per month, per day, per hour,between
                                dates all in one place</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="animated3">
                            <h3>Watering</h3>

                            <p> A mechanism for automatic watering using a water pump after of monitoring and
                                evaluation of data.</p>
                        </div>
                    </div>
                    <div class="clearfix visible-lg"></div>
                </div>

            </div>


            <div id="rightlog" class="col-sm-4">

                <img class="img-responsive" alt="Notifications" width="80" height="70"
                     src="${pageContext.request.contextPath}/static/images/logo.png">

                <h4>Login to your account</h4>

                <div class="${alert_class}" role="alert"><b>${alert_message}</b></div>
                <form id="login_form" class="form-horizontal" accept-charset="UTF-8" action="login" method="post">
                    <div class="form-group">

                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="login-username" placeholder="Username"
                                   name="username_n" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="login-password" placeholder="Password"
                                   name="password_n" required/>

                        </div>
                    </div>

                    <%--<a id="register" style="cursor: pointer">Register</a>--%>
                    <%--<a id="forgotpass" style="cursor: pointer">Forgot your password?</a>--%>

                    <button id="logbutton" type="submit" class="btn btn-primary btn-medium" name="logform" value="LOGIN"
                            form="login_form">Log in
                    </button>
                </form>

                <button id="register" class="btn btn-link">Register</button>
                <button id="forgotpassbtn" class="btn btn-link">Forgot your password?</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="Shared/footer.jsp"/>

</body>

<script src="<c:url value='/static/js/user-change-password.js'/>"></script>
</html>