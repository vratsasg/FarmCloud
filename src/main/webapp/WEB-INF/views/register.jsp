<%--
  Created by IntelliJ IDEA.
  User: DimDesktop
  Date: 14/3/2016
  Time: 10:08 μμ
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register</title>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
          integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"
            integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>


    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/app.css">

</head>
<body>

<jsp:include page="Shared/navbar.jsp"/>

<div class="${alert_class}" role="alert" ><b>${alert_message}</b></div>
<form id="register_form" class="form-horizontal" accept-charset="UTF-8" action="register" method="post">
    <div class="form-group">

        <div class="col-sm-2">
            <input type="text" class="form-control" id="register-username" placeholder="Username" name="username_n" required>
            <span class="text-danger"> You have to enter username</span>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-2">
            <input type="email" class="form-control" id="register-email" placeholder="Password" name="password_n" required />
            <span class="text-danger"> You have to enter a valid email address</span>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-2">
            <input type="password" class="form-control" id="register-password" placeholder="Password" name="password_n" required />
            <span class="text-danger"> You have to enter password</span>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-2">
            <input type="password" class="form-control" id="register-repassword" placeholder="Password" name="password_n" required />
            <span class="text-danger"> You have to retype password</span>
        </div>
    </div>

    <ul style="padding-left: 20px;">
        <li style="display: inline;"><a href="index">Log in</a></li>
        <li style="display: inline;"><a id="forgotpassnotif" >Forgot your password?</a></li>
        <li style="display: inline;"><button id="logbutton" type="submit" class="btn btn-primary btn-medium" name="regform" value="REGISTER" form="register_form_form" >Register</button></li>
    </ul>


</form>
</div>

<jsp:include page="Shared/footer.jsp"/>


</body>
</html>
