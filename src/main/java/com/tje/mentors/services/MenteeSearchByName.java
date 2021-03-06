package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.model.Mentee;
import com.tje.mentors.repository.MenteeDAO;

@Service
public class MenteeSearchByName {
	
	@Autowired
	private MenteeDAO mentiDAO;
	
	public Object service(String searchName, int page) {
				
		return mentiDAO.selectByName(searchName, page);
	}
	
}
