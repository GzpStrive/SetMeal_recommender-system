<%@page import="entity.menuBean"%>
<%@page import="dao.MenuDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="entity.Backcolor"%>
<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>所有菜品</title>
<script>
//1_2.显示与隐藏 菜品分类面板的方法
function show(){
	var test_board=document.getElementById('test_board');
	test_board.style.display="block";
}
function noshow(){
	var test_board=document.getElementById('test_board');
	test_board.style.display="none";
}

function show1(){
	var test_board=document.getElementById('test_board1');
	test_board.style.display="block";
}
function noshow1(){
	var test_board=document.getElementById('test_board1');
	test_board.style.display="none";
}


function show2(){
	var test_board=document.getElementById('test_board2');
	test_board.style.display="block";
}
function noshow2(){
	var test_board=document.getElementById('test_board2');
	test_board.style.display="none";
}
//1_3.菜品是否已经加入购物车的方法
function addFood(Foodid){
	var choicefood = document.getElementById(Foodid);
	if (choicefood==null) {
		var choicefood =document.createElement('div');
		var theFood = "'"+Foodid+"'"
		//添加此标签的属性
		choicefood.innerHTML = '<div class="card"><div>'+Foodid+'</div><div class="Foodbtn" onclick="delFood('+theFood+')">删除菜品</div></div>';
		choicefood.id=Foodid;
		choicefood.style.width="95%";
		choicefood.style.margin="0 auto";
		choicefood.align="center";
		//添加到购物车
		var foodcar = document.getElementById('foodCar');
		foodcar.appendChild(choicefood);
		new $.zui.Messager('菜品已经添加', {
	        icon: 'heart', // 定义消息图标
	        type: 'success' // 定义颜色主题
	    }).show();
	} else {
		new $.zui.Messager('此菜品已存在', {
	        icon: 'bell', // 定义消息图标
	        type:"warning"
	    }).show();
	}
}


//删除菜品的方法
function delFood(Foodid){
	var foodcar1 = document.getElementById("foodCar1");
	var choicefood1 = document.getElementById(Foodid);
	choicefood1.parentNode.removeChild(choicefood1);
	new $.zui.Messager('此菜品已删除', {
		icon: 'bell', // 定义消息图标
		type: 'info' // 定义颜色主题
    }).show();
}

function showFood(Foodid){
	var choicefood =document.getElementById(Foodid);
	choicefood.style.display="block";
}

function noshowFood(Foodid){
	var choicefood =document.getElementById(Foodid);
	choicefood.style.display="none";
}
</script>
</head>    
<body>
<!-- 背景颜色 -->
<% 
	Backcolor bc=new Backcolor();
	bc.SetColor("淡兰云白");
	String backcolor=bc.getColor();
	String backcolor2="天空之镜";
	MenuDao dao=new MenuDao();
	menuBean bean =new menuBean();
%>


<!-- 一，头部目录  -->
<div style="width:100%; background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;
			background-size:contain;position:fixed;z-index: 101;">
	<%@include file="header.jsp"  %>
</div>


