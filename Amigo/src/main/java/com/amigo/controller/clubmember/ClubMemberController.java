package com.amigo.controller.clubmember;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.amigo.service.clubmember.ClubMemberService;
import com.amigo.vo.clubmember.ClubMemberVO;

@Controller
@RequestMapping("/clubMember")
public class ClubMemberController {

	@Inject
	private ClubMemberService service;
	
	@RequestMapping(value = "/getNickname.amg", method=RequestMethod.POST)
	public @ResponseBody ClubMemberVO getNickName(@RequestBody Map<String,Object> map ) {
			
		String username = (String) map.get("userName");
		int cNum = (int) map.get("cNum");
		
		ClubMemberVO clubMember = service.selectNickname(username,cNum);
		
		return clubMember;
	}
}
