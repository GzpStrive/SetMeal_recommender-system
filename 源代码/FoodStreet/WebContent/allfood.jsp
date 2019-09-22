<%@page import="main.java.util.WebUtil"%>
<%@page import="entity.UserBean"%>
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

function show3(){
	var test_board=document.getElementById('test_board3');
	test_board.style.display="block";
}
function noshow3(){
	var test_board=document.getElementById('test_board3');
	test_board.style.display="none";
}
//1_3.菜品是否已经加入购物车的方法
function addFood(Foodid){
	var choicefood = document.getElementById(Foodid);
	if (choicefood==null) {
		
		var name = document.getElementById("name"+Foodid).innerText;
		var potho = document.getElementById("img"+Foodid).src;
		var price = document.getElementById("price"+Foodid).innerText;
		//console.log("allfood,1_3addFood,name=="+name+";foodId=="+Foodid+";potho=="+potho+";price=="+price);
		var choicefood =document.createElement('div');
		var theFood="'"+Foodid+"'";
		//添加此标签的属性
		choicefood.innerHTML = '<div class="card"><div class="choicefoodname" style="font-weight:bold;font-size:115%;margin:2%;">'+name+'</div><div class="Foodbtn" onclick="delFood('+theFood+')">删除菜品</div></div><input class="choicefoodpotho" type="hidden" value="'+potho+'"><input class="choicefoodprice" type="hidden" value="'+price+'">';
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
		//$.ajax(function(){})   
		showPKRecommContent();   //异步刷新出推荐套餐的内容
		showGet_rules();         
		showXTgo();         //正在改
		
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
			  			<a class="ahover" style="width:100%;font-size: 150%;">种类 </a></li>
			  		
				</ul>
			</div>
			
		</div>
		<!-- 1_1.1.分类面板  热门 -->
		<div class="card" id="test_board" onmousemove="show()" onmouseout="noshow()" 
			 style="background:white; width:15%; height:300px;clear:both;z-index:100;
			position:absolute; top:170px;left:21.8%; display:none;background-size:contain;
			background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;">
			 <div class="">
			 
			 <%String[] foodkindLi1 = {"辣椒面","五花肉","香叶","香菇","鸡蛋","糯米","干辣椒","猪肉","鱼头","瘦肉"};
				for(int i=0;i<foodkindLi1.length;i++){%>

			 	<div style="width:48%;float: left;margin: 1%;" ><a class="ahover" onclick="showAllfood('','','<%=foodkindLi1[i] %>','')" ><%=foodkindLi1[i] %></a> </div>
			 <%} %>
			 </div>
			 <div class=""></div>
		</div>
		
		<!-- 1_1.2.分类面板食材 -->
		<div class="card" id="test_board1" onmousemove="show1()" onmouseout="noshow1()" 
			 style="background:white; width:15%; height:300px;clear:both;z-index:100;
			position:absolute; top:170px;left:21.8%; display:none;background-size:contain;
			background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;">
			 <div class="">
			 
			 <%String[] foodkindLi2 ={"五花肉","桂皮","辣椒","香菇","香叶","鸡蛋","糯米","姜片","豆腐","干辣椒","猪肉","青椒","粘米粉","胡萝卜","剁椒"};
				for(int i=0;i<foodkindLi2.length;i++){%>

			 	<div style="width:48%;float: left;margin: 1%;" ><a class="ahover" onclick="showAllfood('','','<%=foodkindLi2[i] %>','')" ><%=foodkindLi2[i] %></a> </div>
			 <%} %>
			 </div>
			 <div class=""></div>
		</div>
		
		<!-- 1_1.3.分类面板  菜系 -->
		<div class="card" id="test_board2" onmousemove="show2()" onmouseout="noshow2()" 
			 style="background:white; width:15%; height:300px;clear:both;z-index:100;
			position:absolute; top:170px;left:21.8%; display:none;background-size:contain;
			background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;">
			<div class="">
			 
			 <%
			 //查找相应的菜系列表
			 List<menuBean> foodserialLi3 =dao.findserial();
			 for(menuBean serial:foodserialLi3){
			%>

			 	<div style="width:48%;float: left;margin: 1%;" ><a class="ahover" onclick="showAllfood('','<%=serial.getSerial() %>','','')"><%=serial.getSerial() %> </a> </div>
			 <%} %>
			 </div>
			 <div class=""></div>
			 
		</div>
			
		<!-- 1_1.4.分类面板  种类 -->
		<div class="card" id="test_board3" onmousemove="show3()" onmouseout="noshow3()" 
			 style="background:white; width:15%; height:300px;clear:both;z-index:100;
			position:absolute; top:170px;left:21.8%; display:none;background-size:contain;
			background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;">
			 <div class="">
			 
				 <%
				 //查找相应的菜系列表
				 List<menuBean> foodkindLi4=dao.findKind();
				 for(menuBean kind:foodkindLi4){
				%>
	
				 	<div style="width:48%;float: left;margin: 1%;" ><a class="ahover" onclick="showAllfood('<%=kind.getKind() %>','','','')"><%=kind.getKind() %> </a> </div>
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
			<div id="allfoodModual" class="scrollbar-hover" style="width:100%; height: 300px;background-size:contain;
					background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;
												float:left; overflow: scroll;">
			
			
			</div>
			<!-- 为MenuDao的findMenuByKey(key,value)服务的form表单 -->
			<form id="allfoodSqlForm" style="height: 0px;">
				<input id="sqlkey" name="sqlkey" type="hidden" value="">
				<input id="sqlvalue" name="sqlvalue" type="hidden" value="">
			</form>
		</div>
		
		
		<script>
			//异步刷新出所有菜品的方法
			//传入的参数分别为                  种类，菜系，食材，模块id
			function showAllfood(K,S,M,modualid){
				var key="material";
				var value="鸡蛋";
				if(K!=""){
					key="kind";
					value=K;
				}else if(S!=""){
					key="serial";
					value=S;
				}else if(M!=""){
					key="material";
					value=M;
				}
				$("#sqlkey").attr("value",key);
				$("#sqlvalue").attr("value",value);
				
				$.ajax({
					url:"backData/allfood_2allfoodShow.jsp",
					type:"POST",
					data:$("#allfoodSqlForm").serialize(),  //form表单的序列化
					dataType:"JSON",
					success:function(data){
						//修改allfoodModual里面的内容
						if(data.code==1){
							var menulists=data.data;  //menuBean对象数组
							var menuStrs = '';
							for( i in menulists ){
								var menuNo=menulists[i].menuNo;
								//console.log("allfood:showAllfood,menulists[i].menuNo=="+menulists[i].menuNo);
								//console.log("allfood:menulists[i]=="+menulists[i].name);
								//console.log("allfood:menulists[i]=="+menulists[i].price);
								//console.log("allfood:menulists[i]=="+menulists[i].photo);
								menuStrs+='<div id="food'+menuNo+'"  class="col-md-4 col-sm-6 col-lg-3" style="width:33%;margin-top:2%;">'+
								'<div class="card" >'+
							  		'<img id="img'+menuNo+'" src="'+menulists[i].photo+'" style="margin-top:8px; width: 60%;" alt="">'+
									'<!-- 点击标签后直接加入已选菜品 -->'+
									'<div class="caption">菜品寓意：'+menulists[i].mean+
									'</div>'+
								    '<div id="name'+menuNo+'" class="card-heading"><strong>'+menulists[i].name+'</strong></div>'+
								    '<div id="price'+menuNo+'" class="card-content text-muted">￥'+menulists[i].price+'</div>'+
								    '<div class="Foodbtn"  onclick="addFood('+menuNo+');">添加菜品</div>'+
							  	'</div>'+
							'</div>';
								
							}
							$("#allfoodModual").html( menuStrs );
						}
						//alert("allfood,showAllfood,data.code=="+data.code+";data"+data);
					}
				});
			}
			showAllfood("","","","");
		</script>
	
		<!-- 1_3.菜品推荐 -->
		<div style="width: 23%;float: left;margin-left:1%;">
			<div class="header" style="width: 100%;float:left;">
				<ul>
					<li class="index_title">关联分析</li>
				</ul>
			</div>
			<!-- 1_3.1这里会异步刷新出内容 -->
			<div id="rules_info" class="scrollbar-hover" style="width:100%; height: 300px; background-size:contain;
					background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;float:left; overflow: scroll;">
				
			</div>
		</div>
			
		<!-- 1_3.2菜品推荐 -->
		<div style="width: 23%;float: left;margin-left:1%;">
			<div class="header" style="width: 100%;float:left;">
				<ul>
					<li class="index_title">基于用户</li>
				</ul>
			</div>
			<div  id="XTgolv" class="scrollbar-hover" style="width:100%; height: 300px; background-size:contain;
					background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;float:left; overflow: scroll;">
				
			</div>
		</div>	
				
		<!-- 1_4.已选择菜品 -->
		<div id="foodCar1"  style="width: 15.1%; float: left;">
			<div class="header" style="width: 100%;float:left;">
				<ul>
					<li class="index_title">已选商品</li>
				</ul>
			</div>
			<%
			//这里获取一下userbean
			  UserBean usBean = (UserBean)session.getAttribute("user_info");
			  System.out.println("allfood,usBean=="+usBean);
			  
			%> 
			<div id="foodCar" class="scrollbar-hover" align="center" style="width:100%; height: 300px;background-size:contain;
					background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;
												float:left; overflow: scroll;">
												
				<!-- 确认下单按钮 -->
				<button id="showConfirmbtn" onclick="showConfirm()" type="button" class="btn btn-primary" data-toggle="modal" data-target="#myLgModal_confirm" style="margin:0 auto;margin-top:5%;margin-bottom: 5%;">确认下单</button>
				<div class="modal fade" id="myLgModal_confirm">
					<div class="modal-dialog modal-lg">
				    <div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
							<h4 class="modal-title" style="color:black;">请确认您的订单</h4>
						</div>
				        <div id="confirmFood" class="scrollbar-hover" style="width:100%; max-height: 300px; background-size:contain;float:left; overflow: scroll;">
						<%if(usBean==null){%>
							<script>
							alert("检测到您太久没有操作或未填写信息，请前往首页在填写信息");  //太久未操作直接跳转到首页
							window.location.href="index.jsp";
							</script>
						 <%
						 }else{ %>
						 	<div>尊敬的<%=usBean.getName() %>客户，请确认您的订单</div>
						 <% }%>
						
						
						</div>
						<form  id="modifyOrder" style="height: 0px;">
							<div><input id="foodcarArr" name="foodcarArr" type="hidden" value="" ></div>
							<div><input id="orderNo" name="orderNo" type="hidden" value="" ></div>
							<div><input id="price" name="price" type="hidden" value="" ></div>
							<div><input id="pPKName" name="pPKName" type="hidden" value="" ></div>
						</form>
				      <div id="confirmFood-footer" class="modal-footer" >
				        <button type="button" class="btn btn-default" data-dismiss="modal" style="float: right;margin-left: 3%;">关闭窗口</button>
				        <button type="button" class="btn btn-primary" onclick="confirm('modifyOrder');" style="float: right;">确认预订</button>
				      </div>
			    </div>
				  </div>
				</div>
				<div class="modal fade" id="noShow">
					<div class="modal-dialog modal-lg">
					
				    <div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
							<h4 class="modal-title" style="color:black;">请继续选择订单</h4>
						</div>
						<h4 class="modal-title" style="color:black;">订单菜品还未满足8个菜，请继续选择</h4>
				      <div  class="modal-footer" >
				        <button type="button" class="btn btn-default" data-dismiss="modal" style="float: right;margin-left: 3%;">关闭窗口</button>
				        
				      </div>
			    </div>
				  </div>
				</div>	
			</div>
		</div>
		<script>
			//1_4.修改确认下单   对话框  的方法
			function showConfirm(){
				var nameobj=document.getElementsByClassName("choicefoodname");
				var pothoobj=document.getElementsByClassName("choicefoodpotho");
				var priceobj=document.getElementsByClassName("choicefoodprice");
				if(pothoobj.length<8){   //每个订单菜品数目不能小于8
					$("#showConfirmbtn").attr("data-target","#noShow");   //将显示确认下单面板不显示
					return;
				}else{
					$("#showConfirmbtn").attr("data-target","#myLgModal_confirm");   //将显示确认下单面板显示
				}
				var allprice = 0;
				for(var i=0;i<nameobj.length;i++){
					var confirmfood =document.createElement('div');
					var oneprice = parseInt(priceobj[i].value.substr(1)); //删除第一个字符,并且将字符串转数字
					allprice=allprice+oneprice;
					
					//console.log('allfood,oneprice=='+oneprice+";allprice"+allprice);
					//添加此标签的属性
					confirmfood.innerHTML = '<div  class="col-md-4 col-sm-6 col-lg-3" style="width:20%;margin-top:2%;">'+
												'<div class="card" >'+
													'<img  src="'+pothoobj[i].value+'" style="margin-top:8px; width: 60%;" alt="">'+
														    '<div  class="card-heading"><strong>'+nameobj[i].innerHTML+'</strong></div>'+
														    '<div class="card-content text-muted">价格:'+priceobj[i].value+'</div></div></div>';
					  	
					/* confirmfood.id=Foodid;
					confirmfood.style.width="95%";
					confirmfood.style.margin="0 auto";
					confirmfood.align="center"; */
					//添加到确认下单面板
					var confirmFood = document.getElementById('confirmFood');//定位到确认面板内容
					confirmFood.appendChild(confirmfood);
					/*$("#confirmName0").attr("innerHTML","'"+nameobj[i].innerHTML+"'");
					console.log('allfood,nameobj=='+nameobj[i].innerHTML);*/
				}
				var allprice1 =document.createElement('div');
				var confirmFoodfooter = document.getElementById('confirmFood-footer');//定位到确认面板内容
				allprice1.innerHTML='以上菜品的总价格为'+allprice+'元';
				allprice1.style.width="98%";
				allprice1.style.margin="0 auto";
				allprice1.align="center";
				confirmFoodfooter.appendChild(allprice1);
				//获取到 form表单里面  foodcarArr对象
				var price = document.getElementById("price");
				price.value=""+allprice;
			}
			
			
			//1_4.确认下单的方法（在已选菜品处）
			function confirm(formid){
				var obj=document.getElementsByClassName("choicefoodname");
				var strs='';
				for(var i=0;i<obj.length;i++){
					point=Math.floor(Math.random()*5 + 1);
					if(i==obj.length-1){
						strs+=obj[i].innerHTML+":"+point;
					}else{
						strs+=obj[i].innerHTML+":"+point+",";
					}
				}
				
				//获取到 form表单里面  foodcarArr对象
				var foodcarArr = document.getElementById("foodcarArr");
				foodcarArr.value=strs;
				var formdata=($("#"+formid+"").serialize());
				var formStr= decodeURIComponent(formdata,true);
				//console.log('allfood,formStr=='+formStr);
				$.ajax({
					url:"backData/allfood_4confirm.jsp",
					type:"POST",
					data:formStr,
					dataType:"JSON",
					success:function(data){
						alert(data.data);
						}
					});
			}
			</script>
			<%
				if(usBean!=null){
					%>
					<script>
					function getusBean(){
						$("#orderNo").attr("value","<%=usBean.getOrderNo()%>");
					}
					getusBean();
					</script>
				<%}
				%>
		
		<script>
			//!-- 1_3.1  异步刷新出关联规则的菜品推荐 -->
			function showGet_rules(){
				var cFoodobj=document.getElementsByClassName("choicefoodname");  //获取到已经选择菜品的名字列表对象
				var choiceFoodstrs1 = '';
				
				for(var i=0;i<cFoodobj.length;i++){
					//console.log('allfood,cFoodobj[i].innerHTML==='+cFoodobj[i].innerHTML);
					var choicename = cFoodobj[i].innerHTML;
					if(i<cFoodobj.length-1){
						choiceFoodstrs1 += choicename+',';
					}else{
						choiceFoodstrs1 += choicename;
					}
				}
				//console.log('allfood,choiceFoodstrs1==='+choiceFoodstrs1);
				$("#foodcarArr").attr("value",choiceFoodstrs1);
				//console.log($("#foodcarArr").val());
				$.ajax({
					url:"backData/allfood_3showGet_rules.jsp",
					type:"POST",
					data:$("#modifyOrder").serialize(),  //form表单的序列化
					dataType:"JSON",
					success:function(data){
						//console.log(data);
						if(data.code=="1"){
							var RulesStrs='';
							mnlist=data.mnlist;
							for(i in mnlist){
								var top = i+1;
								var MNName = "'"+mnlist[i].name+"'"
								var menuNo=mnlist[i].menuNo;
								//console.log(mnlist[i].name);
								RulesStrs+=
								'<div id="food'+menuNo+'"  class="col-md-4 col-sm-6 col-lg-3" style="width:50%;margin-top:2%;">'+
									'<div class="card" >'+
								  		'<img id="img'+menuNo+'" src="'+mnlist[i].photo+'" '+
								  			'style="margin-top:8px; width: 60%;" alt="">'+
										//!-- 点击标签后直接加入已选菜品 -->
										'<div class="caption">菜品寓意:'+mnlist[i].mean+
										'</div>'+
									    '<div id="name'+menuNo+'" class="card-heading"><strong>'+mnlist[i].name+'</strong></div>'+
									    '<div id="price'+menuNo+'"  class="card-content text-muted">￥'+mnlist[i].price+'</div>'+
									    '<div class="Foodbtn"  onclick="addFood('+menuNo+');">添加菜品</div>'+
								  	'</div>'+
								'</div>';
							}
							$("#rules_info").html(RulesStrs);
						}
					}
				});
			}
			//!-- 1_3.2  异步刷新出基于用户的菜品推荐 -->
			function showXTgo(){
				var cFoodobj=document.getElementsByClassName("choicefoodname");  //获取到已经选择菜品的名字列表对象
				var choiceFoodstrs1 = '';
				for(var i=0;i<cFoodobj.length;i++){
					console.log('allfood,XTFoodobj[i].innerHTML==='+cFoodobj[i].innerHTML);
					var choicename = cFoodobj[i].innerHTML;
					if(i<cFoodobj.length-1){
						choiceFoodstrs1 += choicename+',';
					}else{
						choiceFoodstrs1 += choicename;
					}
				}
				console.log('allfood,XT_choiceFoodstrs1==='+choiceFoodstrs1);
				$("#foodcarArr").attr("value",choiceFoodstrs1);
				console.log($("#foodcarArr").val());
				$.ajax({
					url:"backData/allfood_3showXTgo.jsp",
					type:"POST",
					data:$("#modifyOrder").serialize(),  //form表单的序列化
					dataType:"JSON",
					success:function(data){
						console.log(data);
						if(data.code=="1"){
							var XTgoStrs='';
							mnlist=data.mnlist;
							for(i in mnlist){
								var top = i+1;
								var MNName = "'"+mnlist[i].name+"'"
								var menuNo=mnlist[i].menuNo;
								console.log(mnlist[i].name);
								XTgoStrs+=
								'<div id="food'+menuNo+'"  class="col-md-4 col-sm-6 col-lg-3" style="width:50%;margin-top:2%;">'+
									'<div class="card" >'+
								  		'<img id="img'+menuNo+'" src="'+mnlist[i].photo+'" '+
								  			'style="margin-top:8px; width: 60%;" alt="">'+
										//!-- 点击标签后直接加入已选菜品 -->
										'<div class="caption">菜品寓意:'+mnlist[i].mean+
										'</div>'+
									    '<div id="name'+menuNo+'" class="card-heading"><strong>'+mnlist[i].name+'</strong></div>'+
									    '<div id="price'+menuNo+'"  class="card-content text-muted">￥'+mnlist[i].price+'</div>'+
									    '<div class="Foodbtn"  onclick="addFood('+menuNo+');">添加菜品</div>'+
								  	'</div>'+
								'</div>';
							}
							$("#XTgolv").html(XTgoStrs);
						}
					}
				});
			}
		
		</script>
		
		
		
		
		
		<!-- 1_5.套餐推荐-->
		<div id="commendSuit"  style="width:60%; float: left;margin-left: 0.9%;">
			<!-- 标题部分 -->
			<div class="header" style="margin-top: 15px;margin-bottom: 15px;
				width: 100%;float:left;">
				<ul>
					<li class="index_title">猜你喜欢</li>
				</ul>
			</div>
			
			<!-- 这是套餐推荐的套餐信息表    -->
			<form id="PKInfoForm">
				<input id="sqlPKName" name="sqlPKName" type="hidden" value="" >
			</form>
			
			<!-- 5_1.推荐套餐 -->
			<div class="scrollbar-hover" style="width:100%; height: 300px; background-size:contain;
					background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;float:left; overflow: scroll;">
				
					<div>	
					<!-- 套餐详情菜品对话框 -->
					<div class="modal fade" id="myLgModalPK">
						<div class="modal-dialog modal-lg">
					    <div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
								<h4 id="PKFoods_title" class="modal-title" style="color:black;">标题</h4>
							</div>
							<!-- 5_1套餐的详细菜品，通过使用套餐名显示出套餐下对应的菜品   异步刷新 -->
					        <div id="PKFoodStrs" class="scrollbar-hover" style="width:100%; max-height: 300px; background-size:contain;float:left; overflow: scroll;">
								
							</div>
					      <div  class="modal-footer" >
					        <button type="button" class="btn btn-default" data-dismiss="modal" style="float: right;margin-left: 3%;">关闭窗口</button>
					        <div id="PKFoods_footer">
					        <button type="button" class="btn btn-primary" style="float: right;">确认下单</button>
					        </div>
					      </div>
					    </div>
					  </div>
					</div>
		   		</div>
		   		<!-- 5_1套餐的基本信息，通过使用套餐ID找出套餐的相应信息   异步刷新  -->
		   		<div  id="PKRecommContent">

				</div>
			</div>
		</div>
		<script>
			//1_5.确认下单的方法   （套餐确认下单）
			function sureAddPK(PKName){
				var obj=document.getElementsByClassName("card-headingFname");//获取到所有在套餐显示  的菜品名
				var prices=document.getElementsByClassName("cardFprice");//获取到所有在套餐显示  的菜品价格
				
				var strs='';
				var allprice=0;
				for(var i=0;i<obj.length;i++){
					point=Math.floor(Math.random()*5 + 1); //这是随机生成  菜品评分
					if(i==obj.length-1){
						strs+=obj[i].innerHTML+":"+point;
					}else{
						strs+=obj[i].innerHTML+":"+point+",";
					}
					var oneprice = parseInt(prices[i].innerHTML.substr(1)); //删除第一个字符,并且将字符串转数字
					allprice+=oneprice;
					
				}
				alert("总价格为："+allprice);
				$("#price").attr("value",""+allprice);
				$("#pPKName").attr("value",""+PKName);
				//获取到 form表单里面  foodcarArr对象
				var foodcarArr = document.getElementById("foodcarArr");
				foodcarArr.value=strs;
				var formdata=($("#modifyOrder").serialize());
				var formStr= decodeURIComponent(formdata,true);
				console.log('allfood,sureAddPK，formStr=='+formStr);
				$.ajax({
					url:"backData/allfood_5confirm.jsp",
					type:"POST",
					data:formStr,
					dataType:"JSON",
					success:function(data){
						alert(data.data);
						}
				});
			}
			
			//显示  套餐所有商品的  的方法
			function showPKFoods(PKName){
				console.log("allfood,PKName==="+PKName);
				$("#sqlPKName").attr("value",PKName);
				$("#PKFoods_title").html(PKName);
				$.ajax({
					url:"backData/allfood_5showPKFoods.jsp",
					type:"POST",
					data:$("#PKInfoForm").serialize(),  //form表单的序列化
					dataType:"JSON",
					success:function(data){
						var PKFoodsStrs='';
						var PKFoods_footer='';
						if(data.code=="1"){
							console.log("allfood_5showPKFoods[0].name=="+data.mnlist[0].name);
							var Foods = data.mnlist;
							for(i in Foods){
								var Fname = Foods[i].name;
								var Fmean = Foods[i].mean;
								var Fprice = Foods[i].price;
								var Fsales  = Foods[i].sales;
								var Fserial = Foods[i].serial;
								var Fphoto = Foods[i].photo;
								PKFoodsStrs+=
								'<div class="col-md-4 col-sm-6 col-lg-3" style="width:20%;margin-top:2%;">'+
								'<div class="card" >'+
							  		'<img src="'+Fphoto+'" '+
							  			'style="margin-top:8px; width: 60%;" alt="">'+
										//!-- 点击标签后直接加入已选菜品 -->
										'<div class="caption">'+
											'<div>菜品寓意：'+Fmean+'</div>'+
											'<div>菜品销量：'+Fsales+'</div>'+
										'</div>'+
									    '<div class="card-heading"><strong class="card-headingFname">'+Fname+'</strong></div>'+
									    '<div class="cardFprice">￥'+Fprice+'</div>'+
								  	'</div>'+
								'</div>';
								
								
							}
							PKFoods_footer+=
								'<button type="button" class="btn btn-primary" onclick="sureAddPK('+"'"+PKName+"'"+')" style="float: right;">确认下单</button>';
							$("#PKFoods_footer").html(PKFoods_footer);
						}else{
							
							PKFoodsStrs=data.data;
						}
						$("#PKFoodStrs").html(PKFoodsStrs);
					}
				});
				
			}
			
			//异步刷新 出套餐推荐的面板  （即为套餐的基本信息显示） id为PKRecommContent
			//传入的参数为                                                   已经选择的菜品名     要异步刷新的面板RecommCotent
			function showPKRecommContent(){
				var choiceFoodobj=document.getElementsByClassName("choicefoodname");  //获取到已经选择菜品的名字列表对象
				var choiceFoodstrs = '';
				for(var i=0;i<choiceFoodobj.length;i++){
					console.log('allfood,choiceFoodobj[i].innerHTML==='+choiceFoodobj[i].innerHTML);
					var choicefoodname = choiceFoodobj[i].innerHTML;
					if(i!=choiceFoodobj.length-1){
						choiceFoodstrs += choicefoodname+',';
					}else{
						choiceFoodstrs += choicefoodname;
					}
					
					
					}
				//console.log('allfood,choiceFoodstrs==='+choiceFoodstrs);
				$("#foodcarArr").attr("value",choiceFoodstrs);
				//console.log($("#foodcarArr").val());
				$.ajax({
					url:"backData/allfood_5showPKRecommContent.jsp",
					type:"POST",
					data:$("#modifyOrder").serialize(),  //form表单的序列化
					dataType:"JSON",
					success:function(data){
						console.log(data);
						if(data.code=="1"){
							var PKinfostrs='';
							pklist=data.pklist;
							ImgLi = data.ImgLi;
							for(i in pklist){
								var top = i+1;
								var PKName = "'"+pklist[i].name+"'"
								console.log(pklist[i].name);
								PKinfostrs+=
								'<div class="items items-hover" style="width:50% ; float: left;" >'+
								'<div class="item">'+
								    '<div class="item-content">'+
								      	'<div class="MaleList_text" style="width: 25%;">'+
								      		'<img style="width: 100%;border-radius:40%;" '+
								      			 'src="'+ImgLi[i]+'"  alt=""></div>'+
								      	'<div class="MaleList_text">'+
								      		'<div>套餐名</div>'+
									      	'<div>'+pklist[i].name+'</div>'+   
								      	'</div>'+
								      	
								      	'<div class="MaleList_text">'+
								      		'<div>菜品数量</div>'+
									      	'<div >共'+pklist[i].number+'道菜</div>'+
								      	'</div>'+
								      	
								      	'<div class="MaleList_text">'+
								      		'<div>推荐榜</div>'+
									      	'<div>Top'+top+'</div>'+
								      	'</div>'+
								      	//!-- 这里要弹出菜品对话框 -->
								      	'<div align="center" style="width:75%;">'+
										'<button type="button" class="btn btn-primary" onclick="showPKFoods('+PKName+')" data-toggle="modal" data-target="#myLgModalPK">查看详情</button>'+
										'<div align="center" style="font-size: 95%;font-weight:bold;width: 100%;">'+pklist[i].reason+' </div>'+
										'</div>'+
									'</div>'+
								'</div>'+
							'</div>';
							}
							$("#PKRecommContent").html(PKinfostrs);
						}
					}
				});
			}
		</script>
		
		
		
		
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
				  		<img src="images/img/noPic.jpg"
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