package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.model.*;
import com.tje.mentors.repository.*;

@Service
public class MenteeRegistService {

	@Autowired
	private MenteeDAO mentiDAO;
	
	public Object service(Object args) {
		
		return mentiDAO.insert((Mentee)args) == 0 ? false : true;
	}
	
	
}
