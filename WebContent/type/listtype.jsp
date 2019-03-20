<%@page import="java.sql.ResultSet"%>
<%@page import="util.JDBCUtil"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AddType</title>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<script src="../js/jquery.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="../css/content.css">
</head>
<body>
	<div id="up">
		<ul>
			<li><span><a href="../welcome.jsp">平台首页 </a>&gt; 类别管理
					&gt; 类别列表</span></li>
		</ul>
	</div>
	<!-- <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	<div class="container">
		<div class="navbar-header">
			<a href="#" class="navbar-brand">管理</a>
		</div>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="nav navbar-nav">
				<li><a href="#">平台首页</a></li>
				<li><a href="#">类别管理</a></li>
				<li class="active"><a href="#">类别列表</a></li>
			</ul>
		</div>
	</div>
	</nav> -->


	<div style="margin: 20px 100px;">
		<span>${msg }</span>
		<div class="row">
			<form action="" name="fm">
				<table class="table table-condensed" width="900px" cellpadding="0"
					cellspacing="0">
					<tr class="head">
						<td>类别编号</td>
						<td>类别名称</td>
						<td>操作</td>
					</tr>
					<%
						Statement st = JDBCUtil.getStatement();
						String sql = "select * from p_type";
						ResultSet rs = st.executeQuery(sql);
						while (rs.next()) {
							int i = rs.getInt("t_id");
							if(i != 1) {
					%>
					<tr class="odd">
						<td><input type="text" readonly name="t_id"
							value="<%=i%>"></td>
						<td><input type="text" name="t_name"
							id="<%=rs.getInt("t_id")%>" value="<%=rs.getString("t_name")%>"></td>
						<td><input type="button" class="btn btn-info btn-xs"
							value="修改"
							onclick="conduct(1,<%=rs.getInt("t_id")%>,'<%=rs.getString("t_name")%>')">
							<input type="button" class="btn btn-danger btn-xs" value="删除"
							onclick="conduct(2,<%=rs.getInt("t_id")%>,'<%=rs.getString("t_name")%>')">
						</td>
					</tr>
					<%
						}}
					%>
				</table>
			</form>
		</div>
	</div>
</body>
<script type="text/javascript">
function conduct(i,t_id,t_name){
    //lert(11);
    t_name =  document.getElementById(t_id).value;
    if(t_name==""||t_name==null){
    	alert("类别名称不能为空");
    	return;
    }else{
    	//alert(t_name);
        var xmlHttp = new XMLHttpRequest();
    	//配置xmlHttp对象；
    	xmlHttp.open("post","../servlet/DeleteTypeServlet?t_id="+t_id+"&t_name="+encodeURI(encodeURI(t_name))+"&i="+i,true); //false代表同步，true代表异步；
    	//发送请求
    	xmlHttp.send(null);
    	//回调函数 
    	xmlHttp.onreadystatechange=function(){
    		//接收返回的数据：
    		var rs=xmlHttp.responseText;
    		if(xmlHttp.readyState==4){//交互完成
    			if(xmlHttp.status==200){//成功状态
    			//alert(rs);
    			if(rs=="fail"){
    				alert("未修改或已有此分类");
    			}else{
    				alert("操作成功");
    			}
    			window.location = "../type/listtype.jsp";
    			}
    			} 
    		}
    }
}
</script>
</html>
