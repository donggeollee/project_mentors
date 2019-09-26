package com.tje.mentors.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.tje.mentors.model.Lesson;
import com.tje.mentors.model.LikeTable;
import com.tje.mentors.model.Mentee;
import com.tje.mentors.services.LessonListForMainTopService;

@Controller
public class MainController {
	
	@Autowired
	private LessonListForMainTopService lessonListForMainTopService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {

		List<Lesson> mainList = null;
		mainList = (List<Lesson>)lessonListForMainTopService.service();
		model.addAttribute("mainList", mainList);

		return "index";
	}

	@GetMapping("/regist")
	public String registForm() {
		return "member_regist";
	}
	
	@GetMapping("/auth")
	public String auth() {
		return "auth";
	}
	
	
	
	
	
}
