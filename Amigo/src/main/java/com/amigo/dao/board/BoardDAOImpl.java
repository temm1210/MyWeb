package com.amigo.dao.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.amigo.util.PagingHandler;
import com.amigo.vo.board.BoardVO;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Inject
	private SqlSession session;
	
	@Override
	public List<BoardVO> selectBoards(PagingHandler pager,int cNum,int category) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String,Object>();
	
		map.put("cNum", cNum);
		map.put("category", category);
		map.put("start", pager.getStartRownum());
		map.put("end", pager.getEndRownum());
		return session.selectList("selectBoards", map);
	}

	@Override
	public int selectBoardCount(int cNum,int category) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String,Object>();
		
		map.put("cNum", cNum);
		map.put("category", category);
		return session.selectOne("selectBoardCount",map);
	}

}
