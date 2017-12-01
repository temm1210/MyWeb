package com.amigo.service.file;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Service
public class FileUpLoad {
	
	public FileUpLoad() {};
	
	public String fileForm(MultipartFile file,MultipartHttpServletRequest request,String folderName) {		
		String uploadPath = getSaveLocation(request,folderName);
		String saveFileName = file.getOriginalFilename();
		File fileDir = new File(uploadPath + saveFileName);
		int maxWidth = 1600;
		int maxHeight = 950;
		
		if(saveFileName != null && !saveFileName.equals("")) {
			if(!fileDir.exists())
				fileDir.mkdirs();
			
			saveFileName =System.currentTimeMillis() +"_"+saveFileName;
			
			try {
				BufferedImage image = ImageIO.read(file.getInputStream());
				
				int width = image.getWidth();
				int height = image.getHeight();
				
				/*사용자가 올릴려고 하는 이미지의 넓이가 maxWidth보다클시, 비율에맞게 축소*/
				if(width > maxWidth) {
					float widthRatio = maxWidth/((float)width);
					width = (int)(image.getWidth()*widthRatio);
					height = (int)(image.getHeight()*widthRatio);
				}
				
				/*사용자가 올릴려고 하는 이미지의 높이가 maxHeight보다클시, 비율에맞게 축소*/
				if(height > maxHeight) {
					float heightRatio = maxHeight/(float)height;
					width = (int)(width*heightRatio);
					height = (int)(height*heightRatio);
				}
				
				/*이미지를 크기에 맞게 다시 만듬 속도보단 품질이 좋은 이미지로 만듬*/
				Image resizeImg = image.getScaledInstance(width, height, Image.SCALE_SMOOTH);
				
				/*이미지버퍼를 이용해서 지정한 넓이,높이에맞는 이미지를 바이트로 나눠서 임시저장*/
			    BufferedImage newImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		        Graphics g = newImage.getGraphics();
		        
		        /*X:0,y:0에서부터 resizeImg를 그린다*/
		        g.drawImage(resizeImg, 0, 0, null);
		        g.dispose();
		        
		        /*버퍼에 임시저장해둔 바이트로 나눠저장한 이미지 파일을 실제 업로드 경로에 저장*/
		        ImageIO.write(newImage, "jpg", new File(uploadPath + saveFileName));
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		System.out.println("경로확인:"+uploadPath);
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
       /*defaultPath가 webapp까지의 경로를 알아서 구해줌*/
       
       /*filePath는 webapp이후의 경로를 직접설정*/
       return filePath;
	}
	
}
