package com.amigo.dao.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.amigo.util.BoardSearchCriteria;
import com.amigo.util.PagingHandler;
import com.amigo.vo.board.BoardVO;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Inject
	private SqlSession session;
	
	@Override
	public List<BoardVO> selectBoards(BoardSearchCriteria criteria,PagingHandler pager) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String,Object>();

		map.put("cNum", criteria.getcNum());
		map.put("searchOption", criteria.getSearchOption());
		map.put("searchWord",criteria.getSearchWord());
		map.put("orderByWord", criteria.getOrderByWord());
		map.put("category", criteria.getCategory());
		map.put("start", pager.getStartRownum());
		map.put("end", pager.getEndRownum());
		
		return session.selectList("selectBoards", map);
	}

	@Override
	public int selectBoardCount(BoardSearchCriteria criteria) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String,Object>();
		
		map.put("searchOption", criteria.getSearchOption());
		map.put("searchWord",criteria.getSearchWord());
		map.put("orderByWord", criteria.getOrderByWord());
		map.put("cNum", criteria.getcNum());
		map.put("category", criteria.getCategory());
		return session.selectOne("selectBoardCount",map);
	}

	@Override
	public int insertBoard(BoardVO board) {
		// TODO Auto-generated method stub
		return session.insert("insertBoard", board);
		
	}

	@Override
	public BoardVO selectBoard(int bNum, int cNum) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("bNum", bNum);
		map.put("cNum", cNum);
		return session.selectOne("selectBoard", map);
	}

	@Override
	public int updateBoard(BoardVO board) {
		// TODO Auto-generated method stub
		return session.update("updateBoard", board);
	}

	@Override
	public void updateLike(int bNum, int cNum) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("bNum", bNum);
		map.put("cNum", cNum);
		
		session.update("updateLike", map);
	}

	@Override
	public int selectLike(int bNum, int cNum) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("bNum", bNum);
		map.put("cNum", cNum);
		
		return session.selectOne("selectLike", map);
	}

	@Override
	public void updateReadcnt(int bNum, int cNum) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("bNum", bNum);
		map.put("cNum", cNum);
		
		session.update("updateReadcnt", map);
	}

	@Override
	public int deleteBoard(BoardVO board) {
		// TODO Auto-generated method stub
		return session.update("deleteBoard", board);
	}
}
