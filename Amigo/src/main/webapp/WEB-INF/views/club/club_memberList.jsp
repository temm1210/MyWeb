<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="<c:url value="/resources/script/club/club_level.js"/>"></script>
<c:url var="memberImg" value="/resources/images/member_images" />
<c:set var="location" value="${pageContext.request.contextPath}"/>

<style>
	.member{
		border-bottom: 1px solid rgba(0,0,0,.2);
    	padding: 20px;
	}
	.mpic > img{
		border-radius: 50%;
		vertical-align: middle;
		padding-right: 10px;
	}
	.memberPic{
		font-size: 60px;
		vertical-align: middle;
		padding-right: 10px;
	}
	.cmregdate{
		display: inline-block;
		width: 180px;
		padding-right: 30px;
	}
	.nickName{
		display: inline-block;
		width: 150px;
		background: none;
	    border: none;
	    font-family: 'Jeju Gothic', serif;
	    font-size: 15px;
	}
	.cgrade{
		padding-right: 50px;
		width: 70px;
    	display: inline-block;
	}
	#levelUp{
		display: inline-block;
		width: 80px;
	}
	#levelDown{
		display: inline-block;
		border-left: 1px solid rgba(0,0,0,.5);
		padding-left: 10px;
		width: 124px;
	}
</style>

<script>
	$(document).ready(function(){
		//처음에 등업시켜주는 버튼들 전부감춤
		$(".contentLevel").css("display","none")
		var master = $("#clubMaster").text();

		var obj = JSON.parse(sessionStorage.getItem('isMember'))
		
		//로그인한 유저가 동호회 회장이거나, 관리자일시 등업버튼 보여줌
		if(obj.cNickname == master || userName == "STW")
			$(".contentLevel").css("display","inline-block");
	})
</script>
<div id="clubMemberContainer">
	<div id="memberWrap">
		<ul>
			<c:forEach var="member" items="${member}" >
				<li class="member">
					<div class="membersInfo">
						<c:choose>
							<c:when test="${member.mPic != null}">
								<span class="memberinfo mpic"><img height="60px" width="60px" src="${memberImg}/${member.mPic}"></span>
							</c:when>
							
							<c:otherwise>
								<span><i class="fa fa-user-circle memberPic" aria-hidden="true"></i></span>
							</c:otherwise>
						</c:choose>
						<input type="text" class="nickName memberinfo" value="${member.cNickname}">
						<span class="memberinfo cmregdate"><fmt:formatDate value="${member.cmRegdate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
						<span class="memberinfo writerGrade cgrade">${member.cGrade}</span>
						
								
						<div class="contentLevel">
							<c:if test="${member.cGrade != '매니저'}">
								<c:if test="${member.cGrade != '부매니저'}">
									<span class="memberinfo"><a href="javascript:void(0)" id="levelUp" onclick="levelUpAjax('${location}/clubMember/memberLevel.amg','등급업','${member.cNickname}')">등업시키기</a></span>
								</c:if>
								
								<c:if test="${member.cGrade != '신입회원'}">
									<span class="memberinfo"><a href="javascript:void(0)" id="levelDown" onclick="levelUpAjax('${location}/clubMember/memberLevel.amg','등급다운','${member.cNickname}')">등급다운시키기</a></span>
								</c:if>
							</c:if>
							<input type="hidden" id="cnum" value="${member.cNum}">
						</div><!-- contentLevel -->
					</div><!-- membersInfo-->
				</li>
			</c:forEach>
		</ul>
	</div>
</div>