<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>达内商城</title>
    <style>
        body{
            position:absolute;   /* 绝对定位 */
            top:0;
            bottom:0;
            left:0;
            right:0;
            color:#eee;
            font-family:黑体;
        }
        a {
            font-size:12px;
            color:#eee;
        }
        #login {
            width:300px;
            height:431px;
            position:absolute;
            top:0;
            bottom:0;
            left:0;
            right:0;
            margin:auto;
            background-color:rgba(0,0,0,0.6);
        }
        #login>div.header {
            padding:0 20px;                /*内边距上下0px　左右20px*/
            height:44px;                   /*高是44px*/
            border-bottom:1px solid white; /*边框的底部宽为1px，底部样式为solid，颜色为白色*/
        }
        #login>div.header .left{
            margin-top:13px;   /*外边距为13px*/
        }
        #login>div.header .right{
            margin-top:14px;
        }
        #login>div.content {
            width:262px;
            margin:38px auto 0;  /*外边距上38px 左右居中 下为0*/
        }
        #login>div.content .bar span {
            display:block;       /*以块级元素显示*/
            width:56px;
            height:42px;
            line-height:42px;    /*行内框高度为42px*/
            float:left;
            color:#aeaeae;
            background-color:#e8e8e8;
            text-align:center;  /*文本居中对齐*/
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
            height:44px;
            color:#c65149;
            line-height:44px;
        }
        #login>div.content div.option{
            padding-top:29px;
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
        #login>div.content button {
            width:100%;
            height:42px;
            background-color:rgba(44,117,153,0.5);
            outline:none;
            border:none;
            color:white;
            margin-top:75px;
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
        i.icon.icon-warning {
            background:url('../images/caution.png');
        }
        .left {
            float:left;
        }
        .right {
            float:right;
        }
        .mybg {
        	background:url(../images/login_background.jpg) no-repeat;
        	background-size:cover;
        }
    </style>
    
    <script type="text/javascript">
    
    	function submit1(){
    		//alert(222);
    		fm.submit();
    	}
    	
    	function init(){//校验，如果验证错误
    		if ('<%= //此处写一些java代码获取flag判定此标签是否显示
                request.getParameter("flag")%>' == "fail") {
				//显示提示错误信息
				document.getElementById("all-warning").style.display = "inline";
			}
    	}
    
    </script>
</head>
<%
	//第十二天：获取Cookie信息
	Cookie[] cookies = request.getCookies();
	//如果cookies不为空，则判断是否已经存储过Cookies
	if(cookies != null){
		String username = null;
		String password = null;
		//查看cookies中是否已存储用户名与密码
		for(Cookie c : cookies){
			if("username".equals(c.getName())){
				username = c.getValue();
			}
			if("password".equals(c.getName())){
				password = c.getValue();
			}
		}
		System.out.println("打桩儿-Cookies：");
		System.out.println("用户名：" + username);
		System.out.println("密码：" + password);
		//若用户名和密码都被取到，则直接登录
		if(username != null && password != null){
			request.getRequestDispatcher("../servlet/LoginServlet?username=" + username + "&password=" + password).forward(request, response);
			//response.sendRedirect("../servlet/LoginServlet?username=" + username + "&password=" + password);
		}
	}
%>
<body class="mybg" onload="init()">
    <div id="login" style="margin-right:200px;">
        <div class="header">
            <div class="left">
                登陆达内商城
            </div>
            <div class="right">
                <a href="user_register.jsp">新用户注册</a>
            </div>
        </div>
        <div class="content">
            <form name="fm" action="../servlet/LoginServlet" method="post">
                <div class="bar">
                    <span>用 户 名</span>
                    <input type="text" name="username">
                </div>
                <div class="warning">
                    <span style="display: none" id="all-warning">
                        <i class='icon icon-warning'></i>
                        账号跟用户名不匹配请重新输入
                    </span>
                </div>
                <div class="bar">
                    <span>设置密码</span>
                    <input type="password" name="password">
                </div>
                <div class="option">
                    <div class="left">
                        <input type="checkbox" name="remember" value="0"><span>记住密码</span>
                    </div>
                    <div class="right">
                        <a href="#">忘记密码</a>
                    </div>
                </div>
                <div class="btn">
                    <button onclick="submit1()">登&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;录</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>