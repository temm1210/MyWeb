package com.amigo.vo.club;

import java.util.Date;

public class ClubVO {

	private int cNum;
	private int boardCount;
	private int memberCount;
	private int cHobby;
	private String cTitle;
	private String cContent;
	private String cPic;
	private String cMaster;
	private String cMasterPic;
	private String cAddress;
	private Date cRegdate;
	
	public ClubVO() {}
	
	public int getMemberCount() {
		return memberCount;
	}
	public void setMemberCount(int memberCount) {
		this.memberCount = memberCount;
	}
	public String getcMasterPic() {
		return cMasterPic;
	}
	public void setcMasterPic(String cMasterPic) {
		this.cMasterPic = cMasterPic;
	}
	public String getcAddress() {
		return cAddress;
	}
	public void setcAddress(String cAddress) {
		this.cAddress = cAddress;
	}
	public int getcNum() {
		return cNum;
	}
	public void setcNum(int cNum) {
		this.cNum = cNum;
	}
	public String getcTitle() {
		return cTitle;
	}
	public void setcTitle(String cTitle) {
		this.cTitle = cTitle;
	}
	public String getcContent() {
		return cContent;
	}
	public void setcContent(String cContent) {
		this.cContent = cContent;
	}
	public String getcPic() {
		return cPic;
	}
	public void setcPic(String cPic) {
		this.cPic = cPic;
	}
	public String getcMaster() {
		return cMaster;
	}
	public void setcMaster(String cMaster) {
		this.cMaster = cMaster;
	}
	public Date getcRegdate() {
		return cRegdate;
	}
	public void setcRegdate(Date cRegdate) {
		this.cRegdate = cRegdate;
	}
	public int getcHobby() {
		return cHobby;
	}
	public void setcHobby(int cHobby) {
		this.cHobby = cHobby;
	}
	public int getBoardCount() {
		return boardCount;
	}
	public void setBoardCount(int boardCount) {
		this.boardCount = boardCount;
	}
	@Override
	public String toString() {
		return "ClubVO [cNum=" + cNum + ", boardCount=" + boardCount + ", memberCount=" + memberCount + ", cHobby="
				+ cHobby + ", cTitle=" + cTitle + ", cContent=" + cContent + ", cPic=" + cPic + ", cMaster=" + cMaster
				+ ", cMasterPic=" + cMasterPic + ", cAddress=" + cAddress + ", cRegdate=" + cRegdate + "]";
	}
}
