package com.tje.mentors.model;

import java.util.Date;

public class Mentee {
	private int mentee_id;
	private String mentee_email;
	private String mentee_name;
	private String mentee_password;
	private String mentee_profile;
	private String simple_login_CK;
	private Date regist_date;
	
	public Mentee() {
		// TODO Auto-generated constructor stub
	}

	public Mentee(int mentee_id, String mentee_email, String mentee_name, String mentee_password, String mentee_profile,
			String simple_login_CK, Date regist_date) {
		super();
		this.mentee_id = mentee_id;
		this.mentee_email = mentee_email;
		this.mentee_name = mentee_name;
		this.mentee_password = mentee_password;
		this.mentee_profile = mentee_profile;
		this.simple_login_CK = simple_login_CK;
		this.regist_date = regist_date;
	}

	public int getMentee_id() {
		return mentee_id;
	}

	public void setMentee_id(int mentee_id) {
		this.mentee_id = mentee_id;
	}

	public String getMentee_email() {
		return mentee_email;
	}

	public void setMentee_email(String mentee_email) {
		this.mentee_email = mentee_email;
	}

	public String getMentee_name() {
		return mentee_name;
	}

	public void setMentee_name(String mentee_name) {
		this.mentee_name = mentee_name;
	}

	public String getMentee_password() {
		return mentee_password;
	}

	public void setMentee_password(String mentee_password) {
		this.mentee_password = mentee_password;
	}

	public String getMentee_profile() {
		return mentee_profile;
	}

	public void setMentee_profile(String mentee_profile) {
		this.mentee_profile = mentee_profile;
	}

	public String getSimple_login_CK() {
		return simple_login_CK;
	}

	public void setSimple_login_CK(String simple_login_CK) {
		this.simple_login_CK = simple_login_CK;
	}

	public Date getRegist_date() {
		return regist_date;
	}

	public void setRegist_date(Date regist_date) {
		this.regist_date = regist_date;
	}
	
	public String getName() {
		return mentee_name;
	}
	
	public int getId() {
		return mentee_id;
	}

	
}
