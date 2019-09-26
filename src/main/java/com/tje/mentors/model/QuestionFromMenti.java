package com.tje.mentors.model;

import java.util.Date;

public class QuestionFromMenti {
	private int menti_id;
	private String menti_name;
	private String menti_email;
	private int admin_req_id;
	private String title;
	private String content;
	private String reply_CK;
	private Date send_date;
	
	public QuestionFromMenti() {
		// TODO Auto-generated constructor stub
	}

	public QuestionFromMenti(int menti_id, String menti_name, String menti_email, int admin_req_id, String title,
			String content, String reply_CK, Date send_date) {
		super();
		this.menti_id = menti_id;
		this.menti_name = menti_name;
		this.menti_email = menti_email;
		this.admin_req_id = admin_req_id;
		this.title = title;
		this.content = content;
		this.reply_CK = reply_CK;
		this.send_date = send_date;
	}

	public int getMenti_id() {
		return menti_id;
	}

	public void setMenti_id(int menti_id) {
		this.menti_id = menti_id;
	}

	public String getMenti_name() {
		return menti_name;
	}

	public void setMenti_name(String menti_name) {
		this.menti_name = menti_name;
	}

	public String getMenti_email() {
		return menti_email;
	}

	public void setMenti_email(String menti_email) {
		this.menti_email = menti_email;
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
