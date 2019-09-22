<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="entity.Admin"%>
<%@page import="dao.AdminDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
		//参数中文
		request.setCharacterEncoding("utf-8");
		//接收参数
		String No = "1";
		//System.out.println("connectUsdo,No=="+No);
		AdminDao dao1 = new AdminDao();
		Admin admin = dao1.selectAdmin(No);
		
		System.out.println(""+admin);
		String jsonString = "";
		Map<String,Object> map = new HashMap<String,Object>();
		if (admin!=null){
			map.put("code", "1");
			map.put("data", admin);
		}else{
			map.put("code", "2");
		}
		Gson gson = new Gson();   //google提供一个转换json的类
		jsonString = gson.toJson(map);
		response.setContentType("application/json;charset=utf-8");
		PrintWriter pw = response.getWriter();
		pw.write(jsonString);	
%>