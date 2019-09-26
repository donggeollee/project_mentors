package com.tje.mentors.model;

public class MyMentor {
		
	private int menti_id;
	private int mentor_id;
	private String mentor_name;
	private String mentor_email;
	private String phone;
	private String mentor_info;
	private String mentor_profile;
	
	public MyMentor() {
		// TODO Auto-generated constructor stub
	}
		
	public MyMentor(int menti_id, int mentor_id, String mentor_name, String mentor_email, String phone,
			String mentor_info, String mentor_profile) {
		super();
		this.menti_id = menti_id;
		this.mentor_id = mentor_id;
		this.mentor_name = mentor_name;
		this.mentor_email = mentor_email;
		this.phone = phone;
		this.mentor_info = mentor_info;
		this.mentor_profile = mentor_profile;
	}

	public int getMenti_id() {
		return menti_id;
	}
	public void setMenti_id(int menti_id) {
		this.menti_id = menti_id;
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
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getMentor_info() {
		return mentor_info;
	}
	public void setMentor_info(String mentor_info) {
		this.mentor_info = mentor_info;
	}
	public String getMentor_profile() {
		return mentor_profile;
	}
	public void setMentor_profile(String mentor_profile) {
		this.mentor_profile = mentor_profile;
	}
	
	
	
}
