package com.amigo.service.board;

import java.util.List;

import com.amigo.util.PagingHandler;
import com.amigo.vo.board.BoardVO;

public interface BoardService {
	public List<BoardVO> selectBoards(PagingHandler pager,int cNum,int category);
	public int selectBoardCount(int cNum, int category);
	public int insertBoard(BoardVO board);
	public BoardVO selectBoard(int bNum, int cNum);
	public int updateBoard(BoardVO board);
}
