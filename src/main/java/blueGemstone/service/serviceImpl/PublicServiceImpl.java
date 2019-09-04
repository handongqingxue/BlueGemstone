package blueGemstone.service.serviceImpl;

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
import blueGemstone.entity.VarAvgChange;
import blueGemstone.entity.VarChange;
import blueGemstone.entity.WarnHistoryRecord;
import blueGemstone.entity.WarnRecord;
import blueGemstone.service.PublicService;
import blueGemstone.util.Constant;
import blueGemstone.util.StringUtils;

@Service
public class PublicServiceImpl implements PublicService {
	
	@Autowired
	private PublicMapper publicDao;
	private SimpleDateFormat timeSDF=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private static final long PERIOD_DAY = 2 * 1000;
    
    static {
		/*
    	System.out.println("zzzzzzzzzzzz");
    	Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.HOUR_OF_DAY, 0);//�賿1�� 
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		Date date = calendar.getTime();//��һ��ִ�ж�ʱ�����ʱ��  
		//�����һ��ִ�ж�ʱ�����ʱ�� С�ڵ�ǰ��ʱ��  
		if(date.before(new Date())) {
			//date=com.htkapp.core.utils.DateUtil.getAddDay(date, 1);//��ʱҪ�� ��һ��ִ�ж�ʱ�����ʱ���һ�죬�Ա���������¸�ʱ���ִ�С��������һ�죬���������ִ��
		}
		Timer timer=new Timer();
		Data1Task task=new Data1Task();
		timer.schedule(task, date, PERIOD_DAY);//����ָ����������ָ����ʱ�俪ʼ�����ظ��Ĺ̶��ӳ�ִ��
		
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
	public Integer insertVarChange() {
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
	public Integer insertVarAvgChange() {
		// TODO Auto-generated method stub
		
		int count=0;
		String time = timeSDF.format(new Date());
		String createTime = timeSDF.format(new Date());
		for (int i = 0; i < Constant.INSERT_ARR.length; i++) {
			VarAvgChange varAvgChange=new VarAvgChange();
			varAvgChange.setId(UUID.randomUUID().toString().replace("-", ""));
			varAvgChange.setName(Constant.INSERT_ARR[i]);
			float avgValue = publicDao.getVarChangeAvgValue(Constant.INSERT_ARR[i],time);
			System.out.println("avgValue==="+avgValue);
			varAvgChange.setValue(avgValue);
			varAvgChange.setCreateTime(createTime);
			if(avgValue>95)
				varAvgChange.setState(1);
			else if(avgValue<5)
				varAvgChange.setState(2);
			else
				varAvgChange.setState(0);
			
			count+=publicDao.insertVarAvgChange(varAvgChange);
			if(count>0) {
				publicDao.updateVarChange(Constant.INSERT_ARR[i],time);
			}
		}
		return count;
	}

	@Override
	public List<VarChange> selectVarChangeLineData(String name, int page, int row) {
		// TODO Auto-generated method stub
		
		return publicDao.selectVarChangeLineData(name, page, row);
	}

	@Override
	public List<VarChange> selectVarChangeReportData(String name) {
		// TODO Auto-generated method stub
		
		return publicDao.selectVarChangeReportData(name);
	}

	@Override
	public List<VarAvgChange> selectVarAvgChangeLineData(String name, int page, int row) {
		// TODO Auto-generated method stub
		return publicDao.selectVarAvgChangeLineData(name, page, row);
	}

	@Override
	public List<WarnRecord> selectWarnRecordReportData(String name) {
		// TODO Auto-generated method stub
		return publicDao.selectWarnRecordReportData(name);
	}

	@Override
	public List<WarnHistoryRecord> selectWarnHistoryRecordReportData(String name) {
		// TODO Auto-generated method stub
		return publicDao.selectWarnHistoryRecordReportData(name);
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
			if("0".equals(state)) {
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
		
		List<Map<String, Object>> varList=new ArrayList<>();
		for(int i=0;i<Constant.INSERT_ARR.length;i++) {
			Map<String, Object> varMap=new HashMap<>();
			varMap.put("name", Constant.INSERT_ARR[i]);
			Float value=publicDao.getCurrentVarValue(Constant.INSERT_ARR[i]);
			//varMap.put("value", (float)1.00);
			varMap.put("value", value==null?0.0:value);
			varList.add(varMap);
		}
		
		return varList;
	}
}
