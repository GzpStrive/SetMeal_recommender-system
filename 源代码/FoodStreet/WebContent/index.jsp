<%@page import="entity.UserBean"%>
<%@page import="entity.Backcolor"%>
<%@page import="main.java.util.WebUtil"%>
<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>首页</title>
</head>
<body>
<!-- 背景颜色 -->
<% 
	Backcolor bc=new Backcolor();
	bc.SetColor("淡兰云白");
	String backcolor=bc.getColor();
%>	
<!-- 一，头部目录  -->
<div style="width:100%; background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;
			background-size:contain;position:fixed;z-index: 101;">
	<%@include file="header.jsp"  %>
</div>
    	
<!-- 二，主体样式 -->
<!-- 滚动条样式 -->
<div class="scrollbar-hover" style=" background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;background-size:contain; max-height: 700px; overflow: scroll;">
	<div style="margin:0 auto; width: 80%;margin-top:100px;"  align="center" >
		
		<!-- 1. 图片轮播,加选择分类 -->
		<div style="float: left;background: url(images/backcolor/<%=backcolor %>.jpg) repeat-x;background-size:contain;">
			<!-- 1_1.用户信息 -->
			<div style="float:right;width: 20%;"  >
				
			</div>
			<!-- 1_2.分类面板 -->
			<div id="test_board" onmousemove="show()" onmouseout="noshow()" 
				 style="background: red;width:70%; height:100%; z-index: 100;
				 position:absolute;display: block;margin-right: 20%;display: none;">
				
			</div>
			<!-- 1_3.图片轮播 -->
			<!--%@include file="index_1recommend.jsp" %-->
			<div class="header" >
				<ul>
					<li class="index_title">热门推荐</li>
				</ul>
			</div>
			<div id="myNiceCarousel" class="carousel slide" data-ride="carousel" 
				 style="width: 60%;float: left;">
			<div class="header_li">酒店特色</div>
			  <!-- 圆点指示器 -->
			  <ol class="carousel-indicators">
			    <li data-target="#myNiceCarousel" data-slide-to="0" class="active"></li>
			    <li data-target="#myNiceCarousel" data-slide-to="1"></li>
			    <li data-target="#myNiceCarousel" data-slide-to="2"></li>
			  </ol>
			
			  <!-- 轮播项目 -->
			  <div class="carousel-inner" style="height:100%;">
			    <div class="item active">
			      <img alt="First slide" src="http://zui.sexy/docs/img/slide1.jpg" style=" ">
			      <div class="carousel-caption">
			        <h3>二十年老店</h3>
			        <p>是你熟悉的味道</p>
			      </div>
			    </div>
			    <div class="item">
			      <img alt="Second slide" src="http://zui.sexy/docs/img/slide2.jpg">
			      <div class="carousel-caption">
			        <h3>严格遵守国家食品安准则</h3>
			        <p>你的健康就是我们的目标</p>
			      </div>
			    </div>
			    <div class="item">
			      <img alt="Third slide" src="http://zui.sexy/docs/img/slide3.jpg">
			      <div class="carousel-caption">
			        <h3>口味常年受到用户的一致好评</h3>
			        <p>期待您的光临</p>
			      </div>
			    </div>
			  </div>
			
			  <!-- 项目切换按钮 -->
			  <a class="left carousel-control" href="#myNiceCarousel" data-slide="prev">
			    <span class="icon icon-chevron-left"></span>
			  </a>
			  <a class="right carousel-control" href="#myNiceCarousel" data-slide="next">
			    <span class="icon icon-chevron-right"></span>
			  </a>
			</div>
			
			<%
			  UserBean usBean = (UserBean)session.getAttribute("user_info");
			  System.out.println("index_1recommend,usBean"+usBean);
			%>  
			
			
			<div style="width: 40%;float: left;">
			<div class="header_li">请告诉我们一些信息，让我们更好的为您推荐</div>
			
			
			<!-- form表单 -->
			<form class="form-horizontal" action="backData/index_1formdo.jsp" method="post" onsubmit="return isNull();">
			  <!-- 订单表字段：orderNo name tel time deskcount price source age Scene append-->
			  <div class="form-group">
			    <label for="exampleInputAccount4" class="col-sm-2">酒席场景</label>
			    <div class="col-sm-3">
			      <select class="form-control" id="us_Scene" name="Scene" >
			        <option>婚宴</option>
			        <option>庆功宴</option>
			        <option>生日宴</option>
			        <option>满月酒</option>
			        <option>升学宴</option>
			      </select>
			    </div>
			  	
			    <label for="exampleInputAddress1" class="col-sm-2">联系电话</label>
			    <div class="col-sm-5">
			      <input type="text" class="form-control" id="us_tel" name="tel"  placeholder="输入电话，方便我们联系您">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="exampleInputPassword4" class="col-sm-2">预约桌数</label>
			    <div class="col-sm-3">
			      <select class="form-control"  id="us_deskcount" name="deskcount">
			        <option>10</option>
			        <option>15</option>
			        <option>20</option>
			        <option>25</option>
			        <option>50</option>
			      </select>
			    </div>
			    
			    <label for="exampleInputAddress1" class="col-sm-2">预约消费</label>
			    <div class="col-sm-5">
			      <select class="form-control" id="us_append" name="append">
			        <option>1000元档/每桌</option>
			        <option>1500元档/每桌</option>
			      </select>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="exampleInputAccount4" class="col-sm-2">您的芳龄</label>
			    <div class="col-sm-3">
			      <select class="form-control" id="us_age" name="age">
			        <option>15-20岁</option>
			        <option>21-30岁</option>
			        <option>31-45岁</option>
			        <option>46-55岁</option>
			        <option>56-120岁</option>
			      </select>
			    </div>
			    
			    <label for="exampleInputAddress1" class="col-sm-2">您的姓名</label>
			    <div class="col-sm-5">
			      <input type="text" class="form-control" id="us_name" name="name"  placeholder="输入名字，开启智能推荐" value="">
			    </div>
			   </div>
			    <div class="form-group">
			    <label for="exampleInputAccount4" class="col-sm-2">如何得知旺福轩</label>
			    <div class="col-sm-3">
			      <select class="form-control" id="us_source" name="source" >
			        <option>朋友推荐</option>
			        <option>广告推荐</option>
			        <option>好文章推荐</option>
			      </select>
			    </div>
			  </div>
			  <div class="form-group">
			    <div class="col-sm-offset-2 col-sm-10">
			      <div class="checkbox">
			        <label>
			          <input type="checkbox" id="us_remember" name="remember" checked="checked" > 记住我
			        </label>
			      </div>
			    </div>
			  </div>
			  <div class="form-group">
			    <div class="col-sm-offset-2 col-sm-10">
			      <button type="submit" class="btn btn-default">确定</button>
			    </div>
			  </div>
			</form>
			</div>
			
			
			<script  type="text/javascript">//表单提交的时候是否为空的方法
			function isNull(){
				if( $("#us_Scene").val()=='' ){
					alert("场景不能为空");
					return false;
				}else if( $("#us_tel").val()=='' ){
					alert("电话不能为空,否则我们将无法联系您");
					return false;
				}else if( $("#us_deskcount").val()=='' ){
					alert("预约桌数不能为空");
					return false;
				}else if( $("#us_append").val()=='' ){
					alert("预约消费不能为空");
					return false;
				}else if( $("#us_age").val()=='' ){
					alert("你的年龄不能为空");
					return false;
				}else if( $("#us_name").val()=='' ){
					alert("姓名不能为空，否则我们联系时不知道如何称呼您");
					console.log("$(#us_name).val()=="+$("#us_name").val());
					return false;
				}else if( $("#us_source").val()=='' ){
					alert("如何得知不能为空");
					return false;
				}else{
					console.log("$(#us_name).val()=="+$("#us_name").val());
					return true;
				}
			}
			</script>
			<%
			if(usBean!=null){
				%>
				<script>
				function getusBean(){
					var str = "<%=usBean.getScene()%>";
					obj = document.getElementById("us_Scene");
					for(i=0;i<obj.length;i++){
						//console.log("obj[i]=="+obj[i]);
					    if(obj[i].value==str)
					        obj[i].selected = true;
					}
			
					$("#us_name").attr("value","<%=usBean.getName()%>");
					
					$("#us_tel").attr("value","<%=usBean.getTel()%>");
					$("#us_remember").attr("checked",<%=usBean.isCheckd()%>);
				}
				getusBean();
				</script>
			<%}
			%>
		</div>
		
		
		<!-- 2. 猜你喜欢 -->
		<div style="background: url(images/backcolor/<%=backcolor %>.jpg) repeat-x;background-size:contain;">
			<!-- 2_2.推荐套餐 -->
			<!--%@include file="index_2recommend.jsp" %-->
			<!-- 套餐推荐数组 -->
			<div class="MaleList" >
			<div class="header" >
				<ul>
					<li class="index_title">套餐推荐</li>
				</ul>
			</div>
			<div id="hotpackage">
			<div class="items items-hover" style="width:98% ; float: left;" >
				 <div class="item">
				    <div class="item-content">
				      	<div class="MaleList_text" style="width: 25%;">
				      		<img style="width: 70%;border-radius:40%;" 
				      			 src="images/login-pic/民男1.jpeg"  alt=""></div>
				      	<div class="MaleList_text" style="margin:0 auto;margin-left:15%;">
				      		<div>页面正在加载中,请稍候...</div>
					      	<div >填写信息有助于页面刷新哦</div>
				      	</div>
				      	
				    </div>
				    <div>
				      	<!-- div class="pull-center label label-success" style="background:white; height:30px; font-size: 20px;"-->
				      	<!--  a href="#collapseExample<！%=2*mub_pic_index %>" data-toggle="collapse">查看详情</a-->
			      	</div>
			     </div>
			</div>
			<form id="PKInfo" style="height: 0px;">
					<input id="sqlPKName1" name="sqlPKName1" type="hidden" value="123">
					<input id="sqlPKFoods1" name="sqlPKFoods1" type="hidden" value="123">
			</form>
			<script type="text/javascript">
			function getinfo(){
						var data1=$("#PKInfo").serialize();
						var data_params1 = decodeURIComponent(data1,true);
						console.log("我是getinfo===data_params1"+data_params1);
						var info222=document.getElementById("sqlPKName1");
						console.log(info222);
						console.log($("#sqlPKFoods1").val());
			}
			</script>
			     <%
				UserBean usBean2 = (UserBean)session.getAttribute("user_info");
				System.out.println("index_2recommend,usBean"+usBean2);
				if(usBean2!=null){
				%>
				<form id="PackageTop" style="height: 0px;">
						<input id="sqlScene" name="sqlScene" type="hidden" value="'<%=usBean2.getScene() %>'">
						
				</form>
					<script>
					
					/* //确认下单的方法
							function sureOrder(PKName){
								console.log(document.getElementById("sqlPKName1").value);
								var data1=$("#PackageTop").serialize();
								data_params1 = decodeURIComponent(data1,true);   //这是防止中文乱码
								$.ajax({
									url:"backData/index_2recoSureOrder.jsp",
									type:"POST",
									data:data_params1,  //form表单的序列化
									dataType:"JSON",
									success:function(data){
										console.log(data);
									}
								});
							} */
					
					//-- 异步刷新热门套餐的前6名（同类型（场景）的套餐） -->
					function showTopPK(){
						var data=$("#PackageTop").serialize();
						data_params = decodeURIComponent(data,true);   //这是防止中文乱码
						$.ajax({
							url:"backData/index_2reco_showTopPK.jsp",
							type:"POST",
							data:data_params,  //form表单的序列化
							dataType:"JSON",
							success:function(data){
								console.log(data);
								if(data.code=="2"){
									var pklist=data.data;
									var mnmap=data.mnmap;
									var hotPKStrs = '';
									for(i in pklist){
										var top=parseInt(i)+1;
										var photo = mnmap[top][0].photo;  //获取到对应的菜品中第一个菜品的图片
										console.log(pklist[i].name);
										console.log(mnmap[top][0]);
										hotPKStrs+=
										'<div class="items items-hover" style="width:50% ; float: left;" >'+
										 '<div class="item">'+
										    '<div class="item-content">'+
										      	'<div class="MaleList_text" style="width: 25%;">'+
										      		'<img style="width: 70%;border-radius:40%;" src="'+photo+'"  alt=""></div>'+
										      	'<div class="MaleList_text">'+
										      		'<div>套餐名</div>'+
											      	'<div>'+pklist[i].name+'</div>'+  
										      	'</div>'+
										      	
										      	'<div class="MaleList_text">'+
										      		'<div>菜品数量</div>'+
											      	'<div >共'+pklist[i].number+'道菜</div>'+
										      	'</div>'+
										      	
										      	'<div class="MaleList_text">'+
										      		'<div>热销榜</div>'+
											      	'<div >Top'+top+'</div>'+
										      	'</div>'+
										      	//<!-- 下单按钮（查看详情） -->
												'<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myLgModal'+top+'">查看详情</button>'+
										      	
										    '</div>'+
										    '<div>'+
										      	/* <!-- div class="pull-center label label-success" style="background:white; height:30px; font-size: 20px;"-->
										      	<!--  a href="#collapseExample<！%=2*mub_pic_index %>" data-toggle="collapse">查看详情</a-->
												
												<!-- 对话框HTML --> */
												'<div class="modal fade" id="myLgModal'+top+'">'+
													'<div class="modal-dialog modal-lg">'+
												    '<div class="modal-content">'+
														'<div class="modal-header">'+
															'<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>'+
															'<h4 class="modal-title" style="color:black;">套餐详情</h4>'+
														'</div>'+
														//菜品列表如下
												        '<div id="mnlist'+top+'" class="scrollbar-hover" style="width:100%; max-height: 300px; background-size:contain;float:left; overflow: scroll;">'+
															
														'</div>'+
												      '<div class="modal-footer" >'+
												      '<div align="center" style="width:40%;margin:0 auto;">此套餐的总价格为'+pklist[i].price+'</div>'+
												      '<div align="center" style="width:40%;margin:0 auto;">套餐深意：'+pklist[i].reason+'</div>'+
												        '<button type="button" class="btn btn-default" data-dismiss="modal" style="float: right;margin-left: 3%;">关闭窗口</button>'+
												        '<button type="button" class="btn btn-primary" onclick="getinfo()" style="float: right;">确认下单</button>'+
												      '</div>'+
												    '</div>'+
												  '</div>'+
												'</div>'+
									      	'</div>'+
									     '</div>'+
									'</div>';
									
									$("#hotpackage").html( hotPKStrs );
									}
									for(i in pklist){
										var top=parseInt(i)+1;
										var mnStrs='';
										for(mnindex in mnmap[top]){
											//console.log("mn=="+mnmap[top][mnindex].photo);
											var mnId = pklist[i]+':'+mnmap[top][mnindex].menuNo;//为了让每个菜品的id能唯一，  加上对应的套餐  ID
											var mnphoto = mnmap[top][mnindex].photo;
											var mnprice = mnmap[top][mnindex].price;
											var mnname = mnmap[top][mnindex].name;
											var mnmean = mnmap[top][mnindex].mean;
											mnStrs+=
											'<div id="'+mnId+'"  class="col-md-4 col-sm-6 col-lg-3" style="width:20%;margin-top:2%;">'+
											'<div class="card" >'+
										  		'<img src="'+mnphoto+'" '+
										  			'style="margin-top:8px; width: 60%;" alt="">'+
												//<!-- 点击标签后直接加入已选菜品 -->'+
												'<div class="caption">'+
													'菜品寓意：'+mnmean+''+
												'</div>'+
											    '<div class="card-heading"><strong>'+mnname+'</strong></div>'+
											    '<div class="card-content text-muted">￥'+mnprice+'</div>'+
										  	'</div>'+
										'</div> ';
										}
										$("#mnlist"+top+"").html( mnStrs );
									}
								
								}
							}
						});
					}
					//这里运行下  showTopPK()
					showTopPK();
					
					/* //修改  form  表单里面的一些值
					function modiOrder(PKName,PKFoods){
						$("#sqlPKName").attr("value", PKName );
						$("#sqlPKFoods").attr("value", PKFoods);
					} */
					</script>
				<% 
				}
			%>
			
			</div>
			</div>
		</div>
		<!-- 三，结尾说明 -->
		<div id="end">
			<p id="copyright">CN出品</p>
		</div>
	</div>
</div>
<script >
//确认下单的方法
/* function sureOrder(PKName){
	console.log(document.getElementById("sqlPKName1").value);
	var data1=$("#PackageTop").serialize();
	data_params1 = decodeURIComponent(data1,true);   //这是防止中文乱码
	$.ajax({
		url:"backData/index_2recoSureOrder.jsp",
		type:"POST",
		data:data_params1,  //form表单的序列化
		dataType:"JSON",
		success:function(data){
			console.log(data);
		}
	});
} */

</script>
</body>
</html>
