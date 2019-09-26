package com.tje.mentors.model;

public class LikeTable {
	private int like_id;
	private int lesson_id;
	private int mentee_id;
	
	public LikeTable() {
		// TODO Auto-generated constructor stub
	}

	public LikeTable(int like_id, int lesson_id, int mentee_id) {
		super();
		this.like_id = like_id;
		this.lesson_id = lesson_id;
		this.mentee_id = mentee_id;
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
	
}
