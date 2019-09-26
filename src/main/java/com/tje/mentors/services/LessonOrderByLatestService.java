package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.LessonViewForAdminDAO;

@Service
public class LessonOrderByLatestService {
	
	@Autowired
	private LessonViewForAdminDAO lessonViewForAdminDAO;
	
	public Object service(int page) {
		return lessonViewForAdminDAO.orderByLatest(page);
	}
	
}
