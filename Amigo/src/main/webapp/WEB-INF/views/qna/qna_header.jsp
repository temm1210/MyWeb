<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header/topMenu.jsp" %>
<link rel="stylesheet" href="<c:url value="/resources/css/qna/qna_header.css" />">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	#main_img{
		padding-top:440px;
		background-image: url("<c:url value="/resources/images/question1.jpg"/>");
		background-position: center;
		background-size: cover;
		background-repeat: no-repeat; 
		opacity: 0.8;
		width:100%;
		height:100px; 
	}
</style>
<div id="main_img">
	<h2>궁금한게 있으시면 무엇이든 물어보세요</h2>
</div>
<div id="aside">
	<ul>
		<li><span>고객센터</span>
			<ul class="sub_ul">
				<li><a href="${location}/qna/faq.amg" id="fnq_link"><i class="fa fa-server" id="fnq" aria-hidden="true"></i>F&Q</a></li>
				<li><a href="${location}/qna/qna.amg" id="qna_link"><i class="fa fa-server" id="qna" aria-hidden="true"></i>1:1문의</a></li>
			</ul>
		</li>
	</ul>
</div>