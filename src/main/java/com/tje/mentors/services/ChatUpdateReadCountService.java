package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.RequestContentsDAO;

@Service
public class ChatUpdateReadCountService {

	@Autowired
	private RequestContentsDAO requestContentsDAO;

	public Object service(int chat_id, String sender_type) {
		return requestContentsDAO.read(chat_id, sender_type);
	}

}
