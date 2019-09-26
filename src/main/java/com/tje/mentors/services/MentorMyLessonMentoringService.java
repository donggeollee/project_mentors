package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.*;
import com.tje.mentors.model.*;

// 멘토 마이페이지
// 멘토링 요청 확인 서비스
@Service
public class MentorMyLessonMentoringService {

		@Autowired
		private LessonApplyToMentorViewDAO lessonApplyToMentorViewDAO;
		
		
		public Object service(Object args) {
			
			return lessonApplyToMentorViewDAO.selectListByMentorID((LessonApplyToMentorView)args);
		}
	
}
