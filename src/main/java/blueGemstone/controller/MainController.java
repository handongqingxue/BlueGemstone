package blueGemstone.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import blueGemstone.entity.VarAvgChange;
import blueGemstone.entity.VarChange;
import blueGemstone.entity.WarnRecord;
import blueGemstone.service.PublicService;
import blueGemstone.util.Constant;

@Controller
@RequestMapping("/main")
public class MainController {
	
	@Autowired
	private PublicService publicService;
	
	@RequestMapping("/goMain")
	public String goMain() {
		
		return "main";
	}
	
	@RequestMapping("/goVarChangeLine")
	public String goVarChange() {
		
		return "varChangeLine";
	}
	
	@RequestMapping("/goVarChangeReport")
	public String goVarChangeReport() {
		
		return "varChangeReport";
	}
	
	@RequestMapping("/goWarnRecord")
	public String goWarnRecord() {
		
		return "warnRecord";
	}
	
	@RequestMapping("/goInsertData")
	public String goInsertData() {
		
		return "insertData";
	}
	
	@RequestMapping("/insertVarChange")
	public void insertVarChange() {
		
		while (true) {
			try {
				Thread.sleep(10*1000);
				publicService.insertVarChange();
				System.out.println("insertVarChange...........");
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	@RequestMapping("/insertVarAvgChange")
	public void insertVarAvgChange() {
		
		while (true) {
			try {
				Thread.sleep(10*60*1000);
				int i=publicService.insertVarAvgChange();
				System.out.println("insertVarAvgChange...........");
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	@RequestMapping("/selectVarChangeLineData")
	@ResponseBody
	public Map<String,Object> selectVarChangeLineData() {
		
		Map<String,Object> jsonMap=new HashMap<>();
		
		List<VarChange> vcList=publicService.selectVarChangeLineData(Constant.BAO_HE_ZHENG_QI_YA_LI);
		
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
		
		return jsonMap;
	}
	
	@RequestMapping("/selectVarChangeReportData")
	@ResponseBody
	public Map<String,Object> selectVarChangeReportData(String name) {
		
		Map<String,Object> jsonMap=new HashMap<>();
		
		List<VarChange> vcList=publicService.selectVarChangeReportData(name);
		
		jsonMap.put("total", vcList.size());
		jsonMap.put("rows", vcList);
		
		return jsonMap;
	}
	
	@RequestMapping("/selectVarAvgChangeLineData")
	@ResponseBody
	public Map<String,Object> selectVarAvgChangeLineData() {
		
		Map<String,Object> jsonMap=new HashMap<>();
		
		List<VarAvgChange> vacList=publicService.selectVarAvgChangeLineData(Constant.BAO_HE_ZHENG_QI_YA_LI);
		
		if(vacList.size()>0) {
			jsonMap.put("message", "ok");
			List<String> createTimeList=new ArrayList<String>();
			List<Float> valueList=new ArrayList<Float>();
			for (VarAvgChange varAvgChange : vacList) {
				createTimeList.add(varAvgChange.getCreateTime());
				valueList.add(varAvgChange.getValue());
			}
			jsonMap.put("createTimeList", createTimeList);
			jsonMap.put("valueList", valueList);
			jsonMap.put("listSize", createTimeList.size());
		}
		else {
			jsonMap.put("message", "no");
		}
		
		return jsonMap;
	}
	
	@RequestMapping("/selectWarnRecordReportData")
	@ResponseBody
	public Map<String,Object> selectWarnRecordReportData(String name) {
		
		Map<String,Object> jsonMap=new HashMap<>();
		
		List<WarnRecord> wrList=publicService.selectWarnRecordReportData(name);
		
		jsonMap.put("total", wrList.size());
		jsonMap.put("rows", wrList);
		
		return jsonMap;
	}
	
	@RequestMapping("/selectConstantData")
	@ResponseBody
	public Map<String,Object> selectConstantData() {
		
		Map<String,Object> jsonMap=new HashMap<>();
		
		List<Map<String,String>> varList=new ArrayList<Map<String,String>>();
		;
		for (String var : Constant.INSERT_ARR) {
			Map<String,String> varMap=new HashMap<>();
			varMap.put("value", var);
			varMap.put("text", var);
			varList.add(varMap);
		}
		
		jsonMap.put("rows", varList);
		
		return jsonMap;
	}

}
