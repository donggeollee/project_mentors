package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.*;
import com.tje.mentors.model.*;

// 멘토 마이페이지
// 내가 작성한 클래스를 찜한 멘티 목록 (검색조회기능)
@Service
public class MentorMyLessonWhoLikesMenteeSearchService {

		
		@Autowired
		private MenteeWhoLikesMeDAO menteewholikesmeDAO;
		
		
		public Object service(MenteeWhoLikesMe model, int page) {
			
			return menteewholikesmeDAO.selectByName(model,page);
		}
}
