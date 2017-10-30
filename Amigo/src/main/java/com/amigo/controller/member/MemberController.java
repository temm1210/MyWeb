package com.amigo.controller.member;

import java.security.Principal;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.amigo.service.member.MemberService;
import com.amigo.vo.member.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Inject
	private MemberService service;

	/*�α�����*/
	@RequestMapping("/login.amg")
	public String login(HttpServletRequest request,	Model model,
						@RequestParam(value="state",defaultValue="success") String state) {
		System.out.println("����:"+request.getHeader("referer"));
		
		model.addAttribute("state", state);
		
		if(state.equals("success"))
			request.getSession().setAttribute("prevpage", request.getHeader("referer"));
		return "login";
	}
	
	/*ù��° ȸ��������(�������)*/
	@RequestMapping("/joinFirst.amg")
	public String joinFirst() {
		return "join/join_first";
	}
	
	/*�ι�° ���� �Է�*/
	@RequestMapping("/joinSecond.amg")
	public String joinSecond() {
		return "join/join_second";
	}
	
	/*�α��� ���������� ����ִ� ������*/
	@RequestMapping(value = "/joinSuccess.amg",method=RequestMethod.POST)
	public String joinSuccess(@RequestParam("authority") String authority,MemberVO member) {
		service.insertMember(member, authority);
		return "join/join_success";
	}
	
	/*ȸ����������*/
	@RequestMapping(value ="/myPage.amg", method=RequestMethod.GET)
	public String myPage(Principal principal,Model model ) {
		MemberVO member = service.selectMember(principal.getName());
		model.addAttribute("member", member);
		return "user_page";
	}

}
