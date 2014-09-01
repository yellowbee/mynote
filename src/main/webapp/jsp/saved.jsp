<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<html>
<head>
	<base href="<%=basePath%>" />
</head>

<body>
	<p>Document saved!</p>
	<a href="hello">return</a>
</body>

</html>