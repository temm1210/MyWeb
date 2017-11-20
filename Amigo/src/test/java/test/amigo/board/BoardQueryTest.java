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
import com.amigo.util.PagingHandler;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
@WebAppConfiguration
public class BoardQueryTest {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardQueryTest.class);
	
	@Inject
	private BoardService boardService;

	@Test
	@Ignore
	public void selectBoardsTest() {
		PagingHandler pager = new PagingHandler(1, boardService.selectBoardCount(56,0), 2, 3);
		logger.info("selectBoardsTest �׽�Ʈ:{}",boardService.selectBoards(pager,56,0));
	}
	
	@Test
	@Ignore
	public void selectBoardCountTest() {
		logger.info("56�� ��ȣȸ �Խñ� �� ����:"+boardService.selectBoardCount(56,0));
	}
	
	@Test
	public void  selectBoardTest() {
		logger.info("��ȣȸ ��������: {}",boardService.selectBoard(15, 56));
	}
}
