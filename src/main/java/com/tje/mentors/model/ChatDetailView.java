package com.tje.mentors.model;

import java.time.LocalDateTime;
import java.time.format.TextStyle;
import java.util.Locale;

public class ChatDetailView {
	private int chat_id;
	private int mentor_id;
	private String mentor_name;
	private int mentee_id;
	private String mentee_name;
	private int sender;
	private String sender_type;
	private int receiver;
	private String contents;
	private LocalDateTime write_date;
	private int read_check;
	private int unread_count;

	public ChatDetailView() {
		// TODO Auto-generated constructor stub
	}

	public ChatDetailView(int chat_id, int mentor_id, String mentor_name, int mentee_id, String mentee_name, int sender,
			String sender_type, int receiver, String contents, LocalDateTime write_date, int read_check, int unread_count) {
		super();
		this.chat_id = chat_id;
		this.mentor_id = mentor_id;
		this.mentor_name = mentor_name;
		this.mentee_id = mentee_id;
		this.mentee_name = mentee_name;
		this.sender = sender;
		this.sender_type = sender_type;
		this.receiver = receiver;
		this.contents = contents;
		this.write_date = write_date;
		this.read_check = read_check;
		this.unread_count = unread_count;
	}
	
	public ChatDetailView(int chat_id, int mentor_id, String mentor_name, int mentee_id, String mentee_name, int sender,
			String sender_type, int receiver, String contents, LocalDateTime write_date, int read_check) {
		super();
		this.chat_id = chat_id;
		this.mentor_id = mentor_id;
		this.mentor_name = mentor_name;
		this.mentee_id = mentee_id;
		this.mentee_name = mentee_name;
		this.sender = sender;
		this.sender_type = sender_type;
		this.receiver = receiver;
		this.contents = contents;
		this.write_date = write_date;
		this.read_check = read_check;
	}

	public int getChat_id() {
		return chat_id;
	}

	public void setChat_id(int chat_id) {
		this.chat_id = chat_id;
	}

	public int getMentor_id() {
		return mentor_id;
	}

	public void setMentor_id(int mentor_id) {
		this.mentor_id = mentor_id;
	}

	public String getMentor_name() {
		return mentor_name;
	}

	public void setMentor_name(String mentor_name) {
		this.mentor_name = mentor_name;
	}

	public int getMentee_id() {
		return mentee_id;
	}

	public void setMentee_id(int mentee_id) {
		this.mentee_id = mentee_id;
	}

	public String getMentee_name() {
		return mentee_name;
	}

	public void setMentee_name(String mentee_name) {
		this.mentee_name = mentee_name;
	}

	public int getSender() {
		return sender;
	}

	public void setSender(int sender) {
		this.sender = sender;
	}

	public String getSender_type() {
		return sender_type;
	}

	public void setSender_type(String sender_type) {
		this.sender_type = sender_type;
	}

	public int getReceiver() {
		return receiver;
	}

	public void setReceiver(int receiver) {
		this.receiver = receiver;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public LocalDateTime getWrite_date() {
		return write_date;
	}

	public void setWrite_date(LocalDateTime write_date) {
		this.write_date = write_date;
	}

	public int getRead_check() {
		return read_check;
	}

	public void setRead_check(int read_check) {
		this.read_check = read_check;
	}
	
	public int getUnread_count() {
		return unread_count;
	}

	public void setUnread_count(int unread_count) {
		this.unread_count = unread_count;
	}

	public String getTime() {
		String result = write_date.getYear() + "년 " + write_date.getMonth().getDisplayName(TextStyle.NARROW, Locale.KOREAN) + " " +
				write_date.getDayOfMonth() + "일 " +
				write_date.getDayOfWeek().getDisplayName(TextStyle.NARROW, Locale.KOREAN) + "요일  " + write_date.getHour() + "시 " + write_date.getMinute() + "분 " +
				write_date.getSecond() + "초";
		return result;
	}

}
