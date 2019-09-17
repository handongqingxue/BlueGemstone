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
		<span style="color: #fff;font-size:20px;margin-left:10px;">记录点：</span>
		<select id="insertArr_cbb"></select>
	</div>
</div>
<div id="main2" style="width:99%;height:800px; overflow:auto;background-color: rgba(8,51,94,0.5);border: 2px solid;border-image: linear-gradient(120deg, #4d83b2 0%,#2377a7 40%,#00d6ff 50%,#2377a7 60%,#4d83b2 100%) 10 1 stretch;display: none;">
	<div style="width: 100%;height: 60px;line-height: 60px;">
		<span style="color: #fff;font-size:20px;margin-left:10px;">类别：</span>
		<select id="insertArr_cbb2"></select>
		<span style="color: #fff;font-size:20px;margin-left:10px;">区间：</span>
		<select id="timeSpace_cbb2"></select>
		<span style="color: #fff;font-size:20px;margin-left:10px;">开始时间：</span>
		<input id="startTime_dtb" type="text"/>
		<span style="color: #fff;font-size:20px;margin-left:10px;">结束时间：</span>
		<input id="endTime_dtb" type="text"/>
		<div style="width: 80px;height: 40px;line-height: 40px;margin-top:-50px;margin-left:1290px;color:#fff;font-size:20px;text-align:center; background-color: #1A4A8C;cursor: pointer;border: 0.05vw solid rgba(255,255,255,0.3);border-radius:3px;" onclick="searchByName();" onmouseover="changeButDiv(this,1);" onmouseout="changeButDiv(this,0);">查询</div>
	</div>
	<!-- 
	<div id="avgChart_div" style="height:400px;"></div>
	 -->
