package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.MessageSenderDAO;

@Service
public class UnreadCountMenteeService {

	@Autowired
	MessageSenderDAO messageSenderDAO;

	public Object service(int mentee_id) {
		return messageSenderDAO.unreadCountMentee(mentee_id);
	}
}
