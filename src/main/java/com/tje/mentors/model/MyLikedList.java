package com.tje.mentors.model;

public class MyLikedList {
	private int like_id;
	private int lesson_id;
	private int mentee_id;
	private String mentor_name;
	private String title;
	private String category_big;
	private String category_small;
	private double avg_score;
	private int review_count;
	
	public MyLikedList() {
		// TODO Auto-generated constructor stub
	}

	public MyLikedList(int like_id, int lesson_id, int mentee_id, String mentor_name, String title, String category_big,
			String category_small, double avg_score, int review_count) {
		super();
		this.like_id = like_id;
		this.lesson_id = lesson_id;
		this.mentee_id = mentee_id;
		this.mentor_name = mentor_name;
		this.title = title;
		this.category_big = category_big;
		this.category_small = category_small;
		this.avg_score = avg_score;
		this.review_count = review_count;
	}

	public int getLike_id() {
		return like_id;
	}

	public void setLike_id(int like_id) {
		this.like_id = like_id;
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
	
}
