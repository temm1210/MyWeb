package com.amigo.controller.reply;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.amigo.service.reply.ReplyService;
import com.amigo.util.PagingHandler;
import com.amigo.vo.reply.ReplyVO;

@RestController
@RequestMapping("/reply")
public class ReplyController {

	@Inject
	private ReplyService replyService;
	
	@RequestMapping("/reply.amg")
	public ModelAndView reply() {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("club/reply/club_reply");
		return mav;
	}
	
	/*��۵��*/
	@RequestMapping(value="/writeReply.amg",method=RequestMethod.POST,produces = "application/text; charset=utf8")
	public String writeReply(@RequestBody ReplyVO reply) {
		int ch = replyService.insertReply(reply);
		
		return (ch>0)?"����� ����Ͽ����ϴ�":"��۵�Ͽ� ���� �Ͽ����ϴ�";
	}
	
	/*��� ����Ʈ ��������*/
	@RequestMapping(value="/getReplys.amg",method=RequestMethod.GET)
	public ModelAndView getReplys(@RequestParam(value="curPage",defaultValue="1") int curPage,
								  @RequestParam("cNum") int cNum,  
								  @RequestParam("bNum") int bNum){
		
		int totalCount = replyService.selectReplyCount(cNum, bNum);
		ModelAndView mav = new ModelAndView();
		PagingHandler pager = new PagingHandler(curPage, totalCount, 2, 3);
		Map<String,Object> map = new HashMap<String,Object>();
		
		
		map.put("reply", replyService.selectReplys(cNum, bNum,pager));
		map.put("count", replyService.selectReplyCount(cNum, bNum));
		map.put("pager", pager);
		
		mav.addObject("map", map);
		mav.setViewName("club/reply/club_replyList");
		return mav;
	}
	
	/*��� �����ϱ�*/
	@RequestMapping(value="/updateReply.amg", method= {RequestMethod.PUT,RequestMethod.PATCH},produces = "application/text; charset=utf8")
	public String updateReply(@RequestBody Map<String,Object> map) {
		int ch = replyService.updateReply(map);
		return (ch>0)?"��������":"��������";
	}
	
	/*��ۻ����ϱ�*/
	@RequestMapping(value="/deleteReply.amg",method=RequestMethod.DELETE,produces = "application/text; charset=utf8")
	public String deleteReply(@RequestBody Map<String,Object> map) {
		int ch = replyService.deleteReply(map);
		return (ch>0)?"��������":"��������";
	}
	
	
}
