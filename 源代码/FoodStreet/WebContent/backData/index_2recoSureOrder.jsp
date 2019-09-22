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
		
		//接收参数 ：套餐名    菜品数组   
		String sqlPKName = request.getParameter("sqlPKName");
		String sqlPKFoods = request.getParameter("sqlPKFoods");
		System.out.println("index_2rexoSureOrder,sqlPKName=="+sqlPKName);
		
		//接收一个菜品list的信息  list
		/* Map<String, Integer> name_point = new HashMap<>();
		
		// 因为主键原因 这些数据插入股过一次再插就没用了 请更改数据 或更改订单号
		name_point.put("辣椒炒肉1",1);
		name_point.put("辣椒炒肉2",2);
		name_point.put("辣椒炒肉3",3);
		name_point.put("辣椒炒肉4",4);
		
		//这个1是 orderDao.Generate（）返回的订单号，name_point是  Map（菜名，评分）
		//                             订单号   价格price   菜品map
		/* int i=orderDao.update_orderlist(1, "123456", name_point);
		System.out.println(i);
		
		MenuDao dao=new MenuDao();
		menuBean bean =new menuBean();
		bean.setName(name);
		bean.setSerial(serial);
		bean.setPrice(price);
		bean.setKind(kind);
		bean.setMean(mean);
		bean.setProfit_margin(profit_margin);
		bean.setPhoto(photo);
		bean.setMaterial(material);
		bean.setSales(sales); */
		
		/* int result = dao.addMenu(bean);
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
		pw.write(jsonString); */ 
%>