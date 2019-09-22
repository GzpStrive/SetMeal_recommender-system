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
	<title>管理员页面</title>
	  	<link rel="stylesheet" href="zui-1.9.0/layui/css/layui.css"  media="all"/>
  	   	<script src="zui-1.9.0/layui/layui.js" charset="utf-8"></script>
  	   	<style type="text/css">
  	   		/*表头*/
			.table-7 thead th {
			background-color:rgb(81,130,187);
			color:#fff;
			border-bottom-width:0;
			}
			
			/*列样式*/
			.table-7 td {
			color:#000;
			}
			/*标题和列样式*/
			.table-7 tr,#table-7 th {
			border-width:1px;
			border:solid;
			border-color:rgb(81,130,187);
			}
			
			/*填充和字体样式*/
			.table-7 td,#table-7 th {
			border-width:1px;
			padding:5px 10px;
			font-size:12px;
			font-family:Verdana;
			font-weight:bold;
			}
  	   	</style>
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
		
		<!-- 1_1.套餐信息-->
		<div style="width: 100%;float: left;">
			<div class="header" style="width: 100%;float:left;">
				<ul>
					<li class="index_title">套餐信息</li>
				</ul>
			</div>
			<div class="scrollbar-hover" style="width:100%; height: 300px;background-size:contain;
					background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;
												float:left; overflow: scroll;">
				
				<!-- 测试  ： 添加套餐的表单框 -->
				<div class="modal fade" id="myLgModal_add">
					<div class="modal-dialog modal-lg">
				    <div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
							<h4 class="modal-title" style="color:black;">标题</h4>
						</div>
				        <div class="scrollbar-hover" style="width:100%; max-height: 300px; background-size:contain;float:left; overflow: scroll;">
							修改name
					 		number   套餐菜品数格需要通过查找combination 和 menu 表计算出
					 		Scene
					 		reason
					 		price   套餐总价格需要通过查找combination 和 menu 表计算出
					 		sales
					 		<form class="form-horizontal" id="formadd" style="width:90%">     <!-- ID号为formadd的表单 -->
							  <div class="form-group">
							    <label for="exampleInputAccount4" class="col-sm-2">套餐名</label>
							    <div class="col-sm-3">
							      <input type="text" class="form-control" id="pk_name"  name="name" placeholder="套餐名">
							    </div>
							    <label for="exampleInputAccount4" class="col-sm-2">套餐场景</label>
							    <div class="col-sm-4">
							    <select class="form-control" id="pk_Scene" name="Scene">
							        <option>婚宴</option>
							        <option>庆功宴</option>
							      </select>
							    </div>
							  </div>
							  <div class="form-group">
							    <label for="exampleInputPassword4"  class="col-sm-2">套餐寓意</label>
							    <div class="col-sm-3">
							        <input type="text" class="form-control" id="pk_reason" name="reason" placeholder="套餐寓意">
							    </div>
							    
							    <label for="exampleInputAddress1" class="col-sm-2">套餐销量</label>
							    <div class="col-sm-3">
							      <input type="text" class="form-control" id="pk_sales" name="sales" placeholder="套餐销量">
							    </div>
							  </div>
							  <div class="form-group">
							    <div class="col-sm-offset-2 col-sm-10">
							      <div class="checkbox">
							        <label>
							          <input type="checkbox"> 记住我
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
				      <div class="modal-footer" >
				        <button type="button" class="btn btn-default" data-dismiss="modal" style="float: right;margin-left: 3%;">关闭窗口</button>
				        <button type="button" class="btn btn-primary" onclick="addPackage('formadd','步步高升');" style="float: right;">确认添加</button>
				      </div>
				    </div>
				  </div>
				</div>
				
				<!-- ADMIN表 代码 -->
				<table class="table-7" style="width:96%"><!-- 将“table-1”替换为任何设计编号 -->
				<!-- 套餐的字段：package name number Scene reason price sales str2-->
					<thead>
					<tr>
						<th>ID</th>
						<th>套餐名</th>
						<th>菜品数</th>
						<th>场景</th>
						<th>套餐寓意</th>
						<th>价格</th>
						<th>销量</th>
						<th>操作</th>
					</tr>
					</thead>
					<tbody>
					<tr>
						<td>1</td>
						<td>喜结同心</td>
						<td>8</td>
						<td>升学宴</td>
						<td>夫妻永结同心</td>
						<td>999</td>
						<td>0</td>
						<td><button type="button" class="btn btn-primary" data-toggle="modal" onclick="showAllfood('','PKFood','步步高升')" data-target="#myLgModal4">添加菜品测试按钮</button>
						
						<!--  测试：  添加菜品    菜品的表单框 -->
						<div class="modal fade" id="myLgModal4">
							<div class="modal-dialog modal-lg" style="width: 95%">
						    <div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
									<h4 class="modal-title" style="color:black;">添加菜品测试对话框</h4>
								</div>
								
								
						        <div class="scrollbar-hover" style="width:100%; max-height: 300px;background-size:contain;float:left; overflow: scroll;">
									
									
								</div>
						      <div class="modal-footer" >
						        <button type="button" class="btn btn-default" data-dismiss="modal" style="float: right;margin-left: 3%;">关闭窗口</button>
						        <button type="button" class="btn btn-primary" style="float: right;">确认修改</button>
						      	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myLgModal2">大对话框</button>
						      </div>
						    </div>
						  </div>
						</div>
						</td>
					</tr>
					</tbody>
				</table>
				<!-- AJAX异步刷新出PACKAGE表 -->
				<script>
					//异步刷新出所搜索菜品的方法
					//传入的参数分别为                  模块id  模块id2  套餐名
					function showAllfood(modualid,modualid2,Name){
						var sqlPKName = '步步高升';
						if(Name!=''){//若传入的  套餐名不为空则PKName=传入的值
							sqlPKName=Name;
						}
						$("#sqlPKName").attr("value",sqlPKName);
						if(modualid!=''){//模块一的id  不为空的话就异步刷新模块1
							var key="name";
							var value="鸡蛋";
							$("#sqlPKName").attr("value",sqlPKName);
							if($("#sqlvalue").val()==''){
								$("#sqlvalue").attr("value",value);
							}else{
								$("#sqlvalue").attr("value",$("#sqlvalue").val());
								console.log("admin,showAllfood,sqlvalue=="+$("#sqlvalue").val());
							}
							$("#sqlkey").attr("value",key);
							$.ajax({
								url:"backData/admin_1searchfoodShow.jsp",
								type:"POST",
								data:$("#searchFoodForm").serialize(),  //form表单的序列化
								dataType:"JSON",
								success:function(data){
									if(data.code=1){
										//console.log(data.data);
										//修改searchFood里面的内容
										var result=data.data;
										var strs='';
										for(i in result){
											//console.log(result[i].name);
											var menuNo=result[i].menuNo;
											var name=result[i].name;
											var kind=result[i].kind;
											var serial=result[i].serial;
											var mean=result[i].mean;
											var price=result[i].price;
											var sales=result[i].sales;
										 strs+=
										'<tr>'+
											'<td>'+menuNo+'</td>'+
											'<td>'+name+'</td>'+
											'<td>'+kind+'</td>'+
											'<td>'+serial+'</td>'+
											'<td>'+mean+'</td>'+
											'<td>'+price+'</td>'+
											'<td>'+sales+'</td>'+
											'<td>'+
											'<button  class="btn btn-primary" onclick="doPK_MN('+"'"+sqlPKName+"'"+','+"'"+name+"'"+','+"'"+"add"+"'"+')" type="button">'+
												'添加'+
											'</button>'+
											'</td>'+
										'</tr>';
										}
									$("#"+modualid).html( strs );
									//alert("allfood,showAllfood,data.code=="+data.code+";data"+data);
									}
								}
							});
						}
						
						if(modualid2!=''){
							$.ajax({
								url:"backData/admin_1pkfoodShow.jsp",
								type:"POST",
								data:$("#searchFoodForm").serialize(),  //form表单的序列化
								dataType:"JSON",
								success:function(data){
									if(data.code=1){
										//console.log(data.data);
										//修改searchFood里面的内容
										var result2=data.data;
										var strs2='';
										for(i in result2){
											//console.log(result2[i].name);
											var menuNo=result2[i].menuNo;
											var name=result2[i].name;
											var kind=result2[i].kind;
											var serial=result2[i].serial;
											var mean=result2[i].mean;
											var price=result2[i].price;
											var sales=result2[i].sales;
										 strs2+=
										'<tr>'+
											'<td>'+menuNo+'</td>'+
											'<td>'+name+'</td>'+
											'<td>'+kind+'</td>'+
											'<td>'+serial+'</td>'+
											'<td>'+mean+'</td>'+
											'<td>'+price+'</td>'+
											'<td>'+sales+'</td>'+
											'<td>'+
											'<button  class="btn btn-primary" type="button">'+
												'删除'+
											'</button>'+
											'</td>'+
										'</tr>';
										}
									$("#"+modualid2).html( strs2 );
									//alert("allfood,showAllfood,data.code=="+data.code+";data"+data);
									}
								}
							});
						}
						 
					}
					
					
					/*
					这是向套餐添加菜品和从套餐删除菜品的方法
					*/
					//参数          套餐名         菜品名        删除还是添加
					function doPK_MN(PKName,MNName,dowhat){
						if(dowhat=='del'){
							
						}
						
						if(dowhat=='add'){
							$("#sqlPKName").attr("value",PKName);
							$("#sqlMNName").attr("value",MNName);
							$("#sqldowhat").attr("value",dowhat);
							$.ajax({
								url:"backData/admin_1doPK_MN.jsp",
								type:"POST",
								data:$("#searchFoodForm").serialize(),  //form表单的序列化
								dataType:"JSON",
								success:function(data){
										alert(data.data);
								}
							});
						}
					}
					
				</script>
				<script>
				function showPackage(){//异步刷新出package的方法
					$.ajax({
						url:"backData/admin_2PKShow.jsp",
						type:"POST",
						dataType:"JSON",
						success:function(data){
							var strs="";
							if(data.code==1){
								result=data.data;
								//packagetbode的内容
								for( i in result ){
									console.log("admin1_3:i=="+i);
									console.log("admin1_3:result[i]=="+result[i]);
									pkBean=result[i];
									var PKName = "'"+pkBean.name+"'";
									var PKFood="'PKFood"+pkBean.packageNo+"'";
									var searchFood = "'searchFood"+pkBean.packageNo+"'";
									strs+="<tr><td>"+pkBean.packageNo;
									strs+="</td><td>"+pkBean.name;
									strs+="</td><td>"+pkBean.number;
									strs+="</td><td>"+pkBean.Scene;
									strs+="</td><td>"+pkBean.reason;
									strs+="</td><td>"+pkBean.price;
									strs+="</td><td>"+pkBean.sales+"</td>";
									//添加菜品的按钮
									strs+='<td><button type="button" class="btn btn-primary" onclick="showAllfood('+"''"+','+PKFood+','+PKName+')" data-toggle="modal" data-target="#myLgModal'+pkBean.packageNo+'">添加菜品</button>';
									// 套餐的表单框 
									strs+='<div class="modal fade" id="myLgModal'+pkBean.packageNo+'">';
									strs+='<div class="modal-dialog modal-lg" style="width: 95%">';
									strs+='<div class="modal-content">';
									strs+='<div class="modal-header">';
									strs+='<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>';
									strs+='<h4 class="modal-title" style="color:black;">'+pkBean.name+'</h4>';   //标题
									strs+='</div>';
									strs+='<div class="scrollbar-hover" style="width:100%; max-height: 300px; background-size:contain;float:left; overflow: scroll;">';
									//用来修改的form表单
										
									strs+=
									'<div style="float:left;width:40%;margin-left: 4%;">'+
									'<form id="searchFoodForm" class="form-horizontal"  style="width:90%; margin:1%;">'+
									 '<div class="input-group" >'+
									  '<div class="input-control search-box search-box-circle has-icon-left has-icon-right search-example" id="searchboxExample">'+
									    //<!-- 模糊搜索菜品名内容 -->
									    '<input id="sqlvalue" name="sqlvalue" type="search" class="form-control search-input" placeholder="模糊搜索菜品名" value="">'+
									    '<input id="sqlkey" name="sqlkey" type="hidden" value="">'+
									    '<input id="sqlPKName" name="sqlPKName" type="hidden" value="">'+
									    '<input id="sqlMNName" name="sqlMNName" type="hidden" value="">'+
									    '<input id="sqldowhat" name="sqldowhat" type="hidden" value="">'+
									    '<label for="inputSearchExample3" class="input-control-icon-left search-icon"><i class="icon icon-search"></i></label>'+
									  '</div>'+
									  '<span class="input-group-btn">'+
									    '<button class="btn btn-primary" onclick="showAllfood('+searchFood+','+"''"+','+PKName+')" type="button">搜索</button>'+
									  '</span>'+
									'</div>'+
								'</form>'+
								
								
								'<div  class="scrollbar-hover" style="width:100%; margin:0.5%; height: 300px; background-size:contain;float:left; overflow: scroll;">'+
									'<table class="table-7" style="width:96%">'+
										'<thead>'+
											'<tr>'+
												'<th>ID</th>'+
												'<th>菜品名</th>'+
												'<th>菜品种类</th>'+
												'<th>菜品菜系</th>'+
												'<th>菜品寓意</th>'+
												'<th>菜品价格</th>'+
												'<th>销量</th>'+
												'<th>操作</th>'+
											'</tr>'+
										'</thead>'+
										//<!-- 这里面的内容会异步刷新出来 -->
										'<tbody id='+searchFood+'>'+
											'<tr>'+
												'<td>1</td>'+
												'<td>喜结同心</td>'+
												'<td>8</td>'+
												'<td>升学宴</td>'+
												'<td>夫妻永结同心</td>'+
												'<td>999</td>'+
												'<td>0</td>'+
												'<td>'+
												'<button  class="btn btn-primary" type="button">'+
													'添加'+
												'</button>'+
												'</td>'+
											'</tr>'+
										'</tbody>'+
									'</table>'+
								'</div>'+
								'</div>'+
								
								'<div style="float:right;width:50%;margin-right: 4%;">'+
								'<div align="center" style="font-size: 25px;"> 此套餐的菜品 </div>'+
								'<div  class="scrollbar-hover" style="width:99%; margin:0.5%; height: 300px; background-size:contain;float:right; overflow: scroll;">'+
									
									'<table class="table-7" style="width:96%">'+
										'<thead>'+
											'<tr>'+
												'<th>ID</th>'+
												'<th>菜品名</th>'+
												'<th>菜品种类</th>'+
												'<th>菜品菜系</th>'+
												'<th>菜品寓意</th>'+
												'<th>菜品价格</th>'+
												'<th>销量</th>'+
												'<th>操作</th>'+
											'</tr>'+
										'</thead>'+
										//<!-- 会异步刷新的套餐菜品表 -->'+
										'<tbody id='+PKFood+'>'+
											'<tr>'+
												'<td>1</td>'+
												'<td>喜结同心</td>'+
												'<td>8</td>'+
												'<td>升学宴</td>'+
												'<td>夫妻永结同心</td>'+
												'<td>999</td>'+
												'<td>0</td>'+
												'<td>'+
												'<button  class="btn btn-primary" type="button">'+
													'添加'+
												'</button>'+
												'</td>'+
											'</tr>'+
										'</tbody>'+
									'</table>'+
								'</div>'+
								'</div>';
									
									
									strs+='</div>';
									strs+='<div class="modal-footer" >'+
								        '<button type="button" class="btn btn-default" data-dismiss="modal" style="float: right;margin-left: 3%;">关闭窗口</button>'+
								        '<button type="button" onclick="showAllfood('+searchFood+','+PKFood+','+PKName+')" class="btn btn-primary" style="float: right;">刷新页面</button>'+
								      '</div>';
									strs+='</div></div></div>';
									strs+='</td></tr>';
								}
								$("#packageTbody").html( strs );
							}
						}
					});
				};
				showPackage();
				</script>
				<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myLgModal_add" style="float:right;margin:0.5%;">添加套餐</button>
				<!-- 套餐的字段：package name number Scene reason price sales str2-->
				<table class='table-7' id='packageTable' style='width:96%'>
					<thead>
						<tr>
						<th>ID</th>
						<th>套餐名</th>
						<th>菜品数</th>
						<th>场景</th>
						<th>套餐寓意</th>
						<th>价格</th>
						<th>销量</th>
						<th>操作</th>
						</tr>
					</thead>
					<!--会异步刷新的  packageTbody-->
					<tbody id="packageTbody">
					</tbody>
					
				</table>
				<script>
					function modifyPackage(formid){
						
					}
					function addPackage(formid){   //添加Package的Js函数
						//alert('avndaia');
						if( $("#pk_name").val()=='' ){
							alert("套餐名不能为空");
							return;
						};
						if( $("#pk_Scene").val()=='' ){
							alert("套餐场景不能为空");
							return;
						};
						if( $("#pk_reason").val()=='' ){
							alert("套餐寓意不能为空");
							return;
						};
						if( $("#pk_sales").val()==''){
							alert("套餐销量不能为空");
							return;
						};
						var re = /^[0-9]+.?[0-9]*$/; //判断字符串是否为数字 //判断正整数 /^[1-9]+[0-9]*]*$/ 
						var nubmer = $("#pk_sales").val();
						if (!re.test(nubmer)){
							alert("套餐销量不能为非数字");
							document.getElementById("pk_sales").value = "";
							return;
						};
						
						var formdata=($("#"+formid+"").serialize());
						var formStr= decodeURIComponent(formdata,true);
						console.log('admin,formStr=='+formStr);
						$.ajax({
							url:"backData/admin_2PKAdd.jsp",
							type:"POST",
							data:formStr,
							dataType:"JSON",
							success:function(data){
								alert(data.data);
								}
							});
						
					}
				</script>
				
			
			
			
			
			
			</div>
		</div>
		
		<!-- 1_2.菜品信息 -->
		<div style="width: 100%; float: left;height:360px;">
			<div class="header" style="width: 100%;float: left;">
				<ul>
					<li class="index_title">菜品信息</li>
				</ul>
			</div>
			<div class="scrollbar-hover" style="width:100%; height: 300px;background-size:contain;
					background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;
												float:left; overflow: scroll;">
				<!-- AJAX异步刷新出MENU表 -->
				<script>
				function showMenu(){//异步刷新出menu的方法
					$.ajax({
						url:"backData/admin_1MNShow.jsp",
						type:"POST",
						dataType:"JSON",
						success:function(data){
							var strs="";
							if(data.code==1){
								result=data.data;
								//Menutbody的内容
								// 套餐的字段：menuNo name serial price kind price mean profit_margin photo material sales str2
								for( i in result ){
									console.log("admin1_1:i=="+i);
									console.log("admin1_1:result[i]=="+result[i]);
									mnBean=result[i];
									strs+="<tr><td>"+mnBean.menuNo;
									strs+="</td><td>"+mnBean.name;
									strs+="</td><td>"+mnBean.serial;
									strs+="</td><td>"+mnBean.price;
									strs+="</td><td>"+mnBean.kind;
									strs+="</td><td>"+mnBean.mean;
									strs+="</td><td>"+mnBean.profit_margin;
									strs+="</td><td>"+mnBean.sales+"</td>";
									strs+='<td><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myLgModal">修改信息</button>';
									// 修改菜品的表单框 
									strs+='<div class="modal fade" id="myLgModal">';
									strs+='<div class="modal-dialog modal-lg">';
									strs+='<div class="modal-content">';
									strs+='<div class="modal-header">';
									strs+='<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>';
									strs+='<h4 class="modal-title" style="color:black;">标题</h4>';
									strs+='</div>';
									strs+='<div class="scrollbar-hover" style="width:100%; max-height: 400px; background-size:contain;float:left; overflow: scroll;">';
									//用来修改的form表单
									strs+='<form class="form-horizontal" style="width:90%">'+
									 '<div class="form-group">'+
									    '<label for="exampleInputAccount4" class="col-sm-2">菜品名</label>'+
									    '<div class="col-sm-3">'+
									      '<input type="text" class="form-control" id="exampleInputAddress3" placeholder="套餐名">'+
									    '</div>'+
									    '<label for="exampleInputAccount4" class="col-sm-2">套餐场景</label>'+
									    '<div class="col-sm-4">'+
									    '<select class="form-control" id="exampleInputAddress1">'+
									        '<option>婚宴</option>'+
									        '<option>庆功宴</option>'+
									      '</select>'+
									    '</div>'+
									  '</div>'+
									  '<div class="form-group">'+
									    '<label for="exampleInputPassword4" class="col-sm-2">套餐寓意</label>'+
									    '<div class="col-sm-3">'+
									        '<input type="text" class="form-control" id="exampleInputAddress3" placeholder="套餐寓意">'+
									    '</div>'+
									    
									    '<label for="exampleInputAddress1" class="col-sm-2">套餐销量</label>'+
									    '<div class="col-sm-3">'+
									      '<input type="text" class="form-control" id="exampleInputAddress3" placeholder="套餐销量">'+
									    '</div>'+
									  '</div>'+
									  '<div class="form-group">'+
									    '<div class="col-sm-offset-2 col-sm-10">'+
									      '<div class="checkbox">'+
									        '<label>'+
									          '<input type="checkbox"> 记住我'+
									        '</label>'+
									      '</div>'+
									    '</div>'+
									  '</div>'+
									 '<div class="form-group">'+
									    '<div class="col-sm-offset-2 col-sm-10">'+
									      '<button type="submit" class="btn btn-default">确定</button>'+
									    '</div>'+
									  '</div>'+
									'</form>';
									
									strs+='</div>';
									
									
									strs+='<div class="modal-footer" >'+
								        '<button type="button" class="btn btn-default" data-dismiss="modal" style="float: right;margin-left: 3%;">关闭窗口</button>'+
								        '<button type="button" class="btn btn-primary" style="float: right;">确认修改</button>'+
								      '</div>';
									strs+='</div></div></div>';
									strs+='</td></tr>';
								}
								$("#menuTbody").html( strs );
							}
						}
					});
				};
				showMenu();
				</script>
				<!-- 套餐的字段：menuNo name serial price kind price mean profit_margin photo material sales str2-->
				<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myLgModal_menuadd" style="float:right;margin:0.5%;">添加菜品</button>
				<table class='table-7' id='menuTable' style='width:96%'>
					<thead>
						<tr>
						<th>菜品ID</th>
						<th>菜品名</th>
						<th>菜系</th>
						<th>价格</th>
						<th>菜品种类</th>
						<th>套餐名</th>
						<th>利润率</th>
						<th>销量</th>
						<th>操作</th>
						</tr>
					</thead>
					<!--会异步刷新的  packageTbody-->
					<tbody id="menuTbody">
					</tbody>
					
				</table>
				<script>
					function modifyMenu(formid){
						
					}
					function addMenu(formid){   //添加Package的Js函数
						//alert('avndaia');
						if( $("#mn_name").val()=='' ){
							alert("菜品名不能为空");
							return;
						};
						if( $("#mn_serial").val()=='' ){
							alert("菜系不能为空");
							return;
						};
						if( $("#mn_price").val()=='' ){
							alert("价格不能为空");
							return;
						};
						if( $("#mn_mean").val()=='' ){
							alert("菜品所属套餐不能为空");
							return;
						};
						if( $("#mn_photo").val()=='' ){
							alert("图片路径不能为空");
							return;
						};
						if( $("#mn_profit_margin").val()=='' ){
							alert("利润率不能为空");
							return;
						};
						
						if( $("#mn_material").val()=='' ){
							alert("菜品成分不能为空");
							return;
						};
						
						if( $("#mn_sales").val()==''){
							alert("菜品销量不能为空");
							return;
						};
						if( $("#mn_kind").val()==''){
							alert("菜品种类不能为空");
							return;
						};
						var re = /^[0-9]+.?[0-9]*$/; //判断字符串是否为数字 //判断正整数 /^[1-9]+[0-9]*]*$/ 
						var nubmer = $("#mn_sales").val();
						if (!re.test(nubmer)){
							alert("菜品销量不能为非数字");
							document.getElementById("mn_sales").value = "";
							return;
						};
						
						var formdata=($("#"+formid+"").serialize());
						var formStr= decodeURIComponent(formdata,true);
						console.log('admin,formStr=='+formStr);
						$.ajax({
							url:"backData/admin_1MNAdd.jsp",
							type:"POST",
							data:formStr,
							dataType:"JSON",
							success:function(data){
								alert(data.data);
								}
							});
					}
				</script>
				<!-- 添加菜品的表单框 -->
				<div class="modal fade" id="myLgModal_menuadd">
					<div class="modal-dialog modal-lg">
				    <div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
							<h4 class="modal-title" style="color:black;">请添加一个新菜品</h4>
						</div>
				        <div class="scrollbar-hover" style="width:100%; max-height: 300px; background-size:contain;float:left; overflow: scroll;">
							新增
							name
					 		serial 菜系
					 		price 价格 
					 		kind 菜品种类
					 		mean 套餐名
					 		profit_margin 菜品利润
					 		photo         照片路径
					 		material      成分
					 		sales         
					 		<form class="form-horizontal" id="formmenuadd" style="width:90%">     <!-- ID号为formadd的表单 -->
							  <div class="form-group">
							    <label for="exampleInputAccount4" class="col-sm-2">菜品名</label>
							    <div class="col-sm-3">
							      <input type="text" class="form-control" id="mn_name"  name="name" placeholder="菜品名">
							    </div>
							    <label for="exampleInputAccount4" class="col-sm-2">菜品菜系</label>
							    <div class="col-sm-3">
							    <select class="form-control" id="mn_serial" name="serial">
							        <option>粤菜</option>
							        <option>鲁菜</option>
							        <option>小吃</option>
							      </select>
							    </div>
							    
							  </div>
							  <div class="form-group">
							  <label for="exampleInputPassword4"  class="col-sm-2">菜品价格</label>
							    <div class="col-sm-3">
							        <input type="text" class="form-control" id="mn_price" name="price" placeholder="菜品价格">
							    </div>
							    
							  	<label for="exampleInputAddress1" class="col-sm-2">套餐名字</label>
							    <div class="col-sm-3">
							      <input type="text" class="form-control" id="mn_mean" name="mean" placeholder="套餐名字">
							    </div>
							    
							  </div>
							  <div class="form-group">
							  	<label for="exampleInputPassword4"  class="col-sm-2">菜品利润率</label>
							    <div class="col-sm-3">
							        <input type="text" class="form-control" id="mn_profit_margin" name="profit_margin" placeholder="菜品利润" value="0.3">
							    </div>
							    
							    <label for="exampleInputAddress1" class="col-sm-2">菜品销量</label>
							    <div class="col-sm-3">
							      <input type="text" class="form-control" id="mn_sales" name="sales" placeholder="套餐销量">
							    </div>
							    
							    
							  </div>
							  <div class="form-group">
							  	<label for="exampleInputAddress1" class="col-sm-2">照片路径</label>
							    <div class="col-sm-3">
							      <input type="text" class="form-control" id="mn_photo" name="photo" value="images/img/noPic.jpg">
							    </div>
							    <label for="exampleInputPassword4"  class="col-sm-2">菜品成分</label>
							    <div class="col-sm-3">
							        <input type="text" class="form-control" id="mn_material" name="material" placeholder="菜品所用的原材料">
							    </div>
							    
							    
							  </div>
							  <div class="form-group">
							  	<label for="exampleInputAddress1" class="col-sm-2">菜品种类</label>
							    <div class="col-sm-3">
							    <select class="form-control" id="mn_kind" name="kind">
							        <option>荤菜</option>
							        <option>素菜</option>
							        <option>小吃</option>
							      </select>
							    </div>
							  </div>
							</form>
						</div>
				      <div class="modal-footer" >
				        <button type="button" class="btn btn-default" data-dismiss="modal" style="float: right;margin-left: 3%;">关闭窗口</button>
				        <button type="button" class="btn btn-primary" onclick="addMenu('formmenuadd');" style="float: right;">确认添加</button>
				      </div>
				    </div>
				  </div>
				</div>
			</div>
			
		</div>
		
		
		<!-- 1_3.订单管理 -->
		<div style="width: 100%;float: left;">
			<div class="header" style="width: 100%;float:left;">
				<ul>
					<li class="index_title">订单信息</li>
				</ul>
			</div>
			<div class="scrollbar-hover" style="width:100%; height: 300px; background-size:contain;
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
			<div class="scrollbar-hover" style="width:100%; height: 300px; background-size:contain;
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
			
			<div id="foodCar" class="scrollbar-hover" align="center" style="width:100%; height: 300px;background-size:contain;
					background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;
												float:left; overflow: scroll;">
					
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