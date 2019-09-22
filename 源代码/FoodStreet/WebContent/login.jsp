<%@page import="entity.Backcolor"%>
<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登录</title>
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
<!-- 滚动条样式 -->
<div class="scrollbar-hover" style=" background: url(images/backcolor/<%=backcolor%>.jpg) repeat-x;background-size:contain; max-height: 700px; overflow: scroll;">

<div style="margin:0 auto; width: 80%;margin-top:100px; " align="center" >
<div class="index_title" style="width:60%; height: 300px;margin: 0 ; float: left;">
	欢迎登录福满轩套餐预订系统
</div>
<form class="form-horizontal"  style="width:40%;  margin:0 auto;float:left;"
	  action="logindo.jsp" method="post">
  <div class="form-group">
    <label for="exampleInputAccount4" class="col-sm-2">账号</label>
    <div class="col-md-6 col-sm-10">
      <input type="text" class="form-control" id="exampleInputAccount4" 
             placeholder="电子邮件/手机号/用户名" name="telephone">
    </div>
  </div>
  <div class="form-group">
    <label for="exampleInputPassword4" class="col-sm-2" >密码</label>
    <div class="col-md-6 col-sm-10">
      <input type="password" class="form-control" id="exampleInputPassword4" 
             placeholder="密码"  name="pwd">
    </div>
  </div>
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <div class="checkbox">
        <label>
          <input type="checkbox" name="isAdmin"> 管理员
        </label>
      </div>
    </div>
    <div class="col-sm-offset-2 col-sm-10">
      <button type="submit" class="btn btn-default">登录</button>
    </div>
  </div>
</form>
</div>
</div>
</body>
</html>