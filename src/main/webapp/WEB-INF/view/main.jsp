<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String basePath=request.getScheme()+"://"+request.getServerName()+":"
	+request.getServerPort()+request.getContextPath()+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
function initIframe(flag){
	if(flag==1){
		$("#iframe1").attr("src","goVarChangeLine");
	}
	else if(flag==2){
		
	}
	else if(flag==3){
		$("#iframe1").attr("src","goWarnRecord");
	}
}
</script>
<title>Insert title here</title>
</head>
<body>
<iframe id="iframe1" src="goVarChangeLine" style="width:800px;height: 800px;"></iframe>
<!-- 
<iframe src="goWarnRecord" style="width:800px;height: 800px;"></iframe>
 -->
<div>
	<input type="button" value="曲线" onclick="initIframe(1);"/>
	<input type="button" value="报表" onclick="initIframe(2);"/>
	<input type="button" value="报警" onclick="initIframe(3);"/>
</div>
<body>
</body>
</html>