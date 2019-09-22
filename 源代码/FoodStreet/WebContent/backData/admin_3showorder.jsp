<%@page import="java.util.ArrayList"%>
<%@page import="PythonFile.call_python"%>
<%@page import="entity.UserBean"%>
<%@page import="dao.OrderDao"%>
<%@page import="java.util.List"%>
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
		String way1 = request.getParameter("way");
		System.out.println("admin_3showorder,way1=="+way1);
		String way="*";
		if(way1.equals("下单用户")){
			way="1";
		}else if(way1.equals("未下单用户")){
			way="0";
		}

		OrderDao dao = new OrderDao();
		List<UserBean> list =  dao.findOrderByXiadan(way);
		List<UserBean> list2 = new ArrayList<UserBean>();
		if(way1.equals("未下单用户")){   ///这里判断用户时候会下单
			call_python calpy = new call_python();
			Map<Integer, String> map1 = new HashMap<Integer, String>();
			int x=10;
			if(list.size()>15){
				x=15;
			}else{
				x=list.size();
			}
			for(int i=0;i<x;i++){
				UserBean us=list.get(i);
				String deskcount = us.getDeskcount();
				String price = us.getPrice();
				String source = us.getSource();
				String age = us.getAge();
				String Scene = us.getScene();
				String append = us.getAppend();
				//记得上云的时候要换下方法成get_isOrder
				//map1 = calpy.get_isOrder1(deskcount, price, source, age, Scene, append,request.getSession().getServletContext().getRealPath("/"));
				//云服务器
				map1 = calpy.get_isOrder(deskcount, price, source, age, Scene, append);     
				System.out.println("connectUsdo,map1=="+map1.get(0));
				if(map1.get(0).equals("1.0")){
					us.setCheckd(true);
				}else{
					us.setCheckd(false);
				}
				list2.add(i, us);
			}
		}
		String jsonString = "";
		Map<String,Object> map = new HashMap<String,Object>();
		if (list!=null&&way!="0"){
			map.put("code", "1");
			map.put("data", list);
		}else if((list2!=null||list2.size()>0)&&way=="0"){
			map.put("code", "2");
			map.put("data", list2);
		}
		else{
			map.put("code", "0");
			map.put("data", "查询失败，请联系管理员进行修复");
		}
		Gson gson = new Gson();   //google提供一个转换json的类
		jsonString = gson.toJson(map);
		response.setContentType("application/json;charset=utf-8");
		PrintWriter pw = response.getWriter();
		pw.write(jsonString);	
%>