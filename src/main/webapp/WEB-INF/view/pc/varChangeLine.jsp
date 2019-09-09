<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<jsp:include page="../inc/echarts.jsp"></jsp:include>
<%@include file="../inc/reportJs.jsp"%>
<body style="background-image: url('<%=basePath %>resource/image/002.png');background-size:100% 100%;">
<div id="tab_div" style="width: 200px;height: 40px;line-height: 40px;color:#fff;font-size:20px;text-align:center;background-color: #22bddc;cursor: pointer;" onclick="showTabDiv(1);">实时数据</div>
<div id="tab2_div" style="width: 200px;height: 40px;line-height: 40px;margin-top:-40px;margin-left:200px;color:grey;font-size:20px;text-align:center;background-color: #07345e;cursor: pointer;" onclick="showTabDiv(2);">平均数据</div>
<div id="main" style="width:99%;height:800px;overflow:auto;background-color: rgba(8,51,94,0.5);border: 2px solid;border-image: linear-gradient(120deg, #4d83b2 0%,#2377a7 40%,#00d6ff 50%,#2377a7 60%,#4d83b2 100%) 10 1 stretch;">
	<select id="varType_cbb"></select>
</div>
<div id="main2" style="width:99%;height:800px; overflow:auto;background-color: rgba(8,51,94,0.5);border: 2px solid;border-image: linear-gradient(120deg, #4d83b2 0%,#2377a7 40%,#00d6ff 50%,#2377a7 60%,#4d83b2 100%) 10 1 stretch;display: none;">
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
				width:300,
				height:50,
				valueField:"value",
				textField:"text",
				data:data.rows,
				onSelect:function(){
					resetMainDiv();
				},
				onLoadSuccess:function(){
					$(".combo").css("margin-top","10px");
					$(".combo").css("margin-left","50px");
					$(".combo .combo-text").css("color","#fff");
					$(".combo .combo-text").css("background-color","#1A4A8C");
					$(".combo .combo-text").css("font-size","20px");
					
					$(".combobox-item").css("height","50px");
					$(".combobox-item").css("line-height","50px");
					$(".combobox-item").css("font-size","20px");
					$(".combobox-item").css("color","#fff");
					$(".combobox-item").css("background-color","#1A4A8C");
				}
			});
			
			varTypeCbb2=$("#varType_cbb2").combobox({
				width:300,
				height:50,
				valueField:"value",
				textField:"text",
				data:data.rows,
				onSelect:function(){
					resetMain2Div();
				},
				onLoadSuccess:function(){
					$(".combo").css("margin-top","10px");
					$(".combo").css("margin-left","50px");
					$(".combo .combo-text").css("color","#fff");
					$(".combo .combo-text").css("background-color","#1A4A8C");
					$(".combo .combo-text").css("font-size","20px");
					
					$(".combobox-item").css("height","50px");
					$(".combobox-item").css("line-height","50px");
					$(".combobox-item").css("font-size","20px");
					$(".combobox-item").css("color","#fff");
					$(".combobox-item").css("background-color","#1A4A8C");
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
    	drawLine(ec);
    }
);

function drawLine(ec){
	var varTypeJS=JSON.parse('${requestScope.varType}');
	var url1="selectVarChangeLineData";
	var main=$("#main");
	for(var i=0;i<varTypeJS.length;i++){
    	//console.log(varTypeJS[i].name+","+varTypeJS[i].childList.length);
    	main.append("<div name=\""+varTypeJS[i].name+"\" id=\"chart_div"+(i+1)+"\" style=\"margin-top:10px;\"></div>");
    	for(var j=0;j<varTypeJS[i].childList.length;j++){
	    	$("div[name='"+varTypeJS[i].name+"']").append("<div>"
	    			+"<div style=\"width: 100px;height: 40px;line-height: 40px;color:#fff;font-size:20px;text-align:center;margin-left:50px; background-color: #1A4A8C;cursor: pointer;\" onclick=\"nextPage('"+url1+"','"+varTypeJS[i].childList[j].name+"',"+i+","+j+",-1)\" onmouseover=\"changePageDiv(this,1);\" onmouseout=\"changePageDiv(this,0);\">上一页</div>"
	    			+"<div style=\"width: 100px;height: 40px;line-height: 40px;color:#fff;font-size:20px;text-align:center;margin-top:-40px;margin-left:155px; background-color: #1A4A8C;cursor: pointer;\" onclick=\"nextPage('"+url1+"','"+varTypeJS[i].childList[j].name+"',"+i+","+j+",1)\" onmouseover=\"changePageDiv(this,1);\" onmouseout=\"changePageDiv(this,0);\">下一页</div>"
	    			+"</div>");
	    	$("div[name='"+varTypeJS[i].name+"']").append("<div name=\""+varTypeJS[i].childList[j].name+"\" page=\""+page+"\" id=\"chartChild_div"+(i+1)+"_"+(j+1)+"\" style=\"height:400px;\"></div>");
	    	//var series=[];
			//series.push({name:data[seriesArr[i].name],type:'line',stack: '总量',data:data[seriesArr[i].data]});
		    initVarChangeLine(ec,url1,page,row,"chartChild_div"+(i+1)+"_"+(j+1),varTypeJS[i].childList[j].name);
    	}
	}
}

function drawLine2(ec){
	var varTypeJS=JSON.parse('${requestScope.varType}');
	var url2="selectVarAvgChangeLineData";
	var main2=$("#main2");
	for(var i=0;i<varTypeJS.length;i++){
    	main2.append("<div name=\""+varTypeJS[i].name+"\" id=\"avgChart_div"+(i+1)+"\" style=\"margin-top:10px;\"></div>");
    	for(var j=0;j<varTypeJS[i].childList.length;j++){
	    	$("#main2 div[name='"+varTypeJS[i].name+"']").append("<div>"
	    			+"<div style=\"width: 100px;height: 40px;line-height: 40px;color:#fff;font-size:20px;text-align:center;margin-left:50px; background-color: #1A4A8C;cursor: pointer;\" onclick=\"nextPage2('"+url2+"','"+varTypeJS[i].childList[j].name+"',"+i+","+j+",-1)\" onmouseover=\"changePageDiv(this,1);\" onmouseout=\"changePageDiv(this,0);\">上一页</div>"
	    			+"<div style=\"width: 100px;height: 40px;line-height: 40px;color:#fff;font-size:20px;text-align:center;margin-top:-40px;margin-left:155px; background-color: #1A4A8C;cursor: pointer;\" onclick=\"nextPage2('"+url2+"','"+varTypeJS[i].childList[j].name+"',"+i+","+j+",1)\" onmouseover=\"changePageDiv(this,1);\" onmouseout=\"changePageDiv(this,0);\">下一页</div>"
	    			+"</div>");
	    	$("#main2 div[name='"+varTypeJS[i].name+"']").append("<div name=\""+varTypeJS[i].childList[j].name+"\" page=\""+page+"\" id=\"avgChartChild_div"+(i+1)+"_"+(j+1)+"\" style=\"height:400px;\"></div>");
	    	//var series=[];
			//series.push({name:data[seriesArr[i].name],type:'line',stack: '总量',data:data[seriesArr[i].data]});
		    initVarChangeLine(ec,url2,page,row,"avgChartChild_div"+(i+1)+"_"+(j+1),varTypeJS[i].childList[j].name);
    	}
	}
}

function showTabDiv(index){
	if(index==1){
		$("#tab_div").css("color","#fff");
		$("#tab_div").css("background-color","#22bddc");
		$("#tab2_div").css("color","grey");
		$("#tab2_div").css("background-color","#07345e");
		
		$("#main").css("display","block");
		$("#main2").css("display","none");
		
		drawLine(ec1);
	}
	else if(index==2){
		$("#tab_div").css("color","grey");
		$("#tab_div").css("background-color","#07345e");
		$("#tab2_div").css("color","#fff");
		$("#tab2_div").css("background-color","#22bddc");
		
		$("#main").css("display","none");
		$("#main2").css("display","block");
		drawLine2(ec1);
	}
}

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

function changePageDiv(o,flag){
	if(flag==1)
		$(o).css("background-color","#07345e");
	else
		$(o).css("background-color","#1a4a8c");
}
</script>
</body>
</html>