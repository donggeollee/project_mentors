package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.ChatDetailViewDAO;

@Service
public class ChatDetailViewSearchByChatIdService {

	@Autowired
	private ChatDetailViewDAO chatDetailViewDAO;

	public Object service(int chat_id) {
		return chatDetailViewDAO.selectById(chat_id);
	}

}
