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

	 //ʱ����(һ��)  
   private static final long PERIOD_DAY = 2 * 1000;
   
   static {
	   /*
	   	System.out.println("ppppppppp");
	   	Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.HOUR_OF_DAY, 0);//�賿1�� 
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		Date date = calendar.getTime();//��һ��ִ�ж�ʱ�����ʱ��  
		//�����һ��ִ�ж�ʱ�����ʱ�� С�ڵ�ǰ��ʱ��  
		if(date.before(new Date())) {
			//date=addDay(date, 1);//��ʱҪ�� ��һ��ִ�ж�ʱ�����ʱ���һ�죬�Ա���������¸�ʱ���ִ�С��������һ�죬���������ִ��
		}
		Timer timer=new Timer();
		Data1Task task=new Data1Task();
		timer.schedule(task, date, PERIOD_DAY);//����ָ����������ָ����ʱ�俪ʼ�����ظ��Ĺ̶��ӳ�ִ��
		
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
   
   //���ӻ��������  
   public static Date addDay(Date date, int num) {  
       Calendar startDT = Calendar.getInstance();  
       startDT.setTime(date);  
       startDT.add(Calendar.DAY_OF_MONTH, num);  
       return startDT.getTime();  
   }  
}
