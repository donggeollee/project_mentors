package com.tje.mentors.model;

import java.util.Date;

public class MyLessonList {
	private int status_id;
	private int lesson_id;
	private int mentor_id;
	private int mentee_id;
	private String curStatus;
	private Date start_date;
	private String mentor_name;
	private String title;
	private double avg_score;
	private int review_count;
	private String category_big;
	private String category_small;
	
	public MyLessonList() {
		// TODO Auto-generated constructor stub
	}

	public MyLessonList(int status_id, int lesson_id, int mentor_id, int mentee_id, String curStatus, Date start_date,
			String mentor_name, String title, double avg_score, int review_count, String category_big,
			String category_small) {
		super();
		this.status_id = status_id;
		this.lesson_id = lesson_id;
		this.mentor_id = mentor_id;
		this.mentee_id = mentee_id;
		this.curStatus = curStatus;
		this.start_date = start_date;
		this.mentor_name = mentor_name;
		this.title = title;
		this.avg_score = avg_score;
		this.review_count = review_count;
		this.category_big = category_big;
		this.category_small = category_small;
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

	public String getMentor_name() {
		return mentor_name;
	}

	public void setMentor_name(String mentor_name) {
		this.mentor_name = mentor_name;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public double getAvg_score() {
		return avg_score;
	}

	public void setAvg_score(double avg_score) {
		this.avg_score = avg_score;
	}

	public int getReview_count() {
		return review_count;
	}

	public void setReview_count(int review_count) {
		this.review_count = review_count;
	}

	public String getCategory_big() {
		return category_big;
	}

	public void setCategory_big(String category_big) {
		this.category_big = category_big;
	}

	public String getCategory_small() {
		return category_small;
	}

	public void setCategory_small(String category_small) {
		this.category_small = category_small;
	}
	
	
}
