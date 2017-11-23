package com.amigo.service.clubmember;

import java.util.Map;

import com.amigo.vo.clubmember.ClubMemberVO;

public interface ClubMemberService {

	public ClubMemberVO selectClubMember(String username, int cNum);
	public boolean selectNickname(Map<String,Object> map);
	public int joinClub(ClubMemberVO clubMember);
	public int deleteClub(Map<String,Object> map);
	
}
