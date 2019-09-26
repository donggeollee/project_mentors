package com.tje.mentors.model;

import java.util.Date;

public class LessonApplyToMentorView {
	private int apply_id;
	private int lesson_id;
	private int mentor_id;
	private int mentee_id;
	private Date regist_date;
	private String title;
	private String mentee_email;
	private String mentee_name;
	
	public LessonApplyToMentorView() {
		// TODO Auto-generated constructor stub
	}

	public LessonApplyToMentorView(int apply_id, int lesson_id, int mentor_id, int mentee_id, Date regist_date,
			String title, String mentee_email, String mentee_name) {
		super();
		this.apply_id = apply_id;
		this.lesson_id = lesson_id;
		this.mentor_id = mentor_id;
		this.mentee_id = mentee_id;
		this.regist_date = regist_date;
		this.title = title;
		this.mentee_email = mentee_email;
		this.mentee_name = mentee_name;
	}

	public int getApply_id() {
		return apply_id;
	}

	public void setApply_id(int apply_id) {
		this.apply_id = apply_id;
	}

	public int getLesson_id() {
		return lesson_id;
	}

	public void setLesson_id(int lesson_id) {
		this.lesson_id = lesson_id;
	}

	public int getMentor_id() {
		return mentor_id;
	}

	public void setMentor_id(int mentor_id) {
		this.mentor_id = mentor_id;
	}

	public int getMentee_id() {
		return mentee_id;
	}

	public void setMentee_id(int mentee_id) {
		this.mentee_id = mentee_id;
	}

	public Date getRegist_date() {
		return regist_date;
	}

	public void setRegist_date(Date regist_date) {
		this.regist_date = regist_date;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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
	
	
}
