package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.model.*;
import com.tje.mentors.repository.*;

@Service
public class MenteeReviewWriteService {

	@Autowired
	private ReviewDAO reviewDAO;
	
	public Object service(Review model) {
		
		return reviewDAO.insert(model) <= 0 ? false : true ;
	}
	
	
}
