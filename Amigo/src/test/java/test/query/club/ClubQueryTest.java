package test.query.club;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
		/*{cContent=테스트입니다, cTitle=테스트, cHobby=영화, cArea1=서울, cArea2=용산구}*/
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("cContent", "테스트입니다");
		map.put("cTitle", "테스트");
		map.put("cHobby", "영화");
		map.put("cAddress", "서울특별시 관악구 신림동");

		String path="D://";

		service.insertClub(map,path);
		logger.info("Club Insert 확인");
	}
	
	@Ignore
	@Test
	public void selectHobbyTest() {
		logger.info("가져온 주소값:{}",service.selectHobby("동물/반려견"));
	}
	
	@Ignore
	@Test
	public void selectClubNameTest() {
		logger.info("존재하는 동호회:{}",service.selectClubName("수지"));
	}
	
	@Ignore
	@Test
	public void selectClubsTest() {
		ClubSearchCriteria criteria = new ClubSearchCriteria();
		criteria.setTitleSearch("");
		criteria.setHobbySearch("공연전시");
		criteria.setAddrSearch("");
		criteria.setOrderByCriteria("date");
		
		PagingHandler handler = new PagingHandler(1, service.selectClubCount(criteria), 5, 5);
		
		logger.info("동호회 리스트:"+service.selectClubs(criteria,handler));
	}
	
	@Ignore
	@Test
	public void selectClubCountTest() {
		ClubSearchCriteria criteria = new ClubSearchCriteria();
		criteria.setTitleSearch("");
		criteria.setHobbySearch("공연전시");
		criteria.setAddrSearch("");
		criteria.setOrderByCriteria("date");
		logger.info("현재 존재하는 총 동호회수:{}",service.selectClubCount(criteria));
	}
	
	@Ignore
	@Test
	public void selectClubTest() {
		logger.info("가지고온 동호회:{}",service.selectClub(46));
	}
	
	@Test
	public void selectAddressTest() {
		logger.info("selectAddress테스트 시작");
		List<Map<String,Object>> list =  new ArrayList<Map<String,Object>>();
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("cNum",42);
		map.put("cNum",43);
		map.put("cNum",46);
		list.add(map);
		
		ClubSearchCriteria criteria = new ClubSearchCriteria();
		criteria.setHobbySearch("all");
		criteria.setTitleSearch("");
		criteria.setAddrSearch("");
		criteria.setClubNumList(list);
		logger.info("selectAddress결과: {}",service.selectAddress(criteria));
		
		logger.info("selectAddress테스트 종료");
		
	}
}
