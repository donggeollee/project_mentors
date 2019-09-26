package com.tje.mentors.services;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.tje.mentors.repository.Category_nameDAO;
import com.tje.mentors.repository.LessonDAO;
import com.tje.mentors.model.Category_name;

@Service
public class LessonFilterCountService {

	@Autowired
	private LessonDAO dao;
	

	public Object service(String smallCategories,String[] arrLocation) {
		
		// [지역 필터를 통해 '전체'가 전달되는 경우에 따른 분기]
		// 시/구/X 순서로 분기함
		String daoLoc = null;
		// '시' 전체인 경우
		if ( arrLocation[0].equals("all")) { 
			daoLoc = " ";
		// '시'는 전체가 아니고 '구'만 전체인 경우
		} else if (	!arrLocation[0].equals("all") && arrLocation[1].equals("all")) { 
			daoLoc = arrLocation[0];
		// '시' 와 '구' 둘다 전체가 아닌 경우
		} else {
			daoLoc = arrLocation[0] + " " +arrLocation[1]; 
		}
		
		ArrayList<String> smallCateList = new ArrayList<String>();
		
		String[] arrSmallCates = smallCategories.split(",");
		for( String smallCate : arrSmallCates) {
			smallCateList.add(smallCate);
		}
		return dao.selectFilterCount( smallCateList, daoLoc);
	}

}

