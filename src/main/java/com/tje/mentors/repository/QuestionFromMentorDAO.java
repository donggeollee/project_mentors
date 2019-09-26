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
import com.tje.mentors.repository.QuestionFromMenteeDAO.QuestionRowMapper;



@Repository
public class QuestionFromMentorDAO {

	private JdbcTemplate jdbcTemplate;

	@Autowired
	public QuestionFromMentorDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	class QuestionRowMapper implements RowMapper<QuestionFromMentor> {
		@Override
		public QuestionFromMentor mapRow(ResultSet rs, int rowNum) throws SQLException {
			QuestionFromMentor questionFromMentor = new QuestionFromMentor(
					rs.getInt(1), 
					rs.getString(2),
					rs.getString(3),
					rs.getInt(4),
					rs.getString(5),
					rs.getString(6),
					rs.getString(7),
					rs.getTimestamp(8));

			return questionFromMentor;
		}
	}
	
	
		// 멘토가 작성한 글 상세 보기
	
		public Object select(QuestionFromMentor model) {
			return this.jdbcTemplate.queryForObject(
					"select * from QuestionFromMentor where admin_req_id = ?", 
					new QuestionRowMapper(), model.getAdmin_req_id());
		}
		
		// 멘토가 작성한 전체 글 목록 리스트 (최근 작성일자 순)
		
		public Object selectList(QuestionFromMentor model) {
			List<QuestionFromMentor> result = this.jdbcTemplate.query(
					"select * from QuestionFromMentor order by send_date desc",
					new QuestionRowMapper());
			
			return result.isEmpty() ? null : result;
			
		}
		
		// 멘토가 작성한 전체글 목록 리스트 ( 정렬 -> 답변등록상태 N인 것만 제일 우선순위로 &최근 작성일자 순)
				public Object selectListReplyCk(QuestionFromMentor model) {
					List<QuestionFromMentor> result = this.jdbcTemplate.query(
							"select * from QuestionFromMentor order by reply_ck asc, send_date desc",
							new QuestionRowMapper());
					
					return result.isEmpty() ? null : result;
				}		


}
