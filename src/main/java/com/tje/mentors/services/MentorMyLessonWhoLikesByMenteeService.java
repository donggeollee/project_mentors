package com.tje.mentors.services;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.*;
import com.tje.mentors.model.*;

// 멘토 마이페이지
// 내가 작성한 클래스를 찜한 멘티 목록 
@Service
public class MentorMyLessonWhoLikesByMenteeService {

	@Autowired
	private MenteeWhoLikesMeDAO menteewholikesmeDAO;
	
	
	public Object service(Object args) {
		
		HashMap<String, Object> values = (HashMap<String, Object>)args;
		int curPageNo = (Integer)values.get("curPageNo");
		MenteeWhoLikesMe mwlm = (MenteeWhoLikesMe)values.get("mentor_id");
		
		String sortName = (String)values.get("sortName");
		
		if( sortName == null ) {
			return menteewholikesmeDAO.selectByMentee(curPageNo, mwlm);
		}
		System.out.println(sortName);
		if( sortName.equals("orderByName") ) {
			return menteewholikesmeDAO.selectByMenteeName(curPageNo, mwlm);
		}

		if( sortName.equals("orderByClass") ) {
			return menteewholikesmeDAO.selectByMenteeOrderByClass(curPageNo, mwlm);
		} 
			
		if( sortName.equals("orderByLikeAsc") ) { //
			return menteewholikesmeDAO.selectByMenteeAsc(curPageNo, mwlm);
		} 
		
		if( sortName.equals("orderByLikeDesc")) {
		} 
	
		
		return menteewholikesmeDAO.selectByMentee(curPageNo, mwlm);
		
	}

	
}
