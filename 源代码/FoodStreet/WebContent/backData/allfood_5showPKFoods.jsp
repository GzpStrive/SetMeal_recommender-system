<%@page import="java.io.PrintWriter"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="entity.menuBean"%>
<%@page import="java.util.List"%>
<%@page import="dao.combinationDao"%>
<%@page import="dao.PackageDao"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
		//参数中文
		request.setCharacterEncoding("utf-8");
		//接收参数
		String PKName = request.getParameter("sqlPKName");
		System.out.println("allfood_5showPKFoods,PKName=="+PKName);
		
		PackageDao pkdDao = new PackageDao();
		combinationDao cbDao = new combinationDao();
		
		List<menuBean> mnlist =   cbDao.findMenuNoByPKName(PKName);
		
		String jsonString = "";
		Map<String,Object> map = new HashMap<String,Object>();
		if (mnlist!=null && mnlist.size()>0){
			map.put("code", "1");
			map.put("mnlist", mnlist);
		}else if(mnlist!=null && mnlist.size()==0){
			map.put("code", "2");
			map.put("data", "暂无信息");
		}else{
			map.put("code", "0");
			map.put("data", "获取数据失败，请联系程序员修复");
		}
		Gson gson = new Gson();   //google提供一个转换json的类
		jsonString = gson.toJson(map);
		response.setContentType("application/json;charset=utf-8");
		PrintWriter pw = response.getWriter();
		pw.write(jsonString); 
%>

