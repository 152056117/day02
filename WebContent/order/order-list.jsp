<%@page import="java.sql.ResultSet"%>
<%@page import="util.JDBCUtil"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>所有订单</title>
<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<!-- page style -->
<link rel="stylesheet" type="text/css" href="../css/content.css">
<style>
</style>
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
<!-- Google Font -->
<!-- <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic"> -->

<script type="text/javascript">

	function display(oid) {
		myform.action="../servlet/DisplayOrderServlet?oid=" + oid;
		//myform.action="order-detail.jsp";
		myform.submit();
	}
	
	function solve(oid){
		//form.action="order-process.jsp";
		myform.action="../servlet/SolveOrderServlet?oid=" + oid;
		myform.submit();
	}

</script>

</head>
<body class="hold-transition skin-blue sidebar-mini">
	<div id="up">
		<ul>
			<li><span><a href="../welcome.jsp">平台首页 </a>&gt; 订单管理
					&gt; 订单列表</span></li>
		</ul>
	</div>
	<!-- Main content -->
	<section class="content container-fluid">
		<form name="myform" method="post" class="box-body">
			<table id="my_order" class="table table-bordered table-striped">
				<thead>
					<tr>
						<th>订单编号</th>
						<th>订单状态</th>
						<th>创建时间</th>
						<th>订单总额</th>
						<th>可选操作</th>
					</tr>
				</thead>
				<tbody>
					<%
							int i = -1;
							String statu = request.getParameter("status");
							if (statu == null || statu.equals("")) {
								i = -1;
							} else {
								i = Integer.parseInt(statu);
							}
							Statement st = JDBCUtil.getStatement();
							String sql;
							if (i == -1) {
								sql = "select usersorder.*,o_status.o_name status,p_product.price from usersorder,o_status,p_product where usersorder.o_status=o_status.o_id and usersorder.p_id=p_product.p_id";
							} else {
								sql = "select usersorder.*,o_status.o_name status,p_product.price from usersorder,o_status,p_product where usersorder.o_status=o_status.o_id and usersorder.p_id=p_product.p_id and usersorder.o_status="
										+ i;
							}
							ResultSet rs = st.executeQuery(sql);
							while (rs.next()) {
								int oid = rs.getInt("o_id");
						%>
					<tr>
						<td><%=oid%> <input type="hidden" id="o_id" name="o_id"
							value="<%=oid%>" /></td>
						<td><span
							class="label 
									<%if (rs.getInt("o_status") == 1) {%>
										bg-yellow
									<%}%>
									<%if (rs.getInt("o_status") == 2) {%>
										bg-green
									<%}%>
									<%if (rs.getInt("o_status") == 3) {%>
										bg-blue
									<%}%>
									<%if (rs.getInt("o_status") == 4) {%>
										bg-gray
									<%}%>
									<%if (rs.getInt("o_status") == 999) {%>
										bg-red
									<%}%>
								"><%=rs.getString("status")%></span></td>
						<td><%=rs.getString("createtime")%></td>
						<td>￥<%=rs.getDouble("price") * rs.getInt("p_num")%></td>
						<td><input class="btn btn-info btn-xs" type="button"
							onclick="display(<%=oid%>)" value="查看" /> <input
							class="btn btn-success btn-xs" type="button"
							onclick="solve(<%=oid%>)" value="处理" /></td>
					</tr>
					<%
							}
						%>
				</tbody>
			</table>
		</form>
		<!-- /.box-body -->
	</section>
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
