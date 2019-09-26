package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.LessonViewForAdminDAO;

@Service
public class LessonFilterByCategoryBigService {
	
	@Autowired
	private LessonViewForAdminDAO lessonViewForAdminDAO;
	
	public Object service(String big, int page) {
		return lessonViewForAdminDAO.filter(big, page);
	}
	
}
