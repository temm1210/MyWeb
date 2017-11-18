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
		
		/*��ȣȸ ���� �����ü ����(��ȣȸ�� � ȸ���� �����ϰ��ִ��� ������ �����ϱ� ���Ѱ�ü)*/
		ClubMemberVO clubMember = new ClubMemberVO();
		
		clubMember.setNickName((String)map.get("cNickname"));
		clubMember.setMid((String)map.get("username"));
		clubMember.setcGrade((String)map.get("cGrade"));
		
		int ch_clubMember = clubMemberDao.insertClubMember(clubMember);
		/*------------------------------------------------------------*/
		
		/*��ȣȸ ��ü ����*/
		ClubVO club = new ClubVO();
		
		/*��̰� ����� DB�κ��� ������ȣ���� ������*/
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
