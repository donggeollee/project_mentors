package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.ChatDetailViewDAO;

@Service
public class ChatDetailViewSearchByMentorIdService {

	@Autowired
	private ChatDetailViewDAO chatDetailViewDAO;

	public Object service(int mentor_id) {
		return chatDetailViewDAO.selectByMentorId(mentor_id);
	}

}
