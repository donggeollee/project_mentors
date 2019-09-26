package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.model.Lesson;
import com.tje.mentors.repository.LessonDAO;

@Service
public class MentorUpdateLessonService {

	@Autowired
	private LessonDAO lessonDAO;
	
	public Object service(Lesson model) {
		
		return lessonDAO.update(model);
	
	}
}
