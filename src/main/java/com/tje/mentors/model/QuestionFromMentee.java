package com.tje.mentors.model;

import java.util.Date;

public class QuestionFromMentee {
	private int mentee_id;
	private String mentee_name;
	private String mentee_email;
	private int admin_req_id;
	private String title;
	private String content;
	private String reply_CK;
	private Date send_date;
	
	public QuestionFromMentee() {
		// TODO Auto-generated constructor stub
	}

	public QuestionFromMentee(int mentee_id, String mentee_name, String mentee_email, int admin_req_id, String title,
			String content, String reply_CK, Date send_date) {
		super();
		this.mentee_id = mentee_id;
		this.mentee_name = mentee_name;
		this.mentee_email = mentee_email;
		this.admin_req_id = admin_req_id;
		this.title = title;
		this.content = content;
		this.reply_CK = reply_CK;
		this.send_date = send_date;
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

	public String getMentee_email() {
		return mentee_email;
	}

	public void setMentee_email(String mentee_email) {
		this.mentee_email = mentee_email;
	}

	public int getAdmin_req_id() {
		return admin_req_id;
	}

	public void setAdmin_req_id(int admin_req_id) {
		this.admin_req_id = admin_req_id;
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

	public Date getSend_date() {
		return send_date;
	}

	public void setSend_date(Date send_date) {
		this.send_date = send_date;
	}

	
}
