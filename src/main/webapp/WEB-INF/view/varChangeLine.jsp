<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="inc/echarts.jsp"></jsp:include>
<div id="main" style="width:800px;height:400px;overflow-x:auto;overflow-y:hidden;">
	<div id="chart_div" style="height:400px;"></div>
</div>
<div id="main2" style="width:800px;height:400px;overflow-x:auto;overflow-y:hidden;">
	<div id="chart2_div" style="height:400px;"></div>
</div>
<script type="text/javascript">
require(
    [
        'echarts',
        'echarts/chart/line',   // 按需加载所需图表，如需动态类型切换功能，别忘了同时加载相应图表
        'echarts/chart/bar'
    ],
    function (ec) {
    	var url1="selectVarChangeLineData";
    	var seriesArr=[];
    	for(var i=0;i<10;i++){
	    	seriesArr[i]=new Array();
	    	seriesArr[i]["name"]="pinLvName"+(i+1);
	    	seriesArr[i]["data"]="pinLvValueList"+(i+1);
    	}
    	initVarChangeLine(ec,url1,"chart_div","pinLvCTList","pinLvListSize",seriesArr);
    	var url2="selectVarAvgChangeLineData";
    	//initVarChangeLine(ec,url2,"chart2_div");
    }
);
</script>
</body>
</html>