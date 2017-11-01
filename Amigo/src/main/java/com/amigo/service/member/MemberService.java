package com.amigo.service.member;

import com.amigo.vo.member.MemberVO;

public interface MemberService {

	public void insertMember(MemberVO member,String authority);
	public MemberVO selectMember(String mid);
	public void updateMember(MemberVO member);
}
