package test.query.member;

import javax.inject.Inject;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import com.amigo.service.member.MemberService;
import com.amigo.vo.member.MemberVO;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
@WebAppConfiguration
public class MemberQueryTest {
private static final Logger logger = LoggerFactory.getLogger(MemberQueryTest.class);
	
	@Inject
	private MemberService service;
	
	@Test
	@Ignore
	public void selectMemberTest() {
		logger.info("selectMember 확인: {}",service.selectMember("설현"));
	}
	
	@Test
	@Ignore
	public void insertMemberTest() {
		logger.info("insertMemberTest 시작");
		
		MemberVO member = new MemberVO();
		member.setUsername("설현");
		member.setPassword("1234");
		member.setmName("설현");
		member.setmTel("1234");
		member.setmEmail("atad@adf");
		member.setmGender("W");
		member.setmAge(23);
		
		service.insertMember(member,"ROLE_USER");
	}
	
	@Test
	public void updateMemberTest() {
		logger.info("updateMember 시작");
	
		MemberVO member = service.selectMember("호우");
		
		logger.info("member의값:{}",member);
		member.setPassword("qwer1234@");
		member.setmName("호날두");
		member.setmTel("01012341234");
		member.setmEmail("Real@gmail.com");
		
		service.updateMember(member);
	}
	
}
