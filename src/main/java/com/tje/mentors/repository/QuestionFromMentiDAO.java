package com.tje.mentors.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.tje.mentors.model.*;



@Repository
public class QuestionFromMentiDAO {

	private JdbcTemplate jdbcTemplate;

	@Autowired
	public QuestionFromMentiDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	class QuestionRowMapper implements RowMapper<QuestionFromMenti> {
		@Override
		public QuestionFromMenti mapRow(ResultSet rs, int rowNum) throws SQLException {
			QuestionFromMenti questionFromMenti = new QuestionFromMenti(
					rs.getInt(1), 
					rs.getString(2),
					rs.getString(3),
					rs.getInt(4),
					rs.getString(5),
					rs.getString(6),
					rs.getString(7),
					rs.getTimestamp(8));

			return questionFromMenti;
		}
	}
	
		// 멘티가 작성한 글 상세 보기
	
		public Object select(QuestionFromMenti model) {
			return this.jdbcTemplate.queryForObject(
					"select * from QuestionFromMenti where admin_req_id = ? ", 
					new QuestionRowMapper(), model.getAdmin_req_id());
		}
		
		// 멘티가 작성한  전체글 목록 리스트 (최근 작성일자 순)
		
		public Object selectList(QuestionFromMenti model) {
			List<QuestionFromMenti> result = this.jdbcTemplate.query(
					"select * from QuestionFromMenti order by send_date desc",
					new QuestionRowMapper());
			
			return result.isEmpty() ? null : result;
			
		}
		
		// 멘티가 작성한 전체글 목록 리스트 ( 정렬 -> 답변등록상태 N인 것만 제일 우선순위로 &최근 작성일자 순)
		public Object selectListReplyCk(QuestionFromMenti model) {
			List<QuestionFromMenti> result = this.jdbcTemplate.query(
					"select * from QuestionFromMenti order by reply_ck asc, send_date desc",
					new QuestionRowMapper());
			
			return result.isEmpty() ? null : result;
			
		}


}
