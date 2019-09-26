package com.tje.mentors.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tje.mentors.model.ChatDetailView;
import com.tje.mentors.model.Mentee;
import com.tje.mentors.model.Mentor;
import com.tje.mentors.model.RequestChat;
import com.tje.mentors.model.RequestContents;
import com.tje.mentors.services.RequestChatSearchByChatIdService;
import com.tje.mentors.services.RequestChatSearchByMenteeAndMentorIdService;
import com.tje.mentors.services.RequestContentsInsertService;
import com.tje.mentors.services.UnreadCountMenteeService;
import com.tje.mentors.services.UnreadCountMentorService;
import com.tje.mentors.services.ChatDetailViewSearchByChatIdService;
import com.tje.mentors.services.ChatDetailViewSearchByMenteeIdService;
import com.tje.mentors.services.ChatDetailViewSearchByMentorIdService;
import com.tje.mentors.services.ChatUpdateReadCountService;
import com.tje.mentors.services.MessageSenderSearchByMenteeIdService;
import com.tje.mentors.services.MessageSenderSearchByMentorIdService;
import com.tje.mentors.services.RequestChatInsertService;

@Controller
@RequestMapping("/chat")
public class ChatController {
	
	@Autowired
	RequestChatSearchByChatIdService rcsbciService;
	@Autowired
	RequestContentsInsertService rciService;
	@Autowired
	ChatDetailViewSearchByChatIdService cdvsbiService;
	@Autowired
	RequestChatInsertService rChatiService;
	@Autowired
	RequestChatSearchByMenteeAndMentorIdService rcsbmamiService;
	@Autowired
	ChatDetailViewSearchByMentorIdService cdvsbmentoriService;
	@Autowired
	ChatDetailViewSearchByMenteeIdService cdvsbmenteeiService;
	@Autowired
	ChatUpdateReadCountService curcService;
	@Autowired
	UnreadCountMentorService ucmentorService;
	@Autowired
	UnreadCountMenteeService ucmenteeService;
	@Autowired
	MessageSenderSearchByMentorIdService mssbmentoriService;
	@Autowired
	MessageSenderSearchByMenteeIdService mssbmenteeiService;
	
	@GetMapping
	public String requestChat(HttpSession session, Model model) {
		if(session.getAttribute("memberType").equals("mentee")) {
			model.addAttribute("chatList", cdvsbmenteeiService.service(((Mentee)session.getAttribute("loginMember")).getMentee_id()));
			} else {
			model.addAttribute("chatList", cdvsbmentoriService.service(((Mentor)session.getAttribute("loginMember")).getMentor_id()));
		}
		return "chat/chat";
	}

	// 나의 채팅리스트에서 대화중인 목록을 눌렀을 때 들어오는 url
	// 문의하기를 눌렀을 때 들어오는 url
	@RequestMapping("/detail/{chat_id}")
	public String chat(@PathVariable("chat_id") int chat_id, Model model) {
		model.addAttribute("chat_id", chat_id);
		return "chat/detail";
	}

	// 채팅방에서 전송 버튼을 눌렀을때 insert 이벤트 처리
	@ResponseBody
	@PostMapping("/submit")
	public boolean chatSubmit(HttpSession session, @RequestBody RequestContents requestContents) {
		RequestChat target = (RequestChat) rcsbciService.service(new RequestChat(requestContents.getChat_id(),0,0));
		if(session.getAttribute("memberType").equals("mentee")) {
			requestContents.setSender(((Mentee)session.getAttribute("loginMember")).getMentee_id());
			requestContents.setReceiver(target.getMentor_id());
			requestContents.setSender_type("mentee");
		} else {
			requestContents.setSender(((Mentor)session.getAttribute("loginMember")).getMentor_id());
			requestContents.setReceiver(target.getMentee_id());
			requestContents.setSender_type("mentor");
		}
		rciService.service(requestContents);
		return true;
	}
	
	
	
	// 채팅방id로 채팅 리스트 리턴
	// SuppressWarnings : chat_id로 RequestContents 리스트 반환
	@SuppressWarnings("unchecked")
	@ResponseBody
	@PostMapping("/list")
	public List<ChatDetailView> chatList(@RequestParam("chat_id") int chat_id, HttpSession session) {
		curcService.service(chat_id, (String)session.getAttribute("memberType"));
		return (List<ChatDetailView>) cdvsbiService.service(chat_id);
	}
	
	// 레슨 상세보기에서 문의하기를 눌렀을 때 채팅방이 존재하면 채팅방id를 리턴
	// 채팅방이 존재하지 않으면 채팅방을 생성 후 생성된 채팅방id를 리턴
	@ResponseBody
	@PostMapping("/request")
	public int chatRequest(HttpSession session, @RequestParam("mentor_id") int mentor_id) {
		Object obj = rcsbmamiService.service(new RequestChat(0,
				((Mentee)session.getAttribute("loginMember")).getMentee_id(),
				mentor_id));
		
		if(obj instanceof RequestChat) {
			return ((RequestChat)obj).getChat_id();
		} else {
			return (int)obj;
		}
	}
	
	// header에 메시지 알림 개수 및 보낸사람 list 리턴
	@ResponseBody
	@PostMapping("/unread")
	public HashMap<String, Object> unRead(HttpSession session) {
		if(session.getAttribute("loginMember") == null) {
			return null;
		}
		HashMap<String, Object> result = new HashMap<String, Object>();
		if(session.getAttribute("memberType").equals("mentee")) {
			int mentee_id = ((Mentee)session.getAttribute("loginMember")).getMentee_id();
			result.put("unreadCount", ucmenteeService.service(mentee_id));
			result.put("messageSenderList", mssbmenteeiService.service(mentee_id));
		} else {
			int mentor_id = ((Mentor)session.getAttribute("loginMember")).getMentor_id();
			result.put("unreadCount", ucmentorService.service(mentor_id));
			result.put("messageSenderList", mssbmentoriService.service(mentor_id));
		}		
		return result;
	}
	
}
