package com.amigo.util;

public class PagingHandler {
	
	/* ���������� ������ ���� ����.*/
	private int block_size;
	/*���������� ������ �Խñ� ��*/
	private int board_size; 
	
	/*���� ���������ִ� ��������,��*/
	private int curPage;
	private int curBlock;
	
	/*�� ������,����*/
	private int totalPage;
	private int totalBlock;
	
	/*������������ ������ �Խñ��� Rownum�� ���۹�ȣ*/
	private int startRownum;
	/*������������ ������ �Խñ��� Rownum�� ������ ��ȣ*/
	private int endRownum;
	
	/*���纸���ִ� ���� ���� ��*/
	private int prevBlockPage;
	/*���纸���ִ� ���� ���� ��*/
	private int nextBlockPage;
	
	/*�Խ��� �ؿ� ��������ȣ �����ִ°�, 1,2,3,4,.....*/
	private int startPageNo;
	private int endPageNo;
	
	public PagingHandler(int curPage,int totalCountData,int block_size,int board_size) {
		this.block_size = block_size;
		this.board_size = board_size;
		
		this.curPage = curPage;
		this.curBlock = (int) Math.ceil( (double)curPage/block_size );
		
		this.totalPage = (int) Math.ceil((double)totalCountData/board_size );
		this.totalBlock = (int) Math.ceil( (double)totalPage/block_size );
		
		this.startRownum = ((curPage-1) * board_size)+1;
		this.endRownum = startRownum + (board_size-1);
		
		this.prevBlockPage = ( curBlock==1)?1:(curBlock-1) * block_size;
		this.nextBlockPage = ( curBlock == totalBlock)?curPage : (curBlock * block_size)+1;
		
		if(nextBlockPage >= totalPage)
			nextBlockPage = totalPage;
		
		this.startPageNo = ((curBlock-1)*block_size)+1;
		this.endPageNo = startPageNo+(block_size-1);
		
		if(endPageNo >= totalPage)	
			endPageNo = totalPage;
	}
	public int getBlock_size() {
		return block_size;
	}

	public void setBlock_size(int block_size) {
		this.block_size = block_size;
	}

	public int getBoard_size() {
		return board_size;
	}

	public void setBoard_size(int board_size) {
		this.board_size = board_size;
	}

	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getCurBlock() {
		return curBlock;
	}

	public void setCurBlock(int curBlock) {
		this.curBlock = curBlock;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getTotalBlock() {
		return totalBlock;
	}

	public void setTotalBlock(int totalBlock) {
		this.totalBlock = totalBlock;
	}

	public int getStartRownum() {
		return startRownum;
	}

	public void setStartRownum(int startRownum) {
		this.startRownum = startRownum;
	}

	public int getEndRownum() {
		return endRownum;
	}

	public void setEndRownum(int endRownum) {
		this.endRownum = endRownum;
	}

	public int getPrevBlockPage() {
		return prevBlockPage;
	}

	public void setPrevBlockPage(int prevBlockPage) {
		this.prevBlockPage = prevBlockPage;
	}

	public int getNextBlockPage() {
		return nextBlockPage;
	}

	public void setNextBlockPage(int nextBlockPage) {
		this.nextBlockPage = nextBlockPage;
	}

	public int getStartPageNo() {
		return startPageNo;
	}

	public void setStartPageNo(int startPageNo) {
		this.startPageNo = startPageNo;
	}

	public int getEndPageNo() {
		return endPageNo;
	}

	public void setEndPageNo(int endPageNo) {
		this.endPageNo = endPageNo;
	}

	@Override
	public String toString() {
		return "PagingHandler [block_size=" + block_size + ", board_size=" + board_size + ", curPage=" + curPage
				+ ", curBlock=" + curBlock + ", totalPage=" + totalPage + ", totalBlock=" + totalBlock
				+ ", startRownum=" + startRownum + ", endRownum=" + endRownum + ", prevBlockPage=" + prevBlockPage
				+ ", nextBlockPage=" + nextBlockPage + ", startPageNo=" + startPageNo + ", endPageNo=" + endPageNo
				+ "]";
	}
	
	
}
