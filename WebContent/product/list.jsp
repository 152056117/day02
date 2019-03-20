<%@page import="java.util.Random"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="util.JDBCUtil"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN">
<html>
<head>
<title>list.jsp</title>

<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="this is my page">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<!-- page style -->
<link rel="stylesheet" type="text/css" href="../css/content.css">
<link rel="stylesheet" href="../css/bootstrap.min.css">
<!-- Bootstrap 3.3.7 -->
<link rel="stylesheet" href="../css/bootstrap/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="../css/font-awesome/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet" href="../css/Ionicons/ionicons.min.css">
<!-- DataTables -->
<link rel="stylesheet"
	href="../css/datatables.net-bs/dataTables.bootstrap.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="../css/AdminLTE/AdminLTE.min.css">
<!-- AdminLTE Skin -->
<link rel="stylesheet" href="../css/AdminLTE/skin/skin-blue.min.css">
<style type="text/css">
/* #down table {
	position: relative;
	left: 50%;
	margin-left: -450px;
	top: 50px;
	border-top: 1px #999 solid;
	border-right: 1px #999 solid;
}

#down tr {
	height: 60px;
}

#down tr td {
	text-align: center;
	border-left: 1px #999 solid;
	border-bottom: 1px #999 solid;
}

#up a:VISITED, #up a:LINK {
	color: #4C8FBD;
	text-decoration: none;
}

#up a:HOVER {
	color: #4C8FBD;
	text-decoration: none;
}

.head {
	background: #438EB9;
	color: #fff;
}

.odd {
	background: #e5e5e5;
}

.even {
	background: #d5d5d5;
} */
.table tbody tr td{
	vertical-align: middle;
	height: 55px;
}
.table thead tr th{
	text-align: center;
}
.table .myimg{
	text-align: center;
}
.mya{
	text-decoration: none;
}
</style>
</head>

<body>
	<div id="up">
		<ul>
			<li><span><a href="../welcome.jsp">平台首页 </a>&gt; 商品管理
					&gt; 商品列表</span></li>
		</ul>
	</div>
	<form name="myform" method="post" class="box-body" style="margin: 10px">
		<table id="my_order" class="table table-bordered table-striped">
			<thead>
				<tr class="head">
					<th>序号</th>
					<th>商品名称</th>
					<th>商品价格</th>
					<th>商品库存</th>
					<th>商品销量</th>
					<th>商品描述</th>
					<th>商品折扣</th>
					<th>商品图片</th>
					<th>商品状态</th>
					<th>商品类别</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<%
					Statement st = JDBCUtil.getStatement();
					//String sql = "select * from p_product";//下边换用多表查询直接查出商品类型
					String sql = "select p_product.*,p_type.t_name tname from p_product,p_type where p_product.t_id=p_type.t_id";
					ResultSet rs = st.executeQuery(sql);
					Random rand = new Random();
					while (rs.next()) {
				%>
				<tr class="odd">
					<td class="myimg"><%=rs.getInt("p_id")%></td>
					<td><%=rs.getString("p_name")%></td>
					<td class="myimg"><%=rs.getDouble("price")%></td>
					<td class="myimg"><%=rs.getInt("num")%></td>
					<td class="myimg"><%=rs.getInt("total")%></td>
					<td><%=rs.getString("disc")%></td>
					<td class="myimg"><%=rs.getDouble("discount")%></td>
					<%-- <td><img src="D:\<%=rs.getString("img") %>" height="55"/></td> --%>
					<td class="myimg"><img src="/upload/<%=rs.getString("img")%>" height="55" /></td>
					<!-- <td><img src="../imgage/17.webp.jpg" height="55"/></td> -->
					<td class="myimg"><%=rs.getInt("status")%></td>
					<td><%=rs.getString("tname")%></td>
					<%-- <%
	    			Statement st2 = JDBCUtil.getStatement();
		    		String sql2 = "select * from p_type where t_id=" + rs.getInt("t_id");
		    		ResultSet rs2 = st2.executeQuery(sql2);
		    		if(rs2.next()) {
	    		%>
	    		<td><%=rs2.getString("t_name") %></td>
	    		<% } JDBCUtil.closeAll(rs2, st2, null); %> --%>
					<td class="myimg"><a class="btn btn-info btn-xs mya"
						href="../product/updateproject.jsp?m_id=<%=rs.getInt("p_id")%>">修改</a>&nbsp;
						<a class="btn btn-info btn-xs mya"
						href="../product/changeimg.jsp?mid=<%=rs.getInt("p_id")%>">修改图片</a>&nbsp;
						<a class="btn btn-danger btn-xs"
						href="../servlet/DeleteProductServlet?did=<%=rs.getInt("p_id")%>">删除</a>
					</td>
				</tr>
				<%
					}
					JDBCUtil.closeAll(rs, st, null);
				%>
			</tbody>
		</table>
	</form>
	<!-- /.content -->
	<!-- jQuery 3 -->
	<script src="../js/jquery/jquery.min.js"></script>
	<!-- Bootstrap 3.3.7 -->
	<script src="../js/bootstrap/bootstrap.min.js"></script>
	<!-- DataTables -->
	<script src="../js/datatables.net/jquery.dataTables.min.js"></script>
	<script src="../js/datatables.net-bs/dataTables.bootstrap.min.js"></script>
	<!-- AdminLTE App -->
	<script src="../js/AdminLTE/adminlte.min.js"></script>
	<!-- moment -->
	<!-- <script src="../js/moment/moment.min.js"></script> -->
	<!-- page script -->
	<script>
 $(function () {
   $('#my_order').DataTable({
     'paging'      : true,
     'lengthChange': false,
     'searching'   : false,
     'ordering'    : false,
     'info'        : true,
     'autoWidth'   : false,
     'pagingType': 'full_numbers'
   })
 })
