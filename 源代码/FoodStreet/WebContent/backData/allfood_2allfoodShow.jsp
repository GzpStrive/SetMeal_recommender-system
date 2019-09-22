<%@page import="java.io.PrintWriter"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="entity.menuBean"%>
<%@page import="dao.MenuDao"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
			//最终以  sql = "select * from menu where "+key+" like "+"'%"+value+"%'"+""; 语句服务
			String sqlkey = request.getParameter("sqlkey");  //sqlvalue  是sql里面的key
			String sqlvalue = request.getParameter("sqlvalue");  //sqlvalue  是sql里面的value
			System.out.println("allfood_2allfoodShow,sqlkey,sqlvalue=="+sqlkey+sqlvalue);
			
			MenuDao dao=new MenuDao();
			menuBean bean =new menuBean();
			List<menuBean> lists=null;
			lists=dao.findMenuByKey(sqlkey, sqlvalue);
			
			String jsonString = "";
			Map<String,Object> map = new HashMap<String,Object>();
			if (lists!=null){
				map.put("code", "1");
				map.put("data", lists);
			}else{
				map.put("code", "2");
				map.put("data","allfood_2allfoodShow，获取到的菜品列表为空值");
			}
			Gson gson = new Gson();   //google提供一个转换json的类
			jsonString = gson.toJson(map);
			response.setContentType("application/json;charset=utf-8");
			PrintWriter pw = response.getWriter();
			pw.write(jsonString);	
%>
