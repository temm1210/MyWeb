package com.amigo.dao.reply;

import java.util.List;
import java.util.Map;

import com.amigo.vo.reply.ReplyVO;

public interface ReplyDAO {
	public int insertReply(ReplyVO reply);
	public List<ReplyVO> selectReplys(int cNum,int bNum);
	public int selectReplyCount(int cNum,int bNum);
	public int updateReply(Map<String,Object> map);
	public int deleteReply(Map<String,Object> map);
}
