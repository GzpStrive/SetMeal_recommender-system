<%@page import="entity.PackageBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="dao.PackageDao"%>
<%@page import="java.util.Random"%>
<%@page import="PythonFile.pyTest"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.google.gson.Gson"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
		//参数中文
		request.setCharacterEncoding("utf-8");
		//接收参数
		String foodcarArr = request.getParameter("foodcarArr");
		System.out.println("allfood_5showPKRecomm,foodcarArr=="+foodcarArr);
		Random ra =new Random();
		Map<String, Integer> name_point = new HashMap<>();
		String[] foods = foodcarArr.split(",");
		for(String food:foods){
			int point = ra.nextInt(5)+1;
			name_point.put(food,point );
		}
		System.out.println(name_point);
		pyTest pyT = new pyTest();
		//本地
		//Map<Integer, String> map2 = pyT.get_pack2(name_point,request.getSession().getServletContext().getRealPath("/"));
		//云服务器
		Map<Integer, String> map2 = pyT.get_pack(name_point);  
		//System.out.println("allfood_5showPKRecomm,map2=="+map2);
		
		//获取对应id的  套餐  数组  list
		PackageDao dao=new PackageDao();
		List<Integer> PKNoli = new ArrayList<Integer>();  //推荐的套餐ID数组
		List<String> ImgLi = new ArrayList<String>();  //销量最好的图片数组
		for(int i=0;i<map2.size();i++){
			Integer PKNo = Integer.valueOf(map2.get(i));
			PKNoli.add( PKNo );   						//PKNoli是套餐数组
			String Img=dao.findImgByPaKName(PKNo);
			ImgLi.add(Img);
		}
		
		List<PackageBean> PKlist =new ArrayList<PackageBean>();
		try {
			PKlist =  dao.findPKByPKNoLi(PKNoli);  //获取套餐数组
			for(PackageBean pk: PKlist){
			}
			//System.out.println("allfood_5showPKRecomm,PKlist===="+PKlist);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			PKlist=null;
			e.printStackTrace();
		}
		
		String jsonString = "";
		Map<String,Object> map = new HashMap<String,Object>();
		if (PKlist!=null && PKlist.size()>0){
			map.put("code", "1");
			map.put("pklist", PKlist);
			map.put("ImgLi", ImgLi);
		}else if(PKlist!=null && PKlist.size()==0){
			map.put("code", "2");
			map.put("data", "暂无推荐");
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