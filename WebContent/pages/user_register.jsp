<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>达内商城</title>
    <style>
        body{
            position:absolute;
            top:0;
            bottom:0;
            left:0;
            right:0;
            color:#eee;
        }
        a {
            font-size:12px;
            color:#eee;
        }
        #login {
            width:300px;
            height:530px;
            position:absolute;
            top:0;
            bottom:0;
            left:0;
            right:0;
            margin:auto;
            background-color:rgba(0,0,0,0.6);
        }
        #login>div.header {
            padding:0 20px;
            height:44px;
            border-bottom:1px solid white;
            padding-bottom:24px;
        }
        #login>div.header .left{
            margin-top:13px;
        }
        #login>div.header .right{
            margin-top:14px;
        }
        #login>div.content {
            width:262px;
            margin:8px auto 0;
        }
        #login>div.content .bar span {
            display:block;
            width:56px;
            height:42px;
            line-height:42px;
            float:left;
            color:#aeaeae;
            background-color:#e8e8e8;
            text-align:center;
            font-size:12px;
        }
        #login>div.content input:not([type='checkbox']) {
            height:42px;
            border:none;
            padding:0 0 0 12px;
            width:204px;
            box-sizing:border-box;
        }
        #login>div.content div.warning {
            color:#c65149;
            font-size:12px;
            line-height:20px;
        }
        #login>div.content input.verify {
            width:109px;
        }
        #login>div.content div.verify {
            float:right;
            position:relative;
        }
        #login>div.content div.verify div.text{
            position:absolute;
            font-size:8px;
            text-decoration:underline;
            color:#2591cc;
            cursor:pointer;
        }
        #login>div.content div.option{
            padding-top:8px;
            overflow:hidden;
        }
        #login>div.content div.option .left {
            font-size:12px;
        }
        #login>div.content div.option .left input {
            width:12px;
            height:12px;
            margin:0;
            vertical-align:middle;
        }
        #login>div.content div.option .left span {
            vertical-align:middle;
        }
        #login>div.content div.option a{
            color:#2591cc;
        }
        #login>div.content button {
            width:100%;
            height:42px;
            background-color:#0aa2ee;
            outline:none;
            border:none;
            color:white;
            margin-top:8px;
        }
        #login>div.content button:hover {
            cursor:pointer;
        }
        i.icon {
            width:28px;
            height:28px;
            display:inline-block;
            vertical-align:middle;
        }
        i.icon.icon-ban {
            width:12px;
            height:12px;
            background:url('../images/ban.png');
        }
        .left {
            float:left;
        }
        .right {
            float:right;
        }
        .mybg {
        	background:url(../images/register_background.jpg) no-repeat;
        	background-size:cover;
        }
    </style>
    
    <script type="text/javascript">
    	var usernameFlag = false;//用于标示用户名验证是否通过
    	//对输入的用户名进行校验
    	function checkUsername(){
			//获取用户名输入框中的值,并去除前后空格 
			var username = fm.username.value.trim();
			if (username != "") {
				/*
				 * ajax:
				 * 创建XMLHttpRequest对象 
				 * 配置xmlHttp对象      .open(请求方式,提交数据的地址,是否异步)
				 * 发送请求
				 * 回调函数--响应后台处理的信息 
				 */
				var xmlHttp = new XMLHttpRequest();
				xmlHttp.open("post", "../servlet/CheckServlet?username=" + username, true);
				xmlHttp.send(null);//问号传过值了，这里发个空的就行了
				xmlHttp.onreadystatechange=function(){
					//接收返回的数据
					var rs = xmlHttp.responseText;
					if (xmlHttp.readyState == 4) {//xmlHttp.readystate == 4时表示交互完成 
						if (xmlHttp.status == 200) {//xmlHttp.status == 200时表示交互成功
							/* alert(rs); */
							if (rs == "fail") {//用户名已存在 
								//让图标变为错号 
								document.getElementById("warning-username-image").style.background = "url(../images/ban.png)";
								//提示文字显示
								document.getElementById("warning-username-text").style.display = "inline";
								//修改提示文字
								document.getElementById("warning-username-text").innerHTML = "该用户已经被注册";
								//名字验证不通过 
								usernameFlag = false;
							} else {//用户名不存在，可以注册 
								//让图标变为对号 
								document.getElementById("warning-username-image").style.background = "url(../images/right.png)";
								//提示文字隐藏
								document.getElementById("warning-username-text").style.display = "none";
								//名字验证通过 
								usernameFlag = true;
							}
						}
					}
				}
			} else {//用户名为空，不通过 
				//让图标变为错号 
				document.getElementById("warning-username-image").style.background = "url(../images/ban.png)";
				//提示文字显示
				document.getElementById("warning-username-text").style.display = "inline";
				//修改提示文字
				document.getElementById("warning-username-text").innerHTML = "用户名不能为空";
				//名字验证不通过 
				usernameFlag = false;
			}
    	}
    	
    	//对输入的密码进行校验
    	var passwordFlag = false;
    	var password = "";
    	function checkPassword(){
			password = fm.password.value.trim();
			if (password != "") {
				document.getElementById("warning-password-image").style.background = "url(../images/right.png)";
				document.getElementById("warning-password-text").style.display = "none";
				passwordFlag = true;
			} else {
				document.getElementById("warning-password-image").style.background = "url(../images/ban.png)";
				document.getElementById("warning-password-text").style.display = "inline";
				passwordFlag = false;
			}
    	}
    	
    	//对第二次输入的密码进行比对 
    	var password2Flag = false;
    	function checkPassword2(){
			var password2 = fm.password2.value.trim();
			if (password2 != "") {
				if (password != password2) {
					document.getElementById("warning-password2-image").style.background = "url(../images/ban.png)";
					document.getElementById("warning-password2-text").style.display = "inline";
					document.getElementById("warning-password2-text").innerHTML = "两次密码输入不一致";
					password2Flag = false;
				} else {
					document.getElementById("warning-password2-image").style.background = "url(../images/right.png)";
					document.getElementById("warning-password2-text").style.display = "none";
					password2Flag = true;
				}
			} else {
				document.getElementById("warning-password2-image").style.background = "url(../images/ban.png)";
				document.getElementById("warning-password2-text").style.display = "inline";
				document.getElementById("warning-password2-text").innerHTML = "请再次确认密码";
				password2Flag = false;
			}
    	}
    	
    	//对输入的手机号进行校验
    	var mobileFlag = false;
    	function checkMobile(){
			var mobile = fm.mobile.value.trim();
			if (mobile != "") {
				/*
				 * 以/^开头，$/结束
				 * [3-9]表示为任意一个3-9的数字
				 * \d表示任意数字
				 * {9}表示前边的字符出现9次
				 */
				var reg = /^1[3-9]\d{9}$/;
				if (reg.test(mobile)) {//匹配mobile是否符合正则式
					document.getElementById("warning-mobile-image").style.background = "url(../images/right.png)";
					document.getElementById("warning-mobile-text").style.display = "none";
					mobileFlag = true;
				} else {
					document.getElementById("warning-mobile-image").style.background = "url(../images/ban.png)";
					document.getElementById("warning-mobile-text").style.display = "inline";
					document.getElementById("warning-mobile-text").innerHTML = "请输入正确的手机号码";
					mobileFlag = false;
				}
			} else {
				document.getElementById("warning-mobile-image").style.background = "url(../images/ban.png)";
				document.getElementById("warning-mobile-text").style.display = "inline";
				document.getElementById("warning-mobile-text").innerHTML = "手机号不能为空";
				mobileFlag = false;
			}
    	}
    
    	//对输入的邮箱进行校验
    	var mailboxFlag = false;
    	function checkMainbox(){
			var mailbox = fm.mailbox.value.trim();
			if (mailbox != "") {
				var reg = /^[A-Za-z\d]+([-_.][A-Za-z\d]+)*@([A-Za-z\d]+[-.])+[A-Za-z\d]{2,4}$/;
				if (reg.test(mailbox)) {//匹配mobile是否符合正则式
					document.getElementById("warning-mailbox-image").style.background = "url(../images/right.png)";
					document.getElementById("warning-mailbox-text").style.display = "none";
					mailboxFlag = true;
				} else {
					document.getElementById("warning-mailbox-image").style.background = "url(../images/ban.png)";
					document.getElementById("warning-mailbox-text").style.display = "inline";
					document.getElementById("warning-mailbox-text").innerHTML = "请输入合法的邮箱地址";
					mailboxFlag = false;
				}
			} else {
				document.getElementById("warning-mailbox-image").style.background = "url(../images/ban.png)";
				document.getElementById("warning-mailbox-text").style.display = "inline";
				document.getElementById("warning-mailbox-text").innerHTML = "邮箱地址不能为空";
				mailboxFlag = false;
			}
    	}
    	
    	//改变校验码
    	function changeImage() {
			var myImage = document.getElementById("code");
			now = new Date();
			myImage.src = "../servlet/ValidateCode?code=" + now;
		}
    	
    	var verifycodeFlag = false;
    	function checkVerify(){
    		var verifycode = fm.verifycode.value.trim();
    		if (verifycode != "") {//验证码不空
    			//ajax： 
    			//创建XMLHttpRequest对象
    			var xhr = new XMLHttpRequest();
    			//配置xhr
				xhr.open("post", "../servlet/CheckServlet?verifycode=" + verifycode, true);
    			//发送请求
				xhr.send(null);//问号传过值了，这里发个空的就行了
				//设置回调函数
				xhr.onreadystatechange=function(){
					//接收返回的数据
					var rs = xhr.responseText;
					//alert(xhr.readyState + "--" + xhr.status);
					if (xhr.readyState == 4 && xhr.status == 200) {//成功的交互完成了 
						//alert(rs);
						if (rs == "fail") {
							document.getElementById("warning-verifycode-image").style.background = "url(../images/ban.png)";
							document.getElementById("warning-verifycode-text").style.display = "inline";
							document.getElementById("warning-verifycode-text").innerHTML = "请输入正确的验证码";
							verifycodeFlag = false;
						} else {
							document.getElementById("warning-verifycode-image").style.background = "url(../images/right.png)";
							document.getElementById("warning-verifycode-text").style.display = "none";
							verifycodeFlag = true;
						}
					}
				}
			} else {
				document.getElementById("warning-verifycode-image").style.background = "url(../images/ban.png)";
				document.getElementById("warning-verifycode-text").style.display = "inline";
				document.getElementById("warning-verifycode-text").innerHTML = "验证码不能为空";
				verifycodeFlag = false;
			}
    	}
    	
    	//验证表单校验是否通过
    	function checkAll() {
			//获取我已阅读是否已选中
			if (!fm.confirm.checked) {
				alert("请阅读达内阅读协议！");
				return false;//终止后续操作的执行
			}
			
			if (!usernameFlag || !passwordFlag || !password2Flag || !mobileFlag || !mailboxFlag || !verifycodeFlag) {
				checkUsername();
				checkPassword();
				checkPassword2();
				checkMobile();
				checkMainbox();
				checkVerify();
				return false;
			}
			
			//提交表单
			fm.submit();
			return false;//确保只提交一遍
		}
    	
    </script>
    
