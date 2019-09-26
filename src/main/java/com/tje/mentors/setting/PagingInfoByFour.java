package com.tje.mentors.setting;

public class PagingInfoByFour {

	private int pagingSize;
	private int pagingWidth;
	
	public PagingInfoByFour() {}

	public PagingInfoByFour(int pagingSize, int pagingWidth) {
		super();
		this.pagingSize = pagingSize;
		this.pagingWidth = pagingWidth;
	}

	public int getPagingSize() {
		return pagingSize;
	}

	public void setPagingSize(int pagingSize) {
		this.pagingSize = pagingSize;
	}

	public int getPagingWidth() {
		return pagingWidth;
	}

	public void setPagingWidth(int pagingWidth) {
		this.pagingWidth = pagingWidth;
	}
	
	
}
