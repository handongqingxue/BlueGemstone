package blueGemstone.util;

import java.util.TimerTask;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/timerTask")
public class Data1Task extends TimerTask {

	@Override
	public void run() {
		// TODO Auto-generated method stub

		System.out.println("111111111111111");
	}

}