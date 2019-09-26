package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.ChatDetailViewDAO;

@Service
public class ChatDetailViewSearchByMenteeIdService {

	@Autowired
	private ChatDetailViewDAO chatDetailViewDAO;

	public Object service(int mentee_id) {
		return chatDetailViewDAO.selectByMenteeId(mentee_id);
	}

}
