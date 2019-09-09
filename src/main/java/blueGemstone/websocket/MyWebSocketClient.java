package blueGemstone.websocket;

import java.net.URI;
//import org.activiti.engine.impl.util.json.JSONObject;
import org.apache.log4j.Logger;
import org.java_websocket.client.WebSocketClient;
import org.java_websocket.handshake.ServerHandshake;

public class MyWebSocketClient extends WebSocketClient {

	Logger logger = Logger.getLogger(MyWebSocketClient.class);
	 
	public MyWebSocketClient(URI serverUri) {super(serverUri);}
	
	@Override
	public void onOpen(ServerHandshake arg0) {
		// TODO Auto-generated method stub
		logger.info("------ MyWebSocket onOpen ------");
		System.out.println("------ MyWebSocket onOpen ------");
	}
	
	@Override
	public void onClose(int arg0, String arg1, boolean arg2) {
		// TODO Auto-generated method stub
		logger.info("------ MyWebSocket onClose ------");
		System.out.println("------ MyWebSocket onClose ------");
	}
	
	@Override
	public void onError(Exception arg0) {
		// TODO Auto-generated method stub
		logger.info("------ MyWebSocket onError ------");
		System.out.println("------ MyWebSocket onError ------");
	}
	
	@Override
	public void onMessage(String arg0) {
		// TODO Auto-generated method stub
		logger.info("-------- ���յ���������ݣ� " + arg0 + "--------");
		System.out.println("-------- ���յ���������ݣ� " + arg0 + "--------");
	}
}
