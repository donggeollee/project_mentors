package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.model.Image;
import com.tje.mentors.repository.ImageDAO;

@Service
public class ImageInsertService {

	@Autowired
	private ImageDAO imageDAO;
	
	public int service(Image target) {
		return imageDAO.insert(target);
	}
	
}
