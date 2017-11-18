package test.query.club;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.amigo.service.club.ClubService;
import com.amigo.util.ClubSearchCriteria;
import com.amigo.util.PagingHandler;

import test.amigo.oracle.OracleTest;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
@WebAppConfiguration
public class ClubQueryTest {
	private static final Logger logger = LoggerFactory.getLogger(OracleTest.class);
	
	@Inject
	private ClubService service;
	
	@Test
	@Ignore
	public void insertTest() {
		/*{cContent=�׽�Ʈ�Դϴ�, cTitle=�׽�Ʈ, cHobby=��ȭ, cArea1=����, cArea2=��걸}*/
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("cContent", "�׽�Ʈ�Դϴ�");
		map.put("cTitle", "�׽�Ʈ");
		map.put("cHobby", "��ȭ");
		map.put("cAddress", "����Ư���� ���Ǳ� �Ÿ���");

		String path="D://";

		service.insertClub(map,path);
		logger.info("Club Insert Ȯ��");
	}
	
	@Ignore
	@Test
	public void selectHobbyTest() {
		logger.info("������ �ּҰ�:{}",service.selectHobby("����/�ݷ���"));
	}
	
	@Ignore
	@Test
	public void selectClubNameTest() {
		logger.info("�����ϴ� ��ȣȸ:{}",service.selectClubName("����"));
	}
	
	@Ignore
	@Test
	public void selectClubsTest() {
		ClubSearchCriteria criteria = new ClubSearchCriteria();
		criteria.setTitleSearch("");
		criteria.setHobbySearch("��������");
		criteria.setAddressSearch("");
		criteria.setOrderByCriteria("date");
		
		PagingHandler handler = new PagingHandler(1, service.selectClubCount(criteria), 5, 5);
		
		logger.info("��ȣȸ ����Ʈ:"+service.selectClubs(criteria,handler));
	}
	@Ignore
	@Test
	public void selectClubCountTest() {
		ClubSearchCriteria criteria = new ClubSearchCriteria();
		criteria.setTitleSearch("");
		criteria.setHobbySearch("��������");
		criteria.setAddressSearch("");
		criteria.setOrderByCriteria("date");
		logger.info("���� �����ϴ� �� ��ȣȸ��:{}",service.selectClubCount(criteria));
	}
	
	@Test
	public void selectClubTest() {
		logger.info("������� ��ȣȸ:{}",service.selectClub(46));
	}
}
