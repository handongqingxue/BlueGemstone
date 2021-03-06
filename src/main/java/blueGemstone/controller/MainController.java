package blueGemstone.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import blueGemstone.entity.LoginRecord;
import blueGemstone.entity.VarAvgChange;
import blueGemstone.entity.VarChange;
import blueGemstone.entity.VarWarnLimit;
import blueGemstone.entity.WarnHistoryRecord;
import blueGemstone.entity.WarnRecord;
import blueGemstone.service.PublicService;
import blueGemstone.util.Constant;
import blueGemstone.util.SiPuCloudAPI;
import net.sf.json.JSONObject;

import java.awt.Desktop;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;

@Controller
@RequestMapping("/main")
public class MainController {
	
	@Autowired
	private PublicService publicService;
	
	static {
		/*
		Desktop dt = Desktop.getDesktop();
		try {
			//dt.browse(new URI("http://120.27.5.36:8080/BlueGemstone/main/goInsertData"));
			dt.browse(new URI("http://127.0.0.1:8088/BlueGemstone/main/goInsertData"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		*/
	}
	
	/**
	 * 跳转至首页
	 * @param request
	 * @return
	 */
	@RequestMapping("/goMain")
	public String goMain(HttpServletRequest request) {
		
		String device = request.getParameter("device");
		
		/*
		HttpSession session = request.getSession();
		List<VarWarnLimit> vwlList=null;//(List<VarWarnLimit>)session.getAttribute("vwlList");
		if(vwlList==null) {
			System.out.println("selectVarWarnLimitData....");
			vwlList = publicService.selectVarWarnLimitData();
			session.setAttribute("vwlList", vwlList);
		}
		*/
		
		List<Map<String, Object>> varList=publicService.getCurrentVarValueList();
		request.setAttribute("varList", varList);
		
		if(Constant.PC.equals(device)) {
			return "pc/main";
		}
		else
			return "phone/main";
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
		
		return "pc/varChangeLine";
	}
	
	/**
	 * 跳转至变量变化报表页面
	 * @return
	 */
	@RequestMapping("/goVarChangeReport")
	public String goVarChangeReport(HttpServletRequest request) {
		
		String device = request.getParameter("device");
		if(Constant.PC.equals(device))
			return "pc/varChangeReport";
		else
			return "phone/varChangeReport";
	}
	
	/**
	 * 跳转至报警记录页面
	 * @return
	 */
	@RequestMapping("/goWarnRecord")
	public String goWarnRecord() {
		
		return "pc/warnRecord";
	}
	
	/**
	 * 跳转至报警历史记录页面
	 * @return
	 */
	@RequestMapping("/goWarnHistoryRecord")
	public String goWarnHistoryRecord(HttpServletRequest request) {
		
		String device = request.getParameter("device");
		if(Constant.PC.equals(device))
			return "pc/warnHistoryRecord";
		else
			return "phone/warnHistoryRecord";
	}
	
	@RequestMapping("/goInsertData")
	public String goInsertData() {
		
		return "insertData";
	}
	
	/**
	 * 获取变量最新数据并插入数据库
	 */
	@RequestMapping("/insertVarChange")
	@ResponseBody
	public Map<String,Object> insertVarChange(HttpServletRequest request,String pushData) {
		
		Map<String,Object> jsonMap=new HashMap<>();
		
		pushData=pushData.replaceAll("\\\\\"", "\"");
		List<VarWarnLimit> vwlList = publicService.selectVarWarnLimitData();
		publicService.insertVarChange(vwlList,pushData);
		
		return jsonMap;
	}
	
