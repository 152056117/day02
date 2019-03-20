<%@page import="java.sql.ResultSet"%>
<%@page import="util.JDBCUtil"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
<meta name="viewport" content="width=device-width,initial-scale=1">
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../css/content.css">
<script src="../js/jquery.js" type="text/javascript"></script>
<style type="text/css">
.pm {
	height: 20px;
}
.mybtn {
	width: 6%;
	margin: 0 10px;
}
</style>
<script type="text/javascript">
	function doupdate() {
		form1.submit();
	}
</script>
<link rel="stylesheet" type="text/css" href="../css/content.css">
</head>
<body bgcolor=#ECF7E6 onload="init()">
	<div id="up">
		<ul>
			<li><span><a href="../welcome.jsp">平台首页 </a>&gt; 用户管理
					&gt; 用户修改</span></li>
		</ul>
	</div>
	<div align="center">
		<div class="col-sm-2"></div>
		<form name="form1" method="post" action="../servlet/UpdateServlet"
			class="form-horizontal col-sm-10">
			<div class="pm"></div>
			<%
				String id = request.getParameter("select_cust_id");
				String sql = "select * from user where id = " + id;
				Statement st = JDBCUtil.getStatement();
				ResultSet rs = st.executeQuery(sql);

				if (rs.next()) {
			%>
			<input type="hidden" name="id"
				value="<%=request.getParameter("select_cust_id")%>">
			<div class="form-group">
				<label class="col-sm-2 control-label">用户姓名</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" name="username"
						readonly="readonly"
						value="<%=rs.getString("username")%>">
					<span id="warning-all"> </span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">用户密码</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" name="password"
						onblur="checkPassword()" value="<%=rs.getString("password")%>">
					<span id="warning-all"> <span id="warning-password-text"
						style="color: red"></span>
					</span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">手机号 </label>
				<div class="col-sm-6">
					<input type="text" class="form-control" name="mobile"
						onblur="checkMobile()" value="<%=rs.getString("mobile")%>">
					<span id="warning-all"> <span id="warning-mobile-text"
						style="color: red"></span>
					</span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">邮箱 </label>
				<div class="col-sm-6">
					<input type="text" class="form-control" name="mailbox"
						onblur="checkMailbox()" value="<%=rs.getString("mailbox")%>">
					<span id="warning-all"> <span id="warning-mailbox-text"
						style="color: red"></span>
					</span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">性别</label>
				<div class="col-sm-6">
					<select name="sex" class="form-control in">
						<option value="0"
							<%if ((rs.getInt("sex") + "") != null && rs.getInt("sex") == 0) {%>
							selected <%}%>>请选择</option>
						<option value="1"
							<%if ((rs.getInt("sex") + "") != null && rs.getInt("sex") == 1) {%>
							selected <%}%>>男</option>
						<option value="2"
							<%if ((rs.getInt("sex") + "") != null && rs.getInt("sex") == 2) {%>
							selected <%}%>>女</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 text-center">
					<input type="submit" value="确认"
						class="btn btn-primary mybtn" onclick="doupdate()" name="Submit">
					<input type="reset" value="重置" class="btn btn-info mybtn" name="Submit2">
				</div>
			</div>
			<!-- <tr>return checkAll()
				<td height="14" colspan="4" align="right" class="TableAttrName">
					<input type="button" name="Submit" value="确 定"
					onclick="doupdate()"> <input type="reset" name="Submit2"
					value="重 置">
				</td>
			</tr> -->
			<%
				}
			%>
			<p>&nbsp;</p>
		</form>
		<p>&nbsp;</p>
	</div>
</body>
</html>

<%-- <table bordercolor=#cfe3fe cellspacing=1 bordercolordark=#ffffff
	width="90%" bgcolor=#656565 bordercolorlight=#008000 border=0>
	<tbody>
		<tr class="TableTitle">
			<td height=22 colspan="4" class="TableName"
				background="images/bar.jpg">请录入用户基本信息 <input type="hidden"
				name="id" value="<%=request.getParameter("select_cust_id")%>">
			</td>
		</tr>
		<tr>
			<td class="TableAttrName">用户姓名：</td>
			<td class="TableAttrValue"><input type="text" name="username"
				readonly="readonly" value="<%=rs.getString("username")%>"> <span
				style="color: red">*不可修改</span></td>
			<td class="TableAttrName">用户密码：</td>
			<td class="TableAttrValue"><input type="text" name="password"
				value="<%=rs.getString("password")%>"></td>
		</tr>
		<tr>
			<td class="TableAttrName">用户手机：</td>
			<td class="TableAttrValue"><input type="text" name="mobile"
				value="<%=rs.getString("mobile")%>"></td>
			<td class="TableAttrName">用户邮箱：</td>
			<td class="TableAttrValue"><input type="text" name="mailbox"
				value="<%=rs.getString("mailbox")%>"></td>
		</tr>
		<tr>
			<td class="TableAttrName">用户性别：</td>
			<td class="TableAttrValue" colspan="3"><select name="sex">
					<% if(rs.getInt("sex") == 0) {%>
								<option value="0" selected="selected">未选择</option>
								<%} else {%>
								<option value="0">未选择</option>
								<%} if(rs.getInt("sex") == 1) {%>
								<option value="1" selected="selected">男</option>
								<%} else {%>
								<option value="1">男</option>
								<%} if(rs.getInt("sex") == 2) {%>
								<option value="2" selected="selected">女</option>
								<%} else {%>
								<option value="2">女</option>
								<%}%>
					<option value="0"
						<%if ((rs.getInt("sex") + "") != null && rs.getInt("sex") == 0) {%>
						selected <%}%>>未选择</option>
					<option value="1"
						<%if ((rs.getInt("sex") + "") != null && rs.getInt("sex") == 1) {%>
						selected <%}%>>男</option>
					<option value="2"
						<%if ((rs.getInt("sex") + "") != null && rs.getInt("sex") == 2) {%>
						selected <%}%>>女</option>
			</select></td>
		</tr>
		<tr>
			<td height="14" colspan="4" align="right" class="TableAttrName">
				<input type="button" name="Submit" value="确 定" onclick="doupdate()">
				<input type="reset" name="Submit2" value="重 置">
			</td>
		</tr>
	</tbody>
</table> --%>
