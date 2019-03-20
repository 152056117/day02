<%@page import="java.util.Random"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="util.JDBCUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN">
<html>
<head>
<title>add.jsp</title>

<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="this is my page">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">

<!--<link rel="stylesheet" type="text/css" href="./styles.css">-->
<link rel="stylesheet" type="text/css" href="../css/content.css">
<link rel="stylesheet" href="../css/bootstrap.min.css">
<style type="text/css">
#down table {
	position: relative;
	left: 50%;
	margin-left: -250px;
	top: 50px;
}

#down tr {
	height: 40px;
}

.in {
	height: 30px;
	width: 360px;
}

.su {
	height: 30px;
	width: 80px;
	background: #438EB9;
	border-radius: 5px;
	margin-left: 30px;
}

#up a:VISITED, #up a:LINK {
	color: #4C8FBD;
	text-decoration: none;
}

#up a:HOVER {
	color: #4C8FBD;
	text-decoration: none;
}
.mybtn {
	width: 6%;
	margin: 10px;
}
</style>
</head>
<body>
	<div id="up">
		<ul>
			<li><span><a href="../welcome.jsp">平台首页 </a>&gt; 商品管理
					&gt; 商品添加</span></li>
		</ul>
	</div>
	<div style="margin: 20px">
		<div class="col-sm-2"></div>
		<div class="row col-sm-10" style="margin: 0px auto;">
			<form action="../servlet/AddProductServlet" method="post"
				enctype="multipart/form-data" class="form-horizontal">
				<% Random rand = new Random(); %>
				<input type="hidden" class="form-control" name="tatal" value="<%=rand.nextInt(200) %>" >
				<div class="form-group">
					<label class="col-sm-2 control-label">商品名称</label>
					<div class="col-sm-6">
						<input type="text" class="form-control" name="name" >
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">商品价格</label>
					<div class="col-sm-6">
						<input type="text" class="form-control" name="price" >
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">入库商品</label>
					<div class="col-sm-6">
						<input type="text" class="form-control" name="num" >
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">商品描述 </label>
					<div class="col-sm-6">
						<input type="text" class="form-control" name="disc" >
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">商品折扣 </label>
					<div class="col-sm-6">
						<input type="text" class="form-control" name="discount" >
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">商品图片 </label>
					<div class="col-sm-6">
						<input type="file" name="_img" class="in">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">商品类别</label>
					<div class="col-sm-6">
						<select name="cid" class="in">
							<option value="1">--请选择类别--</option>
							<%
	   							//创建执行sql的对象
	   							Statement st = JDBCUtil.getStatement();
	   							String sql = "select * from p_type";
	   							//获取查询的结果集
	   							ResultSet rs = st.executeQuery(sql);
	   							while(rs.next()){
	   								if(rs.getInt("t_id") != 1){
	   						%>
							<option value="<%=rs.getInt("t_id") %>"><%=rs.getString("t_name") %></option>
							<% }} %>
						</select>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 text-center">
						<input type="submit" value="提交" class="mybtn btn btn-primary">
						<input type="reset" value="重置" class="mybtn btn btn-default">
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>

<%-- <form action="../servlet/AddProductServlet" method="post"
	enctype="multipart/form-data">
	<div id="down">
		<table width="500px">
			<tr>
				<td>商品名称</td>
				<td><input type="text" name="name" class="in" /></td>
			</tr>
			<tr>
				<td>商品价格</td>
				<td><input type="text" name="price" class="in" /></td>
			</tr>
			<tr>
				<td>入库商品</td>
				<td><input type="text" name="num" class="in" /></td>
			</tr>
			<tr>
				<td>商品描述</td>
				<td><textarea cols="49" rows="3" name="disc"></textarea></td>
			</tr>
			<tr>
				<td>商品折扣</td>
				<td><input type="text" name="discount" class="in" /></td>
			</tr>
			<tr>
				<td>商品图片</td>
				<td><input type="file" name="_img" class="in"></td>
			</tr>
			<tr>
				<td>商品类别</td>
				<td><select name="cid" class="in">
						<option value="999">--请选择类别--</option>
						<%
	   							//创建执行sql的对象
	   							Statement st = JDBCUtil.getStatement();
	   							String sql = "select * from p_type";
	   							//获取查询的结果集
	   							ResultSet rs = st.executeQuery(sql);
	   							while(rs.next()){
	   								if(rs.getInt("t_id") != 999){
	   						%>
						<option value="<%=rs.getInt("t_id") %>"><%=rs.getString("t_name") %></option>
						<% }} %>
				</select></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="提&nbsp;&nbsp;&nbsp;交"
					class="su">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
					type="reset" value="清&nbsp;&nbsp;&nbsp;空" class="su"></td>
			</tr>
		</table>
	</div>
</form> --%>
