<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
$(function(){
	showVarLabel("除氧器频率1",415,35);
	showVarLabel("除氧器频率2",415,62);
	showVarLabel("除氧器液位",415,97);
	showVarLabel("除氧器温度",415,122);
	showVarLabel("上水泵频率1",197,119);
	showVarLabel("水泵上水流量",301,119);
});

function initIframe(flag){
	if(flag==1){
		/*
		$("#iframe1").css("display","block");
		$("#iframe2").css("display","none");
		$("#iframe3").css("display","none");
		*/
		window.open("goVarChangeLine");
	}
	else if(flag==2){
		/*
		$("#iframe1").css("display","none");
		$("#iframe2").css("display","block");
		$("#iframe3").css("display","none");
		*/
		window.open("goVarChangeReport");
	}
	else if(flag==3){
		/*
		$("#iframe1").css("display","none");
		$("#iframe2").css("display","none");
		$("#iframe3").css("display","block");
		*/
		window.open("goWarnRecord");
	}
	else if(flag==4){
		window.open("goWarnHistoryRecord");
	}
}

function showVarLabel(name,left,top){
	$("span[name='"+name+"']").css("margin-left",left+"px");
	$("span[name='"+name+"']").css("margin-top",top+"px");
}
</script>
<title>Insert title here</title>
</head>
<body>
<div id="var_div" style="width:1024px;height:768px;margin:0 auto;background-image: url('<%=basePath %>resource/image/001.png');background-size:100% 100%;">
	<c:forEach items="${requestScope.varList }" var="item">
	<span name="${item.name }" style="position: absolute;">${item.value }</span>
	</c:forEach>
</div>
<!-- 
<iframe id="iframe1" src="goVarChangeLine" style="width:100%;height: 800px;display: block;"></iframe>
<iframe id="iframe2" src="goVarChangeReport" style="width:800px;height: 800px;display: block;"></iframe>
<iframe id="iframe3" src="goWarnRecord" style="width:800px;height: 800px;display: block;"></iframe>
 -->
<!-- 
<iframe src="goWarnRecord" style="width:800px;height: 800px;"></iframe>
 -->
<div>
	<input type="button" value="曲线" onclick="initIframe(1);"/>
	<input type="button" value="报表" onclick="initIframe(2);"/>
	<input type="button" value="报警" onclick="initIframe(3);"/>
	<input type="button" value="历史报警记录" onclick="initIframe(4);"/>
</div>
<body>
</body>
</html>