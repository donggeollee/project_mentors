package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tje.mentors.repository.Category_nameDAO;
import com.tje.mentors.model.Category_name;

@Service
public class CategorySearchService {

	@Autowired
	private Category_nameDAO dao;
	public Object service(String bigCate) {
		Category_name result = (Category_name)dao.selectByCategoryBig(bigCate);
		return result.getSmall();
	}
}
