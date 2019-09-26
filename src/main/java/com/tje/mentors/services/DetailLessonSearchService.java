package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.model.Lesson;
import com.tje.mentors.repository.DetailLessonViewDAO;

@Service
public class DetailLessonSearchService {
	
	@Autowired
	private DetailLessonViewDAO detailLessonViewDAO;
	
	public Object service(Lesson lesson) {
		return detailLessonViewDAO.selectOne(lesson);
	}
	
}
