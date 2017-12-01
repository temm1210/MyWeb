package com.amigo.dao.clubmember;

import java.util.List;
import java.util.Map;

import com.amigo.vo.clubmember.ClubMemberVO;

public interface ClubMemberDAO {
	public int insertClubMember(ClubMemberVO clubMember);
	public ClubMemberVO selectClubMember(String username,int cNum);
	public boolean selectNickname(Map<String,Object> map);
	public int joinClub(ClubMemberVO clubMember);
	public int leaveClub(Map<String,Object> map);
	public List<ClubMemberVO> selectClubmembers(int cNum);
	public String updateGrade(Map<String,Object> map);
}