</head>
<body class="mybg" onload="init()">
    <div id="login" style="margin-right:200px;">
        <div class="header">
            <div class="left">
                新用户注册
            </div>
            <div class="right">
                <a href="user_login.jsp">直接登录</a>
            </div>
        </div>
        <div class="content">
            <form name="fm" action="../servlet/RegisterServlet" method="post">
                <div class="bar">
                    <span>用 户 名</span>
                    <input type="text" name="username" onblur="checkUsername()">
                </div>
                <div class="warning">
                    <span id="warning-username">
                        <i class='icon icon-ban' id="warning-username-image"></i>
                        <span id="warning-username-text">用户名不能为空</span>
                    </span>
                </div>
                <div class="bar">
                    <span>设置密码</span>
                    <input type="password" name="password" onblur="checkPassword()">
                </div>
                <div class="warning">
                    <span id="warning-password">
                        <i class='icon icon-ban' id="warning-password-image"></i>
                        <span id="warning-password-text">密码不能为空</span>
                    </span>
                </div>
                <div class="bar">
                    <span>确认密码</span>
                    <input type="password" name="password2" onblur="checkPassword2()">
                </div>
                <div class="warning">
                    <span id="warning-password2">
                        <i class='icon icon-ban' id="warning-password2-image"></i>
                        <span id="warning-password2-text">请再次确认密码</span>
                    </span>
                </div>
                <div class="bar">
                    <span>手机号码</span>
                    <input type="text" name="mobile" onblur="checkMobile()">
                </div>
                <div class="warning">
                    <span id="warning-mobile">
                        <i class='icon icon-ban' id="warning-mobile-image"></i>
                        <span id="warning-mobile-text">手机号不能为空</span>
                    </span>
                </div>
                <div class="bar">
                    <span>邮箱地址</span>
                    <input type="text" name="mailbox" onblur="checkMainbox()">
                </div>
                <div class="warning">
                    <span id="warning-mailbox">
                        <i class='icon icon-ban' id="warning-mailbox-image"></i>
                        <span id="warning-mailbox-text">邮箱地址不能为空</span>
                    </span>
                </div>
                <div class="bar">
                    <span>验证码</span>
                    <input type="text" name="verifycode" class="verify" onblur="checkVerify()">
                    <div class="verify">
                        <img id="code" src="../servlet/ValidateCode" alt="">
                        <div class="text">
                            <a href="javascript:changeImage()">看不清,换一张!</a>
                        </div>
                    </div>
                </div>
                <div class="warning">
                    <span id="warning-verifycode">
                        <i class='icon icon-ban' id="warning-verifycode-image"></i>
                        <span id="warning-verifycode-text">验证码不能为空</span>
                    </span>
                </div>
                <div class="option">
                    <div class="left">
                        <input type="checkbox" name="confirm">
                        <span>我已阅读并同意<a href="#">《达内用户协议》</a></span>
                    </div>
                </div>
                <div class="btn">
                	<!-- 运行了这个方法就不再执行了 -->
                    <button onclick="return checkAll()">提交注册信息</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>