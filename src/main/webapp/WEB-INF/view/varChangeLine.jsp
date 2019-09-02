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
<%@include file="inc/reportJs.jsp"%>
<div id="main" style="width:100%;height:600px;overflow:auto;">
	<select id="varType_cbb"></select>
</div>
<div id="main2" style="width:100%;height:600px;overflow:auto;">
	<select id="varType_cbb2"></select>
	<!-- 
	<div id="avgChart_div" style="height:400px;"></div>
	 -->
</div>
<script type="text/javascript">
$(function(){
	$.post("selectVarTypeData",
		function(data){
			varTypeCbb=$("#varType_cbb").combobox({
				width:200,
				valueField:"value",
				textField:"text",
				data:data.rows,
				onSelect:function(){
					resetMainDiv();
				}
			});
			
			varTypeCbb2=$("#varType_cbb2").combobox({
				width:200,
				valueField:"value",
				textField:"text",
				data:data.rows,
				onSelect:function(){
					resetMain2Div();
				}
			});
		}
	,"json");
});

function resetMainDiv(){
	$("#main div[id^='chart_div']").css("display","none");
	$("#main div[name='"+varTypeCbb.combobox("getValue")+"']").css("display","block");
}

function resetMain2Div(){
	$("#main2 div[id^='avgChart_div']").css("display","none");
	$("#main2 div[name='"+varTypeCbb2.combobox("getValue")+"']").css("display","block");
}

var page=1;
var row=100;
var ec1;
require(
    [
        'echarts',
        'echarts/chart/line',   // 按需加载所需图表，如需动态类型切换功能，别忘了同时加载相应图表
        'echarts/chart/bar'
    ],
    function (ec) {
   		ec1=ec;
    	var varTypeJS=JSON.parse('${requestScope.varType}');
    	var url1="selectVarChangeLineData";
    	var main=$("#main");
    	for(var i=0;i<varTypeJS.length;i++){
        	//console.log(varTypeJS[i].name+","+varTypeJS[i].childList.length);
        	main.append("<div name=\""+varTypeJS[i].name+"\" id=\"chart_div"+(i+1)+"\"></div>");
	    	for(var j=0;j<varTypeJS[i].childList.length;j++){
		    	$("div[name='"+varTypeJS[i].name+"']").append("<div>"
		    			+"<input type=\"button\" value=\"上一页\" onclick=\"nextPage('"+url1+"','"+varTypeJS[i].childList[j].name+"',"+i+","+j+",-1)\"/>"
		    			+"<input type=\"button\" value=\"下一页\" onclick=\"nextPage('"+url1+"','"+varTypeJS[i].childList[j].name+"',"+i+","+j+",1)\"/>"
		    			+"</div>");
		    	$("div[name='"+varTypeJS[i].name+"']").append("<div name=\""+varTypeJS[i].childList[j].name+"\" page=\""+page+"\" id=\"chartChild_div"+(i+1)+"_"+(j+1)+"\" style=\"height:400px;\"></div>");
		    	//var series=[];
				//series.push({name:data[seriesArr[i].name],type:'line',stack: '总量',data:data[seriesArr[i].data]});
			    initVarChangeLine(ec,url1,page,row,"chartChild_div"+(i+1)+"_"+(j+1),varTypeJS[i].childList[j].name);
	    	}
    	}
    	
    	var url2="selectVarAvgChangeLineData";
    	var main2=$("#main2");
    	for(var i=0;i<varTypeJS.length;i++){
        	main2.append("<div name=\""+varTypeJS[i].name+"\" id=\"avgChart_div"+(i+1)+"\"></div>");
	    	for(var j=0;j<varTypeJS[i].childList.length;j++){
		    	$("#main2 div[name='"+varTypeJS[i].name+"']").append("<div>"
		    			+"<input type=\"button\" value=\"上一页\" onclick=\"nextPage2('"+url2+"','"+varTypeJS[i].childList[j].name+"',"+i+","+j+",-1)\"/>"
		    			+"<input type=\"button\" value=\"下一页\" onclick=\"nextPage2('"+url2+"','"+varTypeJS[i].childList[j].name+"',"+i+","+j+",1)\"/>"
		    			+"</div>");
		    	$("#main2 div[name='"+varTypeJS[i].name+"']").append("<div name=\""+varTypeJS[i].childList[j].name+"\" page=\""+page+"\" id=\"avgChartChild_div"+(i+1)+"_"+(j+1)+"\" style=\"height:400px;\"></div>");
		    	//var series=[];
				//series.push({name:data[seriesArr[i].name],type:'line',stack: '总量',data:data[seriesArr[i].data]});
			    initVarChangeLine(ec,url2,page,row,"avgChartChild_div"+(i+1)+"_"+(j+1),varTypeJS[i].childList[j].name);
	    	}
    	}
    	//initVarChangeLine(ec,url2,"avgChart_div");
    }
);

function nextPage(url,name,i,j,next){
	var page=$("#main div[name='"+name+"']").attr("page");
	if(next==1)
		page++;
	else if(next==-1)
		page--;
	$("#main div[name='"+name+"']").attr("page",page);
	initVarChangeLine(ec1,url,page,row,"chartChild_div"+(i+1)+"_"+(j+1),name);
}

function nextPage2(url,name,i,j,next){
	var page=$("#main2 div[name='"+name+"']").attr("page");
	if(next==1)
		page++;
	else if(next==-1)
		page--;
	$("#main2 div[name='"+name+"']").attr("page",page);
	initVarChangeLine(ec1,url,page,row,"avgChartChild_div"+(i+1)+"_"+(j+1),name);
}
</script>
</body>
</html>