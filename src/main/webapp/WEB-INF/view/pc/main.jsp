<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<jsp:include page="../inc/echarts.jsp"></jsp:include>
<%@include file="../inc/reportJs.jsp"%>
<script type="text/javascript">
$(function(){
	initVarTab();
	initVarDiv();
	initLineDiv();
});

function initLineDiv(){
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
					var data=$(this).combobox("getData");
					$(this).combobox("select",data[0].value);
					
					$(".combo").css("margin-top","10px");
					$(".combo").css("margin-left","50px");
					$(".combo .combo-text").css("color","#fff");
					$(".combo .combo-text").css("background-color","#1A4A8C");
					$(".combo .combo-text").css("font-size","18px");
					
					$(".combobox-item").css("height","40px");
					$(".combobox-item").css("line-height","40px");
					$(".combobox-item").css("font-size","18px");
					$(".combobox-item").css("color","#fff");
					$(".combobox-item").css("background-color","#1A4A8C");

					setInterval(function(){
					  	var page=$("#lineMain_div #chart_div").attr("page");
						refreshData(insertArrCbb,page);
					},3000,1000);
				}
			});
		}
	,"json");
}

var page=1;
var row=100;
var ec1;
var myChart;
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
	var lineMainDiv=$("#lineMain_div");
	$("#lineMain_div #chart_div").remove();
	page=1;
	lineMainDiv.append("<div id=\"chart_div\" name=\""+name+"\" page=\""+page+"\" style=\"margin-top:10px;\"></div>");
   	$("#chart_div").append("<div>"
   			+"<div style=\"width: 100px;height: 40px;line-height: 40px;color:#fff;font-size:20px;text-align:center;margin-left:50px; background-color: #1A4A8C;cursor: pointer;\" onclick=\"nextPage('"+url1+"','"+name+"',-1)\" onmouseover=\"changePageDiv(this,1);\" onmouseout=\"changePageDiv(this,0);\">上一页</div>"
   			+"<div style=\"width: 100px;height: 40px;line-height: 40px;color:#fff;font-size:20px;text-align:center;margin-top:-40px;margin-left:155px; background-color: #1A4A8C;cursor: pointer;\" onclick=\"nextPage('"+url1+"','"+name+"',1)\" onmouseover=\"changePageDiv(this,1);\" onmouseout=\"changePageDiv(this,0);\">下一页</div>"
   			+"</div>");
   	$("#chart_div").append("<div id=\"line_div\" style=\"height:400px;\"></div>");
    initMainVarChangeLine(ec,url1,page,row,"line_div",name);
}

