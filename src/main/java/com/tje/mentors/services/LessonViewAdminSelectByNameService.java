package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.LessonViewForAdminDAO;

@Service
public class LessonViewAdminSelectByNameService {
	
	@Autowired
	private LessonViewForAdminDAO lessonViewForAdminDAO;
	
	public Object service(String name, int page) {
		return lessonViewForAdminDAO.selectByName(name, page);
	}
	
}
