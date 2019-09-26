package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.*;
import com.tje.mentors.model.*;

// 멘토 마이페이지
// 내가 작성한 클래스 목록 
@Service
public class MentorMyWriteLessonCountService {

		@Autowired
		private LessonDAO lessonDAO;
		
		
		public Object service(int mentor_id) {
			
			return lessonDAO.selectLessonCnt(mentor_id);
		}
	
}
