package com.amigo.util.file;

import java.io.File;
import java.io.IOException;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class FileUpLoad {
	
	public FileUpLoad() {};
	
	public String fileForm(MultipartFile file,MultipartHttpServletRequest request ) {		
		String uploadPath = getSaveLocation(request);
		String saveFileName = file.getOriginalFilename();
		
		if(saveFileName != null && !saveFileName.equals("")) {
			if(new File(uploadPath + saveFileName).exists()) 
				saveFileName =System.currentTimeMillis() +"_"+saveFileName;
				
			try {
				file.transferTo(new File(uploadPath + saveFileName));
			} catch(IllegalStateException e) {
				e.printStackTrace();
			} catch(IOException e2) {
				e2.printStackTrace();			
			}
		}
		
		System.out.println("���Ȯ��:"+uploadPath);
		return saveFileName;
	}
	
	private String getSaveLocation(MultipartHttpServletRequest request){
	   String defaultPath=request.getSession().getServletContext().getRealPath("/");
       String filePath=defaultPath+"resources"+File.separator+"images"+File.separator+"club_images"+File.separator;
       /*defaultPath�� webapp������ ��θ� �˾Ƽ� ������*/
       
       /*filePath�� webapp������ ��θ� ��������*/
       return filePath;
	}
	
}
