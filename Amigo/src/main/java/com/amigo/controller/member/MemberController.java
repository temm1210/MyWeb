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

import com.amigo.service.file.FileUpLoad;
import com.amigo.service.member.MemberService;
import com.amigo.vo.member.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {

	private static final String PROFILE_IMAGES_FOLDER="member_images";
	@Inject
	private MemberService service;
	
	@Inject
	private FileUpLoad fileUpload;

	/*����Ȩ������*/
	@RequestMapping("/main.amg")
	public String main() {
		return "main";
	}
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
	
	/*ȸ����������*/
	@RequestMapping(value ="/modify.amg", method=RequestMethod.GET)
	public String myPage(Principal principal,Model model ) {
		return "modify/modify";
	}
	
	
	/*ȸ���������� �������� ǥ��*/
	@RequestMapping("/modify_update.amg")
	public String modify(Principal principal,Model model ) {	
		MemberVO member = service.selectMember(principal.getName());
		model.addAttribute("member", member);
		return "modify/modify_update";
	}

	/*ȸ������ �����ϰ� ������ư ��������*/
	@RequestMapping(value="/modify_ok.amg", method=RequestMethod.POST)
	public String modifyOk(MemberVO member,
						  MultipartHttpServletRequest request,
						  @RequestParam(value="prev_pic",defaultValue="") String deleteFileName,
						  @RequestParam(value="pic",defaultValue="") MultipartFile file) {
		
		/*���������� ���� ����*/
		fileUpload.deleteFile(request, PROFILE_IMAGES_FOLDER, deleteFileName);
		
		
		/*������ �̹��� ����*/
		String picName = fileUpload.fileForm(file, request, PROFILE_IMAGES_FOLDER);
		member.setmPic(picName);
		
		service.updateMember(member);
		
		/*�������� memberVO��ü�� DB�κ��� �����ͼ� ��ť��Ƽ���������� �����ϴ� SecurityContextHolder�� �־ ����*/
		MemberVO updatedMember = service.selectMember(member.getUsername());
		SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken(updatedMember,null, updatedMember.getAuthorities()));;
		return "redirect:/member/main.amg";
	}
	
	/*ȸ������ ���������� ����ִ� ������*/
	@RequestMapping(value = "/joinSuccess.amg",method=RequestMethod.POST)
	public String joinSuccess(@RequestParam("authority") String authority,
							  @RequestParam(value="pic",defaultValue="") MultipartFile file,
							  MultipartHttpServletRequest request,
							  MemberVO member) {
		/*������ ���� ���ε�*/
		String picName = fileUpload.fileForm(file, request, PROFILE_IMAGES_FOLDER);
		
		/*���ε��� ���� �̸� DB������*/
		member.setmPic(picName);
		service.insertMember(member, authority);
		return "join/join_success";
	}
}
