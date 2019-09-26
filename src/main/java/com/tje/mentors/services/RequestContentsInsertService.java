package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.model.RequestContents;
import com.tje.mentors.repository.RequestContentsDAO;

@Service
public class RequestContentsInsertService {

	@Autowired
	private RequestContentsDAO requestContentsDAO;

	public Object service(RequestContents model) {
		return requestContentsDAO.insert(model);
	}

}
