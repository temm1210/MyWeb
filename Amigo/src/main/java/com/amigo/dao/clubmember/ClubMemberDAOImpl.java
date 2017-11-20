package com.amigo.dao.clubmember;

import java.util.HashMap;
import java.util.Map;

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

	@Override
	public ClubMemberVO selectNickname(String username, int cNum) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("username", username);
		map.put("cNum", cNum);
		
		return sqlSession.selectOne("selectNickname", map);
	}
}
