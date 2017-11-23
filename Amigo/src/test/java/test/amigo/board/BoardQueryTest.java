package test.amigo.board;

import javax.inject.Inject;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.amigo.service.board.BoardService;
import com.amigo.util.BoardSearchCriteria;
import com.amigo.util.PagingHandler;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
@WebAppConfiguration
public class BoardQueryTest {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardQueryTest.class);
	
	@Inject
	private BoardService boardService;

	@Test
	public void selectBoardsTest() {
		BoardSearchCriteria criteria = new BoardSearchCriteria();
		criteria.setcNum(56);
		criteria.setOrderByWord("최신순");
		criteria.setCategory(0);
		PagingHandler pager = new PagingHandler(1, boardService.selectBoardCount(criteria), 2, 1);

/*		criteria.setSearchWord("");
		
		criteria.setSearchOption("all");*/
		logger.info("selectBoardsTest 테스트:{}",boardService.selectBoards(criteria,pager));
	}
	
	@Test
	@Ignore
	public void selectBoardCountTest() {
		BoardSearchCriteria criteria = new BoardSearchCriteria();
		criteria.setSearchWord("");
		criteria.setOrderByWord("");
		criteria.setSearchOption("all");
		logger.info("56번 동호회 게시글 총 갯수:"+boardService.selectBoardCount(criteria));
	}
	
	@Test
	@Ignore
	public void  selectBoardTest() {
		logger.info("동호회 가져오기: {}",boardService.selectBoard(15, 56));
	}
	
	@Test
	@Ignore
	public void updateLike() {
		logger.info("좋아요클릭 테스트시작");
		boardService.updateLike("설현",1, 56);
		logger.info("좋아요클릭 테스트종료");
	}
}
