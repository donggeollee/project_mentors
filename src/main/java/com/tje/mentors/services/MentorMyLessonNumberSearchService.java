package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.*;
import com.tje.mentors.model.*;

// 멘토 마이페이지
// 멘토링 요청 확인 서비스
@Service
public class MentorMyLessonNumberSearchService {

		@Autowired
		private MyMenteeListDAO myMenteeListDAO;
		
		
		public Object service(int mentor_id) {
			
			return myMenteeListDAO.selectTitleId(mentor_id);
		}
	
}
