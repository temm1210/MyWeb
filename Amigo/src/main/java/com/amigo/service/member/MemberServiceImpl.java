package com.amigo.service.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.amigo.dao.authority.AuthorityDAO;
import com.amigo.dao.member.MemberDAO;
import com.amigo.vo.member.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
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
	public MemberVO selectMember(String mid) {
		// TODO Auto-generated method stub
		return memberDao.selectMember(mid);
	}

	@Override
	public void updateMember(MemberVO member) {
		// TODO Auto-generated method stub
		String dbPwd = member.getPassword();
		member.setPassword(passwordEncoder.encode(dbPwd));
		memberDao.updateMember(member);
		
	}

}
