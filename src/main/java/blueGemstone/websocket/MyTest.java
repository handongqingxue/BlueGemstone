package blueGemstone.websocket;

import java.net.URI;
import java.net.URISyntaxException;
import java.nio.channels.NotYetConnectedException;

public class MyTest {

	public static void main(String[] arg0){
		try {
			MyWebSocketClient myClient = new MyWebSocketClient(new URI("http://iot.idosp.net:83/"));
			// 往websocket服务端发送数据
			myClient.send("{\"token\":\"zaQKFYZCwGAGeCH7pV4c\",\"USER_ID\":\"910000706\",\"USER_TYPE\":\"1\"}");
		} catch (NotYetConnectedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
