<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<jsp:include page="inc/echarts.jsp"></jsp:include>
<%@include file="inc/reportJs.jsp"%>
<script type="text/javascript">
$(function(){
	initVarTab();
	initVarDiv();
	initLineDiv();
});

function initLineDiv(){
	$.post("selectInsertArrData",
		function(data){
			varTypeCbb=$("#varType_cbb").combobox({
				width:300,
				height:50,
				valueField:"value",
				textField:"text",
				data:data.rows,
				onSelect:function(){
					showLineDiv($(this).combobox("getValue"));
				},
				onLoadSuccess:function(){
					var data=$(this).combobox("getData");
					$(this).combobox("select",data[0].value);
					
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
}

function showLineDiv(name){
	var varNameJS=JSON.parse('${requestScope.varName}');
	for(var i=0;i<varNameJS.length;i++){
		$("#line_div div[name='"+varNameJS[i].name+"']").css("display","none");
	}
	$("#line_div div[name='"+name+"']").css("display","block");
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
    	var varNameJS=JSON.parse('${requestScope.varName}');
    	var url1="selectVarChangeLineData";
    	var lineDiv=$("#line_div");
    	for(var i=0;i<varNameJS.length;i++){
        	lineDiv.append("<div name=\""+varNameJS[i].name+"\" style=\"margin-top:10px;\"></div>");
	    	$("div[name='"+varNameJS[i].name+"']").append("<div>"
	    			+"<div style=\"width: 100px;height: 40px;line-height: 40px;color:#fff;font-size:20px;text-align:center;margin-left:50px; background-color: #1A4A8C;cursor: pointer;\" onclick=\"nextPage('"+url1+"','"+varNameJS[i].name+"',"+i+",-1)\">上一页</div>"
	    			+"<div style=\"width: 100px;height: 40px;line-height: 40px;color:#fff;font-size:20px;text-align:center;margin-top:-40px;margin-left:155px; background-color: #1A4A8C;cursor: pointer;\" onclick=\"nextPage('"+url1+"','"+varNameJS[i].name+"',"+i+",1)\">下一页</div>"
	    			+"</div>");
	    	$("div[name='"+varNameJS[i].name+"']").append("<div page=\""+page+"\" id=\"chart_div"+(i+1)+"\" style=\"height:400px;\"></div>");
		    initMainVarChangeLine(ec,url1,page,row,"chart_div"+(i+1),varNameJS[i].name);
    	}
		showLineDiv(varTypeCbb.combobox("getValue"));
    }
);

function initMainVarChangeLine(ec,url,page,row,chartDiv,name){
   	$.post(url,
   			{name:name,page:page,row:row},
  			function(data){
               var myChart = ec.init(document.getElementById(chartDiv));
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

function nextPage(url,name,i,next){
	var page=$("#line_div #chart_div"+(i+1)).attr("page");
	if(next==1)
		page++;
	else if(next==-1)
		page--;
	$("#line_div #chart_div"+(i+1)).attr("page",page);
	initMainVarChangeLine(ec1,url,page,row,"chart_div"+(i+1),name);
}

function initVarTab(){
	warnRecTab=$("#warnRec_tab").datagrid({
		title:"报警记录",
		url:"selectWarnRecordReportData",
		toolbar:"#toolbar",
		height:960,
		//pagination:true,
		pageSize:10,
		columns:[[
			{field:"id",title:"序号",formatter:function(value,row,index){
	            return index;
	        }},
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
			if(data.total==0){
				$(this).datagrid("appendRow",{id:"<div style=\"text-align:center;\">暂无数据<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"id",colspan:5});
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
		}
	});
	//setInterval("updateWarnRecord()",10000,1000);
}

function updateWarnRecord(){
	$.post("updateWarnRecord",
		function(data){
			console.log(data.message);
			if(data.message=="ok"){
				warnRecTab.datagrid("reload");
			}
		}
	,"json");
}

function initVarDiv(){
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
}

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

function changeNavDiv(o,flag){
	if(flag==1)
		$(o).css("background-color","#07345e");
	else
		$(o).css("background-color","");
}
</script>
</head>
<body style="background-image: url('<%=basePath %>resource/image/002.png');background-size:100% 100%;">
<div style="color: #fff;height: 50px;line-height: 50px;border-bottom: #fff solid 1px;">
	<span style="font-size: 20px;float: right;margin-right: 100px;color: #1CBFDE;">青岛蓝宝石酒业有限公司</span>
</div>
<div style="margin-left:50px;border: 0.1vw solid;
    border-image: linear-gradient(90deg, rgba(231, 231, 231, 0) 0%,rgba(231, 231, 231, 0) 5%, rgba(231, 231, 231, 0.3) 30%, #ffffff 50%,rgba(231, 231, 231, 0.3) 70%, rgba(231, 231, 231, 0) 95%,rgba(231, 231, 231, 0) 100%) 10 1 stretch;
    border-left: none;
    border-right: none;
    border-bottom: none;background: -webkit-linear-gradient(left,rgba(11,68,124,0),rgba(11,68,124,1),rgba(11,68,124,0) );">
    <div style="width: 550px;height: 40px;margin: 0 auto;">
	<div class="pageNav" style="width: 100px;height: 40px;line-height: 40px;color:#fff;font-size:20px;text-align:center;cursor: pointer;" onclick="initIframe(1);" onmouseover="changeNavDiv(this,1);" onmouseout="changeNavDiv(this,0);">曲线</div>
	<div class="pageNav" style="width: 100px;height: 40px;line-height: 40px;color:#fff;font-size:20px;text-align:center;margin-top:-40px;margin-left:115px; cursor: pointer;" onclick="initIframe(2);"  onmouseover="changeNavDiv(this,1);" onmouseout="changeNavDiv(this,0);">报表</div>
	<div class="pageNav" style="width: 100px;height: 40px;line-height: 40px;color:#fff;font-size:20px;text-align:center;margin-top:-40px;margin-left:230px;cursor: pointer;" onclick="initIframe(3);" onmouseover="changeNavDiv(this,1);" onmouseout="changeNavDiv(this,0);">报警</div>
	<div class="pageNav" style="width: 200px;height: 40px;line-height: 40px;color:#fff;font-size:20px;text-align:center;margin-top:-40px;margin-left:345px;cursor: pointer;" onclick="initIframe(4);" onmouseover="changeNavDiv(this,1);" onmouseout="changeNavDiv(this,0);">历史报警记录</div>
	</div>
</div>
<div style="width: 600px;height: 1000px;margin-top: 10px;background-color: rgba(8,51,94,0.5);border: 2px solid;border-image: linear-gradient(120deg, #4d83b2 0%,#2377a7 40%,#00d6ff 50%,#2377a7 60%,#4d83b2 100%) 10 1 stretch;">
	<table id="warnRec_tab">
	</table>
</div>
<div style="margin-top:-1000px;margin-left:600px;">
	<div style="margin-left:20px;width:1024px;height:768px;background-color: rgba(8,51,94,0.5);border: 2px solid;border-image: linear-gradient(120deg, #4d83b2 0%,#2377a7 40%,#00d6ff 50%,#2377a7 60%,#4d83b2 100%) 10 1 stretch;">
		<div id="var_div" style="width:1024px;height:768px;background-image: url('<%=basePath %>resource/image/001.png');background-size:101% 101%;">
			<c:forEach items="${requestScope.varList }" var="item">
			<span name="${item.name }" style="position: absolute;">${item.value }</span>
			</c:forEach>
		</div>
	</div>
	<div id="line_div" style="height:550px;margin-top: 10px;margin-left:20px;overflow:auto;background-color: rgba(8,51,94,0.5);border: 2px solid;border-image: linear-gradient(120deg, #4d83b2 0%,#2377a7 40%,#00d6ff 50%,#2377a7 60%,#4d83b2 100%) 10 1 stretch;">
		<select id="varType_cbb"></select>
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