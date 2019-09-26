package com.tje.mentors.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.model.Lesson;
import com.tje.mentors.model.LessonViewForAdmin;
import com.tje.mentors.repository.LessonDAO;
import com.tje.mentors.repository.LessonViewForAdminDAO;

@Service
public class LessonSelectAllService {

	@Autowired
	private LessonViewForAdminDAO lessonViewForAdminDAO;
	
	public Object service(int page) {
		List<LessonViewForAdmin> result = (List<LessonViewForAdmin>)lessonViewForAdminDAO.selectAll(page);
		
		return result.isEmpty()? null : result;
	}
	
}
