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
<div id="tab2_div" style="width: 200px;height: 40px;line-height: 40px;margin-top:-40px;margin-left:200px;color:grey;font-size:20px;text-align:center;background-color: #07345e;cursor: pointer;" onclick="showTabDiv(2);">历史数据</div>
<div id="main" style="width:99%;height:800px;overflow:auto;background-color: rgba(8,51,94,0.5);border: 2px solid;border-image: linear-gradient(120deg, #4d83b2 0%,#2377a7 40%,#00d6ff 50%,#2377a7 60%,#4d83b2 100%) 10 1 stretch;">
	<div style="width: 100%;height: 60px;line-height: 60px;">
		<span style="color: #fff;font-size:20px;margin-left:10px;">类别：</span>
		<select id="varType_cbb"></select>
	</div>
</div>
<div id="main2" style="width:99%;height:800px; overflow:auto;background-color: rgba(8,51,94,0.5);border: 2px solid;border-image: linear-gradient(120deg, #4d83b2 0%,#2377a7 40%,#00d6ff 50%,#2377a7 60%,#4d83b2 100%) 10 1 stretch;display: none;">
	<div style="width: 100%;height: 60px;line-height: 60px;">
		<span style="color: #fff;font-size:20px;margin-left:10px;">类别：</span>
		<select id="varType_cbb2"></select>
		<span style="color: #fff;font-size:20px;margin-left:10px;">区间：</span>
		<select id="timeSpace_cbb2"></select>
		<span style="color: #fff;font-size:20px;margin-left:10px;">开始时间：</span>
		<input id="startTime_dtb" type="text"/>
		<span style="color: #fff;font-size:20px;margin-left:10px;">结束时间：</span>
		<input id="endTime_dtb" type="text"/>
		<div style="width: 80px;height: 40px;line-height: 40px;margin-top:-50px;margin-left:1190px;color:#fff;font-size:20px;text-align:center; background-color: #1A4A8C;cursor: pointer;border: 0.05vw solid rgba(255,255,255,0.3);border-radius:3px;" onclick="searchByName();" onmouseover="changeButDiv(this,1);" onmouseout="changeButDiv(this,0);">查询</div>
	</div>
	<!-- 
	<div id="avgChart_div" style="height:400px;"></div>
	 -->
</div>
<script type="text/javascript">
$(function(){
	$.post("selectVarTypeData",
		function(data){
			varTypeCbb=$("#varType_cbb").combobox({
				width:150,
				height:40,
				valueField:"value",
				textField:"text",
				data:data.rows,
				onSelect:function(){
					resetMainDiv();
				},
				onLoadSuccess:function(){
					$(".combo").css("margin-left","50px");
					$(".combo .combo-text").css("color","#fff");
					$(".combo .combo-text").css("background-color","#1A4A8C");
					$(".combo .combo-text").css("font-size","20px");
					
					$(".combobox-item").css("height","40px");
					$(".combobox-item").css("line-height","40px");
					$(".combobox-item").css("font-size","20px");
					$(".combobox-item").css("color","#fff");
					$(".combobox-item").css("background-color","#1A4A8C");
				}
			});
			
			varTypeCbb2=$("#varType_cbb2").combobox({
				width:150,
				height:40,
				valueField:"value",
				textField:"text",
				data:data.rows,
				onSelect:function(){
					//resetMain2Div();
				},
				onLoadSuccess:function(){
					$(".combo").css("margin-left","10px");
					$(".combo .combo-text").css("color","#fff");
					$(".combo .combo-text").css("background-color","#1A4A8C");
					$(".combo .combo-text").css("font-size","20px");
					
					$(".combobox-item").css("height","40px");
					$(".combobox-item").css("line-height","40px");
					$(".combobox-item").css("font-size","20px");
					$(".combobox-item").css("color","#fff");
					$(".combobox-item").css("background-color","#1A4A8C");
				}
			});
		}
	,"json");
	
	timeSpaceCbb2=$("#timeSpace_cbb2").combobox({
		width:150,
		height:40,
		valueField:"value",
		textField:"text",
		data:[{value:1,text:"24小时"},{value:2,text:"一周"},{value:3,text:"一个月"},{value:4,text:"三个月"}],
		onLoadSuccess:function(){
			$(".combo").css("margin-left","10px");
			$(".combo .combo-text").css("color","#fff");
			$(".combo .combo-text").css("background-color","#1A4A8C");
			$(".combo .combo-text").css("font-size","20px");
			
			$(".combobox-item").css("height","40px");
			$(".combobox-item").css("line-height","40px");
			$(".combobox-item").css("font-size","20px");
			$(".combobox-item").css("color","#fff");
			$(".combobox-item").css("background-color","#1A4A8C");
		}
	});
	
	startTimeDTB=$("#startTime_dtb").datetimebox({
		required:true,
		width:220,
		height:40
	});
	
	endTimeDTB=$("#endTime_dtb").datetimebox({
		required:true,
		width:220,
		height:40
	});
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

function drawLine2(ec,varType,timeSpace,startTime,endTime){
	var reqVarTypeJS=JSON.parse('${requestScope.varType}');
	var url2="selectVarAvgChangeLineData";
	var main2=$("#main2");
	var varTypeJS;
	if(varType=="")
		varTypeJS=reqVarTypeJS;
	else{
		varTypeJS=[];
		for(var i=0;i<reqVarTypeJS.length;i++){
			if(reqVarTypeJS[i].name==varType){
				varTypeJS[0]=reqVarTypeJS[i];
				break;
			}
		}
	}
	
	main2.find("div[id^='avgChart_div']").remove();
	var otherParam={timeSpace:timeSpace,startTime:startTime,endTime:endTime};
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
		    initVarChangeLine(ec,url2,page,row,"avgChartChild_div"+(i+1)+"_"+(j+1),varTypeJS[i].childList[j].name,otherParam);
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

		var varType2=varTypeCbb2.combobox("getValue");
		var timeSpace2=timeSpaceCbb2.combobox("getValue");
		var startTime=startTimeDTB.datetimebox("getValue");
		var endTime=endTimeDTB.datetimebox("getValue");
		/*
		console.log(varType2);
		console.log(timeSpace2);
		console.log(startTime);
		console.log(endTime);
		*/
		drawLine2(ec1,varType2,timeSpace2,startTime,endTime);
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
	var timeSpace2=timeSpaceCbb2.combobox("getValue");
	var startTime=startTimeDTB.datetimebox("getValue");
	var endTime=endTimeDTB.datetimebox("getValue");
	var otherParam={timeSpace:timeSpace2,startTime:startTime,endTime:endTime};
	initVarChangeLine(ec1,url,page,row,"avgChartChild_div"+(i+1)+"_"+(j+1),name,otherParam);
}

function changePageDiv(o,flag){
	if(flag==1)
		$(o).css("background-color","#07345e");
	else
		$(o).css("background-color","#1a4a8c");
}
function changeButDiv(o,flag){
	if(flag==1)
		$(o).css("background-color","#00f");
	else
		$(o).css("background-color","#1A4A8C");
}

function searchByName(){
	var varType2=varTypeCbb2.combobox("getValue");
	var timeSpace2=timeSpaceCbb2.combobox("getValue");
	var startTime=startTimeDTB.datetimebox("getValue");
	var endTime=endTimeDTB.datetimebox("getValue");
	//console.log(varType2);
	//console.log(timeSpace2);
	//console.log(startTime);
	//console.log(endTime);
	drawLine2(ec1,varType2,timeSpace2,startTime,endTime);
}
</script>
</body>
</html>