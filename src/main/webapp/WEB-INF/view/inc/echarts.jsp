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
<script src="<%=basePath %>resource/echarts-2.2.7/build/dist/echarts.js"></script>
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
require.config({
    paths: {
        echarts: '<%=basePath %>resource/echarts-2.2.7/build/dist'
    }
});

function initVarChangeLine(ec,url,page,row,chartDiv,name){
   	$.post(url,
   			{name:name,page:page,row:row},
  			function(data){
	   			//console.log(data.createTimeList);
	   			/*
  				var series=[];
  				for(var i=0;i<seriesArr.length;i++){
  					series.push({name:data[seriesArr[i].name],type:'line',stack: '总量',data:data[seriesArr[i].data]});
  				}
  	   			console.log(data);
  	   			*/
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
	         			}
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
</script>
</body>
</html>