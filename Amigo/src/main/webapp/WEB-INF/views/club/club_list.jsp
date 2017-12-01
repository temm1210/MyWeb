<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="<c:url value="/resources/css/club/club_list.css"/>">
<c:url var="clubImg" value="/resources/images/club_images" />
<c:url var="memberImg" value="/resources/images/member_images" />
<c:set var="location" value="${pageContext.request.contextPath}"/>

<script>
	$(document).ready(function(){
		
		$(".clubwrap").hover(function() {
			// 마우스 오버 일 경우 이벤트 발생
			showMarker( $(this).find(".cAddress").val())
			return false;
			
			}, function() {
			// 마우스 아웃 일 경우 또다른 이벤트 발생
				hideMarkers();
			
			});
	})
	
	function blockOrNoneClub(){
		if( cNumJSON!=null ){
			$.each(cNumJSON.clubNumber,function(index,club){

				var itemBox = $(".item-box")
				
				$.each(itemBox,function(index,element){
					var rowNum="row_"+club.cNum;
					if($(element).hasClass(rowNum)){
						
						console.log("안옴?"+club.cNum)
						$(element).removeClass("viewClub")
					}else{
						$(element).addClass("viewClub")
					}
				})
				
			});//each
		}
	}
</script>
<style>
.viewClub{
	display: none;
}
</style>
<span class="total_count">동호회수:${map.totalClubCount}</span>
<div id="article_container">
	<div class="first-article">
		<c:forEach var="clubList" items="${map.clubList}">
			<div class="item-box clubwrap row_${clubList.cNum}">
				<div class="club_row">
					<a href="${location}/club/club.amg?cNum=${clubList.cNum}">
						<div class="club-box"> 
							<div id="img_club" style="background-image:url('${clubImg}/${clubList.cPic}')" ></div>
						</div>  
						
						<div class="item_comment">
							<p class="club_title">${clubList.cTitle}</p>
							<br/>
							<br/>
							<br/>
							<p class="club_master">
								<c:choose>
									<c:when test="${clubList.cMasterPic == null}">
										<i class="fa fa-user-circle master_pic" style="font-size:70px;" aria-hidden="true"></i>				
									</c:when>	
													
									<c:otherwise>
										<img src="${memberImg}/${clubList.cMasterPic}" class="master_pic">
									</c:otherwise>
								</c:choose>
								<span class="club_masterPic">${clubList.cMaster}</span>
							</p>
							<p class="club_intro">${clubList.cContent}</p>
							<p>${clubList.cAddress}</p>
							<p><fmt:formatDate value="${clubList.cRegdate}" pattern="yyyy-MM-dd HH:mm:ss"/>
							<input type="hidden" class="cAddress" value="${clubList.cAddress}">
						</div>
					</a>
				</div>
			<i class="fa fa-user clubs_detail" aria-hidden="true"> ${clubList.memberCount}</i>
			<i class="fa fa-folder clubs_detail" aria-hidden="true"> ${clubList.boardCount}</i>
			</div>
		</c:forEach>
	</div>
	
	<div class="club_page">
		<!-- 처음페이지로가기 -->
		<c:if test="${map.pager.curBlock > 1 }">
			<a href="javascript:goPagingPage(1)"><i class="fa fa-angle-double-left" aria-hidden="true"></i></a>
		</c:if>
	
		<!-- 이전페이지 -->
		<c:if test="${map.pager.curBlock > 1 }">
			<a href="javascript:goPagingPage(${map.pager.prevBlockPage})"><i class="fa fa-angle-left" aria-hidden="true"></i></a>
		</c:if>
		
		<c:forEach var="num" begin="${map.pager.startPageNo}" end="${map.pager.endPageNo}">
			<c:choose>
				<c:when test="${map.pager.curPage == num }">
					<span class="page_num">${num}</span>
				</c:when>
					
				<c:otherwise>
					<a class="page_num" href="javascript:goPagingPage(${num})">${num}</a>
				</c:otherwise>
				
			</c:choose>
		</c:forEach>
	
		<!-- 다음페이지 -->
		<c:if test="${map.pager.curBlock < map.pager.totalBlock}">
			<a href="javascript:goPagingPage(${map.pager.nextBlockPage})"><i class="fa fa-angle-right" aria-hidden="true"></i></a>
		</c:if>
		
		<!-- 마지막페이지 가기 -->
		<c:if test="${map.pager.curBlock < map.pager.totalBlock}">
			<a href="javascript:goPagingPage(${map.pager.totalPage})"><i class="fa fa-angle-double-right" aria-hidden="true"></i></a>
		</c:if>
	</div>
</div>
<%-- <%@ include file ="../footer/footer.jsp"%> --%>

