package com.tje.mentors.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tje.mentors.model.LikeTable;
import com.tje.mentors.model.Mentee;
import com.tje.mentors.repository.LikeTableDAO;
import com.tje.mentors.services.LikeDeleteService;
import com.tje.mentors.services.LikeInsertService;

@Controller
public class LikeController {
	
	@Autowired
	private LikeInsertService liService;
	@Autowired
	private LikeDeleteService ldService;
	
	@ResponseBody
	@PostMapping("/like/pushLike")
	public Integer likeAjax(
			@RequestParam("lesson_id") String lesson_id,
			@RequestParam("likeValue") String likeValue,
			HttpSession session) {
		
		int parseLesson_id = Integer.parseInt(lesson_id);
		//int mentee_id = 1;
		int mentee_id = ((Mentee)session.getAttribute("loginMember")).getMentee_id();
		 
		LikeTable daoObj= new LikeTable(0, parseLesson_id, mentee_id); 
		
		if ( likeValue.equals("0")) {
			if( (int)liService.service(daoObj) == 1 ) {
				return 0;
			} else {
				return -1;
			}
		} else {
			if( (int)ldService.service(daoObj) == 1 ) {
				return 1;
			} else {
				return -1;
			}
		}
	}
	
	
}