function initMainVarChangeLine(ec,url,page,row,chartDiv,name){
   	$.post(url,
   			{name:name,page:page,row:row},
  			function(data){
               myChart = ec.init(document.getElementById(chartDiv));
               option = {
               	    tooltip : {
               	        trigger: 'axis'
               	    },
               	    legend: {
               	        data:[name],
	               	    textStyle: {
	         				fontWeight: 'normal',              //标题颜色
	         				color: '#fff'
	         			},
               	    },
               	    toolbox: {
               	        show : true,
               	        feature : {
               	            mark : {show: true},
               	            dataView : {show: true, readOnly: false},
               	            magicType : {show: true, type: ['line', 'bar', 'stack', 'tiled']},
               	            restore : {show: true},
               	            saveAsImage : {show: true}
               	        }
               	    },
               	    calculable : true,
               	    xAxis : [
               	        {
               	        	splitLine:{show:false},//去除网格线
               	            type : 'category',
               	            boundaryGap : false,
               	            //data : ['周一','周二','周三','周四','周五','周六','周日']
               	            data : data["createTimeList"],
	               	        axisLabel: {
	                            show: true,
	                            textStyle: {
	                                color: '#fff'
	                            }
	                        }
               	        }
               	    ],
               	    yAxis : [
               	        {
               	        	splitLine:{show:false},//去除网格线
               	            type : 'value',
	               	        axisLabel: {
	                            show: true,
	                            textStyle: {
	                                color: '#fff'
	                            }
	                        }
               	        }
               	    ],
               	    /*
               	    series : [
               	        {
               	            name:'压强',
               	            type:'line',
               	            stack: '总量',
               	            //data:[120, 132, 101, 134, 90, 230, 210]
               	        	data:data[valueList]
               	        }
               	    ]
               	    */
               	    series : [
               	        {
               	        	symbol:"none",
               	            name:name,
               	            type:'line',
               	         	smooth: true,
               	            stack: '总量',
               	        	data:data["valueList"],
               	        	itemStyle: {
                                normal: {
                                    color: '#6cb041',
                                    lineStyle:{
                                        width:1//设置线条粗细
                                    }
                                }
                            }
               	        },
               	        {
               	        	symbol:"none",
               	            name:"上限报警",
               	            type:'line',
               	         	smooth: true,
               	            stack: '上限',
               	        	data:data["upLimitList"],
               	        	itemStyle: {
                                normal: {
                                    color: '#f00',
                                    lineStyle:{
                                        width:1//设置线条粗细
                                    }
                                }
                            }
               	        },
               	        {
               	        	symbol:"none",
               	            name:"下限报警",
               	            type:'line',
               	         	smooth: true,
               	            stack: '下限',
               	        	data:data["downLimitList"],
               	        	itemStyle: {
                                normal: {
                                    color: '#f00',
                                    lineStyle:{
                                        width:1//设置线条粗细
                                    }
                                }
                            }
               	        }
               	    ]
               	};
               myChart.setOption(option);
               
               if(data["listSize"]>30)
               	document.getElementById(chartDiv).style.width = data["listSize"]*15+'px';
               myChart.resize();//直接加这句即可
               myChart.setOption(option,true);
   		}
   	,"json");
}

function nextPage(url,name,next){
	var page=$("#lineMain_div #chart_div").attr("page");
	if(next==1)
		page++;
	else if(next==-1)
		page--;
	$("#lineMain_div #chart_div").attr("page",page);
	initMainVarChangeLine(ec1,url,page,row,"line_div",name);
}

