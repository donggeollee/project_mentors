package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.model.*;
import com.tje.mentors.repository.*;

@Service
public class MenteeMyFLessonSearchService {

	@Autowired
	private MyLessonListDAO myLessonListDAO;
	
	public Object service(int menti_id) {
		
		return myLessonListDAO.selectFinished(menti_id);
	}
	
	
}
