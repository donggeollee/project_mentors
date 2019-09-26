package com.tje.mentors.model;

public class MessageSender {
	private int chat_id;
	private String sender_mentee;
	private String sender_mentor;

	public MessageSender() {
	}

	public MessageSender(int chat_id, String sender_mentee, String sender_mentor) {
		super();
		this.chat_id = chat_id;
		this.sender_mentee = sender_mentee;
		this.sender_mentor = sender_mentor;
	}

	public int getChat_id() {
		return chat_id;
	}

	public void setChat_id(int chat_id) {
		this.chat_id = chat_id;
	}

	public String getSender_mentee() {
		return sender_mentee;
	}

	public void setSender_mentee(String sender_mentee) {
		this.sender_mentee = sender_mentee;
	}

	public String getSender_mentor() {
		return sender_mentor;
	}

	public void setSender_mentor(String sender_mentor) {
		this.sender_mentor = sender_mentor;
	}

}
