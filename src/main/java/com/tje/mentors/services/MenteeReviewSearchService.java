package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.*;

@Service
public class MenteeReviewSearchService {

	@Autowired
	private ReviewDAO reviewDAO;
	
	public Boolean service(int lesson_id, int mentee_id) {

		return reviewDAO.select(lesson_id, mentee_id) != null ? true : false;
	}
	
	
}
