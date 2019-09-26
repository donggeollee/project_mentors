package com.tje.mentors.services;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.LessonDAO;

@Service
public class LessonDeleteService {

	@Autowired
	private LessonDAO lessonDAO;
	
	public Object service(Object args) {
		ArrayList<Integer> target = (ArrayList<Integer>)args;
		int sum = 0;
		for(int tmp:target) {
			System.out.println("tmp:"+tmp);
			sum += lessonDAO.delete(tmp);
			System.out.println("sum:"+sum);
		}
		
		if(target.size() == sum)
			return true;
		else
			return false;
	}
	
}
