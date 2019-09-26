package com.tje.mentors.model;

import java.util.Date;

public class QuestionFromMentor {
	private int mentor_id;
	private String mentor_name;
	private String mentor_email;
	private int admin_req_id;
	private String title;
	private String content;
	private String reply_CK;
	private Date send_date;
	
	public QuestionFromMentor() {
		// TODO Auto-generated constructor stub
	}

	public QuestionFromMentor(int mentor_id, String mentor_name, String mentor_email, int admin_req_id, String title,
			String content, String reply_CK, Date send_date) {
		super();
		this.mentor_id = mentor_id;
		this.mentor_name = mentor_name;
		this.mentor_email = mentor_email;
		this.admin_req_id = admin_req_id;
		this.title = title;
		this.content = content;
		this.reply_CK = reply_CK;
		this.send_date = send_date;
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

	public String getMentor_email() {
		return mentor_email;
	}

	public void setMentor_email(String mentor_email) {
		this.mentor_email = mentor_email;
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
