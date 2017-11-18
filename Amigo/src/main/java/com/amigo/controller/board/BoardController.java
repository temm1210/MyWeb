package com.amigo.controller.board;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.amigo.service.board.BoardService;
import com.amigo.util.PagingHandler;

@Controller
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
}
