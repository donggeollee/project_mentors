package com.tje.mentors.controller;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Vector;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.PongMessage;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

public class WebSocketHandler extends TextWebSocketHandler {
	
	private class Member implements Serializable{
		private WebSocketSession session;
		private String member_name;
		private String member_id;
		
		public Member(	WebSocketSession session,
				 String member_name, String member_id) {
			this.session = session;
			this.member_id = member_id;
			this.member_name = member_name;
		}
		
		public WebSocketSession getSession() {
			return session;
		}
		public void setSession(WebSocketSession session) {
			this.session = session;
		}
		public String getMember_name() {
			return member_name;
		}
		public void setMember_name(String member_name) {
			this.member_name = member_name;
		}

		public String getMember_id() {
			return member_id;
		}

		public void setMember_id(String member_id) {
			this.member_id = member_id;
		}
	}
	
	// "admin" -> session 
	private Hashtable<String,WebSocketSession> adminSessionMap = new Hashtable<>(); 
	// "mentor_email" -> session
	private Hashtable<String,Member> mentorSessionMap = new Hashtable<>();
	// "mentee_email" -> session
	private Hashtable<String,Member> menteeSessionMap = new Hashtable<>();
	// 멤버가 문의하기 버튼을 클릭했을 때, messageMap에 저장됨 
	// ex) String message = connect[0] (member_email,message)
	// "mentee_email" -> message
	private Hashtable<String,String> mentorChatMap = new Hashtable<>();
	// "mentee_email" -> message
	private Hashtable<String,String> menteeChatMap = new Hashtable<>();
	// message 형식 
	// - "mentee:asdfsdff,admin:asdfsadf,mentee:dff,mente:ddd
	
	JSONObject jsonSendObj = new JSONObject();
	JSONObject jsonMenteeChatContents = null;
	JSONObject jsonMentorChatContents = null;
	JSONArray jsonArrayMessage = null;
	
