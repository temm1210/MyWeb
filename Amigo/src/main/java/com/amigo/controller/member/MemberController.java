package com.amigo.controller.member;

import java.security.Principal;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.amigo.service.file.FileUpLoad;
import com.amigo.service.member.MemberService;
import com.amigo.vo.member.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	/*프로필사진이 저장될 폴더이름*/
	private static final String PROFILE_IMAGES_FOLDER="member_images";
	
	@Inject
	private MemberService service;
	
	@Inject
	private FileUpLoad fileUpload;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	/*로그인폼*/
	@RequestMapping("/login.amg")
	public String login(HttpServletRequest request,	Model model,
						@RequestParam(value="state",defaultValue="loing_success") String state) {
		model.addAttribute("state", state);
		if(state.equals("loing_success"))
			request.getSession().setAttribute("prevpage", request.getHeader("referer"));
		return "login/login";
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
	
	/*회원정보보기*/
	@RequestMapping(value ="/modify_check.amg", method=RequestMethod.GET)
	public String myPage() {
		return "modify/modify_check";
	}
	
	
	@RequestMapping(value="/modify_entry.amg",method=RequestMethod.POST)
	public String modifyCheck(@RequestParam("password") String password,RedirectAttributes redirectAttr) {
		
		
		/*시큐리티 인증정보를 가져옴*/
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		/*시큐리티인증정보를 가져온걸 MemberVO로 캐스팅*/
		MemberVO member = (MemberVO) auth.getPrincipal();
		String path="";
		
		if(passwordEncoder.matches(password,member.getPassword())) {
			path="modify/modify_entry";
		} else {
			/*리다이렉트시 데이터를넘김 컨트롤러에서 별도의작업없이 바로 jsp에서 msg사용가능(post와 비슷하게보냄)*/
			redirectAttr.addFlashAttribute("msg", "updateCheck_fail");
			path ="redirect:/member/modify_check.amg";
		}
		return path;
	}
	
	/*회원수정에서 내정보를 표시*/
	@RequestMapping("/modify_update.amg")
	public String modify(Principal principal,Model model ) {	
		
		MemberVO member = service.selectMember(principal.getName());
		model.addAttribute("member", member);
		return "modify/modify_update";
	}

	/*회원정보 수정하고 수정버튼 눌렀을때*/
	@RequestMapping(value="/modify_ok.amg", method=RequestMethod.POST)
	public String modifyOk(MemberVO member,
						  MultipartHttpServletRequest request,
						  @RequestParam(value="prev_pic") String prevFileName,
						  @RequestParam(value="pic",defaultValue="") MultipartFile file,
						  @RequestParam(value="isChange") String isChange) {
		
		String updatePicName=null;
		String dbPwd = member.getPassword();
		/*비밀번호 인코딩*/
		member.setPassword(passwordEncoder.encode(dbPwd));
		
		/*프로필사진이 변경되었으면*/
		if(isChange.equals("change")) {
			System.out.println("삭제");
			System.out.println("삭제파일이름:"+prevFileName);
			/*기존프로필 사진 삭제*/
			fileUpload.deleteFile(request, PROFILE_IMAGES_FOLDER, prevFileName);
			/*등록한 프로필사진 불러오기*/
			updatePicName = fileUpload.fileForm(file, request, PROFILE_IMAGES_FOLDER);
			
		}else {
			/*프로필 사진을 변경하지 않았으면 기존프로필사진 사용*/
			updatePicName=prevFileName;
		}
			
		member.setmPic(updatePicName);;
		service.updateMember(member);
		
		/*수정후의 memberVO객체를 DB로부터 가져와서 시큐리티인증정보를 저장하는 SecurityContextHolder에 넣어서 갱신*/
		MemberVO updatedMember = service.selectMember(member.getUsername());
		SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken(updatedMember,null, updatedMember.getAuthorities()));;
		return "redirect:/main.amg";
	}
	
	/*회원가입 성공했을떄 띄워주는 페이지*/
	@RequestMapping(value = "/joinSuccess.amg",method=RequestMethod.POST)
	public String joinSuccess(@RequestParam("authority") String authority,
							  @RequestParam(value="pic",defaultValue="") MultipartFile file,
							  MultipartHttpServletRequest request,
							  MemberVO member) {
		/*프로필 사진 업로드*/
		String picName = fileUpload.fileForm(file, request, PROFILE_IMAGES_FOLDER);
		
		String dbPwd = member.getPassword();
		member.setPassword(passwordEncoder.encode((dbPwd)));
		/*업로드한 파일 이름 DB에저장*/
		member.setmPic(picName);
		service.insertMember(member, authority);
		return "join/join_success";
	}
	
	@RequestMapping("modify_delete.amg")
	public String modifyDelete(RedirectAttributes redirectAttr) {
		return "modify/modify_delete";
	}
	
	@RequestMapping("/modify_delete_ok.amg")
	public String modifyDeleteOk(RedirectAttributes redirectAttr,Authentication auth ) {
		service.deleteMember(auth.getName());
		redirectAttr.addFlashAttribute("msg", "delete_success");
		
		/*강제로그아웃*/
		SecurityContextHolder.clearContext();
		return "redirect:/main.amg";
	}
}
