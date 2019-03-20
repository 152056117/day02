<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>达内商城客户信息修改</title>
<link href="../css/csm_style.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Bootstrap 3.3.7 -->
<link rel="stylesheet" href="../css/bootstrap/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="../css/font-awesome/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet" href="../css/Ionicons/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="../css/AdminLTE/AdminLTE.min.css">
<!-- AdminLTE Skin -->
<link rel="stylesheet" href="../css/AdminLTE/skin/skin-blue.min.css">
<link rel="stylesheet" href="../css/bootstrap.min.css">
<script src="../js/jquery.js" type="text/javascript"></script>
<style type="text/css">
.mybtn {
	width: 6%;
	margin: 0 10px;
}
</style>
<script type="text/javascript">
//判断用户名
//用于标识用户名验证是否通过的标志
var usernameFlag=false;
//对输入的用户名进行校验
function checkUsername(){
	//取得用户名输入框的值,并去除前后空格
	var username = form1.username.value.trim();
	if(username!=""){
		//ajax实现异步请求
		//创建XMLHttpRequest对象
		var xmlHttp = new XMLHttpRequest();
		//配置xmlHttp对象三个参数（提交放式，提交地址，异步还是同步）
		xmlHttp.open("post","../servlet/CheckServlet?username="+encodeURI(encodeURI(username)),true);
		//xmlHttp.open("post","../servlet/CheckServlet?username="+username,true);
		//发送请求
		xmlHttp.send(null);
		//回调函数,响应后台处理信息
		xmlHttp.onreadystatechange=function(){
			//接受返回数据
			var rs = xmlHttp.responseText;
			if(xmlHttp.readyState==4){//交互完成
				if(xmlHttp.status==200){//成功状态
				if(rs=="fail"){//已经被注册
					//改变提示信息
					document.getElementById("warning-username-text").innerHTML="该用户已经被注册";
		    		//提示文字显示
		    		document.getElementById("warning-username-text").style.display="inline";
		    		//名字验证没通过
		    		usernameFlag=false;
				}else{
		    		//提示文字隐藏
		    		document.getElementById("warning-username-text").style.display="none";
		    		//名字验证通过
		    		usernameFlag=true;
				}
				}
			}
		}
	}else{//输入为空的时候
		//提示文字显示
		document.getElementById("warning-username-text").innerHTML="用户名不能为空";
	    document.getElementById("warning-username-text").style.display="inline";
		//名字验证没通过
		usernameFlag=false;
	}
}

//判断密码
	var passwordFlag=false;
	function checkPassword(){//验证密码
	var password =form1.password.value.trim();
	if(password!=""){//密码不为空
		document.getElementById("warning-password-text").style.display="none";
		passwordFlag = true;
	}else{//密码为空
		document.getElementById("warning-password-text").innerHTML="密码不能为空";
		document.getElementById("warning-password-text").style.display="inline";
		passwordFlag = false;
	}
}
	//检测手机号
	var mobileFlag=false;
	function checkMobile(){
		var mobile = form1.mobile.value.trim();
		if(mobile!=""){//密码不为空
			var reg = /^1[3-9]\d{9}$/;
			if(reg.test(mobile)){//符合校验规则
				
        		document.getElementById("warning-mobile-text").style.display="none";
        		mobileFlag = true;
			}else{
				document.getElementById("warning-mobile-text").innerHTML="请输入正确的手机号";
				
				document.getElementById("warning-mobile-text").style.display="inline";
				mobileFlag = false;
			}

    	}else{//密码为空
    		document.getElementById("warning-mobile-text").innerHTML="手机号不能为空";
    	    document.getElementById("warning-mobile-text").style.display="inline";
    		mobileFlag = false;
    	}
	}
	//检测邮箱
	var mailboxFlag=false;
	function checkMailbox(){
		var mailbox = form1.mailbox.value.trim();
		if(mailbox!=""){//邮箱不为空
			var reg = /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/;
			if(reg.test(mailbox)){//符合校验规则
        		document.getElementById("warning-mailbox-text").style.display="none";
        		mailboxFlag = true;
			}else{
				document.getElementById("warning-mailbox-text").innerHTML="请输入合法的邮箱地址";
				document.getElementById("warning-mailbox-text").style.display="inline";
				mailboxFlag = false;
			}
		
    	}else{//邮箱为空
    		document.getElementById("warning-mailbox-text").innerHTML="邮箱地址不能为空";
    		document.getElementById("warning-mailbox-text").style.display="inline";
    		mailboxFlag = false;
    	}
	}
	//验证表单校验是否通过
	function checkAll(){
		//用户名
		if(!usernameFlag){
			checkUsername();
			return false;
		}
		//密码
		if(!passwordFlag){
			checkPassword();
			return false;
		}
		//手机号
		if(!mobileFlag){
			checkMobile();
			return false;
		}
		//邮箱	
		if(!mailboxFlag){
			checkMailbox();
			return false;
		}
		//提交表单
		form1.submit();
		return false;
	}
</script>
<meta name="viewport" content="width=device-width,initial-scale=1">
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../css/content.css">
<script src="../js/jquery.js" type="text/javascript"></script>
</head>
<body bgcolor=#ECF7E6>
	<div id="up">
		<ul>
			<li><span><a href="../welcome.jsp">平台首页 </a>&gt; 用户管理
					&gt; 用户添加</span></li>
		</ul>
	</div>
	<!-- <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<a href="#" class="navbar-brand">管理</a>
			</div>
			<div id="navbar" class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li><a href="#">平台首页>></a></li>
					<li><a href="#">用户管理>></a></li>
					<li class="active"><a href="#">用户添加</a></li>
				</ul>
			</div>
		</div>
	</nav> -->

	<div style="margin: 20px">
		<div class="col-sm-2"></div>
		<div class="row col-sm-10" style="margin: 0px auto;">
			<form name="form1" method="post" action="../servlet/AddUserServlet"
				class="form-horizontal">
				<div class="form-group">
					<label class="col-sm-2 control-label">用户姓名</label>
					<div class="col-sm-6">
						<input type="text" class="form-control" name="username"
							onblur="checkUsername()"> <span id="warning-all">
							<span id="warning-username-text" style="color: red"></span>
						</span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">用户密码</label>
					<div class="col-sm-6">
						<input type="text" class="form-control" name="password"
							onblur="checkPassword()"> <span id="warning-all">
							<span id="warning-password-text" style="color: red"></span>
						</span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">手机号 </label>
					<div class="col-sm-6">
						<input type="text" class="form-control" name="mobile"
							onblur="checkMobile()"> <span id="warning-all"> <span
							id="warning-mobile-text" style="color: red"></span>
						</span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">邮箱 </label>
					<div class="col-sm-6">
						<input type="text" class="form-control" name="mailbox"
							onblur="checkMailbox()"> <span id="warning-all"> <span
							id="warning-mailbox-text" style="color: red"></span>
						</span>
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-2 control-label">性别</label>
					<div class="col-sm-6">
						<select name="sex" class="form-control in">
							<option value="0">请选择</option>
							<option value="1">男</option>
							<option value="2">女</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 text-center">
						<input type="submit" value="确认" class="btn btn-primary mybtn"
							onclick="return checkAll()" name="Submit"> <input
							type="reset" value="重置" class="btn btn-info mybtn" name="Submit2">
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
