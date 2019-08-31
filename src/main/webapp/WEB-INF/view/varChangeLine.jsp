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
<div id="main" style="width:800px;height:2400px;overflow-x:auto;overflow-y:hidden;">
	<div id="chart1_div" style="height:400px;"></div>
	<div id="chart2_div" style="height:400px;"></div>
	<div id="chart3_div" style="height:400px;"></div>
	<div id="chart4_div" style="height:400px;"></div>
	<div id="chart5_div" style="height:400px;"></div>
	<div id="chart6_div" style="height:400px;"></div>
</div>
<div id="main2" style="width:800px;height:400px;overflow-x:auto;overflow-y:hidden;">
	<div id="avgChart_div" style="height:400px;"></div>
</div>
<script type="text/javascript">
alert('${requestScope.varType1Length}');
require(
    [
        'echarts',
        'echarts/chart/line',   // 按需加载所需图表，如需动态类型切换功能，别忘了同时加载相应图表
        'echarts/chart/bar'
    ],
    function (ec) {
    	var url1="selectVarChangeLineData";
    	var count=1;
    	for(var i=0;i<'${requestScope.varTypeLength}';i++){
	    	var seriesArr=[];
	    	for(var j=0;j<count;j++){
    			if(i==0&&j==0)
    				count='${requestScope.varType3Length}';
   				else if(i==1&&j==0)
   					count='${requestScope.varType2Length}';
    			else if(i==2&&j==0)
    				count='${requestScope.varType3Length}';
   				else if(i==3&&j==0)
   					count='${requestScope.varType4Length}';
 				else if(i==4&&j==0)
 					count='${requestScope.varType5Length}';
 				else if(i==5&&j==0)
 					count='${requestScope.varType6Length}';
		    	seriesArr[j]=new Array();
		    	seriesArr[j]["name"]="name1_"+(j+1);
		    	seriesArr[j]["data"]="valueList1_"+(j+1);
	    	}
	    	initVarChangeLine(ec,url1,"chart"+(i+1)+"_div","createList"+(i+1),"listSize"+(i+1),seriesArr);
    	}
    	var url2="selectVarAvgChangeLineData";
    	//initVarChangeLine(ec,url2,"avgChart_div");
    }
);
</script>
</body>
</html>