package blueGemstone.service.serviceImpl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import blueGemstone.dao.PublicMapper;
import blueGemstone.entity.VarAvgChange;
import blueGemstone.entity.VarChange;
import blueGemstone.entity.WarnRecord;
import blueGemstone.service.PublicService;

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
	public int insertVarChange() {
		// TODO Auto-generated method stub
		
		VarChange varChange=new VarChange();
		varChange.setId(UUID.randomUUID().toString().replace("-", ""));
		varChange.setName(VarChange.YAQIANG);
		Random random = new Random();
		float value = random.nextInt(100);
		System.out.println("value==="+value);
		varChange.setValue(value);
		varChange.setCreateTime(timeSDF.format(new Date()));
		if(value>80) {
			varChange.setState(1);
			insertWarnRecord(varChange);
		}
		else if(value<20) {
			varChange.setState(2);
			insertWarnRecord(varChange);
		}
		else
			varChange.setState(0);
		
		int count=publicDao.insertVarChange(varChange);
		return count;
	}

	@Override
	public int insertVarAvgChange() {
		// TODO Auto-generated method stub
		
		VarAvgChange varAvgChange=new VarAvgChange();
		varAvgChange.setId(UUID.randomUUID().toString().replace("-", ""));
		varAvgChange.setName(VarChange.YAQIANG);
		String time = timeSDF.format(new Date());
		float avgValue = publicDao.getVarChangeAvgValue(VarChange.YAQIANG,time);
		System.out.println("avgValue==="+avgValue);
		varAvgChange.setValue(avgValue);
		varAvgChange.setCreateTime(timeSDF.format(new Date()));
		if(avgValue>80)
			varAvgChange.setState(1);
		else if(avgValue<20)
			varAvgChange.setState(2);
		else
			varAvgChange.setState(0);
		
		int count=publicDao.insertVarAvgChange(varAvgChange);
		if(count>0) {
			publicDao.updateVarChange(VarChange.YAQIANG,time);
		}
		return count;
	}

	@Override
	public List<VarChange> selectVarChangeLineData() {
		// TODO Auto-generated method stub
		
		return publicDao.selectVarChangeLineData();
	}

	@Override
	public List<VarAvgChange> selectVarAvgChangeLineData() {
		// TODO Auto-generated method stub
		return publicDao.selectVarAvgChangeLineData();
	}

	@Override
	public List<WarnRecord> selectWarnRecordLineData() {
		// TODO Auto-generated method stub
		return publicDao.selectWarnRecordLineData();
	}

	@Override
	public int insertWarnRecord(VarChange varChange) {
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
	
	public static void main(String[] args) {
		System.out.println(new Random().nextInt(100));
	}
}
