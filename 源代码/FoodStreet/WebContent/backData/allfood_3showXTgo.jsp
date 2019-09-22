<%@page import="PythonFile.call_python"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="entity.menuBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="dao.MenuDao"%>
<%@page import="PythonFile.pyTest"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Random"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
		//参数中文
		request.setCharacterEncoding("utf-8");
		//接收参数
		String foodcarArr = request.getParameter("foodcarArr");
		String OrderNo = request.getParameter("orderNo");
		System.out.println("allfood_3showXTgo,foodcarArr=="+foodcarArr);
		Random ra =new Random();
		Map<String, Integer> name_point = new HashMap<String, Integer>();
		String[] foods = foodcarArr.split(",");
		for(String food:foods){
			int point = ra.nextInt(5)+1;
			name_point.put(food,point );
		}
		System.out.println(name_point);
		call_python calpy = new call_python();
		//本地
		//Map<Integer, String> map2 = calpy.get_xtgl1(name_point,OrderNo,request.getSession().getServletContext().getRealPath("/"));
		//云服务器
		Map<Integer, String> map2 = calpy.get_xtgl(name_point, OrderNo);  
		System.out.println("allfood_3showXTgo,map2======"+map2);
		
		//根据菜品名的map    获取到菜品名数组    再来    获取到menu的 数组  
		MenuDao dao=new MenuDao();
		List<String> MNNameli = new ArrayList<String>();  //推荐的菜品名数组
		for(int i=0;i<map2.size();i++){
			String PKNo = map2.get(i);
			MNNameli.add( PKNo );   						//MNNameli是菜品名数组
		}
		
		List<menuBean> MNlist =new ArrayList<menuBean>();
		try {
			MNlist =  dao.findMNBynameLi(MNNameli);  //获取menu的 数组     
			for(menuBean mn: MNlist){
			}
			System.out.println("allfood_3showXTgo,MNlist====="+MNlist);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			MNlist=null;
			e.printStackTrace();
		}
		
		String jsonString = "";
		Map<String,Object> map = new HashMap<String,Object>();
		if (MNlist!=null && MNlist.size()>0){
			map.put("code", "1");
			map.put("mnlist", MNlist);
		}else if(MNlist!=null && MNlist.size()==0){
			map.put("code", "2");
			map.put("data", "暂无推荐");
		}else{
			map.put("code", "0");
			map.put("data", "allfood_3showXTgo===获取数据失败，请联系程序员修复");
		}
		Gson gson = new Gson();   //google提供一个转换json的类
		jsonString = gson.toJson(map);
		response.setContentType("application/json;charset=utf-8");
		PrintWriter pw = response.getWriter();
		pw.write(jsonString);
%>