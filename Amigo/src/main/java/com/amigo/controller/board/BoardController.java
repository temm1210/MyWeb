package com.amigo.controller.board;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.amigo.service.board.BoardService;
import com.amigo.util.BoardSearchCriteria;
import com.amigo.util.PagingHandler;
import com.amigo.vo.board.BoardVO;
import com.amigo.vo.member.MemberVO;

@RestController
@RequestMapping("/club/board")
public class BoardController {

	@Inject
	private BoardService boardService;
	
	/*��ȣȸ���������� �Խ��� �������� �̿����϶�*/
	@RequestMapping("/boardContent.amg")
	public ModelAndView boardContent(@RequestParam(value="searchOption", defaultValue="all") String searchOption,
								     @RequestParam(value="searchWord", defaultValue="") String searchWord,
								     @RequestParam(value="orderByWord", defaultValue="�ֽż�") String orderByWord,
								     @RequestParam(value="cNum") int cNum,
									 @RequestParam(value="curPage" ,defaultValue="1") int curPage,
			  						 @RequestParam(value="category",defaultValue="0") int category) {
		/*��ȣȸ �Խ��ǿ��� �����������̽��� �°� �Խñۺ������� ���������� �����ϱ����� Ŭ����*/
		BoardSearchCriteria criteria = new BoardSearchCriteria();	
		criteria.setCategory(category);
		criteria.setcNum(cNum);
		criteria.setCurPage(curPage);
		criteria.setOrderByWord(orderByWord);
		criteria.setSearchOption(searchOption);
		criteria.setSearchWord(searchWord);
		
		ModelAndView mav = new ModelAndView();

		mav.setViewName("club/board/club_boardContent");
		mav.addObject("criteria", criteria);
		
		return mav;
	}
	
	@RequestMapping("/boardListAll.amg")
	public ModelAndView boardList(BoardSearchCriteria criteria) {
		
		int totalCount = boardService.selectBoardCount(criteria);
		
		/*�Խ��ǿ��� ����ڰ� �˻�Ű���带 �Է��ϰԳ�, ���ļ����� Ŭ��������*/
		ModelAndView mav = new ModelAndView();
		PagingHandler pager = new PagingHandler(criteria.getCurPage(),totalCount,2,7);
		Map<String,Object> map = new HashMap<String,Object>();
		
		
		map.put("totalCount", totalCount);
		map.put("board", boardService.selectBoards(criteria,pager));
		map.put("pager", pager);
		map.put("criteria", criteria);
		
		mav.addObject("map", map);
		mav.setViewName("club/board/club_board");
		
		return mav;
	}
	
	/*�Խñ۾��� ������ �̵�*/
	@RequestMapping(value="/boardWrite.amg" , method=RequestMethod.GET)
	public ModelAndView boardWriteGet(@RequestParam(value="category",defaultValue="0") int category,
									  @RequestParam(value="cNum",defaultValue="0") int cNum) {
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("category", category);
		mav.addObject("cNum", cNum);
		mav.setViewName("club/board/club_boardWrite");
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
	public ModelAndView boardRead(BoardSearchCriteria criteria,
							      @RequestParam("bNum") int bNum) {
					
		
		ModelAndView mav = new ModelAndView();
		
		/*Ŭ���� �Խñ� ��������*/
		BoardVO board = boardService.selectBoard(bNum, criteria.getcNum());
		System.out.println("�˻��ɼ�Ȯ��:"+criteria.getOrderByWord());
		/*��ȸ������*/
		boardService.updateReadcnt(bNum, criteria.getcNum());
		mav.setViewName("club/board/club_boardRead");
		mav.addObject("board", board);
		mav.addObject("criteria", criteria);
		
		return mav;	
	}
	
	/*�Խñ� ������*/
	@RequestMapping(value="/boardUpdate.amg",produces = "application/text; charset=utf8", method= {RequestMethod.PUT,RequestMethod.PATCH})
	public String boardUpdate(@RequestBody BoardVO board) {
		String msg = "";
		int check = boardService.updateBoard(board);

		if(check > 0)
			msg="�Խñ��� �����Ǿ����ϴ�.";
		else
			msg="�Խñ� ������ �����Ͽ����ϴ�.";
		
		return msg;
	}
	
	/*���ƿ��ư Ŭ����*/
	@RequestMapping("/clickLike.amg")
	public int clickLike(@RequestParam("cNum") int cNum,
		      			  @RequestParam("bNum") int bNum) {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		/*��ť��Ƽ���������� �����°� MemberVO�� ĳ����*/
		MemberVO member = (MemberVO) auth.getPrincipal();
		
		boardService.updateLike(member.getUsername(),bNum, cNum);
		return boardService.selectLike(bNum, cNum);
	}
	
	/*�� ���� Ŭ����*/
	@RequestMapping(value="/boardDelete.amg",method=RequestMethod.DELETE,produces = "application/text; charset=utf8")
	public String boardDelete(@RequestBody BoardVO board) {
		
		board.setbTitle("(������ �Խù��Դϴ�)");
		board.setbContent("(������ �Խù��Դϴ�)");
		board.setbCategory(6);
		
		String msg = "";
		int check = boardService.deleteBoard(board);
		
		if(check > 0)
			msg="�Խñ��� �����Ǿ����ϴ�.";
		else
			msg="�Խñ� ������ �����Ͽ����ϴ�.";
		
		return msg;
	}
	
	/*�Խ��� Ȩ���������� ����� �Խñ� ��������*/
	@RequestMapping("/clubHome.amg")
	public ModelAndView clubHome(@RequestParam(value="cNum") int cNum,
								 @RequestParam(value="ctgLength") int size) {
		
		ModelAndView mav = new ModelAndView();
		List<BoardVO> list = new ArrayList<BoardVO>();

		/*�Խñ� ������������ ����*/
		BoardSearchCriteria criteria = new BoardSearchCriteria();
		criteria.setcNum(cNum);
		criteria.setOrderByWord("�ֽż�");
		criteria.setSearchOption("all");
		criteria.setSearchWord("");
		
		PagingHandler pager = new PagingHandler(1, boardService.selectBoardCount(criteria), 1, 6);
		
		for(int i = 1; i<size;i++) {
			criteria.setCategory(i);
			list.addAll(boardService.selectBoards(criteria,pager));
		}
		
		mav.addObject("size",size-1);
		mav.addObject("board", list);
		mav.addObject("criteria", criteria);
		mav.setViewName("club/club_home");
	
		return mav;
	}
	
}
