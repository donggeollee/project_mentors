package com.tje.mentors.setting;

public class PagingInfoByTen {

	private int pagingSize;
	private int pageRange;
	
	public PagingInfoByTen() {
	}
	
	public PagingInfoByTen(int pagingSize) {
		this.pagingSize = pagingSize;
	}

	public int getPagingSize() {
		return pagingSize;
	}

	public void setPagingSize(int pagingSize) {
		this.pagingSize = pagingSize;
	}

	public int getPageRange() {
		return pageRange;
	}

	public void setPageRange(int pageRange) {
		this.pageRange = pageRange;
	}

	
	
	
}
