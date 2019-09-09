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
	showVarLabel("除氧器频率2",155,11);
	showVarLabel("除氧器频率1",155,46);
	showVarLabel("除氧器液位",155,83);
	showVarLabel("除氧器温度",155,116);
	showVarLabel("上水泵频率1",155,153);
	showVarLabel("上水泵频率2",155,188);
	showVarLabel("水泵上水流量",155,223);
	showVarLabel("饱和蒸汽压力",155,257);
	showVarLabel("过热蒸汽压力",155,292);
	showVarLabel("过热蒸汽温度",155,326);
	showVarLabel("蒸汽流量计",155,363);
	showVarLabel("引风机频率",155,397);
	showVarLabel("鼓风机频率",155,432);
	showVarLabel("二次风频率",155,468);
	showVarLabel("三次风频率1",155,502);
	showVarLabel("三次风频率2",155,537);


	showVarLabel("风室压力",155,573);
	showVarLabel("三次风室压力1",155,607);
	showVarLabel("三次风室压力2",155,642);
	showVarLabel("炉膛差压",155,677);
	showVarLabel("料层差压",155,712);
	
	showVarLabel("含氧量表",155,747);
	showVarLabel("给煤频率1",155,782);
	showVarLabel("给煤频率2",155,816);
	showVarLabel("给煤频率3",155,852);
	
	showVarLabel("床体温度1",155,887);
	showVarLabel("床体温度2",155,922);
	showVarLabel("床体温度3",155,957);
	showVarLabel("床体温度4",155,992);
	
	showVarLabel("旋风分离器温度1",155,1028);
	showVarLabel("旋风分离器温度2",155,1062);
	showVarLabel("锅炉出口温度",155,1098);
	
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
		<c:forEach items="${requestScope.varList }" var="item">
		<span name="${item.name }" style="position: absolute;">${item.value }</span>
		</c:forEach>
		<div id="var_div" style="width:100%;">
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:26px; color: #fff;font-size: 18px;">
				除氧器2#频率
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:124px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:191px;">HZ</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:26px; color: #fff;font-size: 18px;">
				除氧器1#频率
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:124px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:191px;">HZ</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:47px; color: #fff;font-size: 18px;">
				除氧器液位
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:103px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:170px;">HZ</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:47px; color: #fff;font-size: 18px;">
				除氧器温度
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:103px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:170px;">HZ</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:26px; color: #fff;font-size: 18px;">
				1#上水泵频率
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:124px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:191px;">HZ</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:26px; color: #fff;font-size: 18px;">
				2#上水泵频率
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:124px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:191px;">HZ</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:33px; color: #fff;font-size: 18px;">
				水泵上水流量
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:117px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:184px;">L/S</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:33px; color: #fff;font-size: 18px;">
				饱和蒸汽压力
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:117px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:184px;">Mpa</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:33px; color: #fff;font-size: 18px;">
				过热蒸汽压力
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:117px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:184px;">Mpa</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:33px; color: #fff;font-size: 18px;">
				过热蒸汽温度
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:117px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:184px;">℃</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:47px; color: #fff;font-size: 18px;">
				蒸汽流量计
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:103px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:170px;">T/H</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:47px; color: #fff;font-size: 18px;">
				引风机频率
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:103px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:170px;">HZ</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:47px; color: #fff;font-size: 18px;">
				鼓风机频率
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:103px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:170px;">HZ</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:47px; color: #fff;font-size: 18px;">
				二次风频率
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:103px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:170px;">HZ</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:33px; color: #fff;font-size: 18px;">
				三次风频率1
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:117px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:184px;">HZ</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:33px; color: #fff;font-size: 18px;">
				三次风频率2
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:117px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:184px;">HZ</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:67px; color: #fff;font-size: 18px;">
				风室压力
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:83px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:150px;">Mpa</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:10px; color: #fff;font-size: 18px;">
				1#三次风室压力
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:140px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:207px;">Mpa</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:10px; color: #fff;font-size: 18px;">
				2#三次风室压力
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:140px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:207px;">Mpa</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:67px; color: #fff;font-size: 18px;">
				炉膛差压
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:83px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:150px;">Mpa</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:67px; color: #fff;font-size: 18px;">
				料层差压
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:83px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:150px;">Mpa</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:67px; color: #fff;font-size: 18px;">
				1#含氧量
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:83px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:150px;">%</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:47px; color: #fff;font-size: 18px;">
				1#给煤频率
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:103px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:170px;">HZ</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:47px; color: #fff;font-size: 18px;">
				2#给煤频率
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:103px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:170px;">HZ</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:47px; color: #fff;font-size: 18px;">
				3#给煤频率
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:103px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:170px;">HZ</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:47px; color: #fff;font-size: 18px;">
				1#床体温度
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:103px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:170px;">℃</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:47px; color: #fff;font-size: 18px;">
				2#床体温度
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:103px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:170px;">℃</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:47px; color: #fff;font-size: 18px;">
				3#床体温度
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:103px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:170px;">℃</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:47px; color: #fff;font-size: 18px;">
				4#床体温度
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:103px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:170px;">℃</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:33px; color: #fff;font-size: 18px;">
				右分离器温度
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:117px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:184px;">℃</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:33px; color: #fff;font-size: 18px;">
				左分离器温度
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:117px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:184px;">℃</div>
			</div>
			<div style="height: 25px;line-height: 25px;margin-top:10px;margin-left:33px; color: #fff;font-size: 18px;">
				锅炉出口温度
				<div style="background-color: #fff;width: 50px;height: 25px;line-height: 25px;margin-top:-25px;margin-left:117px; color: #000;padding-left: 10px;"></div>
				<div style="margin-top: -25px;margin-left:184px;">℃</div>
			</div>
		</div>
	</div>
</body>
</html>