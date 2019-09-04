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
				width:200,
				valueField:"value",
				textField:"text",
				data:data.rows,
				onSelect:function(){
					showLineDiv($(this).combobox("getValue"));
				},
				onLoadSuccess:function(){
					var data=$(this).combobox("getData");
					$(this).combobox("select",data[0].value);
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
        	lineDiv.append("<div name=\""+varNameJS[i].name+"\"></div>");
	    	$("div[name='"+varNameJS[i].name+"']").append("<div>"
	    			+"<input type=\"button\" value=\"上一页\" onclick=\"nextPage('"+url1+"','"+varNameJS[i].name+"',"+i+",-1)\"/>"
	    			+"<input type=\"button\" value=\"下一页\" onclick=\"nextPage('"+url1+"','"+varNameJS[i].name+"',"+i+",1)\"/>"
	    			+"</div>");
	    	$("div[name='"+varNameJS[i].name+"']").append("<div page=\""+page+"\" id=\"chart_div"+(i+1)+"\" style=\"height:400px;\"></div>");
		    initVarChangeLine(ec,url1,page,row,"chart_div"+(i+1),varNameJS[i].name);
    	}
		showLineDiv(varTypeCbb.combobox("getValue"));
    }
);

function nextPage(url,name,i,next){
	var page=$("#line_div #chart_div"+(i+1)).attr("page");
	if(next==1)
		page++;
	else if(next==-1)
		page--;
	$("#line_div #chart_div"+(i+1)).attr("page",page);
	initVarChangeLine(ec1,url,page,row,"chart_div"+(i+1),name);
}

function initVarTab(){
	warnRecTab=$("#warnRec_tab").datagrid({
		title:"报警记录",
		url:"selectWarnRecordReportData",
		toolbar:"#toolbar",
		height:960,
		pagination:true,
		pageSize:10,
		columns:[[
			{field:"id",title:"序号",formatter:function(value,row,index){
	            return index;
	        }},
			{field:"name",title:"记录点",width:150},
			{field:"createTime",title:"时间",width:180},
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
	        }}
	    ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{id:"<div style=\"text-align:center;\">暂无数据<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"id",colspan:5});
				data.total=0;
			}
		}
	});
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
</script>
</head>
<body style="background-color: #092378;">
<div>青岛蓝宝石酒业有限公司</div>
<div style="width: 600px;height: 1000px;">
	<table id="warnRec_tab">
	</table>
</div>
<div style="margin-top:-1000px;margin-left:600px;">
	<div>
		<input type="button" value="曲线" onclick="initIframe(1);"/>
		<input type="button" value="报表" onclick="initIframe(2);"/>
		<input type="button" value="报警" onclick="initIframe(3);"/>
		<input type="button" value="历史报警记录" onclick="initIframe(4);"/>
	</div>
	<div id="var_div" style="width:1024px;height:768px;background-image: url('<%=basePath %>resource/image/001.png');background-size:100% 100%;">
		<c:forEach items="${requestScope.varList }" var="item">
		<span name="${item.name }" style="position: absolute;">${item.value }</span>
		</c:forEach>
	</div>
	<div id="line_div" style="width:100%;height:450px;overflow:auto;">
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