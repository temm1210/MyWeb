package com.amigo.service.clubmember;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.amigo.dao.clubmember.ClubMemberDAO;
import com.amigo.vo.clubmember.ClubMemberVO;

@Service
public class ClubMemberServicImpl implements ClubMemberService {

	@Inject
	private ClubMemberDAO clubMemberDao;
	
	@Override
	public ClubMemberVO selectNickname(String username, int cNum) {
		// TODO Auto-generated method stub
		return clubMemberDao.selectNickname(username, cNum);
	}

}
