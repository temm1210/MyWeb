package com.amigo.controller.clubmember;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.amigo.service.clubmember.ClubMemberService;
import com.amigo.vo.clubmember.ClubMemberVO;

@RestController
@RequestMapping("/clubMember")
public class ClubMemberController {

	@Inject
	private ClubMemberService service;
	
	@RequestMapping(value = "/getNickname.amg", method=RequestMethod.POST)
	public ClubMemberVO getNickName(@RequestBody Map<String,Object> map ) {
			
		String username = (String) map.get("userName");
		int cNum = (int) map.get("cNum");
 		return service.selectClubMember(username,cNum);
	}
	
	@RequestMapping(value="/checkNickname.amg", method=RequestMethod.POST)
	public String checkNickname(@RequestBody Map<String,Object> map) {
		
		boolean ch = service.selectNickname(map);
		
		return (ch==true)?"success_check":"fail_check";
	}
	
	@RequestMapping(value="/joinClub.amg", method=RequestMethod.POST,produces = "application/text; charset=utf8")
	public String joinClub(@RequestBody ClubMemberVO clubMember) {
		
		int ch = service.joinClub(clubMember);
		return (ch>0)?"동호회 가입에 성공 하였습니다.":"동호회 가입에 실패 하였습니다";
	}
	
	@RequestMapping(value="/leaveClub.amg",method=RequestMethod.DELETE,produces = "application/text; charset=utf8")
	public String leaveClub(@RequestBody Map<String,Object> map) {
		
		int ch = service.leaveClub(map);
		
		return (ch>0)?"정상적으로 탈퇴 되었습니다.":"탈퇴에 실패 하였습니다";
	}
	
	@RequestMapping(value="/memberList.amg",method=RequestMethod.GET)
	public ModelAndView memberList(@RequestParam("cNum") int cNum){
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("club/club_memberList");
		mav.addObject("member", service.selectClubmembers(cNum));
		
		return mav;
	}
	
	@RequestMapping(value="/memberLevel.amg", method=RequestMethod.POST,produces = "application/text; charset=utf8")
	public String memberLevel(@RequestBody Map<String,Object> map) {
		
		return service.updateGrade(map);
	}
}
