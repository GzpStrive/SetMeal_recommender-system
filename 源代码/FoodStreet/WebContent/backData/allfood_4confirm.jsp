<%@page import="dao.OrderDao"%>
<%@page import="entity.menuBean"%>
<%@page import="dao.MenuDao"%>
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
		String foodcarArr = request.getParameter("foodcarArr");
		String price = request.getParameter("price");
		String orderId = request.getParameter("orderNo");
		int orderNo = Integer.parseInt(orderId);
		
		if(price==""){
			price="3000";
		}
		System.out.println("allfood_4confirm,foodcarArr=="+foodcarArr+";orderNo==="+orderNo);
		Map<String, Integer> name_point = new HashMap<>();
		String[] foods = foodcarArr.split(",");
		for(String food:foods){
			String[] item =food.split(":");
			name_point.put(item[0],Integer.parseInt(item[1]) );
		}
		
		System.out.println("allfood_4confirm,name_point=="+name_point);
		//因为主键原因 这些数据插入股过一次再插就没用了 请更改数据 或更改订单号
		OrderDao orderDao = new OrderDao();
		//这个1是 orderDao.Generate（）返回的订单号，name_point是  Map（菜名，评分）
		//                             订单号   价格price   菜品map
		int result=orderDao.update_orderlist(orderNo, price, name_point);
		System.out.println("allfood_4confirm,result=="+result);
		
		String jsonString = "";
		Map<String,Object> map = new HashMap<String,Object>();
		if(result!=0){
			map.put("code", "1");
			map.put("data", "预约成功");
		}else{
			map.put("code", "0");
			map.put("data","更新订单表失败");
		}
		Gson gson = new Gson();   //google提供一个转换json的类
		jsonString = gson.toJson(map);
		response.setContentType("application/json;charset=utf-8");
		PrintWriter pw = response.getWriter();
		pw.write(jsonString);
%>