package com.amigo.service.club;

import java.util.List;
import java.util.Map;

public interface ClubService {
	public int insertClub(Map<String,Object> map,String picPath);
	public int selectHobby(String hobby);
	public List<Map<String,Object>> selectClubName(String username);
}
