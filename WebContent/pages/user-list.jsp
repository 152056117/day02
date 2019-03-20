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
.mybtn {
	width: 6%;
	margin: 0 10px;
}
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
	function TableMouseOver(Obj) {
		Obj.style.backgroundColor = '#AAFFFF';
	}

	function TableMouseOut(Obj) {
		Obj.style.backgroundColor = '';
	}

	function beginSubmit(type) {
		switch (type) {
		case 1://显示
			theForm.action = "";
			if (checkRadio("显示")) {
				theForm.action = "../pages/user_display_detail.jsp";
				theForm.submit();
			}
			break;
		case 2://增加
			theForm.action = "../pages/user_add.jsp";
			theForm.submit();
			break;
		case 3://修改
			theForm.action = "";
			if (checkRadio("修改")) {
				theForm.action = "../pages/user_modify.jsp";
				theForm.submit();
			}
			break;
		case 4://删除
			theForm.action = "";
			if (checkRadio("删除")) {
				theForm.action = "../servlet/DeleteServlet";
				theForm.submit();
			}
			break;
		default:
			break;
		}
	}

	function checkRadio(str) {
		var flag = false;//判定是否有选中用户

		var sel = document.getElementsByName("select_cust_id");

		//判断单选按钮是否有被选中的
		for (i = 0; i < sel.length; i++) {
			if (sel[i].checked == true) {
				flag = true;
				break;
			}
		}
		if (!flag) {
			alert("请选择要" + str + "的用户");
			return false;
		}
		return true;
	}
</script>

