<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dao.OrderDao"%>
<%@page import="entity.UserBean"%>
<%@page import="entity.combinationBean"%>
<%@page import="entity.Admin"%>
<%@page import="dao.AdminDao"%>
<%@page import="main.java.util.WebUtil"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	WebUtil.setEncoding(request, response);
    //-- 订单表字段：orderNo name tel time deskcount price source age Scene append-->
	//接收参数
	String name =request.getParameter("name");
	String tel =request.getParameter("tel");
	String deskcount = request.getParameter("deskcount");
	String price = request.getParameter("price");
	String source = request.getParameter("source");
	String age = request.getParameter("age");
	String Scene = request.getParameter("Scene");
	String append = request.getParameter("append");
	String remember = request.getParameter("remember");
	int is_xiadan = 0;
	int orderNo=0;
	UserBean usBean =new UserBean();
	usBean.setAge(age);
	usBean.setAppend(append);
	usBean.setDeskcount(deskcount);
	usBean.setIs_xiadan(is_xiadan);
	usBean.setName(name);
	usBean.setScene(Scene);
	usBean.setSource(source);
	usBean.setTel(tel);
	usBean.setPrice("0");
	
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");  
	String time = df.format(System.currentTimeMillis());  
	System.out.println("index_1formdo,当前时间="+time);
	
	
	System.out.println("index_1formdo,remember="+remember);
	if(remember==null){
		usBean.setCheckd(false);
	}else{
		usBean.setCheckd(true);
	}
	System.out.println("index_1formdo,name="+name);
	
	//System.out.println("logindo,admin=="+admin);
	if(usBean.isCheckd()){
		//System.out.println("logindo,isAdmin=="+isAdmin);
		if(null!=usBean){
			OrderDao orderDao = new OrderDao();
			orderNo=orderDao.Generate(name, tel, time, deskcount, source, age,Scene, append);
			System.out.println("index_1formdo,orderNo=="+orderNo);
			if(orderNo!=0){
				System.out.println("index_1formdo,存入用户信息到数据库成功");
			}
			usBean.setOrderNo(orderNo);
			usBean.setTime(time);
			session.setAttribute("user_info",usBean);   //将会话设置一个名字为admin的属性，内容为admin对象
			response.sendRedirect("../index.jsp");
			
		}
	}else{
		session.setAttribute("user_info",usBean);
		System.out.println("index_1formdo，不存入数据库");
		response.sendRedirect("../index.jsp");
		
	}
%>