package com.amigo.service.board;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.amigo.dao.board.BoardDAO;
import com.amigo.util.BoardSearchCriteria;
import com.amigo.util.PagingHandler;
import com.amigo.vo.board.BoardVO;


@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO boardDao;
	
	@Override
	public List<BoardVO> selectBoards(BoardSearchCriteria criteria,PagingHandler pager) {
		// TODO Auto-generated method stub
		return boardDao.selectBoards(criteria,pager);
	}

	@Override
	public int selectBoardCount(BoardSearchCriteria criteria) {
		// TODO Auto-generated method stub
		return boardDao.selectBoardCount(criteria);
	}

	@Override
	public int insertBoard(BoardVO board) {
		// TODO Auto-generated method stub
		return boardDao.insertBoard(board);
	}

	@Override
	public BoardVO selectBoard(int bNum, int cNum) {
		// TODO Auto-generated method stub
		return boardDao.selectBoard(bNum, cNum);
	}

	@Override
	public int updateBoard(BoardVO board) {
		// TODO Auto-generated method stub
		return boardDao.updateBoard(board);
	}

	@Override
	public void updateLike(String username,int bNum, int cNum) {
		// TODO Auto-generated method stub	
		boardDao.updateLike(bNum, cNum);	
		
	}

	@Override
	public int selectLike(int bNum, int cNum) {
		// TODO Auto-generated method stub
		return boardDao.selectLike(bNum, cNum);
	}

	@Override
	public void updateReadcnt(int bNum, int cNum) {
		// TODO Auto-generated method stub
		boardDao.updateReadcnt(bNum, cNum);
	}

	@Override
	public int deleteBoard(BoardVO board) {
		// TODO Auto-generated method stub
		return boardDao.deleteBoard(board);
	}
}
