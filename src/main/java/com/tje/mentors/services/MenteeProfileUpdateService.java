package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.model.Mentee;
import com.tje.mentors.model.Mentor;
import com.tje.mentors.repository.MenteeDAO;
import com.tje.mentors.repository.MentorDAO;

@Service
public class MenteeProfileUpdateService {

	@Autowired
	private MenteeDAO menteeDAO;
	
	public Object service(Mentee model) {
		
		return menteeDAO.updateProfile(model) == 0 ? false : true;
	
	}
}
