package com.tje.mentors.model;

import java.util.Date;

//지은 - 추가 모델 DAO 
//나의 멘티 목록 리스트 
public class MyMenteeList {
	private int status_id;
	private int lesson_id;
	private String title;
	private int mentor_id;
	private int mentee_id;
	private String mentee_name;
	private String mentee_email;
	private String curStatus;
	private Date start_date;
	
	public MyMenteeList() {
	}

    // 지은 추가 수정 사항
	public MyMenteeList(int lesson_id, String title) {
		this.lesson_id = lesson_id;
		this.title = title;
	}
	
	
	public MyMenteeList(int status_id, int lesson_id, String title, int mentor_id, int mentee_id, String mentee_name,
			String mentee_email, String curStatus, Date start_date) {
		this.status_id = status_id;
		this.lesson_id = lesson_id;
		this.title = title;
		this.mentor_id = mentor_id;
		this.mentee_id = mentee_id;
		this.mentee_name = mentee_name;
		this.mentee_email = mentee_email;
		this.curStatus = curStatus;
		this.start_date = start_date;
	}

	public int getStatus_id() {
		return status_id;
	}

	public void setStatus_id(int status_id) {
		this.status_id = status_id;
	}

	public int getLesson_id() {
		return lesson_id;
	}

	public void setLesson_id(int lesson_id) {
		this.lesson_id = lesson_id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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

	public String getCurStatus() {
		return curStatus;
	}

	public void setCurStatus(String curStatus) {
		this.curStatus = curStatus;
	}

	public Date getStart_date() {
		return start_date;
	}

	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}
	
}
