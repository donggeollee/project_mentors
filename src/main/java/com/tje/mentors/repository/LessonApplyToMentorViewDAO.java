package com.tje.mentors.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import com.tje.mentors.model.LessonApplyToMentorView;

@Repository
public class LessonApplyToMentorViewDAO {

  private JdbcTemplate jdbcTemplate;
  
  @Autowired
  public LessonApplyToMentorViewDAO(DataSource dataSource) {
	  jdbcTemplate = new JdbcTemplate(dataSource);
  }
  
  private class LessonApplyToMentorViewRowMapper 
  				implements RowMapper<LessonApplyToMentorView>{
	public LessonApplyToMentorView mapRow(ResultSet rs, int rowNum) throws SQLException {
		LessonApplyToMentorView obj = new LessonApplyToMentorView(
				rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), 
				rs.getDate(5), rs.getString(6), rs.getString(7), rs.getString(8));
		return obj;
		}
   }	
  
  // 멘토에게 들어온 요청을 확인하는 게시판
  /* 지은 수정 -> order by regist_date desc 추가했음 */
  public Object selectListByMentorID(LessonApplyToMentorView obj) {
	  return this.jdbcTemplate.query(
			  "select * from lesson_applytomentorview where mentor_id = ? order by regist_date desc", 
			  new LessonApplyToMentorViewRowMapper(), obj.getMentor_id());
  }
  
  public Object selectOne(LessonApplyToMentorView obj) {
	  try {
	  return this.jdbcTemplate.queryForObject(
			  "select * from lesson_applytomentorview where lesson_id=?, mentee_id=?",
			  new LessonApplyToMentorViewRowMapper(), 
			  obj.getLesson_id(),obj.getMentee_id());
	  } catch(Exception e) {
		  return null;
	  }
  }
  
	
  
			  
}
