<%@page import="dao.combinationDao"%>
<%@page import="entity.PackageBean"%>
<%@page import="dao.PackageDao"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="entity.menuBean"%>
<%@page import="dao.MenuDao"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
			//最终以  sql = "select *  from package where Scene="+Scene+""; 语句服务
			String sqlScene = request.getParameter("sqlScene");  //sqlScene  是sql里面的Scene
			
			System.out.println("index_2reco_showTopPK,sqlScene=="+sqlScene);
			
			PackageDao PKdao=new PackageDao();
			combinationDao cbDao = new combinationDao();
			List<PackageBean> lists = PKdao.findPKByPaKName(sqlScene);
			
			List<PackageBean> lists1=lists;
			
			//用来存套餐菜品数据的map
			Map<String,Object> mnmap = new HashMap<String,Object>();
			int mnlistIndex=0;    //菜品list的下标（键值）
			for(PackageBean pk:lists1){
				String PKName =pk.getName();
				List<menuBean> mnlist=cbDao.findMenuNoByPKName(PKName);
				if(mnlist!=null){
					mnlistIndex++;
					String mnlistKey=""+mnlistIndex;
					mnmap.put(mnlistKey, mnlist);
				for(menuBean menu:mnlist) {
					System.out.println("index_2reco_showTopPK,menu=="+menu.getName());
					}
				}
			}
			//System.out.println("index_2reco_showTopPK,list=="+lists);
			
			
			String jsonString = "";
			Map<String,Object> map = new HashMap<String,Object>();
			if (lists!=null && mnmap.size()==0){
				map.put("code", "1");
				map.put("data", lists);
				map.put("mnmap","0");
			}else if(lists!=null&&mnmap.size()>0){
				map.put("code", "2");
				map.put("data", lists);
				map.put("mnmap",mnmap);
			}else
			{
				map.put("code", "0");
				map.put("data","index_2reco_showTopPK，获取到的套餐列表为空值");
			}
			Gson gson = new Gson();   //google提供一个转换json的类
			jsonString = gson.toJson(map);
			response.setContentType("application/json;charset=utf-8");
			PrintWriter pw = response.getWriter();
			pw.write(jsonString);
%>
