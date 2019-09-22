<%@page import="java.util.ArrayList"%>
<%@page import="dao.combinationDao"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="entity.menuBean"%>
<%@page import="dao.MenuDao"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
			String sqlPKName = request.getParameter("sqlPKName");  
			String sqlMNName = request.getParameter("sqlMNName");
			String sqldowhat = request.getParameter("sqldowhat");
			
			System.out.println("admin_1doPK_MN(),sqlPKName==="+sqlPKName+";sqldowhat=="+sqldowhat);
			
			combinationDao dao=new combinationDao();
			int issucc=0;
			if(sqldowhat.equals("add")){
				List<menuBean> lists=new ArrayList<menuBean>();
				lists=dao.findMenuNoByPKName(sqlPKName);
				System.out.println("admin_1doPK_MN(),lists==="+lists);
				if (lists!=null){
					int allprice=0;
					int number =  lists.size()+1;
					for(menuBean bean:lists){
						allprice+=Integer.valueOf( bean.getPrice());
					}
					issucc =  dao.addCom_Pk(sqlPKName, sqlMNName, number, allprice);
				};
			}
			
			String jsonString = "";
			Map<String,Object> map = new HashMap<String,Object>();
			if (issucc!=0){
				map.put("code", "1");
				map.put("data", "操作成功");
			}else{
				map.put("code", "2");
				map.put("data","admin_1doPK_MN，更改表combination失败");
			}
			Gson gson = new Gson();   //google提供一个转换json的类
			jsonString = gson.toJson(map);
			response.setContentType("application/json;charset=utf-8");
			PrintWriter pw = response.getWriter();
			pw.write(jsonString);	
%>
