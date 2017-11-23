package com.amigo.vo.clubmember;

public class ClubMemberVO {
	
	private int cNum;
	private String cNickname;
	private String mid;
	private String cGrade;
	private String mPic;
	
	public String getmPic() {
		return mPic;
	}
	public void setmPic(String mPic) {
		this.mPic = mPic;
	}
	public int getcNum() {
		return cNum;
	}
	public void setcNum(int cNum) {
		this.cNum = cNum;
	}
	public String getcNickname() {
		return cNickname;
	}
	public void setcNickname(String cNickname) {
		this.cNickname = cNickname;
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
		return "ClubMemberVO [cNum=" + cNum + ", cNickname=" + cNickname + ", mid=" + mid + ", cGrade=" + cGrade
				+ ", mPic=" + mPic + "]";
	}
}
