package blueGemstone.websocket;

import java.net.URI;
import java.net.URISyntaxException;
import java.nio.channels.NotYetConnectedException;

import org.java_websocket.WebSocket;

//http://www.bejson.com/httputil/websocket/
public class MyTest {

	public static void main(String[] arg0){
		try {
			MyWebSocketClient myClient = new MyWebSocketClient(new URI("ws://iot.idosp.net:1288"));
			myClient.connect();
			while(!myClient.getReadyState().equals(WebSocket.READYSTATE.OPEN)){
				System.out.println(myClient.getReadyState());
				System.out.println("正在连接...");
		        }
		       //连接成功,发送信息
			//myClient.send("哈喽,连接一下啊");
			// 往websocket服务端发送数据
			myClient.send("{\"token\":\"mkrenbAMWyz9qI25Bsjo\",\"USER_ID\":\"300000495\",\"USER_TYPE\":\"1\"}");
			myClient.send("{\"BindReal\":[200002144]}");
			myClient.send("{\"Time\":1552017421,\"LTime\":1552017420,\"Type\":2,\"Ptid\":400000001,\"Did\":200002144,\"PtCycle\":270,\"Delay\":80,\"Message\":{\"K0\":0,\"K1\":0},\"ex\":\"ex_idosp_data\"}");
		} catch (NotYetConnectedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