</div>
<script type="text/javascript">
$(function(){
	$.post("selectInsertArrData",
		function(data){
			insertArrCbb=$("#insertArr_cbb").combobox({
				width:250,
				height:40,
				valueField:"value",
				textField:"text",
				data:data.rows,
				onSelect:function(){
					var name=$(this).combobox("getValue");
					if(ec1==undefined){
						setTimeout(function(){
							drawLine(ec1,name);
						},"1000");
					}
					else
			    		drawLine(ec1,name);
				},
				onLoadSuccess:function(){
					$(".combo").css("margin-left","50px");
					$(".combo .combo-text").css("color","#fff");
					$(".combo .combo-text").css("background-color","#1A4A8C");
					$(".combo .combo-text").css("font-size","18px");
					
					$(".combobox-item").css("height","40px");
					$(".combobox-item").css("line-height","40px");
					$(".combobox-item").css("font-size","18px");
					$(".combobox-item").css("color","#fff");
					$(".combobox-item").css("background-color","#1A4A8C");
					
					var data=$(this).combobox("getData");
					$(this).combobox("select",data[0].value);
				}
			});
			
			insertArrCbb2=$("#insertArr_cbb2").combobox({
				width:250,
				height:40,
				valueField:"value",
				textField:"text",
				data:data.rows,
				onLoadSuccess:function(){
					$(".combo").css("margin-left","10px");
					$(".combo .combo-text").css("color","#fff");
					$(".combo .combo-text").css("background-color","#1A4A8C");
					$(".combo .combo-text").css("font-size","18px");
					
					$(".combobox-item").css("height","40px");
					$(".combobox-item").css("line-height","40px");
					$(".combobox-item").css("font-size","18px");
					$(".combobox-item").css("color","#fff");
					$(".combobox-item").css("background-color","#1A4A8C");

					var data=$(this).combobox("getData");
					$(this).combobox("select",data[0].value);
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
			$(".combo .combo-text").css("font-size","18px");
			
			$(".combobox-item").css("height","40px");
			$(".combobox-item").css("line-height","40px");
			$(".combobox-item").css("font-size","18px");
			$(".combobox-item").css("color","#fff");
			$(".combobox-item").css("background-color","#1A4A8C");
		},
		onSelect:function(){
			var now=new Date();
			var year=now.getFullYear();
			var month=now.getMonth()+1;
			var date=now.getDate();
			var hours=now.getHours();
			var minutes=now.getMinutes();
			var seconds=now.getSeconds();
			var endTime=year+"-"+(month<10?"0"+month:month)+"-"+date+" "+hours+":"+minutes+":"+seconds;
			endTimeDTB.datetimebox("setValue",endTime);
			
			var timeFlag=$(this).combobox("getValue");
			var timeSpace;
			switch(timeFlag){
				case "1":
					timeSpace=-1;
					break;
				case "2":
					timeSpace=-7;
					break;
				case "3":
					timeSpace=-30;
					break;
				case "4":
					timeSpace=-90;
					break;
			}
			now=addDate(month+"/"+date+"/"+year,timeSpace);
			year=now.getFullYear();
			month=now.getMonth()+1;
			date=now.getDate();
			hours=now.getHours();
			minutes=now.getMinutes();
			seconds=now.getSeconds();
			var startTime=year+"-"+(month<10?"0"+month:month)+"-"+date+" "+hours+":"+minutes+":"+seconds;
			startTimeDTB.datetimebox("setValue",startTime);
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

function addDate(dd,dadd){
	var a = new Date(dd);
	a = a.valueOf();
	a = a + dadd * 24 * 60 * 60 * 1000;
	a = new Date(a);
	return a;
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
    }
);

function drawLine(ec,name){
	var url1="selectVarChangeLineData";
	var main=$("#main");
	$("#main #chart_div").remove();
	page=1;
	main.append("<div id=\"chart_div\" name=\""+name+"\" page=\""+page+"\" style=\"margin-top:10px;\"></div>");
   	$("#chart_div").append("<div>"
   			+"<div style=\"width: 100px;height: 40px;line-height: 40px;color:#fff;font-size:20px;text-align:center;margin-left:50px; background-color: #1A4A8C;cursor: pointer;\" onclick=\"nextPage('"+url1+"','"+name+"',-1)\" onmouseover=\"changePageDiv(this,1);\" onmouseout=\"changePageDiv(this,0);\">上一页</div>"
   			+"<div style=\"width: 100px;height: 40px;line-height: 40px;color:#fff;font-size:20px;text-align:center;margin-top:-40px;margin-left:155px; background-color: #1A4A8C;cursor: pointer;\" onclick=\"nextPage('"+url1+"','"+name+"',1)\" onmouseover=\"changePageDiv(this,1);\" onmouseout=\"changePageDiv(this,0);\">下一页</div>"
   			+"</div>");
   	$("#chart_div").append("<div id=\"line_div\" style=\"height:400px;\"></div>");
    initVarChangeLine(ec,url1,page,row,"line_div",name);
}

function drawLine2(ec,name,timeSpace,startTime,endTime){
	var url2="selectVarAvgChangeLineData";
	var main2=$("#main2");
	main2.find("div[id^='avgChart_div']").remove();
	page=1;
	var otherParam={timeSpace:timeSpace,startTime:startTime,endTime:endTime};
   	main2.append("<div id=\"avgChart_div\" name=\""+name+"\" page=\""+page+"\" style=\"margin-top:10px;\"></div>");
   	$("#avgChart_div").append("<div>"
   			+"<div style=\"width: 100px;height: 40px;line-height: 40px;color:#fff;font-size:20px;text-align:center;margin-left:50px; background-color: #1A4A8C;cursor: pointer;\" onclick=\"nextPage2('"+url2+"','"+name+"',-1)\" onmouseover=\"changePageDiv(this,1);\" onmouseout=\"changePageDiv(this,0);\">上一页</div>"
   			+"<div style=\"width: 100px;height: 40px;line-height: 40px;color:#fff;font-size:20px;text-align:center;margin-top:-40px;margin-left:155px; background-color: #1A4A8C;cursor: pointer;\" onclick=\"nextPage2('"+url2+"','"+name+"',1)\" onmouseover=\"changePageDiv(this,1);\" onmouseout=\"changePageDiv(this,0);\">下一页</div>"
   			+"</div>");
   	$("#avgChart_div").append("<div id=\"avgLine_div\" style=\"height:400px;\"></div>");
    initVarChangeLine(ec,url2,page,row,"avgLine_div",name,otherParam);
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

		var name2=insertArrCbb2.combobox("getValue");
		var timeSpace2=timeSpaceCbb2.combobox("getValue");
		var startTime=startTimeDTB.datetimebox("getValue");
		var endTime=endTimeDTB.datetimebox("getValue");
		/*
		console.log(varType2);
		console.log(timeSpace2);
		console.log(startTime);
		console.log(endTime);
		*/
		drawLine2(ec1,name2,timeSpace2,startTime,endTime);
	}
}

function nextPage(url,name,next){
	var page=$("#main #chart_div").attr("page");
	if(next==1)
		page++;
	else if(next==-1)
		page--;
	$("#main #chart_div").attr("page",page);
	initVarChangeLine(ec1,url,page,row,"line_div",name);
}

function nextPage2(url,name,next){
	var page=$("#main2 #avgChart_div").attr("page");
	if(next==1)
		page++;
	else if(next==-1)
		page--;
	$("#main2 #avgChart_div").attr("page",page);
	var timeSpace2=timeSpaceCbb2.combobox("getValue");
	var startTime=startTimeDTB.datetimebox("getValue");
	var endTime=endTimeDTB.datetimebox("getValue");
	var otherParam={timeSpace:timeSpace2,startTime:startTime,endTime:endTime};
	initVarChangeLine(ec1,url,page,row,"avgLine_div",name,otherParam);
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
	var name2=insertArrCbb2.combobox("getValue");
	var timeSpace2=timeSpaceCbb2.combobox("getValue");
	var startTime=startTimeDTB.datetimebox("getValue");
	var endTime=endTimeDTB.datetimebox("getValue");
	//console.log(varType2);
	//console.log(timeSpace2);
	//console.log(startTime);
	//console.log(endTime);
	drawLine2(ec1,name2,timeSpace2,startTime,endTime);
}
</script>
</body>
</html>