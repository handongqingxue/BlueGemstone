package blueGemstone.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;

import blueGemstone.entity.VarAvgChange;
import blueGemstone.entity.VarChange;
import blueGemstone.entity.WarnHistoryRecord;
import blueGemstone.entity.WarnRecord;
import blueGemstone.service.PublicService;
import blueGemstone.util.Constant;
import blueGemstone.util.SiPuCloudAPI;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;

@Controller
@RequestMapping("/main")
public class MainController {
	
	@Autowired
	private PublicService publicService;
	
	/**
	 * 跳转至首页
	 * @param request
	 * @return
	 */
	@RequestMapping("/goMain")
	public String goMain(HttpServletRequest request) {
		
		List<Map<String, Object>> varList=publicService.getCurrentVarValueList();
		request.setAttribute("varList", varList);
		
		StringBuffer sb=new StringBuffer();
		sb.append("[");
		for(int i=0;i<Constant.INSERT_ARR.length;i++) {
			sb.append("{\"name\":\""+Constant.INSERT_ARR[i]+"\"}");
			if(i<Constant.INSERT_ARR.length-1)
				sb.append(",");
		}
		sb.append("]");

		request.setAttribute("varName", sb.toString());
		
		return "main";
	}
	
	/**
	 * 更新当前的变量值
	 * @return
	 */
	@RequestMapping("/updateCurrentVarValue")
	@ResponseBody
	public Map<String,Object> updateCurrentVarValue() {
		
		Map<String,Object> jsonMap=new HashMap<>();
		
		List<Map<String, Object>> varList=publicService.getCurrentVarValueList();
		
		jsonMap.put("message", "ok");
		jsonMap.put("varList", varList);
		
		return jsonMap;
	}
	
	/**
	 * 跳转至变量变化曲线页面
	 * @param request
	 * @return
	 */
	@RequestMapping("/goVarChangeLine")
	public String goVarChange(HttpServletRequest request) {
		
		StringBuffer sb=new StringBuffer();
		sb.append("[");
		for(int i=0;i<Constant.VAR_TYPE.length;i++) {
			sb.append("{\"name\":\""+Constant.VAR_TYPE_NAME[i]+"\",\"childList\":");
			sb.append("[");
			for(int j=0;j<Constant.VAR_CHILD_TYPE_NAME[i].length;j++) {
				sb.append("{\"name\":\""+Constant.VAR_CHILD_TYPE_NAME[i][j]+"\"}");
				if(j<Constant.VAR_CHILD_TYPE_NAME[i].length-1)
					sb.append(",");
			}
			sb.append("]");
			sb.append("}");
			if(i<Constant.VAR_TYPE.length-1)
				sb.append(",");
		}
		sb.append("]");

		//System.out.println("varType==="+sb.toString());
		request.setAttribute("varType", sb.toString());
		
		return "varChangeLine";
	}
	
	/**
	 * 跳转至变量变化报表页面
	 * @return
	 */
	@RequestMapping("/goVarChangeReport")
	public String goVarChangeReport() {
		
		return "varChangeReport";
	}
	
	/**
	 * 跳转至报警记录页面
	 * @return
	 */
	@RequestMapping("/goWarnRecord")
	public String goWarnRecord() {
		
		return "warnRecord";
	}
	
	/**
	 * 跳转至报警历史记录页面
	 * @return
	 */
	@RequestMapping("/goWarnHistoryRecord")
	public String goWarnHistoryRecord() {
		
		return "warnHistoryRecord";
	}
	
	@RequestMapping("/goInsertData")
	public String goInsertData() {
		
		return "insertData";
	}
	
