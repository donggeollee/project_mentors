package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.MentorDAO;

@Service
public class MentorSearchByNameService {
	
	@Autowired
	private MentorDAO mentorDAO;
	
	public Object service(String name, int page) {
		return mentorDAO.selectByName(name, page);
	}
}
