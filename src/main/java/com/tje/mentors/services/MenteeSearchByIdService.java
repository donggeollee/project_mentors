package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.MenteeDAO;

@Service
public class MenteeSearchByIdService {

	@Autowired
	private MenteeDAO menteeDAO;
	
	public Object service(int id) {
		return menteeDAO.selectById(id);
	}
	
}
