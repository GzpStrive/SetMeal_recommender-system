<%@page import="entity.UserBean"%>
<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>
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
        <h3>我是第一张幻灯片</h3>
        <p>:)</p>
      </div>
    </div>
    <div class="item">
      <img alt="Second slide" src="http://zui.sexy/docs/img/slide2.jpg">
      <div class="carousel-caption">
        <h3>我是第二张幻灯片</h3>
        <p>0.0</p>
      </div>
    </div>
    <div class="item">
      <img alt="Third slide" src="http://zui.sexy/docs/img/slide3.jpg">
      <div class="carousel-caption">
        <h3>我是第三张幻灯片</h3>
        <p>最后一张咯~</p>
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
