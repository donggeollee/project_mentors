package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.model.Mentor;
import com.tje.mentors.repository.MentorDAO;

@Service
public class MentorSearchByEmailService {
	@Autowired
	private MentorDAO mentorDAO;
	
	public Object service(Object args) {
		return mentorDAO.selectByEmail((Mentor)args);
	}
	
}
