package com.amigo.util.security;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

/*인증되지 않은 유저가 접근하고자 할떄 실행되는 핸들러*/
public class InterceptFailureHandler implements AuthenticationEntryPoint {

	@Override
	public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException arg2)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		
		response.setContentType("text/html; charset=EUC-KR");
		PrintWriter out = response.getWriter();
		String output = null;
		
		output+="<script>";
		
		output+="if( confirm('로그인후 이용가능한 서비스입니다. 로그인 하시겠습니까?') )";
		output+="{";
		output+="location.href='/member/login.amg'";
		output+="}";
		
		output+="else";
		output+="{";
		output+="history.back()";
		output+="}";
		
		output+="</script>";
		/*out.println("<script> if(confirm('로그인후 이용가능한 서비스입니다.로그인 하시겠습니까?')){ location.href='/member/login.amg';}</script>");*/
		out.println(output);

		out.flush();

	}

}
