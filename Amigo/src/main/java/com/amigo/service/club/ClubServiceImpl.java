package com.amigo.service.club;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import com.amigo.dao.club.ClubDAO;
import com.amigo.vo.club.ClubVO;


@Service
public class ClubServiceImpl implements ClubService {

	@Inject
	private ClubDAO dao;
	
	@Override
	public int insertClub(Map<String, Object> map,String picPath) {
		// TODO Auto-generated method stub
		String area1 = (String) map.get("cArea1");
		String area2 = (String) map.get("cArea2");
		
		/*�ּҰ� ����� DB�κ��� ������ȣ���� ������*/
		int aNum = selectArea(area1, area2);
		
		/*��̰� ����� DB�κ��� ������ȣ���� ������*/
		int hNum = selectHobby((String)map.get("cHobby"));
		
		/*��ȣȸ ��ü ����*/
		ClubVO club = new ClubVO();
		
		club.setcTitle((String)map.get("cTitle"));
		club.setcContent((String)map.get("cContent"));
		club.setcPic(picPath);
		club.setcMaster((String)map.get("username"));
		club.setcArea(aNum);
		club.setcHoby(hNum);
		
		return dao.insertClub(club);
	}

	@Override
	public List<String> selectSubArea(String area1) {
		// TODO Auto-generated method stub
		return dao.selectSubArea(area1);
	}

	@Override
	public int selectArea(String area1, String area2) {
		// TODO Auto-generated method stub
		return dao.selectArea(area1, area2);
	}

	@Override
	public int selectHobby(String hobby) {
		// TODO Auto-generated method stub
		return dao.selectHobby(hobby);
	}


}
