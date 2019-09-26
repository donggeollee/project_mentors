package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tje.mentors.model.Mentor;
import com.tje.mentors.repository.LessonStatusDAO;
import com.tje.mentors.repository.MentorDAO;

@Service
public class MentorMenteeSearchCntByLessonIdService {
	
	@Autowired
	private LessonStatusDAO lessonStatusDAO;
	
	@Transactional
	public Object service(int lessond_id) {
		
		return lessonStatusDAO.selectByLessonId(lessond_id);
	}
	
}
