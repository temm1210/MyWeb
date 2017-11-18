package com.amigo.dao.club;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.amigo.dao.clubmember.ClubMemberDAO;
import com.amigo.util.ClubSearchCriteria;
import com.amigo.util.PagingHandler;
import com.amigo.vo.club.ClubVO;
import com.amigo.vo.clubmember.ClubMemberVO;


@Repository
public class ClubDAOImpl implements ClubDAO {

	@Inject
	private SqlSession session;
	@Inject
	private ClubMemberDAO clubMemberDao; 

	@Override
	public int insertClub(Map<String, Object> map,String picPath) {
		// TODO Auto-generated method stub
		
		/*동호회 가입 멤버객체 셋팅(동호회에 어떤 회원이 가입하고있는지 정보를 저장하기 위한객체)*/
		ClubMemberVO clubMember = new ClubMemberVO();
		
		clubMember.setNickName((String)map.get("cNickname"));
		clubMember.setMid((String)map.get("username"));
		clubMember.setcGrade((String)map.get("cGrade"));
		
		int ch_clubMember = clubMemberDao.insertClubMember(clubMember);
		/*------------------------------------------------------------*/
		
		/*동호회 객체 셋팅*/
		ClubVO club = new ClubVO();
		
		/*취미가 저장된 DB로부터 고유번호값을 가져옴*/
		int hNum = selectHobby((String)map.get("cHobby"));

		club.setcTitle((String)map.get("cTitle"));
		club.setcContent((String)map.get("cContent"));
		club.setcPic(picPath);
		club.setcMaster((String)map.get("cNickname"));
		club.setcAddress((String)map.get("cAddress"));
		club.setcHobby(hNum);
		
		int ch_club = session.insert("insertClub", club);
		/*------------------------------------------------------------*/
		
		if(ch_clubMember > 0 && ch_club > 0)
			return 2;
		else
			return 0;
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

	@Override
	public List<ClubVO> selectClubs(ClubSearchCriteria criteria,PagingHandler pager) {
		// TODO Auto-generated method stub
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("start", pager.getStartRownum());
		map.put("end", pager.getEndRownum());
		map.put("criteria", criteria);
		
		return session.selectList("selectClubs", map);
	}

	@Override
	public int selectClubCount(ClubSearchCriteria criteria) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("criteria", criteria);
		return session.selectOne("selectClubCount",map);
	}

	@Override
	public ClubVO selectClub(int cNum) {
		// TODO Auto-generated method stub
		return session.selectOne("selectClub",cNum);
	}
}
