package com.tje.mentors.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.tje.mentors.model.DetailLessonView;
import com.tje.mentors.model.Lesson;
import com.tje.mentors.model.LessonStatus;

@Repository
public class LessonStatusDAO {
	
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public LessonStatusDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	private class LessonStatusMapper implements RowMapper<LessonStatus> {
		public LessonStatus mapRow(ResultSet rs, int rowNum) throws SQLException {
			LessonStatus obj = new LessonStatus(
					rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4),
					rs.getString(5), rs.getDate(6));
			return obj;
		}
	}
		
	private class LessonIdMapper implements RowMapper<LessonStatus> {
		public LessonStatus mapRow(ResultSet rs, int rowNum) throws SQLException {
			LessonStatus obj = new LessonStatus(
					rs.getInt("lesson_id"));
			return obj;
		}
	}	
	
	/* 지은 - 추가 수정(단어) */
	// 멘토가 멘토링 완료 눌렀을 때
	public int updateCurStatusFinish(LessonStatus obj) {
		return this.jdbcTemplate.update(
				"update lesson_status set curStatus = 'F' where lesson_id=? and mentee_id =?", 
				obj.getLesson_id(),obj.getMentee_id());
	}
	
	/* 지은 - 추가 수정(단어) */
	// 멘토가 요청 수락했을 때
	public int insert(LessonStatus obj) {
		return this.jdbcTemplate.update(
				"insert into lesson_status values (0,?,?,?,'P',now())",
				obj.getLesson_id(),obj.getMentor_id(),obj.getMentee_id());
	} 
	
	
	// jieun add - admin page
	public int selectByLessonId(int lesson_id) {
		return this.jdbcTemplate.queryForObject(
				"select count(*) from lesson_status where lesson_id = ? and curStatus = 'P'",
					Integer.class, lesson_id);
	}
	
	
}
