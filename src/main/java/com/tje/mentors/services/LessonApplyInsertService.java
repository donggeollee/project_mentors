package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.model.LessonApply;
import com.tje.mentors.repository.LessonApplyDAO;

@Service
public class LessonApplyInsertService {

	@Autowired
	private LessonApplyDAO lessonApplyDAO;
	
	public int service(LessonApply target) {
		return lessonApplyDAO.insert(target);
	}
	
}
