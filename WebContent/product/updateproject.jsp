<%@page import="java.sql.ResultSet"%>
<%@page import="util.JDBCUtil"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<script src="../js/jquery.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.in {
	height: 30px;
	width: 360px;
}

.mybtn {
	width: 6%;
	margin: 10px;
}
</style>
<script type="text/javascript">
	var flag1 = true,flag2 = true,flag3 = true,flag4 = true,flag5 = true,flag6 = true,flag7 = true,flag8 = true;
	
	function SubmitModify() {//提交表单
		CheckPName();
		Check();
		if (flag1&&flag2&&flag3&&flag4&&flag5&&flag6&&flag7) {
			ModifyForm.action = "../servlet/ModifyProductServlet";
			ModifyForm.submit();
		} else {
			alert("请检查修改的内容是否正确");
		}
	}
	
	function Clear() {//提交表单
		ModifyForm.action = "../product/list.jsp";
		ModifyForm.submit();
	}
	
	//document.getElementById("price").onblur = 
	function Check2() {//验证修改的价格是否为空
		var price1 = ModifyForm.price.value.trim();
		if (price1 == "") {
			document.getElementById("p_price").style.visibility = "visible";
			flag2 = false;
		} else {
			document.getElementById("p_price").style.visibility = "hidden";
			flag2 = true;
		}
	}

	function CheckPName() {
		var pname1 = ModifyForm.p_name.value.trim();
		if (pname1 == "") { //验证用户修改值为空，提示用户
			document.getElementById("pname").style.visibility = "visible";
			flag1 = false;
		} else {
			document.getElementById("pname").style.visibility = "hidden";
			flag1 = true;
		}
	}
	
	function Check() {
		//验证修改的价格是否为空
		var price1 = ModifyForm.price.value.trim();
		if (price1 == "") {
			document.getElementById("p_price").style.visibility = "visible";
			flag2 = false;
		} else {
			document.getElementById("p_price").style.visibility = "hidden";
			flag2 = true;
		}
		/*判断价格是否为double
		if (price1 instanceof Double) {
			flag3 = true;
		} else {
			document.getElementById("p_price").innerHTML = "请输入Double类型数据";
			document.getElementById("p_price").style.visibility = "visible";
			flag3 = false;
		}*/
		
		//判断库存是否为空
		var total1 = ModifyForm.total.value.trim();
		if (total1 == "") {
			document.getElementById("p_total").style.visibility = "visible";
			flag4 = false;
		} else {
			document.getElementById("p_total").style.visibility = "hidden";
			flag4 = true;
		}
		/*判断库存是否为整型
		if (total1 instanceof Integer) {
			flag5 = true;
		} else {
			document.getElementById("p_total").innerHTML = "请输入int类型数据";
			document.getElementById("p_total").style.visibility = "visible";
			flag5 = false;
		}*/
		
		//判断入库商品是否为空
		var num1 = ModifyForm.num.value.trim();
		if (num1 == "") {
			document.getElementById("p_num").style.visibility = "visible";
			flag6 = false;
		} else {
			document.getElementById("p_num").style.visibility = "hidden";
			flag6 = true;
		}
		
		/*判断商品描述是否为空
		var disc1 = ModifyForm.disc.value.trim();
		if (disc1 == "") {
			document.getElementById("p_disc").style.visibility = "visible";
			
		} else {
			document.getElementById("p_disc").style.visibility = "hidden";
		}*/
		
		//判断折扣是否为空
		var discount1 = ModifyForm.discount.value.trim();
		if (discount1 == "") {
			document.getElementById("p_discount").style.visibility = "visible";
			flag7 = false;
		} else {
			document.getElementById("p_discount").style.visibility = "hidden";
			flag7 = true;
		}
	}
	
