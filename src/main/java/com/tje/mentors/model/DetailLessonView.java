package com.tje.mentors.model;

public class DetailLessonView {
	private int lesson_id;
	private int mentor_id;
	private String category_big;
	private String category_small;
	private String location;
	private String title;
	private String lesson_info;
	private String curriculum;
	private int price;
	private int total_round;
	private double avg_score;
	private int review_count;
	private String mentor_email;
	private String mentor_name;
	private String mentor_profile;
	private String mentor_info;
	
	public DetailLessonView() {
		// TODO Auto-generated constructor stub
	}

	public DetailLessonView(int lesson_id, int mentor_id, String category_big, String category_small, String location,
			String title, String lesson_info, String curriculum, int price, int total_round, double avg_score,
			int review_count, String mentor_email, String mentor_name, String mentor_profile, String mentor_info) {
		super();
		this.lesson_id = lesson_id;
		this.mentor_id = mentor_id;
		this.category_big = category_big;
		this.category_small = category_small;
		this.location = location;
		this.title = title;
		this.lesson_info = lesson_info;
		this.curriculum = curriculum;
		this.price = price;
		this.total_round = total_round;
		this.avg_score = avg_score;
		this.review_count = review_count;
		this.mentor_email = mentor_email;
		this.mentor_name = mentor_name;
		this.mentor_profile = mentor_profile;
		this.mentor_info = mentor_info;
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

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getLesson_info() {
		return lesson_info;
	}

	public void setLesson_info(String lesson_info) {
		this.lesson_info = lesson_info;
	}

	public String getCurriculum() {
		return curriculum;
	}

	public void setCurriculum(String curriculum) {
		this.curriculum = curriculum;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getTotal_round() {
		return total_round;
	}

	public void setTotal_round(int total_round) {
		this.total_round = total_round;
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
	
}
