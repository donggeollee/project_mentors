package com.tje.mentors.model;

public class ListFilter {

	private String alignment;
	private String checkedSmallCate;
	private String location;
	
	public ListFilter() {}
	
	public ListFilter(String alignment, String checkedSmallCate, String location) {
		super();
		this.alignment = alignment;
		this.checkedSmallCate = checkedSmallCate;
		this.location = location;
	}

	public String getAlignment() {
		return alignment;
	}

	public void setAlignment(String alignment) {
		this.alignment = alignment;
	}

	public String getCheckedSmallCate() {
		return checkedSmallCate;
	}

	public void setCheckedSmallCate(String checkedSmallCate) {
		this.checkedSmallCate = checkedSmallCate;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}
}
