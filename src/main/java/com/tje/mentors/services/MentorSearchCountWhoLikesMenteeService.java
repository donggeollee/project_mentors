package com.tje.mentors.services;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.mentors.repository.*;
import com.tje.mentors.setting.PagingInfoByTen;
import com.tje.mentors.model.*;

// 멘토 마이페이지
// 내가 작성한 클래스를 찜한 멘티 목록의 페이지 정보 가져오기 
@Service
public class MentorSearchCountWhoLikesMenteeService {

	@Autowired
	private MenteeWhoLikesMeDAO menteewholikesmeDAO;
	
	@Autowired
	private PagingInfoByTen pagingInfo;
	
	
	public Object service(Object args) {
		
		int totalCount = menteewholikesmeDAO.selectSearchByNameCount((MenteeWhoLikesMe)args);
		
		int totalPageCount = totalCount / pagingInfo.getPagingSize() +
				(totalCount % pagingInfo.getPagingSize() == 0? 0 : 1);
		
		HashMap<String, Integer> result = new HashMap<String, Integer>();
		
		// 전체 개수
		result.put("totalCount", totalCount);
		// 페이지 개수 
		result.put("totalPageCount", totalPageCount);
		
		return result;
	}

	
}