	@Override 
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// LocalTime.now().toString().substring(0, 8) : 01:07:27
		System.out.println(session.getId() + "님이 접속에 성공");
	} 
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
			String msg = message.getPayload();
			
			String[] source = msg.split(",");
			System.out.println("source[0] : " + source[0]);
			System.out.println("source[1] : " + source[1]);
			if( source.length >= 4) {
			System.out.println("source[2] : " + source[2]);
			System.out.println("source[3] : " + source[3]);
			}
			if( source.length == 5) {
			System.out.println("source[4] : " + source[4]);	
			}
			// 연결요청
			if( source[0].equals("connect") ) { 
				if( source[1].equals("admin")) { 
					adminSessionMap.put("admin", session);
					jsonMenteeChatContents = new JSONObject();
					jsonMentorChatContents = new JSONObject();
					// chatMap에 값이 없으면 실행안됨. 키값이 없기 때문에 
					for ( String mentor_id : mentorChatMap.keySet()) {
						String[] chatContents = mentorChatMap.get(mentor_id).split(",");
						jsonArrayMessage = new JSONArray();
						for ( int i = 0 ; i < chatContents.length ; i++ ) {
							// mentor_email에 해당하는 chat을 jsonArray에 담음
							jsonArrayMessage.add(chatContents[i]);  
						}
						// 각 mentor_email의 채팅내용을 담는 json 객체  
						if ( mentorSessionMap.get(mentor_id) != null ) {
							String mentor_name = mentorSessionMap.get(mentor_id).getMember_name();
							jsonMentorChatContents.put(mentor_id+","+mentor_name, jsonArrayMessage);
						}
					}
					
					for ( String mentee_id : menteeChatMap.keySet()) {
						String[] chatContents = menteeChatMap.get(mentee_id).split(",");
						jsonArrayMessage = new JSONArray();
						for ( int i = 0 ; i < chatContents.length ; i++ ) {
							jsonArrayMessage.add(chatContents[i]); 
						}
						if(  menteeSessionMap.get(mentee_id) != null ) {
							String mentee_name = menteeSessionMap.get(mentee_id).getMember_name();
							jsonMenteeChatContents.put(mentee_id+","+mentee_name, jsonArrayMessage);
						}
					}
					jsonSendObj.put("type", "adminConnect");
					jsonSendObj.put("mentorChatRoom", jsonMentorChatContents);
					jsonSendObj.put("menteeChatRoom", jsonMenteeChatContents);
					System.out.println("admin이 접속했음"); 
				} else if ( source[1].equals("mentor") ) { 
					
					if (mentorSessionMap.get(source[3]) != null) { 
						mentorSessionMap.get(source[3]).setSession(session);
					} else {
						Member member  = new Member(session, source[2], source[3]);
						mentorSessionMap.put(source[3], member);
						mentorChatMap.put(source[3], "mentor:"+ source[2]+"님이 상담을 요청했습니다:"+ LocalTime.now().toString().substring(0, 8));
					}
					
					jsonSendObj.put("mentorConnectMsg","mentor:"+ source[2]+"님이 상담을 요청했습니다:"+ LocalTime.now().toString().substring(0, 8));
					jsonSendObj.put("type", "mentorConnect");
					jsonSendObj.put("mentorInfo", source[2]+","+source[3]);
				} else if( source[1].equals("mentee")) {
					
					if (menteeSessionMap.get(source[3]) != null) {
						menteeSessionMap.get(source[3]).setSession(session);
					} else {
						Member member  = new Member(session, source[2], source[3]); 
						menteeSessionMap.put(source[3], member);
						menteeChatMap.put(source[3], "mentee:"+ source[2]+"님이 상담을 요청했습니다:"+ LocalTime.now().toString().substring(0, 8));
					}
					jsonSendObj.put("menteeConnectMsg","mentee:"+ source[2]+"님이 상담을 요청했습니다:"+ LocalTime.now().toString().substring(0, 8));
					jsonSendObj.put("type", "menteeConnect");
					jsonSendObj.put("menteeInfo", source[2]+","+source[3]);
				}			
				// 관리자가 들어왓을 때 or 관리자가 들어와있을 때만 관리자에게 send
				if ( adminSessionMap.get("admin") != null && adminSessionMap.get("admin").isOpen() ) {
					System.out.println( adminSessionMap.get("admin") ); 
					adminSessionMap.get("admin").sendMessage(new TextMessage(jsonSendObj.toJSONString()));
				} 
				
			// 메세지 요청
			} else if ( source[0].equals("send")) { 
				if( source[1].equals("admin")) {
					
					String tempMsg = "admin:"+ source[2] + ":"+ LocalTime.now().toString().substring(0, 8);
					jsonSendObj.put("adminSendMsg",tempMsg);
					jsonSendObj.put("type", "adminSend");
					jsonSendObj.put("memberInfo",source[4]+","+source[3]); 
					if( source[4].equals("mentor") ) {
						mentorChatMap.put(source[3], mentorChatMap.get(source[3]) + "," + tempMsg);
						if ( mentorSessionMap.get(source[3]).getSession().isOpen() ) {
							jsonSendObj.put("emptyMentor", false);
							mentorSessionMap.get(source[3]).getSession().sendMessage(new TextMessage(jsonSendObj.toJSONString()));
						} else {
							mentorSessionMap.get(source[3]).getSession().close();
							mentorSessionMap.remove(source[3]);
							mentorChatMap.remove(source[3]);
							jsonSendObj.put("emptyMentor", true);
						}
					} else if ( source[4].equals("mentee") ) {
						menteeChatMap.put(source[3], menteeChatMap.get(source[3]) + "," + tempMsg);
						if ( menteeSessionMap.get(source[3]).getSession().isOpen() ) {
							jsonSendObj.put("emptyMentee", false);
							menteeSessionMap.get(source[3]).getSession().sendMessage(new TextMessage(jsonSendObj.toJSONString()));
						} else { 
							menteeSessionMap.get(source[3]).getSession().close();
							menteeSessionMap.remove(source[3]);
							menteeChatMap.remove(source[3]);
							jsonSendObj.put("emptyMentee", true);
						}
					}
					adminSessionMap.get("admin").sendMessage(new TextMessage(jsonSendObj.toJSONString()));
				} else if ( source[1].equals("mentor")) {
					String tempMsg = "mentor:"+ source[2] + ":"+ LocalTime.now().toString().substring(0, 8);
					mentorChatMap.put(source[3], mentorChatMap.get(source[3]) + "," + tempMsg);
					
					jsonSendObj.put("mentorSendMsg",tempMsg);
					jsonSendObj.put("type", "mentorSend");
					jsonSendObj.put("mentorInfo",source[3]);

					if ( adminSessionMap.get("admin") != null && adminSessionMap.get("admin").isOpen() ) {
						adminSessionMap.get("admin").sendMessage(new TextMessage(jsonSendObj.toJSONString()));
					} 
					mentorSessionMap.get(source[3]).getSession().sendMessage(new TextMessage(jsonSendObj.toJSONString()));
				} else if ( source[1].equals("mentee") ) {
					String tempMsg = "mentee:"+ source[2] + ":"+ LocalTime.now().toString().substring(0, 8);
					menteeChatMap.put(source[3], menteeChatMap.get(source[3]) + "," + tempMsg);
					
					jsonSendObj.put("menteeSendMsg",tempMsg);
					jsonSendObj.put("type", "menteeSend");
					jsonSendObj.put("menteeInfo",source[3]);
					
					if ( adminSessionMap.get("admin") != null && adminSessionMap.get("admin").isOpen() ) {
						adminSessionMap.get("admin").sendMessage(new TextMessage(jsonSendObj.toJSONString()));
					} 
					menteeSessionMap.get(source[3]).getSession().sendMessage(new TextMessage(jsonSendObj.toJSONString()));
				} else if ( source[1].equals("admin_image") ) {
					
				} else if ( source[1].equals("mentor_image") ) {
					
				} else if ( source[1].equals("mentee_image") ) {
					String tempMsg = "mentee:"+ source[2] + "," +source[3] + ":" + LocalTime.now().toString().substring(0, 8);
					menteeChatMap.put(source[4], menteeChatMap.get(source[4]) + "," + tempMsg);
					 
					jsonSendObj.put("menteeSendMsg",tempMsg);
					jsonSendObj.put("type", "menteeSendImage");
					jsonSendObj.put("menteeInfo",source[4]); 
					
					if ( adminSessionMap.get("admin") != null && adminSessionMap.get("admin").isOpen() ) {
						adminSessionMap.get("admin").sendMessage(new TextMessage(jsonSendObj.toJSONString()));
					} 
					menteeSessionMap.get(source[4]).getSession().sendMessage(new TextMessage(jsonSendObj.toJSONString()));
				} 
				
			} else if ( source[0].equals("close")) { 
				if ( source[1].equals("admin") ) {
					// 어드민 세션 삭제 
					adminSessionMap.clear();
				} else if ( source[1].equals("mentor") ) {
					// 어드민 페이지에 누가 나갔는 지 알려줌 
					jsonSendObj.put("type", "closeMentor");
					jsonSendObj.put("mentor_id", source[2]);
					if ( adminSessionMap.get("admin") != null && adminSessionMap.get("admin").isOpen() ) {
						adminSessionMap.get("admin").sendMessage(new TextMessage(jsonSendObj.toJSONString()));
					}
					// 어드민 페이지에 누가 나갔는 지 뿌려주고 채팅방, Member 객체 삭제
					mentorChatMap.remove(source[2]);
					mentorSessionMap.remove(source[2]); 
				} else if ( source[1].equals("mentee") ) {
					// 어드민 페이지에 누가 나갔는 지 알려줌
					jsonSendObj.put("type", "closeMentee");
					jsonSendObj.put("mentee_id", source[2]);
					if ( adminSessionMap.get("admin") != null && adminSessionMap.get("admin").isOpen() ) {
						adminSessionMap.get("admin").sendMessage(new TextMessage(jsonSendObj.toJSONString()));
					}
					// 어드민 페이지에 누가 나갔는 지 뿌려주고 채팅방, Member 객체 삭제
					menteeChatMap.remove(source[2]);
					menteeSessionMap.remove(source[2]);
				}
			}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
	}
 
}

