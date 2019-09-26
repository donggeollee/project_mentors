package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.model.LikeTable;
import com.tje.mentors.model.Mentee;
import com.tje.mentors.repository.LikeTableDAO;
import com.tje.mentors.repository.MenteeDAO;

@Service
public class LikeDeleteService {
	
	@Autowired
	private LikeTableDAO DAO;
	
	public Object service(LikeTable model) {
		return (Integer)DAO.delete(model); 
	}

}
