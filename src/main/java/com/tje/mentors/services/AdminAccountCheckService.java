package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.AdminAccountDAO;

@Service
public class AdminAccountCheckService {
	
	@Autowired
	private AdminAccountDAO adminAccountDAO;
	
	public Object service() {
		return adminAccountDAO.select();
	}
	
}
