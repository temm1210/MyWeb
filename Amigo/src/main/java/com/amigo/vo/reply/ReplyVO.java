package com.amigo.vo.reply;

import java.util.Date;

public class ReplyVO {

	private int rNum;
	private int cNum;
	private int bNum;
	private String rWriter;
	private String rContent;
	private String mPic;
	private Date reRegdate;
	
	public String getmPic() {
		return mPic;
	}
	public void setmPic(String mPic) {
		this.mPic = mPic;
	}
	public int getrNum() {
		return rNum;
	}
	public void setrNum(int rNum) {
		this.rNum = rNum;
	}
	public int getcNum() {
		return cNum;
	}
	public void setcNum(int cNum) {
		this.cNum = cNum;
	}
	public int getbNum() {
		return bNum;
	}
	public void setbNum(int bNum) {
		this.bNum = bNum;
	}
	public String getrWriter() {
		return rWriter;
	}
	public void setrWriter(String rWriter) {
		this.rWriter = rWriter;
	}
	public String getrContent() {
		return rContent;
	}
	public void setrContent(String rContent) {
		this.rContent = rContent;
	}
	public Date getReRegdate() {
		return reRegdate;
	}
	public void setReRegdate(Date reRegdate) {
		this.reRegdate = reRegdate;
	}
	@Override
	public String toString() {
		return "ReplyVO [rNum=" + rNum + ", cNum=" + cNum + ", bNum=" + bNum + ", rWriter=" + rWriter + ", rContent="
				+ rContent + ", mPic=" + mPic + ", reRegdate=" + reRegdate + "]";
	}
	
}
