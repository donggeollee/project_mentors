package com.tje.mentors.model;

import java.util.Date;

public class LessonApply {
	private int apply_id;
	private int lesson_id;
	private int mentor_id;
	private int mentee_id;
	private Date regist_date;
	
	public LessonApply() {
		// TODO Auto-generated constructor stub
	}

	public LessonApply(int apply_id, int lesson_id, int mentor_id, int mentee_id, Date regist_date) {
		super();
		this.apply_id = apply_id;
		this.lesson_id = lesson_id;
		this.mentor_id = mentor_id;
		this.mentee_id = mentee_id;
		this.regist_date = regist_date;
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
	
}
