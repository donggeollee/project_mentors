package com.tje.mentors.model;

import java.util.Date;

public class AdminQuestion {
	private int admin_req_id;
	private int sender_id;
	private String title;
	private String content;
	private String reply_CK;
	private String member_type;
	private Date send_date;
	
	public AdminQuestion() {
		// TODO Auto-generated constructor stub
	}

	public AdminQuestion(int admin_req_id, int sender_id, String title, String content, String reply_CK,
			String member_type, Date send_date) {
		super();
		this.admin_req_id = admin_req_id;
		this.sender_id = sender_id;
		this.title = title;
		this.content = content;
		this.reply_CK = reply_CK;
		this.member_type = member_type;
		this.send_date = send_date;
	}

	public int getAdmin_req_id() {
		return admin_req_id;
	}

	public void setAdmin_req_id(int admin_req_id) {
		this.admin_req_id = admin_req_id;
	}

	public int getSender_id() {
		return sender_id;
	}

	public void setSender_id(int sender_id) {
		this.sender_id = sender_id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getReply_CK() {
		return reply_CK;
	}

	public void setReply_CK(String reply_CK) {
		this.reply_CK = reply_CK;
	}

	public String getMember_type() {
		return member_type;
	}

	public void setMember_type(String member_type) {
		this.member_type = member_type;
	}

	public Date getSend_date() {
		return send_date;
	}

	public void setSend_date(Date send_date) {
		this.send_date = send_date;
	}
	
}
