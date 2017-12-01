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
				
				/*����ڰ� �ø����� �ϴ� �̹����� ���̰� maxWidth����Ŭ��, �������°� ���*/
				if(width > maxWidth) {
					float widthRatio = maxWidth/((float)width);
					width = (int)(image.getWidth()*widthRatio);
					height = (int)(image.getHeight()*widthRatio);
				}
				
				/*����ڰ� �ø����� �ϴ� �̹����� ���̰� maxHeight����Ŭ��, �������°� ���*/
				if(height > maxHeight) {
					float heightRatio = maxHeight/(float)height;
					width = (int)(width*heightRatio);
					height = (int)(height*heightRatio);
				}
				
				/*�̹����� ũ�⿡ �°� �ٽ� ���� �ӵ����� ǰ���� ���� �̹����� ����*/
				Image resizeImg = image.getScaledInstance(width, height, Image.SCALE_SMOOTH);
				
				/*�̹������۸� �̿��ؼ� ������ ����,���̿��´� �̹����� ����Ʈ�� ������ �ӽ�����*/
			    BufferedImage newImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		        Graphics g = newImage.getGraphics();
		        
		        /*X:0,y:0�������� resizeImg�� �׸���*/
		        g.drawImage(resizeImg, 0, 0, null);
		        g.dispose();
		        
		        /*���ۿ� �ӽ������ص� ����Ʈ�� ���������� �̹��� ������ ���� ���ε� ��ο� ����*/
		        ImageIO.write(newImage, "jpg", new File(uploadPath + saveFileName));
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
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
