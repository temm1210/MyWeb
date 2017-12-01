package com.amigo.service.reply;

import java.util.List;
import java.util.Map;

import com.amigo.util.PagingHandler;
import com.amigo.vo.reply.ReplyVO;

public interface ReplyService {
	public int insertReply(ReplyVO reply);
	public List<ReplyVO> selectReplys(int cNum,int bNum,PagingHandler pager);
	public int selectReplyCount(int cNum,int bNum);
	public int updateReply(Map<String,Object> map);
	public int deleteReply(Map<String,Object> map);
}
