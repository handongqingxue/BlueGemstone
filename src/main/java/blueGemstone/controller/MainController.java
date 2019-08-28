package blueGemstone.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import blueGemstone.service.PublicService;

@Controller
@RequestMapping("/main")
public class MainController {
	
	@Autowired
	private PublicService publicService;
	
	@RequestMapping("/select")
	public String select() {
		publicService.select();
		return "NewFile";
	}
	
	@RequestMapping("/goInsertData")
	public String goInsertData() {
		
		return "insertData";
	}
	
	@RequestMapping("/insertData1")
	public void insertData1() {
		
		while (true) {
			try {
				int i=publicService.insertData1();
				System.out.println("insert...........");
				Thread.sleep(2*60*1000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}
