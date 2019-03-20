<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>welcome.jsp</title>
	
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    
    <!--<link rel="stylesheet" type="text/css" href="./styles.css">-->
	<style type="text/css">
		* {
			margin: 0px;
			padding: 0px;
			font-size: 14px;
		}
		#up {
			height: 40px;
			border-bottom: 1px #999 dotted;
		}
		
		#up ul li {
			background: url("img/hold.png") 0 0 no-repeat #e5e5e5;
			color: #4C8FBD;
			background-position: 5px 9px;
			height: 40px;
		}
		#up ul li span {
			position: relative;
			top:8px;
			left: 30px;
		}
		#d1 {
			width: 90%;
			background: #D9EDF7;
			height: 50px;
			position: relative;
			top:10px;
			left: 50%;
			margin-left: -45%;
			border-radius: 5px;
		}
		.s1 {
			color: #69AA46;
			position: relative;
			top: 15px;
			left: 30px;
		}
		.s2 {
			color: #31708F;
			position: relative;
			top: 15px;
			left: 30px;
		}
		#d2 {
			width: 506px;
			height: 86px;
			background: url("img/logo2.png");
			position: relative;
			left: 50%;
			margin-left: -253px;
			top: 20px;
		}
	</style>
  </head>
  
  <body>
    <div id="up">
    	<ul>
    		<li><span>平台首页</span></li>
    	</ul>
    </div>
    <div id="down">
    	<div id="d1">
    		<span class="s1">最新公告：</span>
    		<span class="s2">庆祝七夕节，所有商品7折优惠！！！</span>
    	</div>
    	<div id="d2"></div>
    </div>
  </body>
</html>
