<%@page import="entity.menuBean"%>
<%@page import="dao.MenuDao"%>
<%@page import="java.util.List"%>
<%@page import="entity.PackageBean"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="entity.Admin"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
		//参数中文
		request.setCharacterEncoding("utf-8");
		
		//System.out.println("connectUsdo,No=="+No);
		MenuDao dao = new MenuDao();
		List<menuBean> list =  dao.findAllMenu();
		
		String jsonString = "";
		Map<String,Object> map = new HashMap<String,Object>();
		if (list!=null){
			map.put("code", "1");
			map.put("data", list);
		}else{
			map.put("code", "2");
		}
		Gson gson = new Gson();   //google提供一个转换json的类
		jsonString = gson.toJson(map);
		response.setContentType("application/json;charset=utf-8");
		PrintWriter pw = response.getWriter();
		pw.write(jsonString);	
%>