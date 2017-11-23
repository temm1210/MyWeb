package com.amigo.service.clubmember;

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
	public int deleteClub(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return clubMemberDao.deleteClub(map);
	}

}
