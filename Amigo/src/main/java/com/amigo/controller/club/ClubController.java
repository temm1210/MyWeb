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
		
		/*동호회 만드는 사람의 아이디 확인(동호회장)*/
		map.put("username", authencation.getName());
		
		/*업로드된 파일이 저장된 경로랑,사용자가입력한 정보를 저장한 map객체전달*/
		int cNum = service.insertClub(map, picName);
	
		if(cNum > 0) {
			/*msg는 한번만쓰고 삭제*/
			rdr.addFlashAttribute("msg", "success");
			rdr.addAttribute("cNum", cNum);
			
			/*동호회 홈페이지로 이동*/
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
	
	/*history.pushState에서 새로운 url값을 만들어내는데, 이때 새로고침하면 404페이지가 뜬다.
	    이 현상을 해결하기위해 서버단에서 page라는 변수를 하나더 받아서 적절한 페이지를 띄워주도록한다
	  ( spa(싱글페이지) 동작시, 클라이언트단에서 (club_search.js) history.pushState으로인해
	    기존 url+ ?page='페이지' 가 자동으로 생성됨.) 
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
	
	/*탑메뉴에 로그인한 아이디로 가입된 동회회 리스트를 보여주기위해*/
	@RequestMapping(value="/clubsGet.amg",method=RequestMethod.POST,produces="application/json; charset=utf-8") 
	public @ResponseBody List<Map<String,Object>> clubsGet(@RequestBody Map<String,Object> map){
		/*해당아이디로 가입된 동호회의 사진이랑 이름을 가져와서 json형태로 리턴*/
		return service.selectClubName((String) map.get("username"));
	}
	
	/*	JSON방식
	@RequestMapping(value="clubsList.amg",method=RequestMethod.POST)
	public @ResponseBody Map<String,Object> clubsList(@RequestBody ClubSearchCriteria criteria) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		총 동호회수 가져오기
		int totalClubCount = service.selectClubCount(criteria);
		
		
		System.out.println("총동호회수:"+totalClubCount);
		현재 페이지 가져오기
		int curPage = criteria.getCurPage();
	
		현재페이지,총 동호회수, 블럭사이즈, 한페이지당 보여줄 동호회수
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
		
		/*총 동호회수 가져오기*/
		int totalClubCount = service.selectClubCount(criteria);
		System.out.println("값확인2:"+criteria.getClubNumList());
		/*현재 페이지 가져오기*/
		int curPage = criteria.getCurPage();
	
		/*현재페이지,총 동호회수, 블럭사이즈, 한페이지당 보여줄 동호회수*/
		PagingHandler pager = new PagingHandler(curPage, totalClubCount, 2, 4);
		
		map.put("totalClubCount", totalClubCount);
		map.put("clubList",service.selectClubs(criteria, pager));
		
		map.put("pager", pager);

		mav.addObject("map", map);
		mav.setViewName("club/club_list");
		
		return mav;
	}
	
	/*동호회 가입양식을 띄워줌*/
	@RequestMapping("/joinClub.amg")
	public ModelAndView clubJoin(@RequestParam(value="cNum") int cNum) {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("club/club_join");
		mav.addObject("cNum", cNum);
		return mav;
	}
	
	/*동호회 회원이 아닌데 서비스 이용할경우*/
	@RequestMapping("/checkMember.amg")
	public ModelAndView checkMember(@RequestParam(value="cNum") int cNum) {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("club/board/club_boardUserCheck");
		mav.addObject("cNum", cNum);
		return mav;
	}
	
	/*동호회 탈퇴 클릭시*/
	@RequestMapping("/laeveClub.amg")
	public ModelAndView laeveClub(@RequestParam(value="cNum") int cNum) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("club/club_leave");
		mav.addObject("cNum", cNum);
		return mav;
	}
	
	//동호회 주소를 가져옴
	@ResponseBody
	@RequestMapping(value="/getClubAddress.amg",method=RequestMethod.POST,produces = "application/json; charset=utf8")
	public List<ClubVO> getClubAddress(@RequestBody ClubSearchCriteria criteria){
		List<ClubVO> list = service.selectAddress(criteria);
		return list;
	}
	
	//동호회 삭제
	@ResponseBody
	@RequestMapping(value="/deleteClub.amg",method=RequestMethod.GET,produces = "application/text; charset=utf8")
	public String deleteClub(@RequestParam(value="cNum") int cNum) {
		int ch = service.deleteClub(cNum);
		return (ch>0)?"해당 동호회를 삭제하였습니다":"동호회 삭제에 실패하였습니다.";
	}
	
	//동호회 수정(1)
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
	
	//동호회 수정(2)
	@RequestMapping(value="/clubUpdate.amg",method=RequestMethod.POST)
	public String clubUpdate(ClubVO club,
							 MultipartHttpServletRequest request,
							 @RequestParam(value="prev_cPic") String prevFileName,
							 @RequestParam(value="cpic",defaultValue="") MultipartFile file,
							 @RequestParam(value="isChange") String isChange) {

		String updatePicName = null;
		
		//동호회 사진을 변경했다면 기존사진 삭제하고 새로운 사진등록
		if(isChange.equals("change")) {
			fileUpload.deleteFile(request,CLUB_IMAGES_FOLER, prevFileName);
			updatePicName=fileUpload.fileForm(file, request, CLUB_IMAGES_FOLER);
		}else {
			updatePicName=prevFileName;
		}//삭제하지 않았다면, 기존사진 그대로 사용
		
		club.setcPic(updatePicName);
		
		service.updateClub(club);
		

		return "redirect:/club/club.amg?cNum="+club.getcNum();
	}
}
