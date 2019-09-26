package com.tje.mentors.model;

import java.util.Date;

public class RequestContents {
	private int chat_id;
	private int sender;
	private String sender_type;
	private int receiver;
	private String contents;
	private Date write_date;
	private int read_check;

	public RequestContents() {
		// TODO Auto-generated constructor stub
	}

	public RequestContents(int chat_id, int sender, String sender_type, int receiver, String contents, Date write_date,
			int read_check) {
		super();
		this.chat_id = chat_id;
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

	public Date getWrite_date() {
		return write_date;
	}

	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}

	public int getRead_check() {
		return read_check;
	}

	public void setRead_check(int read_check) {
		this.read_check = read_check;
	}

}
