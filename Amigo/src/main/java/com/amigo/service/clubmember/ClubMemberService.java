package com.amigo.service.clubmember;

import com.amigo.vo.clubmember.ClubMemberVO;

public interface ClubMemberService {

	public ClubMemberVO selectNickname(String username, int cNum);
	
}
