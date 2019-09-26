package com.tje.mentors.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.tje.mentors.model.MyLessonList;

@Repository
public class MyLessonListDAO {
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public MyLessonListDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	class MyLessonListRowMapper implements RowMapper<MyLessonList> {
		@Override
		public MyLessonList mapRow(ResultSet rs, int rowNum) throws SQLException {
			
			MyLessonList obj = new MyLessonList(
					rs.getInt(1),
					rs.getInt(2),
					rs.getInt(3),
					rs.getInt(4),
					rs.getString(5),
					rs.getTimestamp(6),
					rs.getString(7),
					rs.getString(8),
					rs.getDouble(9),
					rs.getInt(10),
					rs.getString(11),
					rs.getString(12)
					);
			
			return obj;
		}
	}
	
	public Object selectAll(int mentee_id) {
		return this.jdbcTemplate.query(
				"select * from MyLessonList", 
				new MyLessonListRowMapper());
	}
	
	public Object selectProcess(int mentee_id) {
		return this.jdbcTemplate.query(
				"select * from MyLessonList where curStatus = ? and mentee_id = ?", 
				new MyLessonListRowMapper(), "P", mentee_id);
	}
	
	public Object selectFinished(int mentee_id) {
		return this.jdbcTemplate.query(
				"select * from MyLessonList where curStatus = ? and mentee_id = ?", 
				new MyLessonListRowMapper(), "F", mentee_id);
	}
	
	
	
}
