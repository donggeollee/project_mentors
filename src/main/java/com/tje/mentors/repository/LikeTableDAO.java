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
public class LikeTableDAO {
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public LikeTableDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	class LikeTableRowMapper implements RowMapper<LikeTable> {
		@Override
		public LikeTable mapRow(ResultSet rs, int rowNum) throws SQLException {
			LikeTable obj = new LikeTable(
					rs.getInt(1), 
					rs.getInt(2), 
					rs.getInt(3));
			return obj;
		}
	}
	
	public Object isexistLike(LikeTable obj) {
		try {
			return jdbcTemplate.queryForObject(
					"select * from liketable where mentee_id = ? and lesson_id = ?", 
									new LikeTableRowMapper(),
									obj.getMentee_id(), obj.getLesson_id()
									);
		} catch(Exception e) {
			return null;
		}
	} 
	
	public List<LikeTable> likeListByMenteeId(Mentee obj) {
		return this.jdbcTemplate.query(
					"select * from liketable where mentee_id = ?", 
					new LikeTableRowMapper(), 
					obj.getMentee_id());
	}
	
	public int insert(LikeTable target) {
		return jdbcTemplate.update(
				"insert into liketable values(0, ?, ?)", 
				target.getLesson_id(), target.getMentee_id());
	}
	 
	public int delete(LikeTable target) {
		return jdbcTemplate.update(
				"delete from liketable where lesson_id = ? and mentee_id = ?", 
				target.getLesson_id(), target.getMentee_id());		
	}
}
