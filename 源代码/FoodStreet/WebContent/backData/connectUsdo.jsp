<%@page import="PythonFile.pyTest"%>
<%@page import="PythonFile.call_python"%>
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
		String No = request.getParameter("No");
		System.out.println("connectUsdo,No=="+No);
		
		String deskcount = "10";
		String price = "999";
		String source = "朋友推荐";
		String age = "15-20岁";
		String Scene = "婚宴";
		String append = "1000元档/每桌";
		call_python calpy = new call_python();
		Map<Integer, String> map1 = calpy.get_isOrder1(deskcount, price, source, age, Scene, append,request.getSession().getServletContext().getRealPath("/"));
		System.out.println("connectUsdo,map1=="+map1);
		AdminDao dao1 = new AdminDao();
		Admin admin = dao1.selectAdmin(No);
		
		//测试pyTest   返回套餐id数组  (这是套餐推荐)
		Map<String, Integer> name_point = new HashMap<>();
		name_point.put("厦门沙茶面",1);
		name_point.put("自制湖南剁辣椒",2);
		name_point.put("包菜牛肉丝炒粿条",3);
		name_point.put("肉饼包菜炒粿条",4);
		pyTest pyT = new pyTest();
		Map<Integer, String> map2 = pyT.get_pack2(name_point,request.getSession().getServletContext().getRealPath("/"));
		System.out.println("connectUsdo,map2=="+map2);
		
		//测试call_python   返回  （菜名map）  (这是协同过滤的单品推荐)
		String OrderNo = "1111";
		Map<Integer, String> map3 = calpy.get_xtgl1(name_point, OrderNo, request.getSession().getServletContext().getRealPath("/"));
		System.out.println("connectUsdo,map3=="+map3);
		
		
		Map<Integer, String> map4 =pyT.get_rules1(name_point, request.getSession().getServletContext().getRealPath("/"));
		System.out.println("connectUsdo,map4=="+map4);
		//返回json数据
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