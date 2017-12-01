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

	/*����ڰ� �Է��� Ű���忡 �´� ��ȣȸ ��������*/
	@Override
	public List<ClubVO> selectClubs(ClubSearchCriteria criteria, PagingHandler pager) {
		// TODO Auto-generated method stub
		return clubDao.selectClubs(criteria,pager);
	}

	/*���� ������� �� ��ȣȸ �� ��������*/
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
