package blueGemstone.service.serviceImpl;

import java.util.Calendar;
import java.util.Date;
import java.util.Timer;
import java.awt.Desktop;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import blueGemstone.dao.PublicMapper;
import blueGemstone.entity.Data1;
import blueGemstone.service.PublicService;
import blueGemstone.util.Data1Task;

@Service
public class PublicServiceImpl implements PublicService {
	
	@Autowired
	private PublicMapper publicDao;
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
	public void select() {
		// TODO Auto-generated method stub
		int i=publicDao.select();
		System.out.println("i====="+i);
	}

	@Override
	public int insertData1() {
		// TODO Auto-generated method stub
		
		Data1 data1=new Data1();
		data1.setKey1("aaa");
		data1.setKey2("bbb");
		int count=publicDao.insertData1(data1);
		return count;
	}

}
