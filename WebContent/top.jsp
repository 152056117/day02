<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>top.jsp</title>
	
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    
    <!--<link rel="stylesheet" type="text/css" href="./styles.css">-->
	<style type="text/css">
		* {
			margin: 0px;
			padding: 0px;
			font-size: 12px;
		}
		
		#up {
			height: 47px;
			background: #438EB9;
		}
		
		#up div {
			float: left;
		}
		
		#left {
			height: 37px;
			width: 230px;
			background: url("img/logo1.png") no-repeat;
			position: relative;
			left: 30px;
			top: 3px;
		}
		
		#right {
			text-align: right;
			width: 100%;
			position: relative;
			bottom: 10px;
			right: 20px;
			color: #f5f5f5;
			font-weight: bold;
			font-family: arial;
		}
		
		#right a:VISITED, #right a:LINK {
			color: #f5f5f5;
			font-family: arial;
			text-decoration: none;
		}
		
		#right a:HOVER {
			color: #f5f5f5;
			font-family: arial;
			text-decoration: underline;
		}
	</style>
  </head>
  <body>
    <div id="up">
    	<div id="left"></div>
    	<div id="right">
    		<span>
    			欢迎[<a href=""><%=session.getAttribute("username") %></a>]&nbsp;&nbsp;
    			<a href="servlet/logoutServlet" target="_parent">退出</a>
    		</span>
    		<script>setInterval("clock.innerHTML=new Date().toLocaleString() + '&nbsp;&nbsp;' + ''.charAt(new Date().getDay());",1000);</script>
    		<span id="clock" style="font-size: 12px;font-family: arial;"></span>
    	</div>
    </div>
  </body>
</html>
