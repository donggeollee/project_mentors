package com.tje.mentors.model;

public class Image {
	private int image_id;
	private int lesson_id;
	private String file_name;
	
	public Image() {
		// TODO Auto-generated constructor stub
	}

	public Image(int image_id, int lesson_id, String file_name) {
		super();
		this.image_id = image_id;
		this.lesson_id = lesson_id;
		this.file_name = file_name;
	}

	public int getImage_id() {
		return image_id;
	}

	public void setImage_id(int image_id) {
		this.image_id = image_id;
	}

	public int getLesson_id() {
		return lesson_id;
	}

	public void setLesson_id(int lesson_id) {
		this.lesson_id = lesson_id;
	}

	public String getFile_name() {
		return file_name;
	}

	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	
	public String toString() {
		return String.format("%s,%s,%s", 
				image_id,
				lesson_id,
				file_name
				
				);
	}
	
	
}
