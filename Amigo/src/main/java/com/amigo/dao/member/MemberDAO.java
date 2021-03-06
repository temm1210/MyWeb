package com.amigo.dao.member;

import com.amigo.vo.member.MemberVO;

public interface MemberDAO {

	public void insertMember(MemberVO member);
	public MemberVO selectMember(String username);
	public void updateMember(MemberVO member);
	public int deleteMember(String username);
}
