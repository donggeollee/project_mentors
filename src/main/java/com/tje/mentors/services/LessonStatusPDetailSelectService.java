package com.tje.mentors.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.model.Lesson;
import com.tje.mentors.model.LessonViewForAdmin;
import com.tje.mentors.repository.LessonDAO;
import com.tje.mentors.repository.LessonStatusDAO;
import com.tje.mentors.repository.LessonViewForAdminDAO;
import com.tje.mentors.repository.MyLessonListDAO;
import com.tje.mentors.repository.MyMenteeListDAO;

@Service
public class LessonStatusPDetailSelectService {

	@Autowired
	private MyMenteeListDAO myMenteeListDAO;
	
	public Object service(int lesson_id) {
		
		
		return myMenteeListDAO.selectByLessonId(lesson_id);
	}
	
}
