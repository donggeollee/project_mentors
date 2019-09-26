package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.model.RequestChat;
import com.tje.mentors.repository.RequestChatDAO;

@Service
public class RequestChatInsertService {

	@Autowired
	private RequestChatDAO requestChatDAO;

	public Object service(RequestChat model) {
		return requestChatDAO.insert(model);
	}

}
