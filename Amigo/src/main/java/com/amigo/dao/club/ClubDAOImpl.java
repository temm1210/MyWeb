package com.amigo.dao.club;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.amigo.vo.club.ClubVO;


@Repository
public class ClubDAOImpl implements ClubDAO {

	@Inject
	private SqlSession session;

	@Override
	public int insertClub(ClubVO club) {
		// TODO Auto-generated method stub
		return session.insert("insertClub", club);
	}

	@Override
	public int selectHobby(String hobby) {
		// TODO Auto-generated method stub
		return session.selectOne("selectHobby", hobby);
	}

	@Override
	public List<Map<String,Object>> selectClubName(String username) {
		// TODO Auto-generated method stub
		return session.selectList("selectClubName",username);
	}
}
