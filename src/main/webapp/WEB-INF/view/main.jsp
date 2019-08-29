<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String basePath=request.getScheme()+"://"+request.getServerName()+":"
	+request.getServerPort()+request.getContextPath()+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<title>Insert title here</title>
</head>
<body>
<div id="main" style="width:800px;height:400px;overflow-x:auto;overflow-y:hidden;">
	<div id="chart_div" style="height:400px;"></div>
</div>
<script src="<%=basePath %>resource/echarts-2.2.7/build/dist/echarts.js"></script>
<script type="text/javascript">
    require.config({
        paths: {
            echarts: '<%=basePath %>resource/echarts-2.2.7/build/dist'
        }
    });
    require(
        [
            'echarts',
            'echarts/chart/line',   // 按需加载所需图表，如需动态类型切换功能，别忘了同时加载相应图表
            'echarts/chart/bar'
        ],
        function (ec) {
        	$.post("selectVarChangeLineData",
       			function(data){
        			console.log(data.message);
        			console.log(data.createTimeList);
                    var myChart = ec.init(document.getElementById('chart_div'));
                    option = {
                    	    tooltip : {
                    	        trigger: 'axis'
                    	    },
                    	    legend: {
                    	        data:['压强']
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
                    	            data : data.createTimeList
                    	        }
                    	    ],
                    	    yAxis : [
                    	        {
                    	            type : 'value'
                    	        }
                    	    ],
                    	    series : [
                    	        {
                    	            name:'压强',
                    	            type:'line',
                    	            stack: '总量',
                    	            //data:[120, 132, 101, 134, 90, 230, 210]
                    	        	data:data.valueList
                    	        }
                    	    ]
                    	};
                    myChart.setOption(option);
                    
                    document.getElementById('chart_div').style.width = data.listSize*5+'px';
                    myChart.resize();//直接加这句即可
                    myChart.setOption(option,true);
        		}
        	,"json");
        }
    );
</script>
</body>
</html>