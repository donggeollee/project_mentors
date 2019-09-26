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

@Repository
public class ReviewDAO {

	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public ReviewDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	class reviewRowMapper implements RowMapper<Review>{
		@Override
		public Review mapRow(ResultSet rs, int rowNum) throws SQLException {
				Review review = new Review(
						rs.getInt(1),
						rs.getInt(2),
						rs.getInt(3),
						rs.getString(4),
						rs.getInt(5),
						rs.getTimestamp(6));
			
			return review;
		}
		
	}
	
	// 리뷰 작성 시 리뷰 내용 추가 
	// (리뷰 작성 추가 성공이 완료되면, 그때 서비스에서 레슨 테이블의 리뷰의 평점과 리뷰수를 update시켜줘야함) 
	public int insert(Review model) {
		
		return this.jdbcTemplate.update(
				"insert into review values (null,?,?,?,?,now())",
				model.getLesson_id(),model.getMentee_id(),model.getContent(),
				model.getScore());
	}
	
	
	// 레슨별으로 리뷰 목록 가져오기  
	public Object select(int lesson_id) {
		List<Review> result =  this.jdbcTemplate.query(
				"select * from review where lesson_id = ?",
				new reviewRowMapper(),lesson_id);
		
		return result.isEmpty() ? null : result;
	}
	
	// 레슨별으로 리뷰 목록 가져오기  
	public Object select(Review model) {
		List<Review> result =  this.jdbcTemplate.query(
				"select * from review where lesson_id = ?",
				new reviewRowMapper(),model.getLesson_id());
		
		return result.isEmpty() ? null : result;
	}
	// 각 레슨별 리뷰수 
	public Integer reviewCount(Review model) {
		
		return this.jdbcTemplate.queryForObject(
				"select count(*) from review where lesson_id = ?", 
				Integer.class, model.getLesson_id());
	}
	
	// 리뷰 작성 여부 판단  
		public Object select(int lesson_id, int mentee_id) {
			
			Review review = null;
			
			try {
				review = this.jdbcTemplate.queryForObject(
						"select * from review where lesson_id = ? and mentee_id = ?",
						new reviewRowMapper(),lesson_id,mentee_id);
				return review;
			} catch (Exception e) {
				return null;
			}
					
		}
}
