package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.LessonDAO;

@Service
public class LessonListForMainTopService {
	
	@Autowired
	private LessonDAO lessonDAO;
	
	public Object service() {
		return lessonDAO.mainLessonListOrderByScore();
	}
	
}
