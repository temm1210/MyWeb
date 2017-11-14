package com.amigo.util;

public class PagingHandler {
	
	/* 한페이지에 보여줄 블럭수 설정.*/
	private int block_size;
	/*한페이지에 보여줄 게시글 수*/
	private int board_size; 
	
	/*현재 내가보고있는 페이지랑,블럭*/
	private int curPage;
	private int curBlock;
	
	/*총 페이지,블럭수*/
	private int totalPage;
	private int totalBlock;
	
	/*한페이지에서 보여줄 게시글의 Rownum의 시작번호*/
	private int startRownum;
	/*한페이지에서 보여줄 게시글의 Rownum의 마지막 번호*/
	private int endRownum;
	
	/*현재보고있는 블럭의 이전 블럭*/
	private int prevBlockPage;
	/*현재보고있는 블럭의 다음 블럭*/
	private int nextBlockPage;
	
	/*게시판 밑에 페이지번호 적어주는것, 1,2,3,4,.....*/
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