var wrTotal=0;
function initVarTab(){
	warnRecTab=$("#warnRec_tab").datagrid({
		title:"报警记录",
		url:"selectWarnRecordReportData",
		//pagination:true,
		pageSize:10,
		columns:[[
			{field:"rowNumber",title:"序号"},
			{field:"name",title:"记录点",width:150},
            {field:"value",title:"数值",width:80},
            {field:"state",title:"状态",width:100,formatter:function(value,row){
            	var str;
            	if(value==0)
            		str="正常";
            	else if(value==1)
            		str="上限报警";
            	else if(value==2)
            		str="下限报警";
            	return str;
	        }},
			{field:"createTime",title:"时间",width:180}
	    ]],
        onLoadSuccess:function(data){
        	wrTotal=data.total;
			if(data.total==0){
				$(this).datagrid("appendRow",{rowNumber:"<div style=\"text-align:center;\">暂无数据<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"rowNumber",colspan:5});
				data.total=0;
			}

			//$(".panel-header").css("background","linear-gradient(to bottom,#092378 0,#092378 20%)");
			$(".panel-header").css("background","rgba(8,51,94,0.5)");
			$(".datagrid-header").css("border-color","#092378");
			$(".datagrid-header-inner").css("background-color","#092378");
			$(".datagrid-header-inner .datagrid-header-row").css("color","#fff");
			$(".panel-header .panel-title").css("color","#fff");
			$(".panel-header .panel-title").css("font-size","15px");
			$(".panel-header .panel-title").css("padding-left","10px");
			$(".panel-header, .panel-body").css("border-color","#092378");
			$(".datagrid-body").css("background-color","#092378");
			$(".datagrid-row").css("color","#fff");
			$(".datagrid-body td").css("border-bottom-color","#fff");
			$(".datagrid-header td").css("border-width","0 0px 1px 0");
			$(".datagrid-body td").css("border-width","0 0px 1px 0");
			$(".datagrid-row td").css("border-bottom","0.05vw rgba(255, 255, 255, 0.3) solid");
			//$(".datagrid-pager").css("color","#fff");
			//$(".datagrid-pager").css("background-color","#092378");
		},
		rowStyler: function(index, row) {
	        return 'background-color:rgba(8,51,94,0.5);';
	    }
	});
	setInterval("updateWarnRecord()",10000,1000);
}

function updateWarnRecord(){
	$.post("updateWarnRecord",
		function(data){
			//console.log(data.message+","+wrTotal);
			if(wrTotal>0||data.message=="ok"){
				warnRecTab.datagrid("reload");
			}
		}
	,"json");
}

function initVarDiv(){
	showVarLabel("除氧器频率2",586,18);
	showVarLabel("除氧器频率1",586,42);
	showVarLabel("除氧器液位",586,64);
	showVarLabel("除氧器温度",586,88);
	showVarLabel("上水泵频率1",123,92);
	showVarLabel("上水泵频率2",123,236);
	showVarLabel("水泵上水流量",397,96);
	showVarLabel("饱和蒸汽压力",749,131);
	showVarLabel("过热蒸汽压力",973,72);
	showVarLabel("过热蒸汽温度",1106,72);
	showVarLabel("蒸汽流量计",1263,94);
	showVarLabel("引风机频率",990,268);
	showVarLabel("鼓风机频率",358,317);
	showVarLabel("二次风频率",123,365);
	showVarLabel("三次风频率1",1270,365);
	showVarLabel("三次风频率2",1270,338);


	showVarLabel("风室压力",241,539);
	showVarLabel("三次风室压力1",241,573);
	showVarLabel("三次风室压力2",241,604);
	showVarLabel("炉膛差压",241,636);
	showVarLabel("料层差压",241,667);
	
	showVarLabel("含氧量表",585,539);
	showVarLabel("给煤频率1",585,571);
	showVarLabel("给煤频率2",585,604);
	showVarLabel("给煤频率3",585,637);
	
	showVarLabel("床体温度1",910,539);
	showVarLabel("床体温度2",910,571);
	showVarLabel("床体温度3",910,602);
	showVarLabel("床体温度4",910,633);
	
	showVarLabel("旋风分离器温度1",1270,539);
	showVarLabel("旋风分离器温度2",1270,571);
	showVarLabel("锅炉出口温度",1270,601);
	
	setInterval("updateVarLabel()",5000,1000);
}

function updateVarLabel(){
	$.post("updateCurrentVarValue",
		function(data){
			if(data.message=="ok"){
				console.log(data.message);
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
		window.open("goVarChangeReport?device=pc");
	}
	else if(flag==3){
		/*
		$("#iframe1").css("display","none");
		$("#iframe2").css("display","none");
		$("#iframe3").css("display","block");
		window.open("goWarnRecord");
		*/
	}
	else if(flag==4){
		window.open("goWarnHistoryRecord?device=pc");
	}
}

function showVarLabel(name,left,top){
	$("span[name='"+name+"']").css("margin-left",left+"px");
	$("span[name='"+name+"']").css("margin-top",top+"px");
}

function changeNavDiv(o,flag){
	if(flag==1)
		$(o).css("background-color","#07345e");
	else
		$(o).css("background-color","");
}

function changePageDiv(o,flag){
	if(flag==1)
		$(o).css("background-color","#07345e");
	else
		$(o).css("background-color","#1a4a8c");
}
</script>
</head>
<body style="background-image: url('<%=basePath %>resource/image/002.png');background-size:100% 100%;">
<div style="color: #fff;height: 50px;line-height: 50px;">
	<span style="font-size: 28px;float: left;margin-left: 100px;color: #1CBFDE;">青岛蓝宝石锅炉物联网在线监测系统</span>
	<span style="font-size: 20px;float: right;margin-right: 100px;color: #1CBFDE;">青岛华凌科技有限公司承制研发</span>
</div>
<div style="border: 0.1vw solid;
    border-image: linear-gradient(90deg, rgba(231, 231, 231, 0) 0%,rgba(231, 231, 231, 0) 5%, rgba(231, 231, 231, 0.3) 30%, #ffffff 50%,rgba(231, 231, 231, 0.3) 70%, rgba(231, 231, 231, 0) 95%,rgba(231, 231, 231, 0) 100%) 10 1 stretch;
    border-left: none;
    border-right: none;
    border-bottom: none;background: -webkit-linear-gradient(left,rgba(11,68,124,0),rgba(11,68,124,1),rgba(11,68,124,0) );">
    <div style="width: 550px;height: 40px;margin: 0 auto;">
	<div class="pageNav" style="width: 100px;height: 40px;line-height: 40px;color:#fff;font-size:20px;text-align:center;cursor: pointer;" onclick="initIframe(1);" onmouseover="changeNavDiv(this,1);" onmouseout="changeNavDiv(this,0);">曲线查询</div>
	<div class="pageNav" style="width: 100px;height: 40px;line-height: 40px;color:#fff;font-size:20px;text-align:center;margin-top:-40px;margin-left:115px; cursor: pointer;" onclick="initIframe(2);"  onmouseover="changeNavDiv(this,1);" onmouseout="changeNavDiv(this,0);">报警记录</div>
	<!-- 
	<div class="pageNav" style="width: 100px;height: 40px;line-height: 40px;color:#fff;font-size:20px;text-align:center;margin-top:-40px;margin-left:230px;cursor: pointer;" onclick="initIframe(3);" onmouseover="changeNavDiv(this,1);" onmouseout="changeNavDiv(this,0);">报警</div>
	 -->
	<div class="pageNav" style="width: 100px;height: 40px;line-height: 40px;color:#fff;font-size:20px;text-align:center;margin-top:-40px;margin-left:230px;cursor: pointer;" onclick="initIframe(4);" onmouseover="changeNavDiv(this,1);" onmouseout="changeNavDiv(this,0);">历史报警</div>
	</div>
</div>
<div style="width: 600px;height: 1350px;margin-top: 10px;background-color: rgba(8,51,94,0.5);border: 2px solid;border-image: linear-gradient(120deg, #4d83b2 0%,#2377a7 40%,#00d6ff 50%,#2377a7 60%,#4d83b2 100%) 10 1 stretch;">
	<table id="warnRec_tab">
	</table>
</div>
<div style="margin-top:-1350px;margin-left:600px;">
	<div style="width:1454px;height:758px;margin-left:20px;background-color: rgba(8,51,94,0.5);border: 2px solid;border-image: linear-gradient(120deg, #4d83b2 0%,#2377a7 40%,#00d6ff 50%,#2377a7 60%,#4d83b2 100%) 10 1 stretch;">
		<div id="var_div" style="width:1454px;height:758px;background-image: url('<%=basePath %>resource/image/001.png');background-size:101% 101%;">
			<c:forEach items="${requestScope.varList }" var="item">
			<span name="${item.name }" style="position: absolute;">${item.value }</span>
			</c:forEach>
		</div>
	</div>
	<div id="lineMain_div" style="width:1454px;height:570px;margin-top: 10px;margin-left:20px;overflow:auto;background-color: rgba(8,51,94,0.5);border: 2px solid;border-image: linear-gradient(120deg, #4d83b2 0%,#2377a7 40%,#00d6ff 50%,#2377a7 60%,#4d83b2 100%) 10 1 stretch;">
    	<div style="color: #fff;font-size: 20px;padding-left: 20px;height: 40px;line-height: 40px;">实时曲线</div>
		<select id="insertArr_cbb"></select>
	</div>
</div>
<!-- 
<iframe id="iframe1" src="goVarChangeLine" style="width:100%;height: 800px;display: block;"></iframe>
<iframe id="iframe2" src="goVarChangeReport" style="width:800px;height: 800px;display: block;"></iframe>
<iframe id="iframe3" src="goWarnRecord" style="width:800px;height: 800px;display: block;"></iframe>
 -->
<!-- 
<iframe src="goWarnRecord" style="width:800px;height: 800px;"></iframe>
 -->
<body>
</body>
</html>