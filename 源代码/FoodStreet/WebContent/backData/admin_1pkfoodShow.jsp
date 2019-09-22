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
			//最终以  sql = "select mn.* from combination cb inner join menu mn where mn.menuNo=cb.menuNo AND cb.packageNo=(select pk.packageNo from package pk where pk.name = '"+PKName+"')"; 语句服务
			String sqlPKName = request.getParameter("sqlPKName");  //sqlvalue  是sql里面的key
			System.out.println("admin_1spkfoodShow(),sqlPKName==="+sqlPKName);
			
			combinationDao dao2=new combinationDao();
			menuBean bean =new menuBean();
			List<menuBean> lists=null;
			lists=dao2.findMenuNoByPKName(sqlPKName);
			
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
