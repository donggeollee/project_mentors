package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tje.mentors.repository.*;
import com.tje.mentors.model.*;

// 멘토 마이페이지
// 멘토링 요청 -> 수락 서비스


@Service
public class MentorMyLessonMentoringDeleteService {

		@Autowired
		private LessonApplyDAO lessonApplyDAO;
	
		@Transactional
		public Object service(Object args) {
			
			return lessonApplyDAO.delete((LessonApply)args) == 0 ? false : true;

		}
	
}
