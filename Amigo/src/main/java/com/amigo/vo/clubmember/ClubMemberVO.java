package com.amigo.vo.clubmember;

public class ClubMemberVO {
	
	private int cNum;
	private String nickName;
	private String mid;
	private String cGrade;
	
	public int getcNum() {
		return cNum;
	}
	public void setcNum(int cNum) {
		this.cNum = cNum;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getcGrade() {
		return cGrade;
	}
	public void setcGrade(String cGrade) {
		this.cGrade = cGrade;
	}
	@Override
	public String toString() {
		return "ClubMemberVO [cNum=" + cNum + ", nickName=" + nickName + ", mid=" + mid + ", cGrade=" + cGrade + "]";
	}
}
