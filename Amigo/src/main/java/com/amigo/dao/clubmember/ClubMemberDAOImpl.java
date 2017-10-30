package com.amigo.dao.clubmember;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.amigo.vo.clubmember.ClubMemberVO;

@Repository
public class ClubMemberDAOImpl implements ClubMemberDAO {

	@Inject
	private SqlSession sqlSession;
	
	@Override
	public int insertClubMember(ClubMemberVO clubMember) {
		// TODO Auto-generated method stub
		return sqlSession.insert("insertClubMember", clubMember);
	}
}
