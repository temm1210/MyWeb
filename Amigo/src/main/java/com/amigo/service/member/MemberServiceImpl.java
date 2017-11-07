package com.amigo.service.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.amigo.dao.authority.AuthorityDAO;
import com.amigo.dao.member.MemberDAO;
import com.amigo.vo.member.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private AuthorityDAO authorDao;
	
	@Autowired
	private MemberDAO memberDao;
	
	/*AOP 트랜잭션 처리*/
	@Override
	public void insertMember(MemberVO member,String authority) {
		// TODO Auto-generated method stub	
		memberDao.insertMember(member);
		authorDao.insertUser(member.getUsername(), authority);
	}
	
	@Override
	public MemberVO selectMember(String username) {
		// TODO Auto-generated method stub
		return memberDao.selectMember(username);
	}

	@Override
	public void updateMember(MemberVO member) {
		// TODO Auto-generated method stub
		memberDao.updateMember(member);
	}

	@Override
	public int deleteMember(String username) {
		// TODO Auto-generated method stub
		return memberDao.deleteMember(username);
	}
}