<!--二，主体样式  -->
<!-- 滚动条样式 -->
<div class="scrollbar-hover" style=" background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;background-size:contain; max-height: 700px; overflow: scroll;">   
	<div style="margin:0 auto; margin-top:100px; width: 80%;"  align="center" >
		<!-- 1_1.选择分类 -->
		<div style="width: 15%; float: left;height:360px;">
			<div class="header" style="width: 100%;float: left;">
				<ul>
					<li class="index_title">分类选择</li>
				</ul>
			</div>
			<div style="height:300px; width: 100%;float: left; background-size:contain;
					background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;"  >
				<ul class="nav nav-stacked" >
			  		<li class="active" onmousemove="show()" onmouseout="noshow()" style="width: 100%;">
			  			<a class="ahover" style="width:100%; font-size: 150%;">热门</a></li>
			  		<li                onmousemove="show1()" onmouseout="noshow1()">
			  			<a class="ahover" style="width:100%;font-size: 150%;">食材 </a></li>
			  		<li                onmousemove="show2()" onmouseout="noshow2()">
			  			<a class="ahover" style="width:100%;font-size: 150%;">菜系 </a></li>
			  		<li                onmousemove="show3()" onmouseout="noshow3()">
			  			<a class="ahover" style="width:100%;font-size: 150%;">口味 </a></li>
			  		
				</ul>
			</div>
			
		</div>
		<!-- 1_1.1.分类面板  热门 -->
		<div class="card" id="test_board" onmousemove="show()" onmouseout="noshow()" 
			 style="background:white; width:15%; height:300px;clear:both;z-index:100;
			position:absolute; top:170px;left:21.8%; display:none;background-size:contain;
			background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;">
			 <div class="">
			 
			 <%
			 //查找相应的菜系列表
			 List<menuBean> foodkindLi=dao.findKind();
			 for(menuBean kind:foodkindLi){
				%>

			 	<div style="width:48%;float: left;margin: 1%;" ><a class="ahover" href="allfood.jsp?foodK=<%=kind.getKind() %>"><%=kind.getKind() %> </a> </div>
			 <%} %>
			 </div>
			 <div class=""></div>
		</div>
		
		<!-- 1_1.1.分类面板食材 -->
		<div class="card" id="test_board1" onmousemove="show1()" onmouseout="noshow1()" 
			 style="background:white; width:15%; height:300px;clear:both;z-index:100;
			position:absolute; top:170px;left:21.8%; display:none;background-size:contain;
			background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;">
			 <div class="">
			 
			 <%List<String> foodnameLi1 = new ArrayList<String>();
			 for(int i=0;i<=11;i++){
				 
				 foodnameLi1.add(i, "肉类");};
				for(int i=0;i<=10;i++){%>

			 	<div style="width:48%;float: left;margin: 1%;" ><a class="ahover" href="allfood.jsp?foodC=<%=foodnameLi1.get(i) %>"> 肉类</a> </div>
			 <%} %>
			 </div>
			 <div class=""></div>
		</div>
		
		<!-- 1_1.2.分类面板  菜系 -->
		<div class="card" id="test_board2" onmousemove="show2()" onmouseout="noshow2()" 
			 style="background:white; width:15%; height:300px;clear:both;z-index:100;
			position:absolute; top:170px;left:21.8%; display:none;background-size:contain;
			background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;">
			 <div class="">
			 
			 <%List<menuBean> foodnameLi2=dao.findserial();
				for(menuBean menu:foodnameLi2) {
				%>

			 	<div style="width:48%;float: left;margin: 1%;" ><a class="ahover" href="allfood.jsp?foodS=<%=menu.getSerial() %>"> <%=menu.getSerial() %></a> </div>
			 <%} %>
			 </div>
			 <div class=""></div>
		</div>
			
		<!-- 1_1.3.分类面板 -->
		<div class="card" id="test_board3" onmousemove="show3()" onmouseout="noshow3()" 
			 style="background:white; width:15%; height:300px;clear:both;z-index:100;
			position:absolute; top:170px;left:21.8%; display:none;background-size:contain;
			background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;">
			 <div class="">
			 
			 <%List<String> foodnameLi3 = new ArrayList<String>();
			 for(int i=0;i<=11;i++){
				 
				 foodnameLi3.add(i, "肉类");};
				for(int i=0;i<=10;i++){%>

			 	<div style="width:48%;float: left;margin: 1%;" ><a class="ahover" href="allfood.jsp?foodC=<%=foodnameLi3.get(i) %>"> 肉类</a> </div>
			 <%} %>
			 </div>
			 <div class=""></div>
		</div>
		
		<!-- 1_2.所有菜品 -->
		<div style="width: 36%;float: left;margin-left: 1%;">
			<div class="header" style="width: 100%;float:left;">
				<ul>
					<li class="index_title">所有菜品</li>
				</ul>
			</div>
			<div class="scrollbar-hover" style="width:100%; height: 300px;background-size:contain;
					background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;
												float:left; overflow: scroll;">
			<%
			String foodK = request.getParameter("foodK");  //foodK  是种类Kind() 素菜荤菜
			String foodS = request.getParameter("foodS");  //foodS  是菜系Serial() 北京菜。。
			System.out.println("allfood,foodK,foodS=="+foodK+foodS);
			bean.setSerial("北京菜");      //默认设置的  菜品表
			List<menuBean> lists=dao.findMenuBySerials(bean);   
			
			if(foodK==null && foodS!=null){           //对于获得的参数的非空判断
				bean.setSerial(foodS);
				lists=dao.findMenuBySerials(bean);
			}else if(foodS==null && foodK!=null){
				bean.setKind(foodK);
				lists=dao.findMenuByKind(bean);
			}
			for(menuBean menu:lists) {
				String menuName=menu.getName();
				String menuPrice=menu.getPrice();
				String menuPothopath = menu.getPhoto();
			    int menuNo = menu.getMenuNo();
			 %>
			<div id="food<%=menuNo %>"  class="col-md-4 col-sm-6 col-lg-3" style="width:33%;margin-top:1%;">
				<div class="card"  >
			  		<!--  img src="images/login-pic/民男< %=i %>.jpeg" -->
			  		<img src="<%=menuPothopath %>" style="margin-top:8px; width: 60%;" alt="">
					<!-- 点击标签后直接加入已选菜品 -->
					<div class="caption">
						<div>菜品形容</div>
						<div>热度：（点击量）记1，销量加10</div>
						<div>近期热度：（最近一个月的销量加热度）</div>
					</div>
				    <div class="card-heading"><strong><%=menuName %></strong></div>
				    <div class="card-content text-muted">价格:￥<%=menuPrice %></div>
				    <div class="Foodbtn"  onclick="addFood('tFood<%=menuNo %>');">添加菜品</div>
			  	</div>
			</div>
			 <%} %>
			</div>
		</div>
	
		<!-- 1_3.菜品推荐 -->
		<div style="width: 23%;float: left;margin-left:1%;">
			<div class="header" style="width: 100%;float:left;">
				<ul>
					<li class="index_title">关联分析</li>
				</ul>
			</div>
			<div class="scrollbar-hover" style="width:100%; height: 300px; background-size:contain;
					background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;float:left; overflow: scroll;">
				<%
				bean.setSerial("北京菜");      //默认设置的  菜品表
				List<menuBean> lists3=dao.findMenuBySerials(bean);   
				
				if(foodK==null && foodS!=null){           //对于获得的参数的非空判断
					bean.setSerial(foodS);
					lists3=dao.findMenuBySerials(bean);
				}else if(foodS==null && foodK!=null){
					bean.setKind(foodK);
					lists3=dao.findMenuByKind(bean);
				}
				for(menuBean menu:lists3) {
					String menuName=menu.getName();
					String menuPrice=menu.getPrice();
					String menuPothopath = menu.getPhoto();
				    int menuNo = menu.getMenuNo();
				 %>
				<div id="food<%=menuNo %>"  class="col-md-4 col-sm-6 col-lg-3" style="width:50%;margin-top:2%;">
					<div class="card" >
				  		<!--  img src="images/login-pic/民男< %=i %>.jpeg"--> 
				  		<img src="<%=menuPothopath %>"	style="margin-top:8px; width: 60%;" alt="">
						<!-- 点击标签后直接加入已选菜品 -->
						<div class="caption">
							菜品形容
						</div>
					    <div class="card-heading"><strong><%=menuName %></strong></div>
					    <div class="card-content text-muted">价格:￥<%=menuPrice %></div>
					    <div class="Foodbtn"  onclick="addFood('tFood<%=menuNo %>');">添加菜品</div>
				  	</div>
				</div>
				 <%} %>
			</div>
		</div>
			
		<!-- 1_3.2菜品推荐 -->
		<div style="width: 23%;float: left;margin-left:1%;">
			<div class="header" style="width: 100%;float:left;">
				<ul>
					<li class="index_title">基于用户</li>
				</ul>
			</div>
			<div class="scrollbar-hover" style="width:100%; height: 300px; background-size:contain;
					background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;float:left; overflow: scroll;">
				<%for(int i=1;i<=4;i++){  %>
				<div id="food<%=i %>"  class="col-md-4 col-sm-6 col-lg-3" style="width:50%;margin-top:2%;">
					<div class="card" >
				  		<img src="images/login-pic/民男<%=i %>.jpeg" 
				  			style="margin-top:8px; width: 60%;" alt="">
							<%String price="￥100"; %>
						<!-- 点击标签后直接加入已选菜品 -->
						<div class="caption">
							菜品形容
						</div>
					    <div class="card-heading"><strong>菜品名</strong></div>
					    <div class="card-content text-muted">价格:<%=price %></div>
					    <div class="Foodbtn"  onclick="addFood('tFood<%=i %>');">添加菜品</div>
				  	</div>
				</div>
				 <%} %>
			</div>
		</div>	
				
		<!-- 1_4.已选择菜品 -->
		<div id="foodCar1"  style="width: 15.1%; float: left;">
			<div class="header" style="width: 100%;float:left;">
				<ul>
					<li class="index_title">已选商品</li>
				</ul>
			</div>
			
			<div id="foodCar" class="scrollbar-hover" align="center" style="width:100%; height: 300px;background-size:contain;
					background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;
												float:left; overflow: scroll;">
					
			</div>
		</div>
		
		
		<!-- 1_5.套餐推荐-->
		<div id="commendSuit"  style="width:60%; float: left;margin-left: 0.9%;">
			<!-- 标题部分 -->
			<div class="header" style="margin-top: 15px;margin-bottom: 15px;
				width: 100%;float:left;">
				<ul>
					<li class="index_title">猜你喜欢</li>
				</ul>
			</div>
			
			<!-- 5_2.推荐套餐 -->
			<div class="scrollbar-hover" style="width:100%; height: 300px; background-size:contain;
					background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;float:left; overflow: scroll;">
				<%@include file="allfood_5suitCommend.jsp" %>
			</div>
			
			
		</div>
		
		<!-- 1_6.相关推荐 -->
		<div style="width: 23%; float: left;margin-left: 1%;">
			
			<div class="header" style="width: 100%;float:left;">
				<ul>
					<li class="index_title">相关推荐</li>
				</ul>
			</div>
			<div class="scrollbar-hover" style="width:100%; height: 300px; background-size:contain;
				background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;float:left; overflow: scroll;">
				<%for(int i=1;i<=4;i++){  %>
				<div id="food<%=i %>"  class="col-md-4 col-sm-6 col-lg-3" style="width:50%;margin-top:2%;">
					<div class="card" >
				  		<img src="https://i3.meishichina.com/attachment/recipe/2019/05/23/20190523155861645722210138013.jpg"
				  			style="margin-top:8px; width: 60%;" alt="">
							<%String price="￥100"; %>
						<!-- 点击标签后直接加入已选菜品 -->
						<div class="caption">
							鲜花，司仪，花车。。。。
						</div>
					    <div class="card-heading"><strong>商品名</strong></div>
					    <div class="card-content text-muted">价格:<%=price %></div>
					    <div class="Foodbtn"  onclick="addFood('tFood<%=i %>');">添加商品</div>
				  	</div>
				</div>
				 <%} %>
			</div>
		</div>		
	</div>
</div>

<script type="text/javascript">
/*暂时未用到的  脚本*/
function getRequest() {   
   var url = window.location.search; //获取url中"?"符后的字串   
   var theRequest = new Object();   
   if (url.indexOf("?") != -1) {   
	  var str = url.substr(1);   
	  strs = str.split("&");   
	  for(var i = 0; i < strs.length; i ++) {   
		  //就是这句的实现其乱码解析成正常
		 theRequest[strs[i].split("=")[0]]=decodeURI(strs[i].split("=")[1]); 
	  }   
   }   
   return theRequest;   
}
var arr = getRequest();
var foodC = arr['foodC'];//参数名
</script>
</body>
</html>