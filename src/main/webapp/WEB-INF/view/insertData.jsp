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
<script type="text/javascript">
var websocket = null;

//关闭WebSocket连接
function closeWebSocket() {
	websocket.close();
}

$(function(){
	//setTimeout("initWebSocket()",3000);
	setInterval(function(){
	  var pushData="{\"Time\":1568169413,\"LTime\":1568169412,\"Type\":2,\"Ptid\":400015400,\"Did\":200002144,\"PtCycle\":70,\"Delay\":120,\"Message\":{\"K0\":0,\"K1\":72.340000000000003,\"K2\":0,\"K3\":0,\"K4\":0,\"K5\":0,\"K6\":0,\"K7\":0,\"K8\":0,\"K9\":0,\"K10\":0,\"K11\":135.58000000000001,\"K12\":0,\"K13\":0,\"K14\":0,\"K15\":0,\"K16\":0,\"K17\":0,\"K18\":0,\"K19\":0,\"K20\":0,\"K21\":0,\"K22\":0,\"K23\":0,\"K24\":123.27,\"K25\":0,\"K26\":0,\"K27\":0,\"K28\":0,\"K29\":0,\"K30\":0,\"K31\":0,\"K32\":0,\"K33\":-897201488265216,\"K34\":0,\"K35\":0,\"K36\":0,\"K37\":0,\"K38\":0,\"K39\":0,\"K40\":0,\"K41\":0,\"K42\":0,\"K43\":0,\"K44\":0,\"K45\":0,\"K46\":0,\"K47\":0,\"K48\":0,\"K49\":0,\"K50\":0,\"K51\":0,\"K52\":0,\"K53\":0,\"K54\":110.09999999999999,\"K55\":0,\"K56\":0,\"K57\":0,\"K58\":0,\"K59\":0,\"K60\":0,\"K61\":0,\"K62\":0,\"K63\":0,\"K64\":0,\"K65\":0,\"K66\":0,\"K67\":0,\"K68\":0,\"K69\":0,\"K70\":0,\"K71\":0,\"K72\":0,\"K73\":0,\"K74\":0,\"K75\":0,\"K76\":0,\"K77\":0,\"K78\":0,\"K79\":0,\"K80\":100.09999999999999,\"K81\":0,\"K82\":0,\"K83\":0,\"K84\":0,\"K85\":0,\"K86\":0,\"K87\":0,\"K88\":0,\"K89\":0,\"K90\":0,\"K91\":0,\"K92\":0,\"K93\":0,\"K94\":0,\"K95\":0},\"ex\":\"ex_idosp_data\"}";
	  $.post("insertVarChange",
		{pushData:pushData},
	    function(){
		  
	  	}
	  ,"json");
	},5000,1000);
	//每十分钟计算一次平均值，间隔不同，为了方便查询历史记录
	setInterval(function(){
		insertVarAvgChange(1);
	},10*60*1000,1000);
	//每两小时计算一次平均值
	setInterval(function(){
		insertVarAvgChange(2);
	},2*60*60*1000,1000);
});

function insertVarAvgChange(timeFlag){
	$.post("insertVarAvgChange",
	  {timeFlag:timeFlag},
	  function(){
		  
	  }
	,"json");
}

function initWebSocket(){
	//判断当前浏览器是否支持WebSocket

	if ('WebSocket' in window) {

	//建立连接，这里的/websocket ，是ManagerServlet中开头注解中的那个值

	  websocket = new WebSocket("ws://iot.idosp.net:1288");

	}

	else {

	  alert('当前浏览器 Not support websocket')

	}

	//连接发生错误的回调方法

	websocket.onerror = function () {

	  console.log("WebSocket连接发生错误");

	};

	//连接成功建立的回调方法

	websocket.onopen = function () {

	  console.log("WebSocket连接成功");
	  //var token='KXkItH3vzt6nRN7THv3Q';
	  var token='${sessionScope.token}';
	  //要是token为空，则需要先查询之前用户的登录信息；若用户从未登录过，则需要登录
	  if(token==""){
		  selectLoginData();
	  }
	  else{
		  //console.log(token);
		  //var jsonMsg="{'token':'AJfLRy8hc0gBpomni0Ki','USER_ID':'300000495','USER_TYPE':'1'}";
		  //jsonMsg=jsonMsg.replace(/'/g,'\\"');
	  	  var USER_ID='${sessionScope.USER_ID}';
	  	  var USER_TYPE='${sessionScope.USER_TYPE}';
		  websocket.send("{\"token\":\""+token+"\",\"USER_ID\":\""+USER_ID+"\",\"USER_TYPE\":\""+USER_TYPE+"\"}");
		  websocket.send("{\"BindReal\":[200002144]}");
	  }

	}

	//接收到消息的回调方法

	websocket.onmessage = function (event) {

	  //console.log(event.data);
	  
	  var jsonData=JSON.parse(event.data);
	  if(jsonData.Result==101){//与websocket进行握手后，返回结果数据。若返回的结果是101，说明还未登录，必须登录后再次刷新页面，重新websocket握手，成功了才能收到服务器那边的推送
		  login();
	  }
	  else if(jsonData.ex=="ex_idosp_data"){//握手成功后，就能一直收到服务器的推送了，再把思普云平台推送的数据插入到数据库表里
		  var pushData=JSON.stringify(event.data);
		  $.post("insertVarChange",
			{pushData:pushData.substring(1,pushData.length-1)},
		    function(){
			  
		  	}
		  ,"json");

	  }
	}

	//连接关闭的回调方法

	websocket.onclose = function () {

	  console.log("WebSocket连接关闭");

	}

	//监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。

	window.onbeforeunload = function () {

	  closeWebSocket();

	}
}

//查询用户信息
function selectLoginData(){
	$.post("selectLoginData",
		{name:"13792816022"},
		function(data){
			if(data.message=="ok")
				location.href=location.href;
			else//无信息的话，需要登录
				login();
		}
	,"json");
}

//用户登录
function login(){
	$.post("getSiPuCloudAPIRespJson",
		{jsonParam:"{\"s\":\"App/User/Login\",\"USERNAME\":\"13792816022\",\"PASSWORD\":\"12345678\",\"remember\":\"1\"}"},
		function(result){
			if(result.ret==200){
				//登录成功后，保存用户信息
				$.post("saveUser",
					{USER_ID:result.data.USER_ID,NAME:"13792816022",USER_TYPE:result.data.USER_TYPE,token:result.data.token},
					function(data){
						if(data.message=="ok")
							location.href=location.href;
					}
				,"json");
			}
		}
	,"json");
}
</script>
<title>Insert title here</title>
</head>
<body>
</body>
</html>