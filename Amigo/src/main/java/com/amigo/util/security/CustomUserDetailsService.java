package com.amigo.util.security;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.amigo.dao.authority.AuthorityDAO;
import com.amigo.service.member.MemberService;
import com.amigo.vo.member.MemberVO;

@Service("CustomUserDetailsService")
public class CustomUserDetailsService implements UserDetailsService {
	
	@Inject
	private AuthorityDAO authorDAO;
	
	@Inject
	private MemberService memberService;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		MemberVO memberVo = memberService.selectMember(username);
		
		System.out.println("���񽺰���?");
		/*���̵� �´��� Ȯ��*/
		if(memberVo == null)
			throw new UsernameNotFoundException("��ȿ���� ���� ���̵��Դϴ�");
		
		/*��ȿ�� ���̵� �ش��ϴ� ������ �����´�*/
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		
		/*������ ���ѵ��� GrantedAuthority �������̽��� ��ӹ��� Ŭ������ ������ �����Ѵ�*/
		for(String str : authorDAO.selectAuthor(username))
			authorities.add(new SimpleGrantedAuthority(str));
		
		/*������ ������ ���� UserDetails ��ü*/
		memberVo.setAuthorities(authorities);
		System.out.println("����üũ:"+memberVo.getAuthorities());
		
		return memberVo;
	}
}
