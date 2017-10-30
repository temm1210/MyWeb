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
	
	
	/*AOP 트랜잭션 처리*/
	@Override
	public int insertClub(Map<String, Object> map,String picPath) {
		// TODO Auto-generated method stub
		
		/*동호회 가입 멤버객체 셋팅(동호회에 어떤 회원이 가입하고있는지 정보를 저장하기 위한객체)*/
		ClubMemberVO clubMember = new ClubMemberVO();
		
		clubMember.setNickName((String)map.get("cNickname"));
		clubMember.setMid((String)map.get("username"));
		clubMember.setcGrade("회장");
		
		int ch_clubMember = clubMemberDao.insertClubMember(clubMember);
		/*------------------------------------------------------------*/
		
		/*동호회 객체 셋팅*/
		ClubVO club = new ClubVO();
		
		System.out.println("닉네임확인:"+clubMember.getNickName());
		String area1 = (String) map.get("cArea1");
		String area2 = (String) map.get("cArea2");
		
		/*주소가 저장된 DB로부터 고유번호값을 가져옴*/
		int aNum = selectArea(area1, area2);
		
		/*취미가 저장된 DB로부터 고유번호값을 가져옴*/
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
