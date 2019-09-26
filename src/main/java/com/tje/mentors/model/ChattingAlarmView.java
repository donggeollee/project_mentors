package com.tje.mentors.model;

import java.util.Date;

public class ChattingAlarmView {
	private String sender;
	private String receiver;
	private Date write_date;
	
	public ChattingAlarmView() {
		// TODO Auto-generated constructor stub
	}
	
	public ChattingAlarmView(String sender, String receiver, Date write_date) {
		super();
		this.sender = sender;
		this.receiver = receiver;
		this.write_date = write_date;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public Date getWrite_date() {
		return write_date;
	}

	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}
	
	
}
