package com.tje.mentors.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.tje.mentors.model.*;
import com.tje.mentors.repository.MyLessonListDAO.MyLessonListRowMapper;

// 지은 - 추가 모델 DAO 
// 나의 멘티 목록 리스트 

@Repository
public class MyMenteeListDAO {
	
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public MyMenteeListDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	private class MyMenteeListMapper implements RowMapper<MyMenteeList> {
		public MyMenteeList mapRow(ResultSet rs, int rowNum) throws SQLException {
			MyMenteeList obj = new MyMenteeList(
					rs.getInt(1), 
					rs.getInt(2), 
					rs.getString(3),
					rs.getInt(4), 
					rs.getInt(5),
					rs.getString(6),
					rs.getString(7),
					rs.getString(8),
					rs.getDate(9));
			return obj;
		}
	}
	
	// 지은 추가 수정 사항 
	private class MyMenteeIDMapper implements RowMapper<MyMenteeList> {
		public MyMenteeList mapRow(ResultSet rs, int rowNum) throws SQLException {
			MyMenteeList obj = new MyMenteeList(
					rs.getInt("lesson_id"),
					rs.getString("title"));
			return obj;
		}
	}
		
	// 현재 진행중인 상태의 멘티 리스트 목록 가져오기 (제일 오랜 시간 진행한 순)
	public Object selectAll(int mentor_id, int lesson_id) {
		return this.jdbcTemplate.query(
				"select * from mymenteelist where mentor_id = ? and curStatus ='P' and lesson_id = ? order by start_date;", 
				new MyMenteeListMapper(),
				mentor_id,lesson_id);
	}
	
	/* 지은 - 추가 수정(내가 작성한 클래스 목록 제목 가져오기) */
	public Object selectTitleId(int mentor_id) {
		return this.jdbcTemplate.query(
				"select distinct lesson_id, title from mymenteelist where mentor_id = ?;", 
				new MyMenteeIDMapper(),	mentor_id);
	}
	
	/* 지은 - 추가 수정 관리자 페이지 (상세보기) 멘티 목록*/
	public Object selectByLessonId(int lesson_id) {
		return this.jdbcTemplate.query(
				" select * from mymenteelist where lesson_id = ?", 
				new MyMenteeListMapper(),	lesson_id);
	}
	
	
}
