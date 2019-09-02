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
<div id="main" style="width:100%;height:600px;overflow:auto;">
</div>
<div id="main2" style="width:800px;height:400px;overflow-x:auto;overflow-y:hidden;">
	<div id="avgChart_div" style="height:400px;"></div>
</div>
<script type="text/javascript">
var page=1;
var row=100;
var main=$("#main");
require(
    [
        'echarts',
        'echarts/chart/line',   // 按需加载所需图表，如需动态类型切换功能，别忘了同时加载相应图表
        'echarts/chart/bar'
    ],
    function (ec) {
    	var url1="selectVarChangeLineData";
    	var varTypeJS=JSON.parse('${requestScope.varType}');
    	for(var i=0;i<varTypeJS.length;i++){
        	console.log(varTypeJS[i].name+","+varTypeJS[i].childList.length);
        	main.append("<div name=\""+varTypeJS[i].name+"\"></div>");
	    	for(var j=0;j<varTypeJS[i].childList.length;j++){
		    	var series=new Array();
		    	series["name"]="name"+(i+1)+"_"+(j+1);
		    	series["data"]="valueList"+(i+1)+"_"+(j+1);
		    	
		    	$("div[name='"+varTypeJS[i].name+"']").append("<div>"
		    			+"<input type=\"button\" value=\"上一页\"/>"
		    			+"<input type=\"button\" value=\"下一页\" onclick=\"nextPage('"+ec+"','"+url1+"','"+varTypeJS[i].childList[j].name+"','"+i+"','"+j+"','"+series+"')\"/>"
		    			+"</div>");
		    	$("div[name='"+varTypeJS[i].name+"']").append("<div name=\""+varTypeJS[i].childList[j].name+"\" page=\""+page+"\" id=\"chart"+(i+1)+"_"+(j+1)+"_div\" style=\"height:400px;\"></div>");
		    	//var series=[];
				//series.push({name:data[seriesArr[i].name],type:'line',stack: '总量',data:data[seriesArr[i].data]});
			    initVarChangeLine(ec,url1,page,row,"chart"+(i+1)+"_"+(j+1)+"_div","createList"+(i+1)+"_"+(j+1),"listSize"+(i+1)+"_"+(j+1),series);
	    	}
    	}
    	var url2="selectVarAvgChangeLineData";
    	//initVarChangeLine(ec,url2,"avgChart_div");
    }
);

function nextPage(ec,url,name,i,j,series){
	var page=$("div[name='"+name+"']").attr("page");
	page++;
	initVarChangeLine(ec,url,page,row,"chart"+(i+1)+"_"+(j+1)+"_div","createList"+(i+1)+"_"+(j+1),"listSize"+(i+1)+"_"+(j+1),series);
}
</script>
</body>
</html>