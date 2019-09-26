package com.tje.mentors.model;

import java.util.Date;

public class Review {
	private int review_id;
	private int lesson_id;
	private int mentee_id;
	private String content;
	private int score;
	private Date write_date;
	
	public Review() {
		// TODO Auto-generated constructor stub
	}

	public Review(int review_id, int lesson_id, int mentee_id, String content, int score, Date write_date) {
		super();
		this.review_id = review_id;
		this.lesson_id = lesson_id;
		this.mentee_id = mentee_id;
		this.content = content;
		this.score = score;
		this.write_date = write_date;
	}

	public int getReview_id() {
		return review_id;
	}

	public void setReview_id(int review_id) {
		this.review_id = review_id;
	}

	public int getLesson_id() {
		return lesson_id;
	}

	public void setLesson_id(int lesson_id) {
		this.lesson_id = lesson_id;
	}

	public int getMentee_id() {
		return mentee_id;
	}

	public void setMentee_id(int mentee_id) {
		this.mentee_id = mentee_id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public Date getWrite_date() {
		return write_date;
	}

	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}
	
}
