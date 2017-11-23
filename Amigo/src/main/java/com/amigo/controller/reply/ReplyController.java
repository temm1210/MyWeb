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
	
	/*댓글등록*/
	@RequestMapping(value="/writeReply.amg",method=RequestMethod.POST,produces = "application/text; charset=utf8")
	public String writeReply(@RequestBody ReplyVO reply) {
		int ch = replyService.insertReply(reply);
		
		return (ch>0)?"댓글을 등록하였습니다":"댓글등록에 실패 하였습니다";
	}
	
	/*댓글 리스트 가져오기*/
	@RequestMapping(value="/getReplys.amg",method=RequestMethod.GET)
	public ModelAndView getReplys(@RequestParam("cNum") int cNum,
								  @RequestParam("bNum") int bNum){
		
		ModelAndView mav = new ModelAndView();
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("reply", replyService.selectReplys(cNum, bNum));
		map.put("count", replyService.selectReplyCount(cNum, bNum));
		
		mav.addObject("map", map);
		mav.setViewName("club/reply/club_replyList");
		return mav;
	}
	
	/*댓글 수정하기*/
	@RequestMapping(value="/updateReply.amg", method= {RequestMethod.PUT,RequestMethod.PATCH},produces = "application/text; charset=utf8")
	public String updateReply(@RequestBody Map<String,Object> map) {
		int ch = replyService.updateReply(map);
		return (ch>0)?"수정성공":"수정실패";
	}
	
	/*댓글삭제하기*/
	@RequestMapping(value="/deleteReply.amg",method=RequestMethod.DELETE,produces = "application/text; charset=utf8")
	public String deleteReply(@RequestBody Map<String,Object> map) {
		int ch = replyService.deleteReply(map);
		return (ch>0)?"삭제성공":"삭제실패";
	}
	
	
}
