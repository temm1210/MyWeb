package com.amigo.dao.clubmember;

import java.util.HashMap;
import java.util.List;
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
	public ClubMemberVO selectClubMember(String username, int cNum) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("username", username);
		map.put("cNum", cNum);
		
		return sqlSession.selectOne("selectClubMember", map);
	}

	@Override
	public boolean selectNickname(Map<String,Object> map) {
		// TODO Auto-generated method stub
		
		ClubMemberVO clubMember = sqlSession.selectOne("selectNickname", map);
		return (clubMember == null)?true:false;
	}

	@Override
	public int joinClub(ClubMemberVO clubMember) {
		// TODO Auto-generated method stub
		return sqlSession.insert("joinClub", clubMember);
	}

	@Override
	public int leaveClub(Map<String, Object> map) {
		// TODO Auto-generated method stub
		int ch = sqlSession.delete("leaveClub", map);
		
		return ch;
	}

	@Override
	public List<ClubMemberVO> selectClubmembers(int cNum) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("selectClubmembers", cNum);
	}

	@Override
	public String updateGrade(Map<String, Object> map) {
		// TODO Auto-generated method stub
		sqlSession.update("updateGrade", map);
		return (String) map.get("cGrade");
	}
}
