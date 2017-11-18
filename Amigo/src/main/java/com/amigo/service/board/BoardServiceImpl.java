package com.amigo.service.board;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.amigo.dao.board.BoardDAO;
import com.amigo.util.PagingHandler;
import com.amigo.vo.board.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO boardDao;
	
	@Override
	public List<BoardVO> selectBoards(PagingHandler pager,int cNum,int category) {
		// TODO Auto-generated method stub
		return boardDao.selectBoards(pager,cNum,category);
	}

	@Override
	public int selectBoardCount(int cNum,int category) {
		// TODO Auto-generated method stub
		return boardDao.selectBoardCount(cNum, category);
	}

}
