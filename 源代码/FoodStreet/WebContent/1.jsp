<%@page import="java.util.Map"%>
<%@page import="PythonFile.call_python"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
request.setCharacterEncoding("utf-8");
String deskcount = "10";
String price = "999";
String source = "朋友推荐";
String age = "15-20岁";
String Scene = "婚宴";
String append = "1000元档/每桌";
call_python calpy = new call_python();
System.out.println("-------"+request.getSession().getServletContext().getRealPath("/"));

Map<Integer, String> map = calpy.get_isOrder2(request.getSession().getServletContext().getRealPath("/"));

System.out.println("connectUsdo,map1===="+map);

%>
<body>
123----
 <%for (Integer i : map.keySet()){ %>
 <%=map.get(i) %>
 	<%} %>
</body>
</html>