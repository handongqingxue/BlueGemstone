<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@include file="inc/reportJs.jsp"%>
<script type="text/javascript">
var path='<%=basePath %>';
$(function(){
	tab1=$("#tab1").datagrid({
		title:"报警记录报表",
		url:"selectWarnRecordReportData",
		pagination:true,
		pageSize:10,
		columns:[[
			{field:"createTime",title:"时间",width:200},
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
	        }}
	    ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{createTime:"<div style=\"text-align:center;\">暂无数据<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"createTime",colspan:3});
				data.total=0;
			}
		}
	});
});
</script>
</head>
<body>
<table id="tab1">
</table>
</body>
</html>