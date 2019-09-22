<%@page import="java.io.PrintWriter"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.Map"%>
<%@page import="PythonFile.pyTest"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
		//参数中文
		request.setCharacterEncoding("utf-8");     
		//接收参数
		String material =request.getParameter("material");
		System.out.println("admin_2AIprice,material==="+material);
		System.out.println(material);
		pyTest pT = new pyTest();
		//本地
		//Map<Integer, String> map2=pT.get_price2(material, request.getSession().getServletContext().getRealPath("/"));
		//云服务器
		Map<Integer, String> map2 = pT.get_p(material);   
		System.out.println("admin_2AIprice,map2==="+map2.size());
		
		Random ra =new Random();
		String AIprice=String.valueOf(ra.nextInt(100)+50);
		if(map2!=null &&  map2.size()>0){
			AIprice=  map2.get(0);
		}
		
		
		String jsonString = "";
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("code", "1");
		map.put("ai_price", AIprice);
		map.put("map2",map2.get(0));
		Gson gson = new Gson();   //google提供一个转换json的类
		jsonString = gson.toJson(map);
		response.setContentType("application/json;charset=utf-8");
		PrintWriter pw = response.getWriter();
		pw.write(jsonString);
%>