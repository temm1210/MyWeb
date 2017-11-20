package com.amigo.dao.clubmember;

import com.amigo.vo.clubmember.ClubMemberVO;

public interface ClubMemberDAO {
	public int insertClubMember(ClubMemberVO clubMember);
	public ClubMemberVO selectNickname(String username,int cNum);
}
