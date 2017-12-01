package com.amigo.util;

import java.util.List;
import java.util.Map;

/*동호회 검색시 사용자가 원하는 키워드로 검색해주도록 해주는 클래스*/
public class ClubSearchCriteria {
	
	private String titleSearch;
	private String hobbySearch;
	private String addrSearch;
	private String orderByCriteria;
	private int curPage;
	private List<Map<String,Object>> clubNumList;
	
	public List<Map<String, Object>> getClubNumList() {
		return clubNumList;
	}
	public void setClubNumList(List<Map<String, Object>> clubNumList) {
		this.clubNumList = clubNumList;
	}
	public String getAddrSearch() {
		return addrSearch;
	}
	public void setAddrSearch(String addrSearch) {
		this.addrSearch = addrSearch;
	}
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public String getTitleSearch() {
		return titleSearch;
	}
	public void setTitleSearch(String titleSearch) {
		this.titleSearch = titleSearch;
	}
	public String getHobbySearch() {
		return hobbySearch;
	}
	public void setHobbySearch(String hobbySearch) {
		this.hobbySearch = hobbySearch;
	}

	public String getOrderByCriteria() {
		return orderByCriteria;
	}
	public void setOrderByCriteria(String orderByCriteria) {
		this.orderByCriteria = orderByCriteria;
	}
	@Override
	public String toString() {
		return "ClubSearchCriteria [titleSearch=" + titleSearch + ", hobbySearch=" + hobbySearch + ", addrSearch="
				+ addrSearch + ", orderByCriteria=" + orderByCriteria + ", curPage=" + curPage + ", clubNumList="
				+/* clubNumList +*/ "]";
	}
	
}
