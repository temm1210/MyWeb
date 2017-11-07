package com.amigo.controller.club;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
			rdr.addAttribute("msg", "success" );
			rdr.addAttribute("picName", picName);
			/*��ȣȸ �̸�����*/
			rdr.addAttribute("cName",(String)map.get("cTitle"));
			redirectPath="/club/club.amg";
		}else {
			rdr.addAttribute("msg","fail");
			redirectPath="/club/clubMake.amg";
		}
		return "redirect:"+redirectPath;
	}
	
	@RequestMapping("/club.amg")
	public String club(@RequestParam(value="msg",defaultValue="") String msg,
					   @RequestParam(value="picName",defaultValue="") String picName,
					   @RequestParam(value="cName",defaultValue="") String cName,
					   Model model) {
		
		model.addAttribute("msg", msg);
		model.addAttribute("picName", picName);
		model.addAttribute("cName",cName);
		return "club/club";
	}
	
	@RequestMapping("/clubSearch.amg")
	public ModelAndView clubSearch(@RequestParam(value="keyword",defaultValue="") String keyword) {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("keyword", keyword);
		mav.setViewName("club/club_serach");
		
		return mav;
	}
	
	@RequestMapping(value="clubsGet.amg",method=RequestMethod.POST,produces="application/json; charset=utf-8") 
	public @ResponseBody List<Map<String,Object>> clubsGet(@RequestBody Map<String,Object> map){
		/*�ش���̵�� ���Ե� ��ȣȸ�� �����̶� �̸��� �����ͼ� json���·� ����*/
		List<Map<String,Object>> listMap = service.selectClubName((String) map.get("username"));
		System.out.println("��������:"+(String) map.get("username"));
		for(Map<String,Object> map2 : listMap) {
			System.out.println("��Ȯ��:"+map2.get("CTITLE"));
			System.out.println("��Ȯ��:"+map2.get("CPIC"));
		}
		return listMap;
	}
}
