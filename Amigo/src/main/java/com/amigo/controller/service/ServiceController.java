package com.amigo.controller.service;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class ServiceController {
	
	/*메인홈페이지*/
	@RequestMapping("/main.amg")
	public String main() {
		return "main/main";
	}
	
	@RequestMapping("qna/faq.amg")
	public String faq() {
		return "qna/faq";
	}
	
	@RequestMapping("qna/qna.amg")
	public String question() {
		return "qna/qna";
	}
	
	@RequestMapping("/amigoService.amg")
	public String amigoService() {
		return "service/amigo_service";
	}
	
	@RequestMapping("/footerInform.amg")
	public String footerInform() {
		return "footer/footer_inform";
	}
	
	@RequestMapping("/footerAgree.amg")
	public String footerAgree() {
		return "footer/footer_agree";
	}
	
	@RequestMapping("/footerEmail.amg")
	public String footerEmail() {
		return "footer/footer_email";
	}
	
	@RequestMapping("/footerLegal.amg")
	public String footerLegal() {
		return "footer/footer_legal";
	}
}
