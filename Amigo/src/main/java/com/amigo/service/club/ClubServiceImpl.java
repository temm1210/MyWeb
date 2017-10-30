package com.amigo.service.club;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import com.amigo.dao.club.ClubDAO;
import com.amigo.dao.clubmember.ClubMemberDAO;
import com.amigo.vo.club.ClubVO;
import com.amigo.vo.clubmember.ClubMemberVO;


@Service
public class ClubServiceImpl implements ClubService {

	@Inject
	private ClubDAO clubDao;
	
	@Inject
	private ClubMemberDAO clubMemberDao; 
	
	
	/*AOP Ʈ����� ó��*/
	@Override
	public int insertClub(Map<String, Object> map,String picPath) {
		// TODO Auto-generated method stub
		
		/*��ȣȸ ���� �����ü ����(��ȣȸ�� � ȸ���� �����ϰ��ִ��� ������ �����ϱ� ���Ѱ�ü)*/
		ClubMemberVO clubMember = new ClubMemberVO();
		
		clubMember.setNickName((String)map.get("cNickname"));
		clubMember.setMid((String)map.get("username"));
		clubMember.setcGrade("ȸ��");
		
		int ch_clubMember = clubMemberDao.insertClubMember(clubMember);
		/*------------------------------------------------------------*/
		
		/*��ȣȸ ��ü ����*/
		ClubVO club = new ClubVO();
		
		System.out.println("�г���Ȯ��:"+clubMember.getNickName());
		String area1 = (String) map.get("cArea1");
		String area2 = (String) map.get("cArea2");
		
		/*�ּҰ� ����� DB�κ��� ������ȣ���� ������*/
		int aNum = selectArea(area1, area2);
		
		/*��̰� ����� DB�κ��� ������ȣ���� ������*/
		int hNum = selectHobby((String)map.get("cHobby"));

		club.setcTitle((String)map.get("cTitle"));
		club.setcContent((String)map.get("cContent"));
		club.setcPic(picPath);
		club.setcMaster((String)map.get("cNickname"));
		club.setcArea(aNum);
		club.setcHobby(hNum);
		
		int ch_club = clubDao.insertClub(club);
		/*------------------------------------------------------------*/
		
		if(ch_clubMember > 0 && ch_club > 0)
			return 2;
		else
			return 0;
	}

	@Override
	public List<String> selectSubArea(String area1) {
		// TODO Auto-generated method stub
		return clubDao.selectSubArea(area1);
	}

	@Override
	public int selectArea(String area1, String area2) {
		// TODO Auto-generated method stub
		return clubDao.selectArea(area1, area2);
	}

	@Override
	public int selectHobby(String hobby) {
		// TODO Auto-generated method stub
		return clubDao.selectHobby(hobby);
	}


}