	/**
	 * 获取变量最新数据并插入数据库
	 */
	@RequestMapping("/insertVarChange")
	public void insertVarChange() {
		
		while (true) {
			try {
				Thread.sleep(10*1000);
				publicService.insertVarChange();
				//System.out.println("insertVarChange...........");
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 获取变量平均数据并插入数据库
	 */
	@RequestMapping("/insertVarAvgChange")
	public void insertVarAvgChange() {
		
		while (true) {
			try {
				Thread.sleep(10*60*1000);
				int i=publicService.insertVarAvgChange();
				//System.out.println("insertVarAvgChange...........");
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	/**
	 * 查询变量数据曲线
	 * @param name
	 * @param page
	 * @param row
	 * @return
	 */
	@RequestMapping("/selectVarChangeLineData")
	@ResponseBody
	public Map<String,Object> selectVarChangeLineData(String name,int page,int row) {
		
		Map<String,Object> jsonMap=new HashMap<>();
		
		List<VarChange> vcList=publicService.selectVarChangeLineData(name,page,row);
		List<String> createTimeList=new ArrayList<String>();
		List<Float> valueList=new ArrayList<Float>();
		for (VarChange varChange : vcList) {
			createTimeList.add(varChange.getCreateTime());
			valueList.add(varChange.getValue());
		}
		jsonMap.put("createTimeList", createTimeList);
		jsonMap.put("listSize", createTimeList.size());
		jsonMap.put("valueList", valueList);
		
		/*
		if(vcList.size()>0) {
			jsonMap.put("message", "ok");
			List<String> createTimeList=new ArrayList<String>();
			List<Float> valueList=new ArrayList<Float>();
			for (VarChange varChange : vcList) {
				createTimeList.add(varChange.getCreateTime());
				valueList.add(varChange.getValue());
			}
			jsonMap.put("createTimeList", createTimeList);
			jsonMap.put("valueList", valueList);
			jsonMap.put("listSize", createTimeList.size());
		}
		else {
			jsonMap.put("message", "no");
		}
		*/
		
		return jsonMap;
	}
	
	/**
	 * 查询变量变化报表数据
	 * @param name
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping("/selectVarChangeReportData")
	@ResponseBody
	public Map<String,Object> selectVarChangeReportData(String name,int page,int rows) {
		
		Map<String,Object> jsonMap=new HashMap<>();
		
		int count=publicService.getVarChangeReportDataCount(name);
		List<VarChange> vcList=publicService.selectVarChangeReportData(name,page,rows);
		
		jsonMap.put("total", count);
		jsonMap.put("rows", vcList);
		
		return jsonMap;
	}
	
	/**
	 * 查询变量平均数据曲线
	 * @param name
	 * @param page
	 * @param row
	 * @return
	 */
	@RequestMapping("/selectVarAvgChangeLineData")
	@ResponseBody
	public Map<String,Object> selectVarAvgChangeLineData(String name,int page,int row) {
		
		Map<String,Object> jsonMap=new HashMap<>();
		
		List<VarAvgChange> vacList=publicService.selectVarAvgChangeLineData(name,page,row);
		
		List<String> createTimeList=new ArrayList<String>();
		List<Float> valueList=new ArrayList<Float>();
		for (VarAvgChange varAvgChange : vacList) {
			createTimeList.add(varAvgChange.getCreateTime());
			valueList.add(varAvgChange.getValue());
		}
		jsonMap.put("createTimeList", createTimeList);
		jsonMap.put("listSize", createTimeList.size());
		jsonMap.put("valueList", valueList);
		
		return jsonMap;
	}
	
	/**
	 * 查询报警记录报表数据
	 * @param name
	 * @return
	 */
	@RequestMapping("/selectWarnRecordReportData")
	@ResponseBody
	public Map<String,Object> selectWarnRecordReportData(String name) {
		
		Map<String,Object> jsonMap=new HashMap<>();
		
		List<WarnRecord> wrList=publicService.selectWarnRecordReportData(name);
		
		jsonMap.put("total", wrList.size());
		jsonMap.put("rows", wrList);
		
		return jsonMap;
	}
	
	/**
	 * 查询历史报警记录报表数据
	 * @param name
	 * @return
	 */
	@RequestMapping("/selectWarnHistoryRecordReportData")
	@ResponseBody
	public Map<String,Object> selectWarnHistoryRecordReportData(String name) {
		
		Map<String,Object> jsonMap=new HashMap<>();
		
		List<WarnHistoryRecord> whrList=publicService.selectWarnHistoryRecordReportData(name);
		
		jsonMap.put("total", whrList.size());
		jsonMap.put("rows", whrList);
		
		return jsonMap;
	}
	
	/**
	 * 查询变量类型
	 * @return
	 */
	@RequestMapping("/selectVarTypeData")
	@ResponseBody
	public Map<String,Object> selectVarTypeData() {
		
		Map<String,Object> jsonMap=new HashMap<>();
		
		List<Map<String,String>> varList=new ArrayList<Map<String,String>>();
		;
		for (String varType : Constant.VAR_TYPE_NAME) {
			Map<String,String> varMap=new HashMap<>();
			varMap.put("value", varType);
			varMap.put("text", varType);
			varList.add(varMap);
		}
		
		jsonMap.put("rows", varList);
		
		return jsonMap;
	}
	
	/**
	 * 查询32个变量
	 * @return
	 */
	@RequestMapping("/selectInsertArrData")
	@ResponseBody
	public Map<String,Object> selectInsertArrData() {
		
		Map<String,Object> jsonMap=new HashMap<>();
		
		List<Map<String,String>> varList=new ArrayList<Map<String,String>>();
		
		for (String var : Constant.INSERT_ARR) {
			Map<String,String> varMap=new HashMap<>();
			varMap.put("value", var);
			varMap.put("text", var);
			varList.add(varMap);
		}
		
		jsonMap.put("rows", varList);
		
		return jsonMap;
	}
	
	/**
	 * 更新报警记录
	 * @return
	 */
	@RequestMapping("/updateWarnRecord")
	@ResponseBody
	public Map<String,Object> updateWarnRecord() {
		
		Map<String,Object> jsonMap=new HashMap<>();
		
		publicService.updateWarnRecord();
		
		jsonMap.put("message", "ok");
		
		return jsonMap;
	}

	/**
	 * 获得思普云接口返回的数据包
	 * @return
	 */
	@RequestMapping("/getSiPuCloudAPIRespJson")
	@ResponseBody
	public Map<String,Object> getSiPuCloudAPIRespJson() {

		Map<String,Object> jsonMap=new HashMap<>();
		
		Map<String, Object> map = net.sf.json.JSONObject.fromObject("{\"s\":\"App.OpenAPI.TabelGatewayModelsApi\"}");
		
		List<NameValuePair> params=new ArrayList<NameValuePair>();
		int index=0;
        for (Entry<String, Object> entry : map.entrySet()) {  
            //System.out.println(entry.getKey()+"="+entry.getValue());  
    		params.add(index, new BasicNameValuePair(entry.getKey(), entry.getValue().toString()));
            index++;
        }   
		try {
			jsonMap=SiPuCloudAPI.getRespJson(params);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return jsonMap;
	}

}
