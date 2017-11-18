package com.amigo.controller.club;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.amigo.service.club.ClubService;
import com.amigo.service.file.FileUpLoad;
import com.amigo.util.ClubSearchCriteria;
import com.amigo.util.PagingHandler;
import com.amigo.vo.club.ClubVO;

@Controller
@RequestMapping("/club")
public class ClubController {

	private static final String CLUB_IMAGES_FOLER = "club_images";
	
	@Inject
	private ClubService service;
	
	
	@RequestMapping(value="/clubMake.amg",method= {RequestMethod.GET,RequestMethod.POST})
	public String clubMake() {
		return "club/club_make";
	}
	
	@RequestMapping(value="/insertClub.amg",method=RequestMethod.POST)
	public String insertClub(@RequestParam(value="cpic",required=false) MultipartFile file,
						   MultipartHttpServletRequest request,
						   RedirectAttributes rdr,
						   Authentication authencation,
						   @RequestParam Map<String,Object> map) {
		/*���Ͼ��ε��� ��ι�ȯ*/

		FileUpLoad ful = new FileUpLoad();
		String picName = ful.fileForm(file,request,CLUB_IMAGES_FOLER);
		String redirectPath = "";
		
		/*��ȣȸ ����� ����� ���̵� Ȯ��(��ȣȸ��)*/
		map.put("username", authencation.getName());
		
		/*���ε�� ������ ����� ��ζ�,����ڰ��Է��� ������ ������ map��ü����*/
		int ch_club = service.insertClub(map, picName);
	
		if(ch_club > 0) {
			/*msg�� �ѹ������� ����*/
			rdr.addFlashAttribute("msg", "success");
			/*��ȣȸ �̸�����*/
			rdr.addAttribute("cTitle",(String)map.get("cTitle"));
			redirectPath="/club/club.amg";
		}else {
			rdr.addFlashAttribute("msg","fail");
			redirectPath="/club/clubMake.amg";
		}
		return "redirect:"+redirectPath;
	}
	
	@RequestMapping("/club.amg")
	public ModelAndView club(@RequestParam(value="cNum",required=false) int cNum) {
	
		ModelAndView mav = new ModelAndView();
		System.out.println("��ȣȸ��ȣ:"+cNum);
		ClubVO club = service.selectClub(cNum);
		
		mav.addObject("club",club);
		mav.addObject("cNum",cNum);
		mav.setViewName("club/club");
		
		return mav;
	}
	
	/*history.pushState���� ���ο� url���� �����µ�, �̶� ���ΰ�ħ�ϸ� 404�������� ���.
	    �� ������ �ذ��ϱ����� �����ܿ��� page��� ������ �ϳ��� �޾Ƽ� ������ �������� ����ֵ����Ѵ�
	  ( spa(�̱�������) ���۽�, Ŭ���̾�Ʈ�ܿ��� (club_search.js) history.pushState��������
	    ���� url+ ?page='������' �� �ڵ����� ������.) 
	*/
	@RequestMapping("/clubSearch.amg")
	public ModelAndView clubSearch(@RequestParam(value="keyword",defaultValue="") String keyword,
								   @RequestParam(value="page",defaultValue="1") String page) {
		
		ModelAndView mav = new ModelAndView();

		mav.addObject("keyword", keyword);
		mav.addObject("page", page);
		mav.setViewName("club/club_search");
		
		return mav;
	}
	
	/*ž�޴��� �α����� ���̵�� ���Ե� ��ȸȸ ����Ʈ�� �����ֱ�����*/
	@RequestMapping(value="/clubsGet.amg",method=RequestMethod.POST,produces="application/json; charset=utf-8") 
	public @ResponseBody List<Map<String,Object>> clubsGet(@RequestBody Map<String,Object> map){
		/*�ش���̵�� ���Ե� ��ȣȸ�� �����̶� �̸��� �����ͼ� json���·� ����*/
		return service.selectClubName((String) map.get("username"));
	}
	
	/*	JSON���
	@RequestMapping(value="clubsList.amg",method=RequestMethod.POST)
	public @ResponseBody Map<String,Object> clubsList(@RequestBody ClubSearchCriteria criteria) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		�� ��ȣȸ�� ��������
		int totalClubCount = service.selectClubCount(criteria);
		
		
		System.out.println("�ѵ�ȣȸ��:"+totalClubCount);
		���� ������ ��������
		int curPage = criteria.getCurPage();
	
		����������,�� ��ȣȸ��, ��������, ���������� ������ ��ȣȸ��
		PagingHandler pager = new PagingHandler(curPage, totalClubCount, 5, 6);
		
		map.put("totalClubCount", totalClubCount);
		map.put("clubList",service.selectClubs(criteria, pager) );
		
		map.put("pager", pager);
		return map;

	}*/
	
	@RequestMapping(value="/clubsList.amg",method=RequestMethod.POST)
	public ModelAndView clubsList(@RequestBody ClubSearchCriteria criteria) {
		
		ModelAndView mav = new ModelAndView();
		Map<String,Object> map = new HashMap<String,Object>();
		
		/*�� ��ȣȸ�� ��������*/
		int totalClubCount = service.selectClubCount(criteria);
		
		System.out.println("�ѵ�ȣȸ��:"+totalClubCount);
		/*���� ������ ��������*/
		int curPage = criteria.getCurPage();
	
		/*����������,�� ��ȣȸ��, ��������, ���������� ������ ��ȣȸ��*/
		PagingHandler pager = new PagingHandler(curPage, totalClubCount, 2, 4);
		
		map.put("totalClubCount", totalClubCount);
		map.put("clubList",service.selectClubs(criteria, pager) );
		
		map.put("pager", pager);

		mav.addObject("map", map);
		mav.setViewName("club/club_list");
		
		return mav;
	}
	
	@RequestMapping("/clubJoin.amg")
	public String clubJoin() {
		return "club/club_join";
	}

}




