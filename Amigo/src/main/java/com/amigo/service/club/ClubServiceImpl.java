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
		
		/*��̰� ����� DB�κ��� ������ȣ���� ������*/
		int hNum = selectHobby((String)map.get("cHobby"));

		club.setcTitle((String)map.get("cTitle"));
		club.setcContent((String)map.get("cContent"));
		club.setcPic(picPath);
		club.setcMaster((String)map.get("cNickname"));
		club.setcAddress((String)map.get("cAddress"));
		club.setcHobby(hNum);
		
		int ch_club = clubDao.insertClub(club);
		/*------------------------------------------------------------*/
		
		if(ch_clubMember > 0 && ch_club > 0)
			return 2;
		else
			return 0;
	}
	
	/*��̿� �ش��ϴ� ���� ��ȣ�������� ��Ű��{1 . �ڿ�} �ڿ��̶�� 1����������*/
	@Override
	public int selectHobby(String hobby) {
		// TODO Auto-generated method stub
		return clubDao.selectHobby(hobby);
	}
	/*�ش���̵�� ���Ե� ��ȣȸ�� �����̶� �̸��� ������*/
	@Override
	public List<Map<String,Object>> selectClubName(String username) {
		// TODO Auto-generated method stub
		return clubDao.selectClubName(username);
	}
}
