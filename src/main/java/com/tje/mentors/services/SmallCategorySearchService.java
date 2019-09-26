package com.tje.mentors.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.tje.mentors.repository.Category_nameDAO;

@Service
public class SmallCategorySearchService {

	@Autowired
	private Category_nameDAO category_nameDAO;
	
	public Object service(String big) {
		
		return category_nameDAO.selectByCategoryBig(big);
	
	}
}
