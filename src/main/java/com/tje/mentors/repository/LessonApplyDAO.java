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
import com.tje.mentors.model.LessonApply;

@Repository
public class LessonApplyDAO {
	
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public LessonApplyDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	private class LessonApplyRowMapper implements RowMapper<LessonApply> {
		public LessonApply mapRow(ResultSet rs, int rowNum) throws SQLException {
			LessonApply obj = new LessonApply(
					rs.getInt(1), rs.getInt(2), rs.getInt(3), 
					rs.getInt(4), rs.getDate(5));
			return obj;
		}
	}
	
	// 멘티가 레슨 신청했을 때
	public int insert(LessonApply obj) {
		return  this.jdbcTemplate.update(
				"insert into lesson_apply values (0,?,?,?,now())",
				obj.getLesson_id(),obj.getMentor_id(),
				obj.getMentee_id());
	}
	
	/* 지은 - 수정 추가 */
	// 멘토가 요청에 수락  or 거절 했을 때  
	public int delete(LessonApply obj) {
		return this.jdbcTemplate.update(
				"delete from lesson_apply where mentee_id = ? and lesson_id = ? and mentor_id = ?", 
				obj.getMentee_id(),obj.getLesson_id(),obj.getMentor_id());
	}
	
}
