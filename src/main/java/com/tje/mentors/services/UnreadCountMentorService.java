package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.MessageSenderDAO;

@Service
public class UnreadCountMentorService {

	@Autowired
	MessageSenderDAO messageSenderDAO;

	public Object service(int mentor_id) {
		return messageSenderDAO.unreadCountMentor(mentor_id);
	}
}
