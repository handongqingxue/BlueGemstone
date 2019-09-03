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
	showVarLabel("上水泵频率2",197,254);
	showVarLabel("水泵上水流量",301,119);
	showVarLabel("过热蒸汽压力",615,108);
	showVarLabel("过热蒸汽温度",715,108);
	showVarLabel("蒸汽流量计",790,132);
	showVarLabel("引风机频率",805,312);
	showVarLabel("锅炉出口温度",388,333);
	showVarLabel("床体温度1",388,368);
	showVarLabel("床体温度2",388,402);
	showVarLabel("床体温度3",388,437);
	showVarLabel("床体温度4",388,471);
	showVarLabel("鼓风机频率",330,550);
	showVarLabel("二次风频率",330,612);
	showVarLabel("三次风频率1",330,670);
	showVarLabel("三次风频率2",330,707);
	showVarLabel("旋风分离器温度1",708,402);
	showVarLabel("旋风分离器温度2",708,435);
	showVarLabel("炉膛差压",691,481);
	showVarLabel("料层差压",691,517);
	showVarLabel("含氧量表",691,553);
	showVarLabel("给煤频率1",691,583);
	showVarLabel("给煤频率2",691,620);
	showVarLabel("给煤频率3",691,654);
	showVarLabel("三次风室压力1",538,575);
	showVarLabel("三次风室压力2",538,621);
	showVarLabel("风室压力",538,661);
	showVarLabel("饱和蒸汽压力",520,202);
	setInterval("updateVarLabel()",5000,1000);
});

function updateVarLabel(){
	$.post("updateCurrentVarValue",
		function(data){
			if(data.message=="ok"){
				var varList=data.varList;
				for(var i=0;i<varList.length;i++){
					var name=varList[i].name;
					$("span[name='"+name+"']").text(varList[i].value);
				}
			}
		}
	,"json");
}

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