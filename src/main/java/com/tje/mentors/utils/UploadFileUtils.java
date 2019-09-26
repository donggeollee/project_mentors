package com.tje.mentors.utils;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.http.HttpHeaders;
import org.springframework.util.FileCopyUtils;

public class UploadFileUtils {

	public static String uploadFile(
			String uploadPath, String originalName, byte[] fileData) throws IOException {
		// UUID 발급
		UUID uid = UUID.randomUUID();
		// 저장할 파일명 = UUID + 원본이름
		String savedName = uid.toString() + "_" + originalName;
		// 업로드할 디렉토리 (날짜별 폴더)
		// 파일 경로( 기존의 업로드 경로[루트폴더] + 날짜별 경로 ), 파일명을 받아 객체 생성
	
		
		File target = new File(uploadPath,savedName);
		// 임시 디렉토리에 업로드된 파일을 지정된 디렉토리로 복사
		FileCopyUtils.copy(fileData, target);
		// 썸네일 생성을 위한 파일 확장자 검사
		String formatName = 
				originalName.substring(originalName.lastIndexOf(".")+1);
		String uploadedFileName = null;
		// 이미지 파일만 썸네일 생성
		if(MediaUtils.getMediaType(formatName) != null) {
			// 썸네일 생성
			uploadedFileName = makeThumbnail(uploadPath,savedName);
		} else {
			// 나머지는 아이콘 생성
			uploadedFileName = makeIcon(uploadPath,savedName);
		}
		return uploadedFileName;
	}
	
	
	
	// 썸네일 생성
	private static String makeThumbnail(
			String uploadPath,String fileName) throws IOException {
		// 이미지를 읽기 위한 버퍼
		BufferedImage sourceImg = 
				ImageIO.read(new File(uploadPath, fileName));
		// 100픽셀 단위의 썸네일 생성
		BufferedImage destImg = Scalr.resize(
				sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);
		// 썸네일의 이름을 생성(원본 파일명에 's_'를 붙임)
		String thumbnailName = uploadPath + File.separator + "s_" + fileName;
		File newFile = new File(thumbnailName);
		
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
		// 썸네일 생성
		ImageIO.write(destImg, formatName, newFile);
		// 썸네일의 이름을 리턴함
		return thumbnailName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}
	
	// 아이콘 생성
	private static String makeIcon(String uploadPath,String fileName) {
		// 아이콘의 이름
		String iconName = uploadPath+ File.separator + fileName;
		// 아이콘의 이름을 리턴
		// File.separatorChar : 디렉토리 구분자
		// 윈도우 \ , 유닉스(리눅스) /
		return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}
}
