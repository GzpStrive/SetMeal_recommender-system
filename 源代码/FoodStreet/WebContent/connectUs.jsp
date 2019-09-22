<%@page import="entity.Admin"%>
<%@page import="dao.AdminDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="entity.Backcolor"%>
<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>联系我们</title>
 
<style type="text/css">    
.Foodbtn{
		margin:0 auto;   
		width: 50%;   
		background: purple;    
		/*transition: width 1s;*/    
		/*all所有元素发生变化用这个控制*/    
		transition: all 0.4s;			   
}    
.Foodbtn:hover{  
	width: 100%;    
}
  
</style>
<!-- 导入脚本 -->
<script type="text/javascript" src="zui-1.9.0/js/jquery-1.9.1.js"></script>

<script>
function showFood(Foodid){
	var choicefood =document.getElementById(Foodid);
	choicefood.style.display="block";
}

function noshowFood(Foodid){
	var choicefood =document.getElementById(Foodid);
	choicefood.style.display="none";
}

//定义一个搜索函数 (其中数据显示部分使用ajax异步刷新实现)
function search(){
	if($("#No").val()==''){
		alert("用户编号不能为空");
		return;
	}else{
	$.ajax({
		url:"backData/connectUsdo.jsp",
		type:"POST",
		data:$("#myform").serialize(),
		dataType:"JSON",
		success:function(data){
			$("#result").html('');
			if(data.code==1){
				result=data.data;
				var strs="<div>第"+result.No+"位";
				strs+="/电话："+result.telephone +"</div>";
			}
			$("#result").html( strs );
		}
	})
	}
}
</script>
</head>    
<body>
<!-- 背景颜色 -->
<% 
	Backcolor bc=new Backcolor();
	bc.SetColor("淡兰云白");
	String backcolor=bc.getColor();
	AdminDao dao1 = new AdminDao();
	Admin admin = dao1.selectAdmin("1");
%>

	
<!-- 一，头部目录  -->
<div style="width:100%; background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;
			background-size:contain;position:fixed;z-index: 101;">
	<%@include file="header.jsp"  %>
</div>
<!-- 滚动条样式 -->
<div class="scrollbar-hover" style=" background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;background-size:contain; max-height: 100%; overflow: scroll;">   
	
	<!--二，主体样式  -->
	<div style="margin:0 auto; margin-top:100px; width: 80%;"  align="center" >
		<div class="">
		<%=""+admin.getNo() %>
		<%=admin.getPwd() %>
		</div>
		
		<div>
		</div>
		<!-- 一个查询填写信息查询的表单 -->
		<form id="myform">
			No:<input type="text" id="No" name="No" >
			<input type="button" value="查询" onclick="search()"/>
		</form>
		
		<div id="result">
		
		</div>
	</div>

</div>

<%
int  mub_pic_index=1;
while(mub_pic_index<=8){
%>
<div class="items items-hover" style="width:50% ; float: left;" >
	 <div class="item">
	    <div class="item-content">
	      	<div class="MaleList_text" style="width: 25%;">
	      		<img style="width: 70%;border-radius:40%;" 
	      			 src="images/login-pic/民男<%=mub_pic_index %>.jpeg"  alt=""></div>
	      	<div class="MaleList_text">
	      		<div>套餐名</div>
		      	<div>龙凤呈祥</div>   
	      	</div>
	      	
	      	<div class="MaleList_text">
	      		<div>菜品数量</div>
		      	<div >共12道菜</div>
	      	</div>
	      	
	      	<div class="MaleList_text">
	      		<div>热销榜</div>
		      	<div>Top1</div>
	      	</div>
	      	<div align="center" style="font-size: 120%;font-weight:bold;width: 75%;">推荐理由。。。。。。。。 </div>
	      	<!-- 大对话框 -->
	      	<div align="center" style="width:75%;">
			<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myLgModal"  style="margin: 0 auto;">大对话框</button>
	      	</div>
	    </div>
	    <div>	
			<!-- 对话框HTML -->
			<div class="modal fade" id="myLgModal">
				<div class="modal-dialog modal-lg">
			    <div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
						<h4 class="modal-title" style="color:black;">标题</h4>
					</div>
			        <div class="scrollbar-hover" style="width:100%; max-height: 300px; background-size:contain;float:left; overflow: scroll;">
						<%for(int i=1;i<=8;i++){  %>
						<div id="food<%=i %>"  class="col-md-4 col-sm-6 col-lg-3" style="width:20%;margin-top:2%;">
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
						  	</div>
						</div> 
						 <%} %>
					</div>
			      <div class="modal-footer" >
			        <button type="button" class="btn btn-default" data-dismiss="modal" style="float: right;margin-left: 3%;">关闭窗口</button>
			        <button type="button" class="btn btn-primary" style="float: right;">确认下单</button>
			      </div>
			    </div>
			  </div>
			</div>
   		</div>
  	</div>
</div>
<%mub_pic_index++;} %>
</body>
</html>