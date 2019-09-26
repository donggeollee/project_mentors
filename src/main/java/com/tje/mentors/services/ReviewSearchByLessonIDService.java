package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.ReviewDAO;

@Service
public class ReviewSearchByLessonIDService {
	
	@Autowired
	ReviewDAO reviewDAO;
	
	public Object service(int lesson_id) {
		return reviewDAO.select(lesson_id);
	}
	
}
