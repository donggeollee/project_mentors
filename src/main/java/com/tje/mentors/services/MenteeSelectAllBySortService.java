package com.tje.mentors.services;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.*;

@Service
public class MenteeSelectAllBySortService {
	
	@Autowired
	private MenteeDAO menteeDAO;
	
	public Object service(Object args, Object args2) {
		
		int curPageNo = (Integer)args;
		String sortName = (String)args2;
		
		if( sortName == null ) {
			return menteeDAO.orderByDefault(curPageNo);
		} 
		
		else if ( sortName.equals("defaults")) {
			return menteeDAO.orderByDefault(curPageNo);
		}
		
		else if ( sortName.equals("name")) {
			return  menteeDAO.orderByName(curPageNo);
		}
		
		else if ( sortName.equals("latest")) {
			return menteeDAO.orderByLatest(curPageNo);
		}
		
		else if ( sortName.equals("oldest")) {
			return menteeDAO.orderByOldest(curPageNo);
		}
		
		else if ( sortName.equals("simpleLogin")) {
			return menteeDAO.orderBySimpleLogin(curPageNo);
		} 
		else {
			return menteeDAO.orderByDefault(curPageNo);
		}
		
	}
	
}
