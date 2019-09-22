<%@page import="entity.UserBean"%>
<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>

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

	