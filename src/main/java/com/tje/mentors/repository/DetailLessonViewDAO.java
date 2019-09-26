package com.tje.mentors.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.tje.mentors.model.DetailLessonView;
import com.tje.mentors.model.Lesson;

@Repository
public class DetailLessonViewDAO {
	
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public DetailLessonViewDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	private class DetailLessonViewRowMapper implements RowMapper<DetailLessonView> {

		public DetailLessonView mapRow(ResultSet rs, int rowNum) throws SQLException {
			DetailLessonView obj = new DetailLessonView(
					rs.getInt(1), rs.getInt(2), rs.getString(3), 
					rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7),
					rs.getString(8), rs.getInt(9), rs.getInt(10), rs.getDouble(11), 
					rs.getInt(12), rs.getString(13), rs.getString(14), 
					rs.getString(15), rs.getString(16));
			return obj;
		}
	}
	
	// �긽�꽭 �젅�뒯 蹂댁뿬以� �븣 
	public Object selectOne(Lesson obj) {
		return this.jdbcTemplate.queryForObject(
				"select * from detail_lesson_view where lesson_id = ?",
				new DetailLessonViewRowMapper(),
				obj.getLesson_id());
	}
	
}
