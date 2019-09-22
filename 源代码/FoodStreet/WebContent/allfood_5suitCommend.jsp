<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>
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
		      	<div >Top1</div>
	      	</div>
	      	<!-- 大对话框 -->
			<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myLgModal">大对话框</button>
	      	
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