package com.amigo.util;

/*동호회네 게시판 검색시 사용자입력에 따라 원하는 결과를 뿌려좀*/
public class BoardSearchCriteria {

	private String searchOption;
	private String searchWord;
	private String orderByWord;
	private int category;
	private int curPage;
	/*검색조건에 맞게 보여줄 동호회*/
	private int cNum;
	
	public int getcNum() {
		return cNum;
	}
	public void setcNum(int cNum) {
		this.cNum = cNum;
	}
	public String getSearchOption() {
		return searchOption;
	}
	public void setSearchOption(String searchOption) {
		this.searchOption = searchOption;
	}
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
	public String getOrderByWord() {
		return orderByWord;
	}
	public void setOrderByWord(String orderByWord) {
		this.orderByWord = orderByWord;
	}
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	@Override
	public String toString() {
		return "BoardSearchCriteria [searchOption=" + searchOption + ", searchWord=" + searchWord + ", orderByWord="
				+ orderByWord + ", category=" + category + ", curPage=" + curPage + ", cNum=" + cNum + "]";
	}
	
}
