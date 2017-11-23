package com.amigo.dao.club;

import java.util.List;
import java.util.Map;

import com.amigo.util.ClubSearchCriteria;
import com.amigo.util.PagingHandler;
import com.amigo.vo.club.ClubVO;

public interface ClubDAO {
	public int insertClub(Map<String, Object> map,String picPath);
	public int selectHobby(String hobby);
	public int selectCnum(String cTitle);
	public List<Map<String,Object>> selectClubName(String username);
	public List<ClubVO> selectClubs(ClubSearchCriteria criteria,PagingHandler pager);
	public int selectClubCount(ClubSearchCriteria criteria);
	public ClubVO selectClub(int cNum);
}
