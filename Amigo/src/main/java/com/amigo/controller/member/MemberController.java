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

	/*로그인폼*/
	@RequestMapping("/login.amg")
	public String login(HttpServletRequest request,	Model model,
						@RequestParam(value="state",defaultValue="success") String state) {
		System.out.println("리퍼:"+request.getHeader("referer"));
		
		model.addAttribute("state", state);
		if(state.equals("success"))
			request.getSession().setAttribute("prevpage", request.getHeader("referer"));
		return "login";
	}
	
	/*첫번째 회원가입폼(약관동의)*/
	@RequestMapping("/joinFirst.amg")
	public String joinFirst() {
		return "join/join_first";
	}
	
	/*두번째 정보 입력*/
	@RequestMapping("/joinSecond.amg")
	public String joinSecond() {
		return "join/join_second";
	}
	
	/*회원가입 성공했을떄 띄워주는 페이지*/
	@RequestMapping(value = "/joinSuccess.amg",method=RequestMethod.POST)
	public String joinSuccess(@RequestParam("authority") String authority,
							  @RequestParam(value="pic",defaultValue="") MultipartFile file,
							  MultipartHttpServletRequest request,
							  MemberVO member) {
		/*유저가 프로필 사진을 등록했을떄*/
	
		FileUpLoad ful = new FileUpLoad();
		String picName = ful.fileForm(file, request, "member_images");
		member.setmPic(picName);
		service.insertMember(member, authority);
		return "join/join_success";
	}
	
	/*회원정보보기*/
	@RequestMapping(value ="/modify.amg", method=RequestMethod.GET)
	public String myPage(Principal principal,Model model ) {
		return "modify";
	}
	
	
	/*회원수정에서 내정보를 표시*/
	@RequestMapping("/modify_update.amg")
	public String modify(Principal principal,Model model ) {	
		MemberVO member = service.selectMember(principal.getName());
		model.addAttribute("member", member);
		return "modify_update";
	}
	
	/*회원정보 수정하고 수정버튼 눌렀을때*/
	@RequestMapping(value="/modify_ok.amg", method=RequestMethod.POST)
	public String modifyOk(MemberVO member,
						  MultipartHttpServletRequest request,
						  @RequestParam(value="pic",defaultValue="") MultipartFile file) {
		
		FileUpLoad ful = new FileUpLoad();
		String picName = ful.fileForm(file, request, "member_images");
		System.out.println("파일이름:"+picName);
		member.setmPic(picName);
		service.updateMember(member);
		
		/*수정후의 memberVO객체를 DB로부터 가져와서 시큐리티인증정보를 저장하는 SecurityContextHolder에 넣어서 갱신*/
		MemberVO updatedMember = service.selectMember(member.getUsername());
		SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken(updatedMember,null, updatedMember.getAuthorities()));;
		return "index";
	}
}
