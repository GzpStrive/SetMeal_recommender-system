<%@page import="entity.Admin"%>
<%@page import="dao.AdminDao"%>
<%@page import="main.java.util.WebUtil"%>
<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>

<head>
<meta charset="UTF-8">
<title>正在登陆</title>

<!-- ZUI 标准版压缩后的 CSS 文件 -->
<link  href="zui-1.9.0/dist/css/zui.min.css" rel="stylesheet" type="text/css"/>

<!-- ZUI Java脚本 依赖 jQuery -->
<script  type="text/javascript"  src="zui-1.9.0/dist/lib/jquery/jquery.js"></script>
<!-- ZUI 标准版压缩后的 JavaScript 文件 -->
<script  type="text/javascript" src="zui-1.9.0/dist/js/zui.min.js"></script>
<style type="text/css">
	@import url("css/Admin.css");
</style>
</head>

<body>
<div align="center" style="margin: 0 auto;">
	<div id="loginCircle" data-loading="正在加载..." class="load-indicator loading" 
		 style="width: 100px; height: 100px; ">
	</div>
	<div id="loginSucc" style="width:30%;">
		若一直在此界面请和管理员联系
		电话：110
	</div>
<%
	WebUtil.setEncoding(request, response);
	String telephone =request.getParameter("telephone");
	String pwd =request.getParameter("pwd");
	String isAdmin = request.getParameter("isAdmin");
	if(isAdmin==null){ isAdmin="none";}
	System.out.println("logindo,isAdmin="+isAdmin);
	AdminDao dao =new AdminDao();
	Admin admin =dao.login(telephone, pwd);
	//System.out.println("logindo,admin=="+admin);
	if(isAdmin.equals("on")){
		//System.out.println("logindo,isAdmin=="+isAdmin);
		if(null!=admin){
			session.setAttribute("admin",admin);   //将会话设置一个名字为admin的属性，内容为admin对象
			response.sendRedirect("admin.jsp");
			System.out.println("hear");
		}else{
%>
			<script type="text/javascript">
			//将内容改变成密码错误的情况
			$(document).ready(function(e){
		        $('#loginSucc').html('<div>密码或帐号错误，请重试<div/><div class="Foodbtn" style="width:30%;"><a href="login.jsp">返回</div>');
		    })
		    </script>
		<%
		}
	}else{
		%>
			<script type="text/javascript">
			//将内容改正
			$(document).ready(function(e){
		        $('#loginSucc').html('<div>您不是管理员<div/><div class="Foodbtn" style="width:30%;"><a href="login.jsp">返回</div>');
		    })
			</script>
<%
	}
%>
</div>
</body>