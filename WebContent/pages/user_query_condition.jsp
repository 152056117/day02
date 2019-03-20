<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>达内商城客户信息查询</title>
<link href="../css/csm_style.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">

	function query(){
		/*
		 * 先记录要添加的sql语句中的where条件 
		 * 获取各查询值
		 */
		var whereSQL = " where 1=1 ";//方便拼接，不管后边增加什么新的条件都得写and 
		var username = fm.username.value.trim();
		var password = fm.password.value.trim();
		var mobile = fm.mobile.value.trim();
		var sex = fm.sex.value;
		var mailbox = fm.mailbox.value.trim();
		
		if (username != null && username != "") {
			whereSQL += "and username='" + username + "'";
		}
		
		if (password != null && password != "") {
			whereSQL += "and password='" + password + "'";
		}
		
		if (mobile != null && mobile != "") {
			whereSQL += "and mobile='" + mobile + "'";
		}
		
		if (mailbox != null && mailbox != "") {
			whereSQL += "and mailbox='" + mailbox + "'";
		}
		
		if (sex != null && sex != "") {
			whereSQL += "and sex=" + sex;
		}
		
		//找兄弟页面，重写编写他的源地址，把值传递过去
		parent.mainFrame.location.href = "user-list.jsp?whereSQL=" + whereSQL;
	}

</script>
</head>
<body bgcolor=#ECF7E6>
	<div align="center">
		<form name="fm" method="post" action="">
			<p>&nbsp;</p>
			<table bordercolor=#cfe3fe cellspacing=1 bordercolordark=#ffffff
				width="90%" bgcolor=#656565 bordercolorlight=#008000 border=0>
				<tbody>
					<tr class="TableTitle">
						<td height=22 colspan="4">请录入查询的基本信息</td>
					</tr>
					<tr>
						<td class="TableAttrName">姓名：</td>
						<td class="TableAttrValue"><input type="text" name="username"></td>
						<td class="TableAttrName">密码：</td>
						<td class="TableAttrValue"><input type="text" name="password"></td>
					</tr>
					<tr>
						<td class="TableAttrName">手机：</td>
						<td class="TableAttrValue"><input type="text" name="mobile"></td>
						<td class="TableAttrName">性别：</td>
						<td class="TableAttrValue"><select name="sex">
								<option value="0">不选择</option>
								<option value="1">男</option>
								<option value="2">女</option>
						</select></td>
					</tr>
					<tr>
						<td class="TableAttrName">邮箱：</td>
						<td class="TableAttrValue"><input type="text" name="mailbox"></td>
						<td class="TableAttrName"></td>
						<td class="TableAttrValue"></td>
					</tr>
					<tr>
						<td height="14" colspan="4" align="right" class="TableAttrName">
							<input type="button" value="查 询" onclick="query()"> <input type="reset"
							value="清 空">
						</td>
					</tr>
				</tbody>
			</table>
			<p>&nbsp;</p>
		</form>
		<p>&nbsp;</p>
	</div>
</body>
</html>
