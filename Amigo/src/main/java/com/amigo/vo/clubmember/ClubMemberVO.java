package com.amigo.vo.clubmember;

import java.util.Date;

public class ClubMemberVO {
	
	private int cNum;
	private String cNickname;
	private String mid;
	private String cGrade;
	private String mPic;
	private String author;
	private Date cmRegdate;
	
	public Date getCmRegdate() {
		return cmRegdate;
	}
	public void setCmRegdate(Date cmRegdate) {
		this.cmRegdate = cmRegdate;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
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
				+ ", mPic=" + mPic + ", author=" + author + ", cmRegdate=" + cmRegdate + ", getCmRegdate()="
				+ getCmRegdate() + ", getAuthor()=" + getAuthor() + ", getmPic()=" + getmPic() + ", getcNum()="
				+ getcNum() + ", getcNickname()=" + getcNickname() + ", getMid()=" + getMid() + ", getcGrade()="
				+ getcGrade() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()="
				+ super.toString() + "]";
	}
}
