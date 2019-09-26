package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.*;

@Service
public class MenteeMyLikedLessonSearchDescService {

	@Autowired
	private MyLikedListDAO myLikedListDAO;
	
	public Object service(int menti_id,int page) {

		return myLikedListDAO.selectAllDesc(menti_id,page);
	}
	
	
}
