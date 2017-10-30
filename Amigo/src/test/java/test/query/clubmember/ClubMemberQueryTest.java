package test.query.clubmember;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.amigo.dao.clubmember.ClubMemberDAO;
import com.amigo.vo.clubmember.ClubMemberVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
@WebAppConfiguration
public class ClubMemberQueryTest {
	private static final Logger logger = LoggerFactory.getLogger(ClubMemberQueryTest.class);
	
	@Inject
	private ClubMemberDAO dao;
	
	@Test
	public void insertClubMemberTest() {
	
		logger.info("insertClubMember �׽�Ʈ����");
		ClubMemberVO clubMember = new ClubMemberVO();
		
		clubMember.setNickName("�׽�Ʈ �г���");
		clubMember.setMid("IU");
		clubMember.setcGrade("�Ϲ�ȸ��");
		dao.insertClubMember(clubMember);
	}
}
