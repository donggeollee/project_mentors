package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.*;

@Service
public class MenteeMyMentorViewService {

	@Autowired
	private MyMentorDAO myMentorDAO;
	
	public Object service(int menti_id) {

		return myMentorDAO.selectAll(menti_id);
	}
	
	
}
