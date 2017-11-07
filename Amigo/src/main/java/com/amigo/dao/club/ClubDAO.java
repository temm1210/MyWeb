package com.amigo.dao.club;

import java.util.List;
import java.util.Map;

import com.amigo.vo.club.ClubVO;

public interface ClubDAO {
	public int insertClub(ClubVO club);
	public int selectHobby(String hobby);
	public List<Map<String,Object>> selectClubName(String username);
}
