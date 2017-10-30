package com.amigo.controller.club;
import java.security.Principal;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.amigo.service.club.ClubService;
import com.amigo.util.file.FileUpLoad;


@Controller
@RequestMapping("/club")
public class ClubController {

	@Inject
	private ClubService service;
	
	
	/*select�ڽ� ���۽���û DB���� 2��° selectBox�� �� ���� List��ȯ*/
	@ResponseBody   
	@RequestMapping(value="/selectBox.amg",method=RequestMethod.POST)
	public List<String> selectBox(@RequestParam("area") String area) {

		return service.selectSubArea(area);
	}
	
	@RequestMapping(value="/clubMake.amg",method= {RequestMethod.GET,RequestMethod.POST})
	public String clubMake(Principal principal) {
		System.out.println("����üũ :"+principal.getName());
		return "/club/club_make";
	}
	
	@RequestMapping(value="/insertClub.amg",method=RequestMethod.POST)
	public String insertClub(@RequestParam("cpic") MultipartFile file,
						   MultipartHttpServletRequest request,
						   RedirectAttributes rdr,
						   Authentication authencation,
						   @RequestParam Map<String,Object> map) {
		/*���Ͼ��ε��� ��ι�ȯ*/
		FileUpLoad ful = new FileUpLoad();
		String picName = ful.fileForm(file,request);
		/*------------*/
		
		/*��ȣȸ ����� ����� ���̵� Ȯ��(��ȣȸ��)*/
		map.put("username", authencation.getName());
		
		/*���ε�� ������ ����� ��ζ�,����ڰ��Է��� ������ ������ map��ü����*/
		int ch = service.insertClub(map, picName);
		String redirectPath = "";
		
		if(ch > 0) {
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
	
	
	@RequestMapping("/clubRead.amg/{num}")
	public String clubReead(@PathVariable("num") int num) {
		
		return "club/club";
	}
	
	@RequestMapping("/clubSearch.amg")
	public ModelAndView clubSearch(@RequestParam(value="keyword",defaultValue="") String keyword) {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("keyword", keyword);
		mav.setViewName("club/club_serach");
		
		return mav;
	}

}
