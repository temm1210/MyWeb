package com.amigo.dao.member;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.amigo.vo.member.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Inject
	private SqlSession sqlSession;

	@Override
	public void insertMember(MemberVO member) {
		// TODO Auto-generated method stub
		sqlSession.insert("insertMember", member);
	}

	@Override
	public MemberVO selectMember(String username) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("selectMember", username);
	}

	@Override
	public void updateMember(MemberVO member) {
		// TODO Auto-generated method stub
		sqlSession.update("updateMember", member);
	}

	@Override
	public int deleteMember(String username) {
		// TODO Auto-generated method stub
		return sqlSession.delete("deleteMember", username);
	}
}
