package com.tje.mentors.services;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.*;

@Service
public class MenteeSelectAllService {
	
	@Autowired
	private MenteeDAO menteeDAO;
	
	public Object service(int page) {

			return menteeDAO.selectAll(page);
		}
		
	
}
