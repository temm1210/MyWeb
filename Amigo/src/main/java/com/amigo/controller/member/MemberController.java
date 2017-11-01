package com.amigo.controller.member;

import java.security.Principal;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.amigo.service.member.MemberService;
import com.amigo.util.file.FileUpLoad;
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
	
	/*ȸ������ ���������� ����ִ� ������*/
	@RequestMapping(value = "/joinSuccess.amg",method=RequestMethod.POST)
	public String joinSuccess(@RequestParam("authority") String authority,
							  @RequestParam(value="pic",defaultValue="") MultipartFile file,
							  MultipartHttpServletRequest request,
							  MemberVO member) {
		/*������ ������ ������ ���������*/
	
		FileUpLoad ful = new FileUpLoad();
		String picName = ful.fileForm(file, request, "member_images");
		member.setmPic(picName);
		service.insertMember(member, authority);
		return "join/join_success";
	}
	
	/*ȸ����������*/
	@RequestMapping(value ="/modify.amg", method=RequestMethod.GET)
	public String myPage(Principal principal,Model model ) {
		return "modify";
	}
	
	
	/*ȸ���������� �������� ǥ��*/
	@RequestMapping("/modify_update.amg")
	public String modify(Principal principal,Model model ) {	
		MemberVO member = service.selectMember(principal.getName());
		model.addAttribute("member", member);
		return "modify_update";
	}
	
	/*ȸ������ �����ϰ� ������ư ��������*/
	@RequestMapping(value="/modify_ok.amg", method=RequestMethod.POST)
	public String modifyOk(MemberVO member,
						  MultipartHttpServletRequest request,
						  @RequestParam(value="pic",defaultValue="") MultipartFile file) {
		
		FileUpLoad ful = new FileUpLoad();
		String picName = ful.fileForm(file, request, "member_images");
		System.out.println("�����̸�:"+picName);
		member.setmPic(picName);
		service.updateMember(member);
		
		/*�������� memberVO��ü�� DB�κ��� �����ͼ� ��ť��Ƽ���������� �����ϴ� SecurityContextHolder�� �־ ����*/
		MemberVO updatedMember = service.selectMember(member.getUsername());
		SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken(updatedMember,null, updatedMember.getAuthorities()));;
		return "index";
	}
}
