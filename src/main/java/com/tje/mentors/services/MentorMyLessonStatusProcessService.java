package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tje.mentors.repository.*;
import com.tje.mentors.model.*;

// 멘토 마이페이지
// 멘토링 요청 -> 수락 서비스 + 클래스 상황 Process로 변경


@Service
public class MentorMyLessonStatusProcessService {

		@Autowired
		private LessonStatusDAO lessonStatusDAO;
	
		@Transactional
		public Object service(Object args) {
			
			return lessonStatusDAO.insert((LessonStatus)args) == 0 ? false : true;

		}
	
}
