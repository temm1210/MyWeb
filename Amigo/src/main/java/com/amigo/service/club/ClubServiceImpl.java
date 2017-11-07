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
		
		/*취미가 저장된 DB로부터 고유번호값을 가져옴*/
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
	
	/*취미에 해당하는 고유 번호가져오기 스키마{1 . 자연} 자연이라면 1번을가져옴*/
	@Override
	public int selectHobby(String hobby) {
		// TODO Auto-generated method stub
		return clubDao.selectHobby(hobby);
	}
	/*해당아이디로 가입된 동호회의 사진이랑 이름을 가져옴*/
	@Override
	public List<Map<String,Object>> selectClubName(String username) {
		// TODO Auto-generated method stub
		return clubDao.selectClubName(username);
	}
}
