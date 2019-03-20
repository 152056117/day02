<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head lang="en">
<meta content="text/html; charset=UTF-8">
<title></title>
<style>
body {
	background: #000;
}

#div0 {
	width: 716px;
	height: 332px;
	position: relative;
	margin: 0 auto;
}

#duihao {
	width: 106px;
	height: 106px;
	position: absolute;
	top: 98px;
	left: 135px;
	bottom: 283px;
}

#zhuce {
	font-size: 66px;
	font-family: "SimHei";
	color: #ffffff;
	position: absolute;
	top: 114px;
	right: 157px;
	bottom: 152px;
}

#miao {
	font-size: 30px;
	font-family: "SimHei";
	color: #46f6fd;
	height: 47px;
	line-height: 47px;
	padding-left: 15px;
	position: absolute;
	bottom: 46px;
	left: 228px;
}

#zidong {
	font-size: 30px;
	font-family: "SimHei";
	color: #47f9fc;
	position: absolute;
	left: 283px;
	bottom: 57px;
	top: 245px;
}
</style>

	<script type="text/javascript">
  		
  		var start = 5;
  		var step = -1;
  		function count(){
  			document.getElementById("miao").innerHTML = start;
  			start += step;
  			if (start <= 0) {
				start = 5;
				//跳转
				window.location = "../pages/user_login.jsp";
			}
  			/*
  			 * 一次性定时器
  			 * 1000毫秒后继续执行count()方法 
  			 */
  			setTimeout("count()", 1000);
  		}
  		
  		//方法二：
		window.onload = count;
  		
  	</script>

</head>
<body><!-- 方法一：onload="count()" -->
	<div id="div0">
		<img src="../images/register_2.png" alt="" /> <span id="duihao"><img
			src="../images/register_3.png" alt="" /></span> <span id="zhuce">注册成功!</span>
		<span id="miao">5</span> <span id="zidong">秒钟后自动跳转！</span>
	</div>
</body>
</html>