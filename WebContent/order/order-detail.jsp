<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>订单详情</title>
<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<!-- page style-->
<link rel="stylesheet" type="text/css" href="../css/content.css">
<style>
.my_itemtitle {
	font-size: 20px;
}

.my_info {
	width: 50% !important;
}

.my_print {
	text-align: right;
}

#up a:VISITED, #up a:LINK {
	color: #4C8FBD;
	text-decoration: none;
}

#up a:HOVER {
	color: #4C8FBD;
	text-decoration: none;
}
</style>
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
<!-- Google Font -->
<!-- <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic"> -->
</head>
<body class="hold-transition skin-blue sidebar-mini">

	<div id="up">
		<ul>
			<li><span><a href="../welcome.jsp">平台首页 </a>&gt; 订单管理
					&gt; 订单详情</span></li>
		</ul>
	</div>
	<!-- Main content -->
	<section class="invoice">
		<!-- title row -->
		<div class="row">
			<div class="col-xs-12">
				<h2 class="page-header">
					<i class="fa"></i>订单详情 <small class="pull-right">当前日期:
						${nowtime }</small>
				</h2>
			</div>
			<!-- /.col -->
		</div>
		<!-- info row -->
		<div class="row invoice-info">
			<div class="col-sm-4 invoice-col my_info">
				<b class="my_itemtitle">收件人</b><br> <br> <b>姓名：</b>${u_name }<br>
				<b>地址：</b>${u_address }<br> <b>电话：</b>${u_mobile }<br>
			</div>
			<!-- /.col -->
			<div class="col-sm-4 invoice-col my_info">
				<b class="my_itemtitle">#${o_id }</b>
				<br><br>
				<b>创建时间：</b>${o_createtime }
				<%if(request.getAttribute("o_destorytime") != null) { %>
				<br>
				<b>完成时间：</b>${o_destorytime }
				<% } %>
				<br>
				<b>订单总额：</b>￥${o_totalprice }
				<br>
				<b>订单状态：</b>${status }
			</div>
			<!-- /.col -->
		</div>
		<hr>
		<!-- /.row -->
		<!-- Table row -->
		<div class="row">
			<div class="col-xs-12 table-responsive">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>数量</th>
							<th>名称</th>
							<th>商品编号</th>
							<th>商品描述</th>
							<th>单价</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>${o_num }</td>
							<td>${p_name }</td>
							<td>${p_id }</td>
							<td>${p_disc }</td>
							<td>￥${p_price }</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- /.col -->
		</div>
		<!-- /.row -->
		<hr>
		<!-- this row will not appear when printing -->
		<!-- <div class="row no-print">
			<div class="col-xs-12 my_print">
				<a href="order-print.jsp" target="_blank" class="btn btn-default"><i
					class="fa fa-print"></i> Print</a>
			</div>
		</div> -->
	</section>
	<!-- /.content -->

	<!-- jQuery 3 -->
	<script src="../js/jquery/jquery.min.js"></script>
	<!-- Bootstrap 3.3.7 -->
	<script src="../js/bootstrap/bootstrap.min.js"></script>
	<!-- DataTables -->
	<script src="../js/datatables.net/jquery.dataTables.min.js"></script>
	<script src="../js/datatables.net-bs/dataTables.bootstrap.min.js"></script>
	<!-- FastClick -->
	<script src="../js/fastclick/fastclick.js"></script>
	<!-- AdminLTE App -->
	<script src="../js/AdminLTE/adminlte.min.js"></script>
	<!-- page script -->
	<script>
		
	</script>
</body>
</html>
