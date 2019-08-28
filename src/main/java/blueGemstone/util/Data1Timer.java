package blueGemstone.util;

import java.awt.Desktop;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.Calendar;
import java.util.Date;
import java.util.Timer;

import org.springframework.stereotype.Controller;

@Controller
public class Data1Timer {

	 //时间间隔(一天)  
   private static final long PERIOD_DAY = 2 * 1000;
   
   static {
	   /*
	   	System.out.println("ppppppppp");
	   	Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.HOUR_OF_DAY, 0);//凌晨1点 
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		Date date = calendar.getTime();//第一次执行定时任务的时间  
		//如果第一次执行定时任务的时间 小于当前的时间  
		if(date.before(new Date())) {
			//date=addDay(date, 1);//此时要在 第一次执行定时任务的时间加一天，以便此任务在下个时间点执行。如果不加一天，任务会立即执行
		}
		Timer timer=new Timer();
		Data1Task task=new Data1Task();
		timer.schedule(task, date, PERIOD_DAY);//安排指定的任务在指定的时间开始进行重复的固定延迟执行
		
		Desktop dt = Desktop.getDesktop();
		try {
			dt.browse(new URI("http://192.168.1.125:8080/ScanOrder/admin/allBill/goAutoEnterReceipt"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		*/
   }
   
   //增加或减少天数  
   public static Date addDay(Date date, int num) {  
       Calendar startDT = Calendar.getInstance();  
       startDT.setTime(date);  
       startDT.add(Calendar.DAY_OF_MONTH, num);  
       return startDT.getTime();  
   }  
}
