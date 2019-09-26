package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tje.mentors.repository.LessonViewForAdminDAO;

@Repository
public class LessonCountByNameService {

	@Autowired
	private LessonViewForAdminDAO lessonViewForAdminDAO;
	
	public Object service(String name) {
		return lessonViewForAdminDAO.countByName(name);
	}
	
}
