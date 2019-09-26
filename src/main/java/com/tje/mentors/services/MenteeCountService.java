package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.*;

@Service
public class MenteeCountService {
	
	@Autowired
	private MenteeDAO menteeDAO;
	
	public Object service() {
		
		return menteeDAO.countAll();
	}
	
}
