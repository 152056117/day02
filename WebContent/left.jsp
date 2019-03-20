<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>left.jsp</title>
	
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
		body {
			border: 1px #ddd solid;
		}
		
		div h3 {
			height: 40px;
			cursor: pointer;/*鼠标放在上面变成手型*/
			background: #f8f8f8;
			border-bottom: 1px #999 dotted;
			color: #2B7DBC;
		}
		#con {
			background: url("img/cont.png") no-repeat;
		}
		
		div h3 span {
			position: relative;
			top: 10px;
			left: 30px;
		}
		
		div ul {
			display: none;
		}
		
		div ul li {
			height: 40px;
			border-bottom: 1px #999 dotted;
			color: #616161;
			cursor: pointer;
			list-style: none;
		}
		
		div ul li a {
			position: relative;
			top: 10px;
			left: 40px;
			border-left: 1px #999 dotted;
		}
		
		div ul li a:VISITED,div ul li a:LINK {
			text-decoration: none;
			color: #616161;
		}
		div ul li a:HOVER {
			text-decoration: underline;
			color: #222;
			font-weight: bold;
			border-left: 1px #222 dotted;
		}
		
		div ul li:HOVER {
			background: #e8e8e8;
		}
		
		.h1 {
			background: url("img/user.png") 0 0 no-repeat #e8e8e8;
			background-position: 5px 9px;
		}
		.h2 {
			background: url("img/product.png") 0 0 no-repeat #e8e8e8;
			background-position: 5px 9px;
		}
		.h3 {
			background: url("img/desc.png") 0 0 no-repeat #e8e8e8;
			background-position: 5px 9px;
		}
		.h4 {
			background: url("img/order.png") 0 0 no-repeat #e8e8e8;
			background-position: 5px 9px;
		}
		.h5 {
			background: url("img/other.png") 0 0 no-repeat #e8e8e8;
			background-position: 5px 9px;
		}
	</style>
	<script type="text/javascript" src="js/jquery-1.8.3.js"></script>
	<script type="text/javascript">
		$(function(){
			$("h3").click(topic,topic);
			function topic() {
				$(this).next("ul").slideToggle(200);
				$(this).next("ul").siblings("ul").slideUp(200);
			}
		});
	</script>
  </head>
  
  <body>
    <div>
    	<h3 id="con"></h3>
    	<h3 class="h1"><span>用户管理</span></h3>
    	<ul>
    		<li><a href="pages/user_add.jsp" target="con">--用户添加</a></li>
    		<li><a href="pages/user-list.jsp" target="con">--用户列表</a></li>
    	</ul>
    	<h3 class="h2"><span>商品管理</span></h3>
    	<ul>
    		<li><a href="product/add.jsp" target="con">--商品添加</a></li>
    		<li><a href="product/list.jsp" target="con">--商品列表</a></li>
    	</ul>
    	<h3 class="h3"><span>类别管理</span></h3>
    	<ul>
    		<li><a href="type/addtype.jsp" target="con">--类别添加</a></li>
    		<li><a href="type/listtype.jsp" target="con">--类别列表</a></li>
    	</ul>
    	<h3  class="h4"><span>订单管理</span></h3>
    	<ul>
    		<li><a href="order/order-list.jsp?status=-1" target="con">--所有订单</a></li>
    		<li><a href="order/order-list.jsp?status=1" target="con">--待付款</a></li>
    		<li><a href="order/order-list.jsp?status=2" target="con">--处理中</a></li>
    		<li><a href="order/order-list.jsp?status=3" target="con">--已发货</a></li>
    		<li><a href="order/order-list.jsp?status=4" target="con">--已交付</a></li>
    		<li><a href="order/order-list.jsp?status=999" target="con">--已销毁</a></li>
    	</ul>
    	<!-- <h3 class="h5"><span>其他操作</span></h3>
    	<ul>
    		<li><a href="" target="con">--订单列表</a></li>
    	</ul> -->
    </div>
  </body>
</html>
