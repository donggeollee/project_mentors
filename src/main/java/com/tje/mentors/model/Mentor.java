package com.tje.mentors.model;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;


// 멘토 수정 됨 (0731)
public class Mentor {
	private int mentor_id;
	private String mentor_email;
	private String mentor_name;
	private String mentor_password;
	private String mentor_categoryBig;
	private String mentor_profile;
	private String mentor_info;
	private String phone;
	
	@JsonFormat(pattern = "yyyy년 MM월 dd일")
	private Date regist_date;
	
	public Mentor() {
		// TODO Auto-generated constructor stub
	}

	public Mentor(int mentor_id, String mentor_email, String mentor_name, String mentor_password,
			String mentor_categoryBig, String mentor_profile, String mentor_info, String phone, Date regist_date) {
		super();
		this.mentor_id = mentor_id;
		this.mentor_email = mentor_email;
		this.mentor_name = mentor_name;
		this.mentor_password = mentor_password;
		this.mentor_categoryBig = mentor_categoryBig;
		this.mentor_profile = mentor_profile;
		this.mentor_info = mentor_info;
		this.phone = phone;
		this.regist_date = regist_date;
	}

	public int getMentor_id() {
		return mentor_id;
	}

	public void setMentor_id(int mentor_id) {
		this.mentor_id = mentor_id;
	}

	public String getMentor_email() {
		return mentor_email;
	}

	public void setMentor_email(String mentor_email) {
		this.mentor_email = mentor_email;
	}

	public String getMentor_name() {
		return mentor_name;
	}

	public void setMentor_name(String mentor_name) {
		this.mentor_name = mentor_name;
	}

	public String getMentor_password() {
		return mentor_password;
	}

	public void setMentor_password(String mentor_password) {
		this.mentor_password = mentor_password;
	}

	public String getMentor_categoryBig() {
		return mentor_categoryBig;
	}

	public void setMentor_categoryBig(String mentor_categoryBig) {
		this.mentor_categoryBig = mentor_categoryBig;
	}

	public String getMentor_profile() {
		return mentor_profile;
	}

	public void setMentor_profile(String mentor_profile) {
		this.mentor_profile = mentor_profile;
	}

	public String getMentor_info() {
		return mentor_info;
	}

	public void setMentor_info(String mentor_info) {
		this.mentor_info = mentor_info;
	}


	public Date getRegist_date() {
		return regist_date;
	}

	public void setRegist_date(Date regist_date) {
		this.regist_date = regist_date;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getName() {
		return mentor_name;
	}
	
	public int getId() {
		return mentor_id;
	}
}
