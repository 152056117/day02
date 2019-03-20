<%@page import="util.JDBCUtil"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>修改图片信息</title>
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
<link rel="stylesheet" type="text/css" href="../css/content.css">
<style type="text/css">
.mybtn{
	width: 100px;
	margin: 10px;
}
.table tr td{
	text-align: center;
}
</style>
<script type="text/javascript">
function previewFile() { // 通过标签选择器获取HTML元素 
	var preview = document.querySelector('img'); 
	var file = document.querySelector('input[type=file]').files[0]; // Js内置文件流 
	var reader = new FileReader(); // 更新img标签的src属性为图片的本地路径，就可以显示了
	reader.onloadend = function () { 
		preview.src = reader.result; 
		} // 图片文件不空就显示 
	if (file)
	{ reader.readAsDataURL(file); }
	else { // 图片文件是空的 
		preview.src = "";
	} 
}
 function sb1(){
	tz.action="../servlet/ChangeImgServlet?p_id=<%=request.getParameter("mid")%>";
	tz.submit();
}
function sb2() {
	tz.action = "../product/list.jsp";
	tz.submit();
}
</script>
</head>
<body>
	<div id="up">
		<ul>
			<li><span><a href="../welcome.jsp">平台首页 </a>&gt; 商品管理
					&gt; 商品图片修改</span></li>
		</ul>
	</div>
	<form name="tz" method="post" enctype="multipart/form-data">
		<div style="width: 400px; height: 200px; margin: auto">
			<table class=".table" style="margin: 20px auto;">
				<%
					Statement st = JDBCUtil.getStatement();
					String id = request.getParameter("mid");
					String sql = "select * from p_product	where p_id=" + id;
					System.out.println(sql);
					ResultSet rs = st.executeQuery(sql);
					while (rs.next()) {
				%>
				<tr>
					<td style="padding: 20px;"><img src="/upload/<%=rs.getString("img")%>" height="200px" width="300px" /></td>
					<td>
						<input type="file" name="_img" onchange="previewFile()" />
					</td>
				</tr>
				<%
					}
				%>
				<tr align="center">
					<td colspan="2">
						<input type="button" name="Submit" value="确认" class="btn btn-primary mybtn" onclick="sb1()">
						<input type="button" name="Submit" class="btn btn-default mybtn" value="取消" onclick="sb2()">
					</td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>