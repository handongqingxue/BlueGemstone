package blueGemstone.service.serviceImpl;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import blueGemstone.dao.PublicMapper;
import blueGemstone.entity.LoginRecord;
import blueGemstone.entity.VarAvgChange;
import blueGemstone.entity.VarChange;
import blueGemstone.entity.VarWarnLimit;
import blueGemstone.entity.WarnHistoryRecord;
import blueGemstone.entity.WarnRecord;
import blueGemstone.service.PublicService;
import blueGemstone.util.Constant;
import blueGemstone.util.StringUtils;
import net.sf.json.JSONObject;

@Service
public class PublicServiceImpl implements PublicService {
	
	@Autowired
	private PublicMapper publicDao;
	private SimpleDateFormat timeSDF=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private SimpleDateFormat startTimeSDF=new SimpleDateFormat("yyyy-MM-dd 00:00:00");
	private DecimalFormat df1 = new DecimalFormat("0.0");
	private static final long PERIOD_DAY = 2 * 1000;
    
    static {
		/*
    	System.out.println("zzzzzzzzzzzz");
    	Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.HOUR_OF_DAY, 0);//凌晨1点 
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		Date date = calendar.getTime();//第一次执行定时任务的时间  
		//如果第一次执行定时任务的时间 小于当前的时间  
		if(date.before(new Date())) {
			//date=com.htkapp.core.utils.DateUtil.getAddDay(date, 1);//此时要在 第一次执行定时任务的时间加一天，以便此任务在下个时间点执行。如果不加一天，任务会立即执行
		}
		Timer timer=new Timer();
		Data1Task task=new Data1Task();
		timer.schedule(task, date, PERIOD_DAY);//安排指定的任务在指定的时间开始进行重复的固定延迟执行
		
		Desktop dt = Desktop.getDesktop();
		try {
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
	
	@Override
	public Integer insertVarChange(List<VarWarnLimit> vwlList, String pushData) {
		// TODO Auto-generated method stub

		//System.out.println("pushData==="+pushData);
		JSONObject jsonPushData = JSONObject.fromObject(pushData);
		JSONObject messageJO = jsonPushData.getJSONObject("Message");
		//System.out.println("Message==="+messageJO);
		
		int count=0;
		String createTime = timeSDF.format(new Date());
		for (VarWarnLimit varWarnLimit : vwlList) {
			VarChange varChange=new VarChange();
			varChange.setId(UUID.randomUUID().toString().replace("-", ""));
			varChange.setName(varWarnLimit.getName());
			Float value = Float.valueOf(messageJO.getString(varWarnLimit.getkName()));
			//System.out.println("value==="+value);
			varChange.setValue(value);
			varChange.setCreateTime(createTime);
			Float upLimit = varWarnLimit.getUpLimit();
			varChange.setUpLimit(upLimit);
			Float downLimit = varWarnLimit.getDownLimit();
			varChange.setDownLimit(downLimit);
			if(value>upLimit) {
				varChange.setState(1);
				insertWarnRecord(varChange);
			}
			else if(value<downLimit) {
				varChange.setState(2);
				insertWarnRecord(varChange);
			}
			else
				varChange.setState(0);
			
			count+=publicDao.insertVarChange(varChange);
		}
		return count;
	}
	
	@Override
	public Integer insertVarChangeTest() {
		// TODO Auto-generated method stub
		
		int count=0;
		String createTime = timeSDF.format(new Date());
		for (int i = 0; i < Constant.INSERT_ARR.length; i++) {
			VarChange varChange=new VarChange();
			varChange.setId(UUID.randomUUID().toString().replace("-", ""));
			varChange.setName(Constant.INSERT_ARR[i]);
			Random random = new Random();
			float value = random.nextInt(100);
			//System.out.println("value==="+value);
			varChange.setValue(value);
			varChange.setCreateTime(createTime);
			if(value>98) {
				varChange.setState(1);
				insertWarnRecord(varChange);
			}
			else if(value<2) {
				varChange.setState(2);
				insertWarnRecord(varChange);
			}
			else
				varChange.setState(0);
			
			count+=publicDao.insertVarChange(varChange);
		}
		return count;
	}

	@Override
	public Integer insertVarAvgChange(List<VarWarnLimit> vwlList, Integer timeFlag) {
		// TODO Auto-generated method stub

		int count=0;
		String time = timeSDF.format(new Date());
		String createTime = timeSDF.format(new Date());
		for (VarWarnLimit varWarnLimit : vwlList) {
			VarAvgChange varAvgChange=new VarAvgChange();
			varAvgChange.setId(UUID.randomUUID().toString().replace("-", ""));
			String name = varWarnLimit.getName();
			varAvgChange.setName(name);
			float avgValue = publicDao.getVarChangeAvgValue(name,time,timeFlag);
			System.out.println("name==="+name+",avgValue==="+avgValue);
			varAvgChange.setValue(avgValue);
			varAvgChange.setCreateTime(createTime);
			varAvgChange.setTimeFlag(timeFlag);
			float upLimit = varWarnLimit.getUpLimit();
			varAvgChange.setUpLimit(upLimit);
			float downLimit = varWarnLimit.getDownLimit();
			varAvgChange.setDownLimit(downLimit);
			if(avgValue>upLimit)
				varAvgChange.setState(1);
			else if(avgValue<downLimit)
				varAvgChange.setState(2);
			else
				varAvgChange.setState(0);
			
			count+=publicDao.insertVarAvgChange(varAvgChange);
			if(count>0) {
				publicDao.updateVarChange(name,time,timeFlag);
			}
		}
		return count;
	}

	@Override
	public Integer insertVarAvgChangeTest(Integer timeFlag) {
		// TODO Auto-generated method stub
		
		int count=0;
		String time = timeSDF.format(new Date());
		String createTime = timeSDF.format(new Date());
		for (int i = 0; i < Constant.INSERT_ARR.length; i++) {
			VarAvgChange varAvgChange=new VarAvgChange();
			varAvgChange.setId(UUID.randomUUID().toString().replace("-", ""));
			varAvgChange.setName(Constant.INSERT_ARR[i]);
			float avgValue = publicDao.getVarChangeAvgValue(Constant.INSERT_ARR[i],time,timeFlag);
			System.out.println("avgValue==="+avgValue);
			varAvgChange.setValue(avgValue);
			varAvgChange.setCreateTime(createTime);
			varAvgChange.setTimeFlag(timeFlag);
			if(avgValue>98)
				varAvgChange.setState(1);
			else if(avgValue<2)
				varAvgChange.setState(2);
			else
				varAvgChange.setState(0);
			
			count+=publicDao.insertVarAvgChange(varAvgChange);
			if(count>0) {
				publicDao.updateVarChange(Constant.INSERT_ARR[i],time,timeFlag);
			}
		}
		publicDao.deleteVarChange();//删除计算完平均值后的多余的数据
		return count;
	}

	@Override
	public List<VarChange> selectVarChangeLineData(String name, int page, int row) {
		// TODO Auto-generated method stub
		
		return publicDao.selectVarChangeLineData(name, page, row);
	}

	@Override
	public int getVarChangeReportDataCount(String name) {
		// TODO Auto-generated method stub
		return publicDao.getVarChangeReportDataCount(name);
	}

	@Override
	public List<VarChange> selectVarChangeReportData(String name, int page, int rows) {
		// TODO Auto-generated method stub
		
		return publicDao.selectVarChangeReportData(name, page, rows);
	}

	@Override
	public List<VarAvgChange> selectVarAvgChangeLineData(String name, String timeSpace, String startTime, String endTime, int page, int rows) {
		// TODO Auto-generated method stub
		
		if(StringUtils.isEmpty(startTime)||StringUtils.isEmpty(endTime)) {
			Date date = new Date();
			startTime=startTimeSDF.format(date);
			endTime=timeSDF.format(date);
		}
		return publicDao.selectVarAvgChangeLineData(name, timeSpace, startTime, endTime, page, rows);
	}

	@Override
	public List<WarnRecord> selectWarnRecordReportData(String name) {
		// TODO Auto-generated method stub
		return publicDao.selectWarnRecordReportData(name);
	}

	@Override
	public int getWarnHistoryRecordReportDataCount(String name) {
		// TODO Auto-generated method stub
		return publicDao.getWarnHistoryRecordReportDataCount(name);
	}

	@Override
	public List<WarnHistoryRecord> selectWarnHistoryRecordReportData(String name, int page, int rows) {
		// TODO Auto-generated method stub
		return publicDao.selectWarnHistoryRecordReportData(name, page, rows);
	}

	@Override
	public Integer insertWarnRecord(VarChange varChange) {
		// TODO Auto-generated method stub
		
		WarnRecord warnRecord=new WarnRecord();
		warnRecord.setId(UUID.randomUUID().toString().replace("-", ""));
		warnRecord.setName(varChange.getName());
		warnRecord.setValue(varChange.getValue());
		warnRecord.setState(varChange.getState());
		warnRecord.setCreateTime(varChange.getCreateTime());
		warnRecord.setMemo(varChange.getMemo());
		
		return publicDao.insertWarnRecord(warnRecord);
	}
	
	@Override
	public Integer updateWarnRecord() {
		// TODO Auto-generated method stub
		
		for(int i=0;i<Constant.INSERT_ARR.length;i++) {
			Integer state=publicDao.getVarStateByName(Constant.INSERT_ARR[i]);
			if(0==state) {//如果状态是0，说明恢复正常了，就查询出最后一条报警记录来，插入到历史报警记录表里
				List<WarnRecord> wrList = selectWarnRecordReportData(Constant.INSERT_ARR[i]);
				for (WarnRecord wr : wrList) {
					WarnHistoryRecord whr=new WarnHistoryRecord();
					whr.setId(UUID.randomUUID().toString().replace("-", ""));
					whr.setName(wr.getName());
					whr.setValue(wr.getValue());
					whr.setCreateTime(wr.getCreateTime());
					whr.setState(wr.getState());
					publicDao.insertWarnHistoryRecord(whr);
				}
				publicDao.deleteWarnRecordByName(Constant.INSERT_ARR[i]);
			}
		}
		return 1;
	}

	@Override
	public List<Map<String, Object>> getCurrentVarValueList() {
		// TODO Auto-generated method stub
		
		List<VarChange> valueList=publicDao.getCurrentVar();

		List<Map<String, Object>> varList=new ArrayList<>();
		for(int i=0;i<valueList.size();i++) {
			VarChange varChange = valueList.get(i);
			Map<String, Object> varMap=new HashMap<>();
			varMap.put("name", varChange.getName());
			//varMap.put("value", (float)1.00);
			Float value = varChange.getValue();
			varMap.put("value", value==null?0.0:df1.format(value));
			//System.out.println("name==="+varChange.getName()+",value==="+value);
			varList.add(varMap);
		}
		
		return varList;
	}

	@Override
	public List<VarWarnLimit> selectVarWarnLimitData() {
		// TODO Auto-generated method stub
		return publicDao.selectVarWarnLimitData();
	}

	@Override
	public Integer insertLoginRecord(LoginRecord loginRecord) {
		// TODO Auto-generated method stub
		
		loginRecord.setCreateTime(timeSDF.format(new Date()));
		return publicDao.insertLoginRecord(loginRecord);
	}

	@Override
	public LoginRecord selectLastLoginRecordByName(String name) {
		// TODO Auto-generated method stub
		return publicDao.selectLastLoginRecordByName(name);
	}

	@Override
	public int getWarnRecordCount() {
		// TODO Auto-generated method stub
		return publicDao.getWarnRecordCount();
	}
}