</script>
<link rel="stylesheet" type="text/css" href="../css/content.css">
</head>
<body onload="init()">
	<div id="up">
		<ul>
			<li><span><a href="../welcome.jsp">平台首页 </a>&gt; 商品管理
					&gt; 商品修改</span></li>
		</ul>
	</div>
	<!-- <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	<div class="container">
		<div class="navbar-header">
			<a href="#" class="navbar-brand">管理</a>
		</div>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="nav navbar-nav">
				<li><a href="#">平台首页>> </a></li>
				<li><a href="#">商品管理>></a></li>
				<li class="active"><a href="#">商品修改</a></li>
			</ul>
		</div>
	</div>
	</nav> -->
	<div style="margin-top: 20px">
		<div class="row">
			<div class="col-sm-2"></div>
			<form name="ModifyForm" method="post"
				class="form-horizontal col-sm-10">
				<%
					String id = request.getParameter("m_id");
					String sql = "select * from p_product where p_id=" + id;

					System.out.println(sql);

					Statement st = JDBCUtil.getStatement();
					ResultSet rs = st.executeQuery(sql);

					if (rs.next()) {
				%>
				<div class="form-group">
					<label class="col-sm-2 control-label">商品序号</label>
					<div class="col-sm-6">
						<input type="text" class="form-control" name="p_id"
							value="<%=rs.getInt("p_id")%>" readonly><span
							style="color: red">商品序号不可修改</span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">商品名称</label>
					<div class="col-sm-6">
						<input type="text" class="form-control" name="p_name"
							value="<%=rs.getString("p_name")%>" onblur="CheckPName()">
						<span id="pname" style="visibility: hidden; color: red">
							商品名称不能为空 </span> <span id="pname1"
							style="visibility: hidden; color: red"> "请输入字符串" </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">商品价格</label>
					<div class="col-sm-6">
						<input type="text" class="form-control" name="price" id="price"
							value="<%=rs.getDouble("price")%>" onblur="Check()">
						<span id="p_price" style="visibility: hidden; color: red">
							请用0来表示商品价格为空 </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">商品库存</label>
					<div class="col-sm-6">
						<input type="text" class="form-control" name="total"
							value="<%=rs.getInt("total")%>" onblur="Check()"> <span
							id="p_total" style="visibility: hidden; color: red">
							请用0来表示商品库存为空 </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">商品销量</label>
					<div class="col-sm-6">
						<input type="text" class="form-control" name="num"
							value="<%=rs.getInt("num")%>" onblur="Check()"> <span
							id="p_num" style="visibility: hidden; color: red">
							请用0来表示入库商品为空 </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">商品描述</label>
					<div class="col-sm-6">
						<input type="text" class="form-control" name="disc"
							value="<%=rs.getString("disc")%>" onblur="Check()"> <span
							id="p_disc" style="visibility: hidden; color: red">
							请用无来表示商品描述为空 </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">商品折扣</label>
					<div class="col-sm-6">
						<input type="text" class="form-control" name="discount"
							value="<%=rs.getDouble("discount")%>" onblur="Check()"> <span
							id="p_discount" style="visibility: hidden; color: red">
							请用0来表示商品折扣为空 </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">商品状态</label>
					<div class="col-sm-6">
						<select name="status" class="form-control in" style="height: 40px">
							<option value="1">已下架</option>
							<option value="2">上架</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">商品类别</label>
					<div class="col-sm-6">
						<select name="t_id" class="form-control in" style="height: 40px">
							<%
	   							//创建执行sql的对象
	   							Statement st2 = JDBCUtil.getStatement();
	   							String sql2 = "select * from p_type";
	   							//获取查询的结果集
	   							ResultSet rs2 = st.executeQuery(sql2);
	   							while(rs2.next()){
	   								if(rs2.getInt("t_id") != 1){
	   						%>
							<option value="<%=rs2.getInt("t_id") %>"><%=rs2.getString("t_name") %></option>
							<% }} %>
						</select>
					</div>
				</div>
				<%
					}
				%>
				<div class="form-group">
					<div class="col-sm-offset-2 text-center">
						<input type="submit" value="确认" class="btn btn-primary mybtn"
							onclick="return SubmitModify()">
						<input type="reset" value="重置" class="btn btn-info mybtn" >
						<input type="button"
							value="取消" class="btn btn-default mybtn" onclick="Clear()">
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>