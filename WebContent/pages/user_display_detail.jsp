<%@page import="util.JDBCUtil"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>达内商城客户基本信息</title>
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
<style type="text/css">
.pm{
	height: 20px;
}
.mya{
	text-decoration:none;
	color: white;
}
.mybtn{
	width: 6%;
	margin: 0 10px;
}
</style>
<script type="text/javascript">
function check(){
	form1.submit();
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
			<li>
				<span>
					<a href="../welcome.jsp">平台首页 </a>&gt; 用户管理&gt; 客户详情
				</span>
			</li>
		</ul>
	</div>
	<!-- <div class="row">
		<div class="col-xs-12">
			<h2 class="page-header">
				<i class="fa"></i> 客户详情 <small class="pull-right">日期: <script>setInterval("clock.innerHTML=new Date().toLocaleString() + '&nbsp;&nbsp;' + ''.charAt(new Date().getDay());",1000);</script>
					<span id="clock" style="font-size: 12px; font-family: arial;"></span></small>
			</h2>
		</div>
		/.col
	</div> -->
	<div class="pm"></div>
	<div class="row" align="center">
		<div class="col-sm-2"></div>
		<form name="form1" method="post" action="../pages/user-list.jsp"
			class="form-horizontal col-sm-10">
			<%
			    String id = request.getParameter("select_cust_id");
			    String sql ="select * from user where id = "+id;
			    Statement st = JDBCUtil.getStatement();
			    ResultSet rs = st.executeQuery(sql);
			    while(rs.next()){
			    	
			        	String str = null;
			        
			        	int i  =rs.getInt("sex");
			            if(i==0)
			            	str = "未填写";
			            else if(i==1){
			          	 str = " 男";
			            }else{
			          	 str = " 女";
			           }
		    %>
			<div class="form-group">
				<label class="col-sm-2 control-label">用户编号</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" name="id"
						value="<%=rs.getInt("id") %>" readonly="readonly">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">用户姓名</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" name="name"
						value="<%=rs.getString("username") %>" readonly="readonly">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">用户密码</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" name="dayOver"
						value="<%=rs.getString("password") %>" readonly="readonly">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">用户手机</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" name="dayLate"
						value="<%=rs.getString("mobile") %>" readonly="readonly">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">用户邮箱</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" name="dayLeave"
						value=" <%=rs.getString("mailbox") %>" readonly="readonly">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">用户性别</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" name="dayAbsent"
						value="<%=str %>" readonly="readonly">
				</div>
			</div>
			<div class="form-group">
				<div align="center">
					<input type="button" name="Submit" value="确 定" onclick="check()" class="btn btn-default btn-sm mybtn">
				</div>
			</div>
			<% } %>
		</form>
	</div>
</body>
</html>
