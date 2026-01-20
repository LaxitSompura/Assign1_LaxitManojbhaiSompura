<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="model.Registration" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Success</title>
</head>
<body>

<%
    Registration r = (Registration) request.getAttribute("reg");
%>

<h2>Form submitted successfully ✅</h2>

<p><b>User ID:</b> <%= (r != null) ? r.getUserId() : "" %></p>
<p><b>Name:</b> <%= (r != null) ? r.getName() : "" %></p>
<p><b>Country:</b> <%= (r != null) ? r.getCountry() : "" %></p>
<p><b>Email:</b> <%= (r != null) ? r.getEmail() : "" %></p>

<a href="index.jsp">Back</a>

</body>
</html>
