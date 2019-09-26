package com.tje.mentors.model;

public class RequestChat {
	private int chat_id;
	private int mentee_id;
	private int mentor_id;
	
	public RequestChat() {
		// TODO Auto-generated constructor stub
	}

	public RequestChat(int chat_id, int mentee_id, int mentor_id) {
		super();
		this.chat_id = chat_id;
		this.mentee_id = mentee_id;
		this.mentor_id = mentor_id;
	}

	public int getChat_id() {
		return chat_id;
	}

	public void setChat_id(int chat_id) {
		this.chat_id = chat_id;
	}

	public int getMentee_id() {
		return mentee_id;
	}

	public void setMentee_id(int mentee_id) {
		this.mentee_id = mentee_id;
	}

	public int getMentor_id() {
		return mentor_id;
	}

	public void setMentor_id(int mentor_id) {
		this.mentor_id = mentor_id;
	}
	
}
