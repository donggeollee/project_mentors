package com.tje.mentors.services;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.tje.mentors.model.Lesson;
import com.tje.mentors.repository.LessonDAO;

// 최신순/리뷰평점순/
@Service
public class LessonListFilterService {
	
	@Autowired
	private LessonDAO dao;
	
	
	public Object service(String bigCategory,ArrayList<String> smallCategories,
			String[] arrLocation, String align, int lessonPage  ) {
		
		
		// [사용자가 선택한 정렬 방식에 따라  sql 문에서 사용할 칼럼값 설정]
		// 최신순으로 정렬이 된 상태에서 사용자가 다시 최신순을 눌렀을 때, 
		// 반대로 오래된 순서로 정렬 되도록 하려면 javascript 에서 기존 값과 
		// 비교하여 "theOldest"와 같은 값을 컨트롤러를 통해 해당 서비스로 넘어왔을 조건을 통해 
		// 비교할 수 있도록 아래의 정렬 조건식에 else if 문을 추가하면 
		// 될 것 같은 생각으로 만들었습니다............................
		String daoAlign = null;
		if(align.equals("theLatest")) {
			daoAlign = "write_date desc";
		} else if(align.equals("theOldest")) {
			daoAlign = "write_date";
		} else if(align.equals("highScore")) {
			daoAlign = "avg_score desc";
		} else if(align.equals("lowScore")) {
			daoAlign = "avg_score";
		}
		
		// [지역 필터를 통해 '전체'가 전달되는 경우에 따른 분기] 
		// 시/구/X 순서로 분기함 
		String daoLoc = null;
		// '시' 전체인 경우
		if ( arrLocation[0].equals("all")) { 
			daoLoc = "%";
		// '시'는 전체가 아니고 '구'만 전체인 경우
		} else if (	!arrLocation[0].equals("all") && arrLocation[1].equals("all")) { 
			daoLoc = arrLocation[0];
		// '시' 와 '구' 둘다 전체가 아닌 경우
		} else {
			daoLoc = arrLocation[0] + " " +arrLocation[1]; 
		}

		List<Lesson> result  = (List<Lesson>)dao.selectAllByFilter( 
					bigCategory, smallCategories , daoLoc ,daoAlign, lessonPage);
		
		return result;
	}
}
