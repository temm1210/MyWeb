package com.amigo.service.club;

import java.util.List;
import java.util.Map;

import com.amigo.util.ClubSearchCriteria;
import com.amigo.util.PagingHandler;
import com.amigo.vo.club.ClubVO;

public interface ClubService {
	public int insertClub(Map<String,Object> map,String picPath);
	public int selectHobby(String hobby);
	public List<Map<String,Object>> selectClubName(String username);
	public List<ClubVO> selectClubs(ClubSearchCriteria criteria,PagingHandler pager);
	public int selectClubCount(ClubSearchCriteria criteria);
	public ClubVO selectClub(String cTitle);
}
