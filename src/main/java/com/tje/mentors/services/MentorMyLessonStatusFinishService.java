package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tje.mentors.repository.*;
import com.tje.mentors.model.*;

// 멘토 마이페이지
// 멘티리스트 멘토링 완료 버튼 클릭 시 
// lesson_status 상황 F로 변경 (종료)


@Service
public class MentorMyLessonStatusFinishService {

		@Autowired
		private LessonStatusDAO lessonStatusDAO;
	
		public Object service(Object args) {
			
			return lessonStatusDAO.updateCurStatusFinish((LessonStatus)args) == 0 ? false : true;

		}
	
}
