<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN">
<html>
  <head>
    <title>main.jsp</title>
	
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    
    <!--<link rel="stylesheet" type="text/css" href="./styles.css">-->

  </head>
  
  <!-- rows表示以行的形式把页面分成3部分,上面的是150,下面的是150,剩下的就是中间的高度 -->
  <frameset rows="47,*" border="0">
  	<frame src="../top.jsp" noresize="noresize" scrolling="no">
  	<frameset cols="190,*" border="1">
  		<frame src="../left.jsp" >
  		<frame src="../welcome.jsp" noresize="noresize" name="con">
  	</frameset>
  </frameset>
</html>
