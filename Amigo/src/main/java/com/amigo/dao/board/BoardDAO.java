package com.amigo.dao.board;

import java.util.List;

import com.amigo.util.BoardSearchCriteria;
import com.amigo.util.PagingHandler;
import com.amigo.vo.board.BoardVO;

public interface BoardDAO {

	public List<BoardVO> selectBoards(BoardSearchCriteria criteria,PagingHandler pager);
	public int selectBoardCount(BoardSearchCriteria criteria);
	public int insertBoard(BoardVO board);
	public BoardVO selectBoard(int bNum, int cNum);
	public int updateBoard(BoardVO board);
	public void updateLike(int bNum, int cNum);
	public int selectLike(int bNum,int cNum);
	public void updateReadcnt(int bNum,int cNum);
	public int deleteBoard(BoardVO board);
}
