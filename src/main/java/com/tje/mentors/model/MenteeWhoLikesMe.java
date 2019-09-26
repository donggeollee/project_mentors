package com.tje.mentors.model;

public class MenteeWhoLikesMe {
	private int like_id;
	private int lesson_id;
	private int mentee_id;
	private String mentee_name;
	private String mentee_email;
	private String title;
	private int mentor_id;
	
	public MenteeWhoLikesMe() {
		// TODO Auto-generated constructor stub
	}

	public MenteeWhoLikesMe(int like_id, int lesson_id, int mentee_id, String mentee_name, String mentee_email,
			String title, int mentor_id) {
		super();
		this.like_id = like_id;
		this.lesson_id = lesson_id;
		this.mentee_id = mentee_id;
		this.mentee_name = mentee_name;
		this.mentee_email = mentee_email;
		this.title = title;
		this.mentor_id = mentor_id;
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
	
}
