<%@page import="entity.User"%>
<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>
<style type="text/css">
	.header_li{
	font-size: 130%;
	font-weight: bold;
	}
	.header{
	clear:both;
	margin-top: 15px;
	margin-bottom: 15px;
	width: 100%;
	float: left;
	}
	.index_title{
	clear:both;
	margin:0 auto;
	width:100%;
	padding: 100;
	font-weight: bold;
	list-style:none;
	color: #000000;
	font-size: 200%;
	float:left;
	}
	.MaleList{
	clear:both;
	padding: 0px 0 0 0;
	}
	.MaleList_text{
	float:left;
	width:25%;
	font-size: 110%;
	font-weight:bold;
	display: inline;
	padding: 2%;
	}
	/*方形状变椭圆风格*/
	.Foodbtn{
			margin:0 auto;   
			width: 80%;  
			font-size:130%;        
			color: white;
			border-radius:10%;
			background: rgb(100 149 237);
			margin-bottom: 7%;
			text-decoration:none;
			/*transition: width 1s;*/    
			/*all所有元素发生变化用这个控制*/ 
			transition: all 0.3s;
	}    	
	.Foodbtn:hover{
		cursor:pointer;
		font-size:130%;
		font-weight:bold;
		width: 85%; 
		border-radius:50%;
		color: black;
		background: rgb(248 248 255);   
	}
	.index_title{
			clear:both;
			margin:0 auto;
			width:100%;
			padding: 100;
			font-weight: bold;
			list-style:none;
			color: #000000;
			font-size: 200%;
			float:left;
			}
	.ahover{
		float:left;
		font-size:130%;
		margin-top:1%;
		width: 80%;
		transition: all 0.4s;
		color: white;
	}
	.ahover:hover{
		text-decoration:none;/*是a标签下划线去掉*/
		border-radius:50%;
		font-size:131%;
		font-weight:bold;
		width:85%;
		background: rgb(245 245 245);
	}
</style>
<!-- ZUI 标准版压缩后的 CSS 文件 -->
<link  href="zui-1.9.0/dist/css/zui.min.css" rel="stylesheet" type="text/css"/>

<!-- ZUI Java脚本 依赖 jQuery -->
<script  type="text/javascript"  src="zui-1.9.0/dist/lib/jquery/jquery.js"></script>
<!-- ZUI 标准版压缩后的 JavaScript 文件 -->
<script  type="text/javascript" src="zui-1.9.0/dist/js/zui.min.js"></script>


<div id="header" style="width: 80%; margin: 0 auto; height: 80px;">
	<!-- 标题图标 -->
	<div id="logo" style="float:left;width: 30%;">
		<h1 style="font-size: 40px;">福满轩</h1>
	</div>

	
	<!-- 菜单栏 -->
	<div id="menu"  style="float:right; padding: 20px 0 0 0;">
		<ul class="nav nav-pills" class="nav nav-pills">
			<li class="header_li"  ><a  href="index.jsp">首页</a></li>
			<li class="header_li"  ><a  href="allfood.jsp">所有菜品</a></li>
			<li class="header_li"  ><a  href="admin.jsp">管理员</a></li>
			
			<!-- 检查用户是否登陆 
			< %
				User user = (User)session.getAttribute("user1");
				if(user==null){
					%>
					<li class="header_li" onclick=""><a href="login.jsp">登陆</a></li>
					<!--  li class="header_li" onclick=""><a href="register.jsp">注册</a></li-->
					
				<!--	< %
				}else{
					if("boy".equals(user.getGender())){
						%>
							<li class="dl_img"><a href="#"><img src="img/boy.png" height="40" ></a></li>
							<li><a href="cancel.do" onclick="return confirm('是否确定注销登陆?');"  style="text-decoration: underline;color: #2055ce;">< %=user.getUsername()%></a></li>
						< %
					}else{
						%>
							<li class="dl_img"><a href="#"><img src="img/girl.png" height="40"></a></li>
							<li><a href="cancel.do" onclick="return confirm('是否确定注销登陆?');" style="text-decoration: underline;color: #2055ce" >< %=user.getUsername()%></a></li>
						< %
					}
				}
			%>-->
				
		</ul>
	</div>
</div>