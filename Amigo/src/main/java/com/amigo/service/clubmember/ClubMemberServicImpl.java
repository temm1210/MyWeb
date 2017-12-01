package com.amigo.service.clubmember;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.amigo.dao.clubmember.ClubMemberDAO;
import com.amigo.vo.clubmember.ClubMemberVO;

@Service
public class ClubMemberServicImpl implements ClubMemberService {

	@Inject
	private ClubMemberDAO clubMemberDao;
	
	@Override
	public ClubMemberVO selectClubMember(String username, int cNum) {
		// TODO Auto-generated method stub
		return clubMemberDao.selectClubMember(username, cNum);
	}

	@Override
	public boolean selectNickname(Map<String,Object> map) {
		// TODO Auto-generated method stub
		return clubMemberDao.selectNickname(map);
	}

	@Override
	public int joinClub(ClubMemberVO clubMember) {
		// TODO Auto-generated method stub	
		return clubMemberDao.joinClub(clubMember);
	}

	@Override
	public int leaveClub(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return clubMemberDao.leaveClub(map);
	}

	@Override
	public List<ClubMemberVO> selectClubmembers(int cNum) {
		// TODO Auto-generated method stub
		return clubMemberDao.selectClubmembers(cNum);
	}

	@Override
	public String updateGrade(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return clubMemberDao.updateGrade(map);
	}

}
