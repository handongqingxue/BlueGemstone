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
	
	@RequestMapping("/goMain")
	public String goMain() {
		
		return "main";
	}
	
	@RequestMapping("/goInsertData")
	public String goInsertData() {
		
		return "insertData";
	}
	
	@RequestMapping("/insertVarChange")
	public void insertVarChange() {
		
		while (true) {
			try {
				Thread.sleep(2*1000);
				int i=publicService.insertVarChange();
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

}
