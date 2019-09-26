package com.tje.mentors.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WebSocketController {
	
	
	@GetMapping("/adminChat")
	public String adminChat(Model model) {
		return "admin/adminChat";
	}
	
	@GetMapping("/memberChat")
	public String memberChat() {
		return "include/memberChat"; 
	}
	
}
 
