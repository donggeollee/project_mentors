package com.tje.mentors.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.tje.mentors.model.MyLessonList;
import com.tje.mentors.model.MyMentor;

@Repository
public class MyMentorDAO {
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public MyMentorDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	class MyMentorRowMapper implements RowMapper<MyMentor> {
		@Override
		public MyMentor mapRow(ResultSet rs, int rowNum) throws SQLException {
			
			MyMentor obj = new MyMentor(
					rs.getInt("mentee_id"),
					rs.getInt("mentor_id"),
					rs.getString("mentor_name"),
					rs.getString("mentor_email"),
					rs.getString("phone"),
					rs.getString("mentor_info"),
					rs.getString("mentor_profile")
					);
			
			return obj;
		}
	}
	
	
	public Object selectAll(int mentee_id) {
		return this.jdbcTemplate.query(
				"select DISTINCT * from mymentor where mentee_id = ?", 
				new MyMentorRowMapper(),mentee_id);
	}
	
	
}
	
