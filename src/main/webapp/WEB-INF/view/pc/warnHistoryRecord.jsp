<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@include file="../inc/reportJs.jsp"%>
<script type="text/javascript">
var path='<%=basePath %>';
$(function(){
	$.post("selectInsertArrData",
		function(data){
			nameCbb=$("#name_cbb").combobox({
				width:300,
				height:40,
				valueField:"value",
				textField:"text",
				data:data.rows,
				onLoadSuccess:function(){
					var data=$(this).combobox("getData");
					$(this).combobox("select",data[0].value);
					
					$(".combo").css("margin-top","-5px");
					$(".combo").css("margin-left","10px");
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
	
	tab1=$("#tab1").datagrid({
		title:"报警历史记录报表",
		url:"selectWarnHistoryRecordReportData",
		toolbar:"#toolbar",
		pagination:true,
		pageSize:50,
		columns:[[
			{field:"rowNumber",title:"序号"},
			{field:"name",title:"记录点",width:200},
            {field:"value",title:"数值",width:200},
            {field:"state",title:"状态",width:200,formatter:function(value,row){
            	var str;
            	if(value==0)
            		str="正常";
            	else if(value==1)
            		str="上限报警";
            	else if(value==2)
            		str="下限报警";
            	return str;
	        }},
			{field:"createTime",title:"时间",width:200}
	    ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{rowNumber:"<div style=\"text-align:center;\">暂无数据<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"rowNumber",colspan:5});
				data.total=0;
			}
			
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
		}
	});
});

function changeButDiv(o,flag){
	if(flag==1)
		$(o).css("background-color","#00f");
	else
		$(o).css("background-color","#1A4A8C");
}

function searchByName(){
	var name=nameCbb.combobox("getValue");
	tab1.datagrid("reload",{"name":name});
}
</script>
</head>
<body style="background-image: url('<%=basePath %>resource/image/002.png');background-size:100% 100%;">
<div style="width:99%; background-color: rgba(8,51,94,0.5);border: 2px solid;border-image: linear-gradient(120deg, #4d83b2 0%,#2377a7 40%,#00d6ff 50%,#2377a7 60%,#4d83b2 100%) 10 1 stretch;">
	<div id="toolbar" style="height:60px;line-height:60px;background-color: rgb(9, 35, 120);">
		<span style="color: #fff;font-size:20px;margin-left:10px;">记录点：</span>
		<select id="name_cbb"></select>
		 <div style="width: 80px;height: 40px;line-height: 40px;margin-top:-52px;margin-left:420px;color:#fff;font-size:20px;text-align:center; background-color: #1A4A8C;cursor: pointer;border: 0.05vw solid rgba(255,255,255,0.3);border-radius:3px;" onclick="searchByName();" onmouseover="changeButDiv(this,1);" onmouseout="changeButDiv(this,0);">查询</div>
	</div>
	<table id="tab1">
	</table>
</div>
</body>
</html>