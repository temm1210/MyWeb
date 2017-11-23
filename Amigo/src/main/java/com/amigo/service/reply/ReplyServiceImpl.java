package com.amigo.service.reply;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.amigo.dao.reply.ReplyDAO;
import com.amigo.vo.reply.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Inject
	private ReplyDAO replyDao;
	
	@Override
	public int insertReply(ReplyVO reply) {
		// TODO Auto-generated method stub
		return replyDao.insertReply(reply);
	}

	@Override
	public List<ReplyVO> selectReplys(int cNum, int bNum) {
		// TODO Auto-generated method stub
		return replyDao.selectReplys(cNum, bNum);
	}

	@Override
	public int selectReplyCount(int cNum, int bNum) {
		// TODO Auto-generated method stub
		return replyDao.selectReplyCount(cNum, bNum);
	}

	@Override
	public int updateReply(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return replyDao.updateReply(map);
	}

	@Override
	public int deleteReply(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return replyDao.deleteReply(map);
	}

}
