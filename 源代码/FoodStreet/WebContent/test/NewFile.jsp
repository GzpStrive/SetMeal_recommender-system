<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>图片的缓慢缩放</title>
  <style>
		.box{
			width:300px;
			margin:0 auto;
			height:auto;
		}
</style>
		<script type="text/javascript">
		/***
			实现缩放图片的关键点：
			1）图片需要用<img>来引用
			   通过我本人自己的测试，发现图片的宽高不能通过css或内联style来另外设置，不然缩放不起作用。
			2）实现缩放效果采用setInterVal()缓慢缩放
			3）宽高要同比例缩放
			   例如：以同比例5%的速度增大
					 img.width = img.width*1.05;
					 img.height = img.height*1.05;
			4）图片缩放的限制：
			   **每次点击时规定缩放的比例
			   **图片总体缩放到一定程度后，限制不能缩放
			5）注意释放定时器clearInterval();
		***/
			window.onload = function(){
				
			}
		</script>
</head>
<script>
  window.onload = function(){
    var btn_big = document.getElementById("big");
    var btn_small = document.getElementById("small");
    var pic = document.getElementById("pic");
    //缓慢放大
    btn_big.onclick = function(){
      var width = parseInt(pic.style.width);
      var i = width;
      var count = 0;
      console.log(width);
      var timer = setInterval(function(){
    	count=count+0.25;  //改变count和i所加的值可以控制图片的放大的速度
        i=i+0.25;
        pic.style.width = i + "%";   
        if(count == 10 ){
          clearInterval(timer);
        }else if( i > 50){
          btn_big.onclick = function(e){
            btn_big.onclick = null;
          };
        }
      },13);
    };
 
    //缓慢缩小
    btn_small.onclick = function(){
      var width = parseInt(pic.style.width);
      var count = 0;
      if(width == 10){
        alert("图片已最小!!");
        return false;
      }
      console.log(width);
      var timer2 = setInterval(function(){
        count=count+0.25;  //改变count和width所加减的值可以控制图片的缩小的速度
        width=width-0.25;
        pic.style.width = width +"%";
        if(count == 10){
          clearInterval(timer2);
        }else if( width < 10){
          btn_small.onclick = null;
        }
      },13);
    }
  }
</script>
<style>
  #pic{
    width: 20%;
  }
</style>
<body>
  <div id="pic" style="width: 20%">
    <img src="images/null.jpg" style="width:100%;">
  </div>
  
    <div class="scale">
    <button id="big">放大</button> <button id="small">缩小</button>
  </div>
 

</body>
</html>
