package com.amigo.util.security;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

/*�������� ���� ������ �����ϰ��� �ҋ� ����Ǵ� �ڵ鷯*/
public class InterceptFailureHandler implements AuthenticationEntryPoint {

	@Override
	public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException arg2)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		
		response.setContentType("text/html; charset=EUC-KR");
		PrintWriter out = response.getWriter();
		String output = null;
		
		output+="<script>";
		
		output+="if( confirm('�α����� �̿밡���� �����Դϴ�. �α��� �Ͻðڽ��ϱ�?') )";
		output+="{";
		output+="location.href='/member/login.amg'";
		output+="}";
		
		output+="else";
		output+="{";
		output+="history.back()";
		output+="}";
		
		output+="</script>";
		/*out.println("<script> if(confirm('�α����� �̿밡���� �����Դϴ�.�α��� �Ͻðڽ��ϱ�?')){ location.href='/member/login.amg';}</script>");*/
		out.println(output);

		out.flush();

	}

}
