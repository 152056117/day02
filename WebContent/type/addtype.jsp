<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AddType</title>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<script src="../js/jquery.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="../css/content.css">
<script type="text/javascript">
	function check() {
		var name = document.getElementById("t_name").value.trim();
		if (name == "" || name == null) {
			alert("类别名称不能为空");
			return;
		} else {
			var xmlHttp = new XMLHttpRequest();
			//配置xmlHttp对象；
			xmlHttp.open("post", "../servlet/AddTypeServlet?t_name="
					+ encodeURI(encodeURI(name)), true); //false代表同步，true代表异步；
			//发送请求
			xmlHttp.send(null);
			//回调函数 
			xmlHttp.onreadystatechange = function() {
				//接收返回的数据：
				var rs = xmlHttp.responseText;
				if (xmlHttp.readyState == 4) {//交互完成
					if (xmlHttp.status == 200) {//成功状态
						if (rs == "success") {
							alert("添加成功");
							window.location = "../type/listtype.jsp";
						} else {
							alert("添加失败");
							window.location = "../type/addtype.jsp";
						}
					}
				}
			}
		}
	}
</script>
</head>
<body>
	<div id="up">
		<ul>
			<li><span><a href="../welcome.jsp">平台首页 </a>&gt; 类别管理
					&gt; 类别添加</span></li>
		</ul>
	</div>
	<!-- <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	<div class="container">
		<div class="navbar-header">
			<a href="#" class="navbar-brand">管理</a>
		</div>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="nav navbar-nav">
				<li><a href="../welcome.jsp">平台首页</a></li>
				<li><a href="#">类别管理</a></li>
				<li class="active"><a href="#">类别添加</a></li>
			</ul>
		</div>
	</div>
	</nav> -->
	<div style="margin-top: 100px">
		<div class="row">
			<div class="col-sm-2"></div>
			<form action="../servlet/AddTypeServlet" method="post"
				class="form-horizontal col-sm-10">
				<div class="form-group">
					<label class="col-sm-2 control-label">类别名称</label>
					<div class="col-sm-6">
						<input type="text" class="form-control" name="t_name" id="t_name">
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 text-center">
						<input type="button" value="添加" class="btn btn-primary"
							onclick="check()"> <input type="reset" value="取消"
							class="btn btn-info">
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>