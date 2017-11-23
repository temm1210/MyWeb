package test.amigo.reply;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.amigo.service.reply.ReplyService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
@WebAppConfiguration
public class ReplyQueryTest {
	
	private static final Logger logger = LoggerFactory.getLogger(ReplyQueryTest.class);
	
	@Inject
	private ReplyService replyService;

	@Test
	public void selectReplysTest() {
		logger.info("selectReplys테스트 시작");
		logger.info("selectReplys결과 {}",replyService.selectReplys(56, 2));
		logger.info("selectReplys테스트 종료");
	}
}
