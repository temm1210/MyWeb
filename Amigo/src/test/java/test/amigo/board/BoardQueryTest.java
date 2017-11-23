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
		criteria.setOrderByWord("�ֽż�");
		criteria.setCategory(0);
		PagingHandler pager = new PagingHandler(1, boardService.selectBoardCount(criteria), 2, 1);

/*		criteria.setSearchWord("");
		
		criteria.setSearchOption("all");*/
		logger.info("selectBoardsTest �׽�Ʈ:{}",boardService.selectBoards(criteria,pager));
	}
	
	@Test
	@Ignore
	public void selectBoardCountTest() {
		BoardSearchCriteria criteria = new BoardSearchCriteria();
		criteria.setSearchWord("");
		criteria.setOrderByWord("");
		criteria.setSearchOption("all");
		logger.info("56�� ��ȣȸ �Խñ� �� ����:"+boardService.selectBoardCount(criteria));
	}
	
	@Test
	@Ignore
	public void  selectBoardTest() {
		logger.info("��ȣȸ ��������: {}",boardService.selectBoard(15, 56));
	}
	
	@Test
	@Ignore
	public void updateLike() {
		logger.info("���ƿ�Ŭ�� �׽�Ʈ����");
		boardService.updateLike("����",1, 56);
		logger.info("���ƿ�Ŭ�� �׽�Ʈ����");
	}
}
