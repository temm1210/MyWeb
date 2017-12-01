package com.amigo.dao.reply;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.amigo.util.PagingHandler;
import com.amigo.vo.reply.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	@Override
	public int insertReply(ReplyVO reply) {
		// TODO Auto-generated method stub
		return sqlSession.insert("insertReply", reply);
	}

	@Override
	public List<ReplyVO> selectReplys(int cNum, int bNum,PagingHandler pager) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("cNum", cNum);
		map.put("bNum", bNum);
		map.put("start", pager.getStartRownum());
		map.put("end", pager.getEndRownum());
		
		return sqlSession.selectList("selectReplys", map);
	}

	@Override
	public int selectReplyCount(int cNum, int bNum) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("cNum", cNum);
		map.put("bNum", bNum);
		
		return sqlSession.selectOne("selectReplyCount", map);
	}

	@Override
	public int updateReply(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.update("updateReply", map);
	}

	@Override
	public int deleteReply(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.delete("deleteReply", map);
	}

}
