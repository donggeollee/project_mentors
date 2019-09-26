package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.ImageDAO;

@Service
public class ImageSearchByLessonService {
	
	@Autowired
	ImageDAO imageDAO;
	
	public Object service(int lesson_id) {
		return imageDAO.select(lesson_id);
	}
}
