package com.tje.mentors.services;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tje.mentors.repository.*;
import com.tje.mentors.setting.PagingInfoByTen;
import com.tje.mentors.model.*;


@Service
public class MentorMyLessonMenteeCountAddService {

	@Autowired
	private LessonDAO lessonDAO;
	
	@Transactional
	public Object service(int menteeCnt, int lesson_id) {
		
		
		return lessonDAO.menteeCntupdate(menteeCnt,lesson_id) == 0 ? false : true;
	}

	
}
