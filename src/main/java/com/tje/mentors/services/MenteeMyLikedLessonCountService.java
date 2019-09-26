package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.*;

@Service
public class MenteeMyLikedLessonCountService {

	@Autowired
	private MyLikedListDAO myLikedListDAO;
	
	public Object service(int mentee_id) {

		return myLikedListDAO.selectLikedCount(mentee_id);
	}
	
	
}
