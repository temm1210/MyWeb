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
	
	/*동호회페이지에서 게시판 컨텐츠를 이용중일때*/
	@RequestMapping("/boardContent.amg")
	public ModelAndView boardContent(@RequestParam(value="searchOption", defaultValue="all") String searchOption,
								     @RequestParam(value="searchWord", defaultValue="") String searchWord,
								     @RequestParam(value="orderByWord", defaultValue="최신순") String orderByWord,
								     @RequestParam(value="cNum") int cNum,
									 @RequestParam(value="curPage" ,defaultValue="1") int curPage,
			  						 @RequestParam(value="category",defaultValue="0") int category) {
		/*동호회 게시판에서 유저인터페이스에 맞게 게시글보기위한 여러조건을 설정하기위한 클래스*/
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
		
		/*게시판에서 사용자가 검색키워드를 입력하게나, 정렬순서를 클릭했을때*/
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
	
	/*게시글쓰는 폼으로 이동*/
	@RequestMapping(value="/boardWrite.amg" , method=RequestMethod.GET)
	public ModelAndView boardWriteGet(@RequestParam(value="category",defaultValue="0") int category,
									  @RequestParam(value="cNum",defaultValue="0") int cNum) {
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("category", category);
		mav.addObject("cNum", cNum);
		mav.setViewName("club/board/club_boardWrite");
		return mav;
	}
	
	/*게시글쓰고 작성클릭 클릭시*/
	@RequestMapping(value="boardWrite.amg",method=RequestMethod.POST)
	public String boardWritePost(@RequestBody BoardVO board) {
		String msg = "";
		int check = boardService.insertBoard(board);

		/*게시글작성 성공시*/
		if(check > 0)
			msg="success";
		else
			msg="fail";
		
		return msg;
	}
	
	/*게시글 제목클릭시 상세보기*/
	@RequestMapping(value="/boardRead.amg",method=RequestMethod.GET)
	public ModelAndView boardRead(BoardSearchCriteria criteria,
							      @RequestParam("bNum") int bNum) {
					
		
		ModelAndView mav = new ModelAndView();
		
		/*클릭한 게시글 가져오기*/
		BoardVO board = boardService.selectBoard(bNum, criteria.getcNum());
		System.out.println("검색옵션확인:"+criteria.getOrderByWord());
		/*조회수증가*/
		boardService.updateReadcnt(bNum, criteria.getcNum());
		mav.setViewName("club/board/club_boardRead");
		mav.addObject("board", board);
		mav.addObject("criteria", criteria);
		
		return mav;	
	}
	
	/*게시글 수정시*/
	@RequestMapping(value="/boardUpdate.amg",produces = "application/text; charset=utf8", method= {RequestMethod.PUT,RequestMethod.PATCH})
	public String boardUpdate(@RequestBody BoardVO board) {
		String msg = "";
		int check = boardService.updateBoard(board);

		if(check > 0)
			msg="게시글이 수정되었습니다.";
		else
			msg="게시글 수정에 실패하였습니다.";
		
		return msg;
	}
	
	/*좋아요버튼 클릭시*/
	@RequestMapping("/clickLike.amg")
	public int clickLike(@RequestParam("cNum") int cNum,
		      			  @RequestParam("bNum") int bNum) {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		/*시큐리티인증정보를 가져온걸 MemberVO로 캐스팅*/
		MemberVO member = (MemberVO) auth.getPrincipal();
		
		boardService.updateLike(member.getUsername(),bNum, cNum);
		return boardService.selectLike(bNum, cNum);
	}
	
	/*글 삭제 클릭시*/
	@RequestMapping(value="/boardDelete.amg",method=RequestMethod.DELETE,produces = "application/text; charset=utf8")
	public String boardDelete(@RequestBody BoardVO board) {
		
		board.setbTitle("(삭제된 게시물입니다)");
		board.setbContent("(삭제된 게시물입니다)");
		board.setbCategory(6);
		
		String msg = "";
		int check = boardService.deleteBoard(board);
		
		if(check > 0)
			msg="게시글이 삭제되었습니다.";
		else
			msg="게시글 삭제에 실패하였습니다.";
		
		return msg;
	}
	
	/*게시판 홈페이지에서 사용할 게시글 가져오기*/
	@RequestMapping("/clubHome.amg")
	public ModelAndView clubHome(@RequestParam(value="cNum") int cNum,
								 @RequestParam(value="ctgLength") int size) {
		
		ModelAndView mav = new ModelAndView();
		List<BoardVO> list = new ArrayList<BoardVO>();

		/*게시글 가져오기위한 셋팅*/
		BoardSearchCriteria criteria = new BoardSearchCriteria();
		criteria.setcNum(cNum);
		criteria.setOrderByWord("최신순");
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
