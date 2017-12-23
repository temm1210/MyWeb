package com.amigo.controller.club;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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
import com.amigo.vo.member.MemberVO;

@Controller
@RequestMapping("/club")
public class ClubController {

	private static final String CLUB_IMAGES_FOLER = "club_images";
	
	@Inject
	private ClubService service;
	
	@Inject
	private FileUpLoad fileUpload;
	
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
		
	
		String picName = fileUpload.fileForm(file,request,CLUB_IMAGES_FOLER);
		String redirectPath = "";
		
		/*��ȣȸ ����� ����� ���̵� Ȯ��(��ȣȸ��)*/
		map.put("username", authencation.getName());
		
		/*���ε�� ������ ����� ��ζ�,����ڰ��Է��� ������ ������ map��ü����*/
		int cNum = service.insertClub(map, picName);
	
		if(cNum > 0) {
			/*msg�� �ѹ������� ����*/
			rdr.addFlashAttribute("msg", "success");
			rdr.addAttribute("cNum", cNum);
			
			/*��ȣȸ Ȩ�������� �̵�*/
			redirectPath="/club/club.amg";
		}else {
			
			rdr.addFlashAttribute("msg","fail");
			redirectPath="/club/clubMake.amg";
		}
		return "redirect:"+redirectPath;
	}
	
	@RequestMapping("/club.amg")
	public ModelAndView club(@RequestParam(value="cNum") int cNum,
							 @RequestParam(value="bNum",defaultValue="0") int bNum
							 /*BoardSearchCriteria criteria*/) {
	
		ModelAndView mav = new ModelAndView();
		ClubVO club = service.selectClub(cNum);
		
		MemberVO user = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		mav.addObject("userid", user.getUsername());
		mav.addObject("club",club);
		mav.addObject("cNum",cNum);
		
		/*mav.addObject("criteria",criteria);*/
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
		System.out.println("��Ȯ��2:"+criteria.getClubNumList());
		/*���� ������ ��������*/
		int curPage = criteria.getCurPage();
	
		/*����������,�� ��ȣȸ��, ��������, ���������� ������ ��ȣȸ��*/
		PagingHandler pager = new PagingHandler(curPage, totalClubCount, 2, 4);
		
		map.put("totalClubCount", totalClubCount);
		map.put("clubList",service.selectClubs(criteria, pager));
		
		map.put("pager", pager);

		mav.addObject("map", map);
		mav.setViewName("club/club_list");
		
		return mav;
	}
	
	/*��ȣȸ ���Ծ���� �����*/
	@RequestMapping("/joinClub.amg")
	public ModelAndView clubJoin(@RequestParam(value="cNum") int cNum) {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("club/club_join");
		mav.addObject("cNum", cNum);
		return mav;
	}
	
	/*��ȣȸ ȸ���� �ƴѵ� ���� �̿��Ұ��*/
	@RequestMapping("/checkMember.amg")
	public ModelAndView checkMember(@RequestParam(value="cNum") int cNum) {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("club/board/club_boardUserCheck");
		mav.addObject("cNum", cNum);
		return mav;
	}
	
	/*��ȣȸ Ż�� Ŭ����*/
	@RequestMapping("/laeveClub.amg")
	public ModelAndView laeveClub(@RequestParam(value="cNum") int cNum) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("club/club_leave");
		mav.addObject("cNum", cNum);
		return mav;
	}
	
	//��ȣȸ �ּҸ� ������
	@ResponseBody
	@RequestMapping(value="/getClubAddress.amg",method=RequestMethod.POST,produces = "application/json; charset=utf8")
	public List<ClubVO> getClubAddress(@RequestBody ClubSearchCriteria criteria){
		List<ClubVO> list = service.selectAddress(criteria);
		return list;
	}
	
	//��ȣȸ ����
	@ResponseBody
	@RequestMapping(value="/deleteClub.amg",method=RequestMethod.GET,produces = "application/text; charset=utf8")
	public String deleteClub(@RequestParam(value="cNum") int cNum) {
		int ch = service.deleteClub(cNum);
		return (ch>0)?"�ش� ��ȣȸ�� �����Ͽ����ϴ�":"��ȣȸ ������ �����Ͽ����ϴ�.";
	}
	
	//��ȣȸ ����(1)
	@ResponseBody
	@RequestMapping(value="/getClub.amg")
	public ModelAndView getClub( @RequestParam(value="cNum") int cNum ) {
		ModelAndView mav = new ModelAndView();
		ClubVO club = service.selectClub(cNum);
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("club", club);
		mav.addObject("map", map);
		mav.setViewName("club/club_modify");
		
		return mav;
	}
	
	//��ȣȸ ����(2)
	@RequestMapping(value="/clubUpdate.amg",method=RequestMethod.POST)
	public String clubUpdate(ClubVO club,
							 MultipartHttpServletRequest request,
							 @RequestParam(value="prev_cPic") String prevFileName,
							 @RequestParam(value="cpic",defaultValue="") MultipartFile file,
							 @RequestParam(value="isChange") String isChange) {

		String updatePicName = null;
		
		//��ȣȸ ������ �����ߴٸ� �������� �����ϰ� ���ο� �������
		if(isChange.equals("change")) {
			fileUpload.deleteFile(request,CLUB_IMAGES_FOLER, prevFileName);
			updatePicName=fileUpload.fileForm(file, request, CLUB_IMAGES_FOLER);
		}else {
			updatePicName=prevFileName;
		}//�������� �ʾҴٸ�, �������� �״�� ���
		
		club.setcPic(updatePicName);
		
		service.updateClub(club);
		

		return "redirect:/club/club.amg?cNum="+club.getcNum();
	}
}
