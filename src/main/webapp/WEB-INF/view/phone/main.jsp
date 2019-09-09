<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport">
<title>Insert title here</title>
<jsp:include page="../inc/echarts.jsp"></jsp:include>
<%@include file="../inc/reportJs.jsp"%>
<script type="text/javascript">
$(function(){
	initVarTab();
	initVarDiv();
});

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
	
	//setInterval("updateVarLabel()",5000,1000);
}

function showVarLabel(name,left,top){
	$("span[name='"+name+"']").css("margin-left",left+"px");
	$("span[name='"+name+"']").css("margin-top",top+"px");
}

function initVarTab(){
	warnRecTab=$("#warnRec_tab").datagrid({
		title:"报警记录",
		url:"selectWarnRecordReportData",
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
			{field:"createTime",title:"时间",width:170}
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
		},
		rowStyler: function(index, row) {
	        return 'background-color:rgba(8,51,94,0.5);';
	    }
	});
	//setInterval("updateWarnRecord()",10000,1000);
}
</script>
</head>
<body style="background-image: url('<%=basePath %>resource/image/002.png');background-size:100% 100%;">
<div style="width: 100%;margin-top: 10px;background-color: rgba(8,51,94,0.5);border: 2px solid;border-image: linear-gradient(120deg, #4d83b2 0%,#2377a7 40%,#00d6ff 50%,#2377a7 60%,#4d83b2 100%) 10 1 stretch;">
	<table id="warnRec_tab">
	</table>
</div>
	<div style="width:100%;margin-top:10px;background-color: rgba(8,51,94,0.5);border: 2px solid;border-image: linear-gradient(120deg, #4d83b2 0%,#2377a7 40%,#00d6ff 50%,#2377a7 60%,#4d83b2 100%) 10 1 stretch;">
		<div id="var_div" style="width:100%;height:758px;">
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:67px; color: #fff;font-size: 18px;">
				风室压力
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:83px; color: #000;padding-left: 10px;">aaa</div>
				<div style="margin-top: -25px;margin-left:150px;">Mpa</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:10px; color: #fff;font-size: 18px;">
				1#三次风室压力
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:140px; color: #000;padding-left: 10px;">aaa</div>
				<div style="margin-top: -25px;margin-left:207px;">Mpa</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:10px; color: #fff;font-size: 18px;">
				2#三次风室压力
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:140px; color: #000;padding-left: 10px;">aaa</div>
				<div style="margin-top: -25px;margin-left:207px;">Mpa</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:67px; color: #fff;font-size: 18px;">
				炉膛差压
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:83px; color: #000;padding-left: 10px;">aaa</div>
				<div style="margin-top: -25px;margin-left:150px;">Mpa</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:67px; color: #fff;font-size: 18px;">
				料层差压
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:83px; color: #000;padding-left: 10px;">aaa</div>
				<div style="margin-top: -25px;margin-left:150px;">Mpa</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:67px; color: #fff;font-size: 18px;">
				1#含氧量
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:83px; color: #000;padding-left: 10px;">aaa</div>
				<div style="margin-top: -25px;margin-left:150px;">%</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:47px; color: #fff;font-size: 18px;">
				1#给煤频率
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:103px; color: #000;padding-left: 10px;">aaa</div>
				<div style="margin-top: -25px;margin-left:170px;">HZ</div>
			</div>
			<c:forEach items="${requestScope.varList }" var="item">
			<span name="${item.name }" style="position: absolute;">${item.value }</span>
			</c:forEach>
		</div>
	</div>
</body>
</html>