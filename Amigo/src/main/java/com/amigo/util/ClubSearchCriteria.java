package com.amigo.util;


/*��ȣȸ �˻��� ����ڰ� ���ϴ� Ű����� �˻����ֵ��� ���ִ� Ŭ����*/
public class ClubSearchCriteria {
	
	private String titleSearch;
	private String hobbySearch;
	private String addressSearch;
	private String orderByCriteria;
	private int curPage;
	
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
	public String getAddressSearch() {
		return addressSearch;
	}
	public void setAddressSearch(String addressSearch) {
		this.addressSearch = addressSearch;
	}
	public String getOrderByCriteria() {
		return orderByCriteria;
	}
	public void setOrderByCriteria(String orderByCriteria) {
		this.orderByCriteria = orderByCriteria;
	}
	@Override
	public String toString() {
		return "ClubSearchCriteria [titleSearch=" + titleSearch + ", hobbySearch=" + hobbySearch + ", addressSearch="
				+ addressSearch + ", orderByCriteria=" + orderByCriteria + ", curPage=" + curPage + "]";
	}
}
