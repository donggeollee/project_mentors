package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.*;
import com.tje.mentors.model.*;

// 멘토 마이페이지
// 내가 작성한 클래스를 찜한 멘티 목록 
@Service
public class MentorMyLessonWhoLikesMenteeService {

	@Autowired
	private MenteeWhoLikesMeDAO menteewholikesmeDAO;
	
	
	public Object service(Object args) {
		
		return menteewholikesmeDAO.select((Mentor)args);
	}

	
}
