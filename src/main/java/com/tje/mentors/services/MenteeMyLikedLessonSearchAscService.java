package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.*;

@Service
public class MenteeMyLikedLessonSearchAscService {

	@Autowired
	private MyLikedListDAO myLikedListDAO;
	
	public Object service(int menti_id,int page) {

		return myLikedListDAO.selectAllAsc(menti_id,page);
	}
	
	
}
