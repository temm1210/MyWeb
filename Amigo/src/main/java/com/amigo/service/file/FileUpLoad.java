package com.amigo.service.file;

import java.io.File;
import java.io.IOException;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Service
public class FileUpLoad {
	
	public FileUpLoad() {};
	
	public String fileForm(MultipartFile file,MultipartHttpServletRequest request,String folderName) {		
		String uploadPath = getSaveLocation(request,folderName);
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
	public void deleteFile(MultipartHttpServletRequest request,String folderName,String deleteFileName) {
		String deletePath = getSaveLocation(request, folderName)+deleteFileName;
		File file = new File(deletePath);
		
		if(file.exists() == true){
			file.delete();
		}
	}
	
	private String getSaveLocation(MultipartHttpServletRequest request,String folderName){
	   String defaultPath=request.getServletContext().getRealPath("/");
	   String filePath=defaultPath+"resources"+File.separator+"images"+File.separator+folderName+File.separator;       
       /*defaultPath�� webapp������ ��θ� �˾Ƽ� ������*/
       
       /*filePath�� webapp������ ��θ� ��������*/
       return filePath;
	}
	
}
