package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.model.LikeTable;
import com.tje.mentors.model.Mentee;
import com.tje.mentors.repository.LikeTableDAO;
import com.tje.mentors.repository.MenteeDAO;

@Service
public class LikeListSearchByMenteeService {
	
	@Autowired
	private LikeTableDAO DAO;
	
	public Object service(Mentee model) {
		return DAO.likeListByMenteeId(model);
	}

}
