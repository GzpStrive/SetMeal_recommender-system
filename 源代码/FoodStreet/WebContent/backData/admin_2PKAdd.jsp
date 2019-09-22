<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="entity.PackageBean"%>
<%@page import="dao.PackageDao"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="entity.Admin"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
		//参数中文
		request.setCharacterEncoding("utf-8");

		//接收参数		
		String name = request.getParameter("name");
		String Scene  = request.getParameter("Scene");
		String reason =request.getParameter("reason");
		String sale =request.getParameter("sales");
		int sales =Integer.parseInt(sale);
		System.out.println("admin_modifydo,name=="+name+";Scene=="+Scene+";sales=="+sales);
		PackageDao dao=new PackageDao();
		PackageBean bean=new PackageBean();
		bean.setName(name);
		bean.setNumber("8");
		bean.setScene(Scene);
		bean.setReason(reason);
		bean.setPrice("666");
		bean.setSales(sales);
		int result=dao.AddPackage(bean);
		String jsonString = "";
		Map<String,Object> map = new HashMap<String,Object>();
		if(result==1){
			map.put("code", "1");
			map.put("data", "成功");
		}else{
			map.put("code", "2");
		}
		Gson gson = new Gson();   //google提供一个转换json的类
		jsonString = gson.toJson(map);
		response.setContentType("application/json;charset=utf-8");
		PrintWriter pw = response.getWriter();
		pw.write(jsonString);
%>