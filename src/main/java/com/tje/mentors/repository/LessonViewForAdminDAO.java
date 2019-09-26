package com.tje.mentors.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.tje.mentors.model.LessonViewForAdmin;
import com.tje.mentors.model.Mentor;
import com.tje.mentors.repository.MentorDAO.mentorRowMapper;
import com.tje.mentors.setting.PagingInfoByTen;

@Repository
public class LessonViewForAdminDAO {

	@Autowired
	private PagingInfoByTen pagingInfo;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	class LessonViewForAdminRowMapper implements RowMapper<LessonViewForAdmin> {
		@Override
		public LessonViewForAdmin mapRow(ResultSet rs, int rowNum) throws SQLException {
			
			LessonViewForAdmin obj = new LessonViewForAdmin(
						rs.getInt("lesson_id"),
						rs.getInt("mentor_id"),
						rs.getString("category_big"),
						rs.getString("category_small"),
						rs.getString("location"),
						rs.getString("title"),
						rs.getString("lesson_info"),
						rs.getString("curriculum"),
						rs.getInt("price"),
						rs.getInt("total_round"),
						rs.getString("lesson_thumnail"),
						rs.getDouble("avg_score"),
						rs.getInt("mentee_count"),
						rs.getInt("review_count"),
						rs.getTimestamp("write_date"),
						rs.getString("mentor_name")
					);
			
			return obj;
		}
	}
	
	public Object selectAll(int page) {
		return this.jdbcTemplate.query(
				"select * from lessonViewForAdmin limit ?,?;", 
				new LessonViewForAdminRowMapper(), 
				(page-1)*this.pagingInfo.getPagingSize(),
				this.pagingInfo.getPagingSize());
	}
	
	public int countAll() {
		return this.jdbcTemplate.queryForObject(
				"select count(*) from lessonViewForAdmin;", 
				Integer.class);
	}
	
	public int countByName(String name) {
		return this.jdbcTemplate.queryForObject(
				"select count(*) from lessonViewForAdmin where mentor_name like ?", 
				Integer.class,
				"%"+name+"%");
	}
	
	public int countByFilter(String big) {
		return this.jdbcTemplate.queryForObject(
				"select count(*) from lessonViewForAdmin where category_big = ?", 
				Integer.class,
				big);
	}
	
	public Object selectByName(String name, int page) {
		
		List<LessonViewForAdmin> result =  this.jdbcTemplate.query(
				"select * from lessonViewForAdmin where mentor_name like ? limit ?,?;", 
				new LessonViewForAdminRowMapper(),
				"%"+name+"%", 
				(page-1)*this.pagingInfo.getPagingSize(),
				this.pagingInfo.getPagingSize());
		
		return result.isEmpty()? null : result;
		
	}
	
	public Object orderByDefault(int page) {
		List<LessonViewForAdmin> result = this.jdbcTemplate.query(
				"select * from lessonViewForAdmin order by lesson_id limit ?,?;", 
				new LessonViewForAdminRowMapper(), 
				(page-1)*this.pagingInfo.getPagingSize(),
				this.pagingInfo.getPagingSize());
		return result.isEmpty() ? null : result;
	}
	
	public Object orderByName(int page) {
		List<LessonViewForAdmin> result = this.jdbcTemplate.query(
				"select * from lessonViewForAdmin order by mentor_name limit ?,?;", 
				new LessonViewForAdminRowMapper(), 
				(page-1)*this.pagingInfo.getPagingSize(),
				this.pagingInfo.getPagingSize());
		return result.isEmpty() ? null : result;
	}
	
	public Object orderByLatest(int page) {
		List<LessonViewForAdmin> result = this.jdbcTemplate.query(
				"select * from lessonViewForAdmin order by write_date desc limit ?,?;",
				new LessonViewForAdminRowMapper(), 
				(page-1)*this.pagingInfo.getPagingSize(),
				this.pagingInfo.getPagingSize());
		return result.isEmpty() ? null : result;
	}
	
	public Object orderByOldest(int page) {
		List<LessonViewForAdmin> result = this.jdbcTemplate.query(
				"select * from lessonViewForAdmin order by write_date asc limit ?,?;", 
				new LessonViewForAdminRowMapper(), 
				(page-1)*this.pagingInfo.getPagingSize(),
				this.pagingInfo.getPagingSize());
		return result.isEmpty() ? null : result;
	}
	
	public Object filter(String big, int page) {
		List<LessonViewForAdmin> result = this.jdbcTemplate.query(
				"select * from lessonViewForAdmin where category_big = ? limit ?,?;", 
				new LessonViewForAdminRowMapper(), big, 
				(page-1)*this.pagingInfo.getPagingSize(),
				this.pagingInfo.getPagingSize());
		return result.isEmpty() ? null : result;
	}
	
}