</script>
</body>
</html>
<%-- <div id="down">
	<table width="900px" cellpadding="0" cellspacing="0">
		<tr class="head">
			<td>序号</td>
			<td>商品名称</td>
			<td>商品价格</td>
			<td>商品库存</td>
			<td>商品销量</td>
			<td>商品描述</td>
			<td>商品折扣</td>
			<td>商品图片</td>
			<td>商品状态</td>
			<td>商品类别</td>
			<td>操作</td>
		</tr>
		<% 
	    		Statement st = JDBCUtil.getStatement();
	    		//String sql = "select * from p_product";//下边换用多表查询直接查出商品类型
	    		String sql = "select p_product.*,p_type.t_name tname from p_product,p_type where p_product.t_id=p_type.t_id";
	    		ResultSet rs = st.executeQuery(sql);
	    		while(rs.next()) {
	    			System.out.println(rs.getString("img"));
	    	%>
		<tr class="odd">
			<td><%=rs.getInt("p_id") %></td>
			<td><%=rs.getString("p_name") %></td>
			<td><%=rs.getDouble("price") %></td>
			<td><%=rs.getInt("num") %></td>
			<td>0</td>
			<td><%=rs.getString("disc") %></td>
			<td><%=rs.getDouble("discount") %></td>
			<td><img src="D:\<%=rs.getString("img") %>" height="55"/></td>
			<td><img src="/upload/<%=rs.getString("img") %>" height="55" /></td>
			<!-- <td><img src="../imgage/17.webp.jpg" height="55"/></td> -->
			<td><%=rs.getInt("status") %></td>
			<td><%=rs.getString("tname") %></td>
			<%
	    			Statement st2 = JDBCUtil.getStatement();
		    		String sql2 = "select * from p_type where t_id=" + rs.getInt("t_id");
		    		ResultSet rs2 = st2.executeQuery(sql2);
		    		if(rs2.next()) {
	    		%>
	    		<td><%=rs2.getString("t_name") %></td>
	    		<% } JDBCUtil.closeAll(rs2, st2, null); %>
			<td><a
				href="../product/updateproject.jsp?m_id=<%=rs.getInt("p_id") %>">修改</a>&nbsp;
				<a
				href="../servlet/DeleteProductServlet?did=<%=rs.getInt("p_id") %>">删除</a>&nbsp;
				<a href="../product/changeimg.jsp?mid=<%=rs.getInt("p_id") %>">修改图片</a>
			</td>
		</tr>
		<% } JDBCUtil.closeAll(rs, st, null); %>
	</table>
</div> --%>
