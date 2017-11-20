package test.query.clubmember;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import com.amigo.service.clubmember.ClubMemberService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
@WebAppConfiguration
public class ClubMemberQueryTest {
	private static final Logger logger = LoggerFactory.getLogger(ClubMemberQueryTest.class);
	
	@Inject
	private ClubMemberService service;
	
	@Test 
	public void selectNickname() {
		logger.info("selectNickname테스트: {}",service.selectNickname("설현", 56));
	}
}
