package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.*;
import com.tje.mentors.model.*;

// 멘토 마이페이지
// 나의 멘티 목록
@Service
public class MentorMyMenteeListService {

		@Autowired
		private MyMenteeListDAO mymenteelistDAO;
		
		public Object service(int mentor_id, int lesson_id) {
			
			return mymenteelistDAO.selectAll(mentor_id,lesson_id);
		}
	
}