</head>
<body class="hold-transition skin-blue sidebar-mini">
	<div id="up">
		<ul>
			<li><span><a href="../welcome.jsp">平台首页 </a>&gt; 用户管理
					&gt; 用户列表</span></li>
		</ul>
	</div>
	<!-- Main content -->
	<section class="content container-fluid">
		<form name="theForm" method="post" class="box-body">
			<table id="my_order" class="table table-bordered table-striped">
				<thead>
					<tr>
						<th></th>
						<th>用户ID</th>
						<th>用户姓名</th>
						<th>用户密码</th>
						<th>用户手机</th>
						<th>用户邮箱</th>
					</tr>
				</thead>
				<tbody>
					<%
							Statement st = JDBCUtil.getStatement();
							ResultSet rs = null;
							//第十一天：实现分页逻辑 
							int pageSize = 4;//每页显示几个用户 
							int pageNow = 1;//当前为第几页，默认起始值为1 
							int rowCount = 0;//一共有多少条数据，值从数据库中查出 
							int pageCount = 0;//一共有多少页 ,值通过rowCount和pageSize计算得出 

							//第十一天下午-user_list_main--接收查询条件
							String whereSQL = request.getParameter("whereSQL");
							String sqlQuery = "";

							//查询rowCount
							String sql1 = "select count(1) from user";//第十一天
							if (whereSQL != null && !whereSQL.equals("") && !whereSQL.equals("null")) {
								sql1 += whereSQL;
							}
							rs = st.executeQuery(sql1);
							if (rs.next()) {
								rowCount = rs.getInt(1);
							}

							//计算pageCount
							pageCount = (rowCount % pageSize == 0) ? rowCount / pageSize : rowCount / pageSize + 1;
							//接收页增量
							String s_pageNow = request.getParameter("pageno");
							if (s_pageNow != null) {
								pageNow = Integer.parseInt(s_pageNow);
							}

							//第十天： 查询user表中的所有数据
							//Statement st = JDBCUtil.getStatement();
							//String sqlQuery = "select * from user";//第十天
							//String sqlQuery = "select * from user limit " + (pageNow - 1) * pageSize + "," + pageSize;//第十一天上午
							if (whereSQL != null && !whereSQL.equals("") && !whereSQL.equals("null")) {
								sqlQuery += "select * from user " + whereSQL + " limit " + (pageNow - 1) * pageSize + "," + pageSize;
							} else {
								sqlQuery = "select * from user limit " + (pageNow - 1) * pageSize + "," + pageSize;
							}
							rs = st.executeQuery(sqlQuery);

							while (rs.next()) {//利用java代码实现循环产生标签
						%>

					<tr class="TableRowEven" onmouseover="TableMouseOver(this)"
						onmouseout="TableMouseOut(this)">
						<td align=right><input type="radio" name="select_cust_id"
							value="<%=rs.getInt("id")%>"></td>
						<td align=left><a
							href="cust_info_frame_qur.jsp?usernbr=sd000019&usertype=2&fromPage=1"><%=rs.getInt("id")%></a></td>
						<td align=left><%=rs.getString("username")%></td>
						<td align=left><%=rs.getString("password")%></td>
						<td align=left><%=rs.getString("mobile")%></td>
						<td align=left><%=rs.getString("mailbox")%></td>
					</tr>

					<%
							}
						%>

					<tr class="TableRowEven">
						<td height="19" colspan="6" align="center" valign="top">共<%=rowCount%>条&nbsp;
							第<%=pageNow%>/<%=pageCount%>页&nbsp; <a id="pageFirst"
							href="../pages/user-list.jsp?pageno=1&whereSQL=<%=whereSQL%>">首页&nbsp;</a>
							<a id="pagePre"
							href="../pages/user-list.jsp?pageno=<%=pageNow - 1%>&whereSQL=<%=whereSQL%>">上页&nbsp;</a>
							<a id="pageNext"
							href="../pages/user-list.jsp?pageno=<%=pageNow + 1%>&whereSQL=<%=whereSQL%>">下页&nbsp;</a>
							<a id="pageLast"
							href="../pages/user-list.jsp?pageno=<%=pageCount%>&whereSQL=<%=whereSQL%>">尾页&nbsp;</a>
							<a href="javascript:zhuandao()">转到</a> <input type="text"
							name="pageno" value="<%=pageNow%>" size="3" class="SubmitStyle"
							onblur="pageno()"> <%-- <input type="hidden" name="whereSQL" value="<%=whereSQL%>"> 方法一。方法二在下边 --%>
						</td>
					</tr>
					<tr class="TableRowEven">
						<td align="right" colspan="6" valign="top" height="19"><input
							type="submit" value="显 示" class="btn btn-info btn-sm mybtn"
							onClick="beginSubmit(1)"> <!-- <input type="submit" name="Submit422" value="增 加" class="btn btn-primary btn-sm mybtn" onClick="beginSubmit(2)"> -->
							<input type="submit" value="修 改"
							class="btn btn-primary btn-sm mybtn" onClick="beginSubmit(3)">
							<input type="submit" value="删 除"
							class="btn btn-danger btn-sm mybtn" onClick="beginSubmit(4)">
						</td>
					</tr>
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
		$(function() {
			$('#my_order').DataTable({
				'paging' : true,
				'lengthChange' : false,
				'searching' : false,
				'ordering' : false,
				'info' : true,
				'autoWidth' : false,
				'pagingType' : 'full_numbers'
			})
		})
	</script>
</body>
<% if(pageNow <= 1){ // 此时为首页 ,设置首页和上页不可点击  %>
<script type="text/javascript">
		document.getElementById("pageFirst").removeAttribute("href");
		document.getElementById("pagePre").removeAttribute("href");
	</script>
<% } %>
<% if(pageNow >= pageCount){ // 此时为尾页 ,设置尾页和下页不可点击  %>
<script type="text/javascript">
		document.getElementById("pageNext").removeAttribute("href");
		document.getElementById("pageLast").removeAttribute("href");
	</script>
<% } %>
<script type="text/javascript">
	function zhuandao(){//先行校验是否为页码
		var pageNo = document.getElementsByName("pageno")[0].value;//getElementsByName可以得到多个对象
		//输入的值不在范围内或者不为数字，都不允许通过,isNaN:is not a number?
		if (pageNo <= 0 || pageNo > <%=pageCount %> || isNaN(pageNo)) {
			alert("请输入正确的页码");
			document.getElementsByName("pageno")[0].value = <%=pageNow %>;
			return;
		}
		
		theForm.action = "../pages/user-list.jsp?whereSQL=<%=whereSQL %>";//方法二
		theForm.submit();
	}
</script>
</html>
