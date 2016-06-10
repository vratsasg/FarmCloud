<%--
  Created by IntelliJ IDEA.
  User: DimDesktop
  Date: 17/1/2016
  Time: 11:52 μμ
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title></title>
</head>
<body>
<footer class="footer">
    <div class="container" style="float: right">
        <%java.text.DateFormat df = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
        <h5>&copy; <%= df.format(new java.util.Date()) %> eAggricultural web app </h5>
        <%--<p class="text-muted"></p>--%>
    </div>
</footer>
</body>
</html>
