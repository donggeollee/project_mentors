package com.tje.mentors.services;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.tje.mentors.model.Lesson;
import com.tje.mentors.repository.LessonDAO;

// 최신순/리뷰평점순/
@Service
public class LessonListForAndroidService {
	
	@Autowired
	private LessonDAO dao;

	public Object service(Lesson model) {
		return (List<Lesson>)dao.selectByAndroid(model);
	}
}