	/**
	 * 获取变量平均数据并插入数据库
	 */
	@RequestMapping("/insertVarAvgChange")
	@ResponseBody
	public Map<String,Object> insertVarAvgChange(HttpServletRequest request, Integer timeFlag) {

		Map<String,Object> jsonMap=new HashMap<>();
		
		List<VarWarnLimit> vwlList = (List<VarWarnLimit>)request.getSession().getAttribute("vwlList");
		if(vwlList==null) {
			vwlList = publicService.selectVarWarnLimitData();
			request.getSession().setAttribute("vwlList", vwlList);
		}
		publicService.insertVarAvgChange(vwlList,timeFlag);
		
		System.out.println("insertVarAvgChange...");
		
		return jsonMap;
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
		
		VarWarnLimit rangeVar=publicService.getRange(name);
		List<VarChange> vcList=publicService.selectVarChangeLineData(name,page,row);
		List<String> createTimeList=new ArrayList<String>();
		List<Float> valueList=new ArrayList<Float>();
		List<Float> upLimitList=new ArrayList<Float>();
		List<Float> downLimitList=new ArrayList<Float>();
		for (VarChange varChange : vcList) {
			createTimeList.add(varChange.getCreateTime());
			valueList.add(varChange.getValue());
			Float upLimit = varChange.getUpLimit();
			//upLimitList.add(upLimit==null?(float)0.00:upLimit);
			upLimitList.add(upLimit);
			Float downLimit = varChange.getDownLimit();
			//downLimitList.add(downLimit==null?(float)0.00:downLimit);
			downLimitList.add(downLimit);
		}
		jsonMap.put("createTimeList", createTimeList);
		jsonMap.put("listSize", createTimeList.size());
		jsonMap.put("valueList", valueList);
		jsonMap.put("upLimitList", upLimitList);
		jsonMap.put("downLimitList", downLimitList);
		jsonMap.put("max", rangeVar.getMax());
		jsonMap.put("min", rangeVar.getMin());
		
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
	public Map<String,Object> selectVarAvgChangeLineData(String name,int page,int row,String otherParam) {
		
		Map<String,Object> jsonMap=new HashMap<>();
		
		//System.out.println("otherParam==="+otherParam);
		JSONObject otherParamJO = JSONObject.fromObject(otherParam);
		String timeSpace = otherParamJO.getString("timeSpace");
		String startTime = otherParamJO.getString("startTime");
		String endTime = otherParamJO.getString("endTime");
		/*
		System.out.println("name==="+name);
		System.out.println("page==="+page);
		System.out.println("row==="+row);
		System.out.println("timeSpace==="+timeSpace);
		System.out.println("startTime==="+startTime);
		System.out.println("endTime==="+endTime);
		*/
		List<VarAvgChange> vacList=publicService.selectVarAvgChangeLineData(name,timeSpace,startTime,endTime,page,row);
		
		List<String> createTimeList=new ArrayList<String>();
		List<Float> valueList=new ArrayList<Float>();
		List<Float> upLimitList=new ArrayList<Float>();
		List<Float> downLimitList=new ArrayList<Float>();
		for (VarAvgChange varAvgChange : vacList) {
			createTimeList.add(varAvgChange.getCreateTime());
			valueList.add(varAvgChange.getValue());
			Float upLimit = varAvgChange.getUpLimit();
			upLimitList.add(upLimit==null?(float)0.00:upLimit);
			Float downLimit = varAvgChange.getDownLimit();
			downLimitList.add(downLimit==null?(float)0.00:downLimit);
		}
		jsonMap.put("createTimeList", createTimeList);
		jsonMap.put("listSize", createTimeList.size());
		jsonMap.put("valueList", valueList);
		jsonMap.put("upLimitList", upLimitList);
		jsonMap.put("downLimitList", downLimitList);
		
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
	public Map<String,Object> selectWarnHistoryRecordReportData(String name,int page,int rows) {
		
		Map<String,Object> jsonMap=new HashMap<>();
		
		int count=publicService.getWarnHistoryRecordReportDataCount(name);
		List<WarnHistoryRecord> whrList=publicService.selectWarnHistoryRecordReportData(name,page,rows);
		
		jsonMap.put("total", count);
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
		
		int count=publicService.getWarnRecordCount();
		if(count>0)
			jsonMap.put("message", "ok");
		else
			jsonMap.put("message", "no");
		
		return jsonMap;
	}

	/**
	 * 获得思普云接口返回的数据包
	 * @return
	 */
	@RequestMapping("/getSiPuCloudAPIRespJson")
	@ResponseBody
	public Map<String,Object> getSiPuCloudAPIRespJson(String jsonParam) {

		Map<String,Object> jsonMap=new HashMap<>();
		
		Map<String, Object> map = net.sf.json.JSONObject.fromObject(jsonParam);
		
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

	/**
	 * 保存用户信息
	 * @param session
	 * @param USER_ID
	 * @param NAME
	 * @param USER_TYPE
	 * @param token
	 * @return
	 */
	@RequestMapping("/saveUser")
	@ResponseBody
	public Map<String,Object> saveUser(HttpSession session, String USER_ID, String NAME, Integer USER_TYPE, String token) {

		Map<String,Object> jsonMap=new HashMap<>();
		
		System.out.println("token==="+token);
		session.setAttribute("USER_ID", USER_ID);
		session.setAttribute("USER_TYPE", USER_TYPE);
		session.setAttribute("token", token);
		
		LoginRecord loginRecord=new LoginRecord();
		loginRecord.setUserId(USER_ID);
		loginRecord.setName(NAME);
		loginRecord.setUserType(USER_TYPE);
		loginRecord.setToken(token);
		int i=publicService.insertLoginRecord(loginRecord);

		jsonMap.put("message", "ok");
		
		return jsonMap;
	}
	
	/**
	 * 查询用户登录信息，放进session里
	 * @param session
	 * @param name
	 * @return
	 */
	@RequestMapping("/selectLoginData")
	@ResponseBody
	public Map<String,Object> selectLoginData(HttpSession session, String name) {

		Map<String,Object> jsonMap=new HashMap<>();
		
		LoginRecord loginRecord = publicService.selectLastLoginRecordByName(name);

		if(loginRecord==null) {
			jsonMap.put("message", "no");
		}
		else {
			session.setAttribute("USER_ID", loginRecord.getUserId());
			session.setAttribute("USER_TYPE", loginRecord.getUserType());
			session.setAttribute("token", loginRecord.getToken());
			
			jsonMap.put("message", "ok");
		}
		
		return jsonMap;
	}

}
