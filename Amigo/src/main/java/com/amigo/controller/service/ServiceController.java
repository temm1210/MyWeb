package com.amigo.controller.service;


import javax.servlet.http.HttpSession;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.amigo.vo.member.MemberVO;


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
	
	@RequestMapping(value = "/chat.amg", method = RequestMethod.GET)
	public ModelAndView home(ModelAndView mav) {
		
		MemberVO user = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		mav.setViewName("chat");
		mav.addObject("userid", user.getUsername());
		
		
		return mav;
	}
}
