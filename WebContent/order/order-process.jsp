<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>订单处理</title>
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

.my_radio {
	display: inline-block !important;
}

.my_formgroup {
	display: inline-block !important;
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
					&gt; 订单处理</span></li>
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
				<b class="my_itemtitle">#${o_id }</b><br> <br> <b>创建时间：</b>
				${o_createtime }<br> <b>订单总额：</b>￥${o_totalprice }<br> <b>订单状态：</b>
				<!-- radio -->
				<div class="form-group my_formgroup">
					<form name="form" action="../servlet/UpdateOrderServlet"
						method="post">
						<div class="radio my_radio">
							<label> <input type="radio" name="optionsRadios"
								id="optionsRadios1" value="1"
								<%	int sta = Integer.parseInt((String)request.getAttribute("o_status"));
									if(sta == 1) { %>
								checked <% 	} else { %> disabled <% 	} %>>待处理
							</label>
						</div>
						<div class="radio my_radio">
							<label> <input type="radio" name="optionsRadios"
								id="optionsRadios2" value="2" <%  if(sta == 2) { %> checked
								<% 	} else if(sta != 1) { %> disabled <% 	} %>>处理中
							</label>
						</div>
						<div class="radio my_radio">
							<label> <input type="radio" name="optionsRadios"
								id="optionsRadios3" value="3" <%  if(sta == 3) { %> checked
								<% 	} else if(sta != 2) { %> disabled <% 	} %>>已发货
							</label>
						</div>
						<div class="radio my_radio">
							<label> <input type="radio" name="optionsRadios"
								id="optionsRadios4" value="4" <%  if(sta == 4) { %> checked
								<% 	} else if(sta != 3) { %> disabled <% 	} %>>已交付
							</label>
						</div>
						<%  if(sta == 999) { %>
						<div class="radio my_radio">
							<label> <input type="radio" name="optionsRadios"
								id="optionsRadios4" value="4" checked>已销毁
							</label>
						</div>
						<% 	} %>
						<div class="radio my_radio">
							&nbsp;&nbsp;&nbsp; <input type="hidden" name="o_id"
								value="<%=request.getAttribute("o_id") %>" /> <input
								type="hidden" name="old-status" value="<%=sta %>" />
							<%  if(sta != 999 && sta != 4) { %>
							<input type="submit" class="btn btn-default btn-xs" value="保存" />
							<% 	} %>
						</div>
					</form>
				</div>
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
	</section>
	<!-- /.content -->
	<div class="clearfix"></div>

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
