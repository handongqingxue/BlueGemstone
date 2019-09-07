package blueGemstone.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

public class SiPuCloudAPI {
	
	private static final String URL="http://iot.idosp.net:83/";

	public static Map<String, Object> getRespJson(List<NameValuePair> params) throws Exception {
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		// TODO Auto-generated method stub
		//POST��URL
		//����HttpPost����
		HttpPost httppost=new HttpPost(URL);
		//��Ӳ���
		if(params!=null)
			httppost.setEntity(new UrlEncodedFormEntity(params,HTTP.UTF_8));
		//���ñ���
		HttpResponse response=new DefaultHttpClient().execute(httppost);
		//����Post,������һ��HttpResponse����
		if(response.getStatusLine().getStatusCode()==200){//���״̬��Ϊ200,������������
			String result=EntityUtils.toString(response.getEntity());
			//�õ����ص��ַ���,��ӡ���
			System.out.println(result);
			Gson gson = new Gson();
			jsonMap = gson.fromJson(result, jsonMap.getClass());
		}
		return jsonMap;
	}
}
