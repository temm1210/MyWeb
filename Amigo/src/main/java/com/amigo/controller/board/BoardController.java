package com.amigo.controller.board;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.amigo.service.board.BoardService;
import com.amigo.util.PagingHandler;
import com.amigo.vo.board.BoardVO;

@RestController
@RequestMapping("/club/board")
public class BoardController {

	@Inject
	private BoardService boardService;
	
	@RequestMapping("/boardListAll.amg")
	public ModelAndView boardList(@RequestParam(value="cNum") int cNum,
								  @RequestParam(value="curPage") int curPage,
								  @RequestParam(value="category",defaultValue="0") int category) {
		
		int totalCount = boardService.selectBoardCount(cNum,category);
		ModelAndView mav = new ModelAndView();
		PagingHandler pager = new PagingHandler(curPage,totalCount,2,3);
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("totalCount", totalCount);
		map.put("board", boardService.selectBoards(pager,cNum,category));
		map.put("pager", pager);
		map.put("cNum", cNum);
		map.put("category", category);
		
		mav.addObject("map", map);
		mav.setViewName("club/club_board");
		
		return mav;
	}
	
	/*�Խñ۾��� ������ �̵�*/
	@RequestMapping(value="/boardWrite.amg" , method=RequestMethod.GET)
	public ModelAndView boardWriteGet(@RequestParam(value="category",defaultValue="0") int category,
									  @RequestParam(value="cNum",defaultValue="0") int cNum) {
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("category", category);
		mav.addObject("cNum", cNum);
		mav.setViewName("club/club_boardWrite");
		return mav;
	}
	
	/*�Խñ۾��� �ۼ�Ŭ�� Ŭ����*/
	@RequestMapping(value="boardWrite.amg",method=RequestMethod.POST)
	public String boardWritePost(@RequestBody BoardVO board) {
		String msg = "";
		int check = boardService.insertBoard(board);

		/*�Խñ��ۼ� ������*/
		if(check > 0)
			msg="success";
		else
			msg="fail";
		
		return msg;
	}
	
	/*�Խñ� ����Ŭ���� �󼼺���*/
	@RequestMapping(value="/boardRead.amg",method=RequestMethod.GET)
	public ModelAndView boardRead(@RequestParam("cNum") int cNum,
							      @RequestParam("bNum") int bNum,
							      @RequestParam("curPage") int curPage,
							      @RequestParam("category") int category) {
		
		ModelAndView mav = new ModelAndView();
		BoardVO board = boardService.selectBoard(bNum, cNum);

		mav.setViewName("club/club_boardRead");
		mav.addObject("board", board);
		mav.addObject("curPage", curPage);
		mav.addObject("category", category);
		
		return mav;	
	}
	
	/*�Խñ� ������*/
	@RequestMapping(value="/boardUpdate.amg", method= {RequestMethod.PUT,RequestMethod.PATCH})
	public String boardUpdate(@RequestBody BoardVO board) {
		String msg = "";
		int check = boardService.updateBoard(board);

		if(check > 0)
			msg="success";
		else
			msg="fail";
		
		return msg;
	}
}
