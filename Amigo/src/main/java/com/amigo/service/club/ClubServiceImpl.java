package com.amigo.service.club;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import com.amigo.dao.club.ClubDAO;
import com.amigo.util.ClubSearchCriteria;
import com.amigo.util.PagingHandler;
import com.amigo.vo.club.ClubVO;

@Service
public class ClubServiceImpl implements ClubService {

	@Inject
	private ClubDAO clubDao;
	
	@Override
	public int insertClub(Map<String, Object> map,String picPath) {
		// TODO Auto-generated method stub
		return clubDao.insertClub(map,picPath);
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

	/*사용자가 입력한 키워드에 맞는 동호회 가져오기*/
	@Override
	public List<ClubVO> selectClubs(ClubSearchCriteria criteria, PagingHandler pager) {
		// TODO Auto-generated method stub
		return clubDao.selectClubs(criteria,pager);
	}

	/*현재 만들어진 총 동호회 수 가져오기*/
	@Override
	public int selectClubCount(ClubSearchCriteria criteria) {
		// TODO Auto-generated method stub
		return clubDao.selectClubCount(criteria);
	}

	@Override
	public ClubVO selectClub(int cNum) {
		// TODO Auto-generated method stub
		return clubDao.selectClub(cNum);
	}

	@Override
	public List<ClubVO> selectAddress(ClubSearchCriteria criteria) {
		// TODO Auto-generated method stub
		return clubDao.selectAddress(criteria);
	}

	@Override
	public int deleteClub(int cNum) {
		// TODO Auto-generated method stub
		return clubDao.deleteClub(cNum);
	}

	@Override
	public int updateClub(ClubVO club) {
		// TODO Auto-generated method stub
		return clubDao.updateClub(club);
	}
}
