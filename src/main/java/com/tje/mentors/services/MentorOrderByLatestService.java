package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.MentorDAO;

@Service
public class MentorOrderByLatestService {
	
	@Autowired
	private MentorDAO mentorDAO;
	
	public Object service(int page) {
		return mentorDAO.orderByLatest(page);
	}
	
}
