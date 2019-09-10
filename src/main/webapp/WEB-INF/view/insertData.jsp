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
/*
$(function(){
	$.post("../main/insertVarChange",
		function(){
		
		}
	,"json");
	
	$.post("../main/insertVarAvgChange",
		function(){
		
		}
	,"json");
});
*/
</script>
<title>Insert title here</title>
</head>
<body>
<div id="message"></div>
 <script>

      var websocket = null;

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

          setMessageInnerHTML("WebSocket连接发生错误");

      };

      //连接成功建立的回调方法

      websocket.onopen = function () {

          setMessageInnerHTML("WebSocket连接成功");
          websocket.send("{\"token\":\"b25moj3VTFyL3eVo2F9g\",\"USER_ID\":\"300000495\",\"USER_TYPE\":\"1\"}");
          websocket.send("{\"BindReal\":[200002144]}");

      }

      //接收到消息的回调方法

      websocket.onmessage = function (event) {

          setMessageInnerHTML(event.data);

          if(event.data=="1"){

              location.reload();

          }

      }

      //连接关闭的回调方法

      websocket.onclose = function () {

          setMessageInnerHTML("WebSocket连接关闭");

      }

      //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。

      window.onbeforeunload = function () {

          closeWebSocket();

      }

      //将消息显示在网页上

      function setMessageInnerHTML(innerHTML) {

          document.getElementById('message').innerHTML += innerHTML + '<br/>';

      }

      //关闭WebSocket连接

      function closeWebSocket() {

          websocket.close();

      }

  </script>

</body>
</html>