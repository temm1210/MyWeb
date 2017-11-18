package com.amigo.dao.board;

import java.util.List;

import com.amigo.util.PagingHandler;
import com.amigo.vo.board.BoardVO;

public interface BoardDAO {

	public List<BoardVO> selectBoards(PagingHandler pager,int cNum,int category);
	public int selectBoardCount(int cNum,int category);
}
