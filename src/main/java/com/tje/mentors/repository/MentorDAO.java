package com.tje.mentors.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.tje.mentors.model.Mentor;
import com.tje.mentors.setting.PagingInfoByTen;

@Repository
public class MentorDAO {
	
	@Autowired
	private PagingInfoByTen pagingInfo;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
			
	class mentorRowMapper implements RowMapper<Mentor>{
		@Override
		public Mentor mapRow(ResultSet rs, int rowNum) throws SQLException {
			Mentor mentor = new Mentor(
					rs.getInt("mentor_id"),
					rs.getString("mentor_email"),
					rs.getString("mentor_name"),
					rs.getString("mentor_password"),
					rs.getString("mentor_categoryBig"),
					rs.getString("mentor_profile"),//?�택?�항
					rs.getString("mentor_info"),//?�택?�항
					rs.getString("phone"),
					rs.getTimestamp("regist_date"));		
			return mentor;
		}
		
	}
	
	public int insert(Mentor model) {
		return this.jdbcTemplate.update(
				"insert into mentor values (null, ?, ?, ?, ?, null, ?, ?, now())", 
				model.getMentor_email(),
				model.getMentor_name(),
				model.getMentor_password(),
				model.getMentor_categoryBig(),
				model.getMentor_info() == "" || model.getMentor_info().length() == 0 ? null : model.getMentor_info() ,
				model.getPhone());
	}
	
	public int countAll() {
		return this.jdbcTemplate.queryForObject("select count(*) from mentor;", Integer.class); 
	}
	
	public int countByName(String target) {
		return this.jdbcTemplate.queryForObject(
				"select count(*) from mentor where mentor_name like ?;", 
				Integer.class, "%"+target+"%"); 
	}
	
	public Object selectAll(int page) {
		List<Mentor> mentorList = this.jdbcTemplate.query("select * from mentor limit ?,?;", 
				new mentorRowMapper(), 
				(page-1)*this.pagingInfo.getPagingSize(),
				this.pagingInfo.getPagingSize());
		return mentorList.isEmpty() ? null : mentorList;
	}
	
	public Object selectByEmail(Mentor model){

		Mentor loginMember = null;
		
		try {
			loginMember = this.jdbcTemplate.queryForObject(
			"select * from mentor where mentor_email = ?",
			new mentorRowMapper(),
			model.getMentor_email());
			
			return loginMember;
		} catch (Exception e) {
			return null;
		}
		
	}
	
	
	public Object selectById(Mentor model){
		
		Mentor loginMember = null;
		
		try {
			loginMember = this.jdbcTemplate.queryForObject(
			"select * from mentor where mentor_id = ?",
			new mentorRowMapper(),
			model.getMentor_id());
			
			return loginMember;
			
		} catch (Exception e) {
			return null;
		}
		
	}
	
	public Object selectByName(String name, int page) {
		
		List<Mentor> result =  this.jdbcTemplate.query(
				"select * from mentor where mentor_name like ? limit ?,?", 
				new mentorRowMapper(),
				"%"+name+"%", 
				(page-1)*this.pagingInfo.getPagingSize(),
				this.pagingInfo.getPagingSize());
		
		return result.isEmpty()? null : result;
		
	}
	

	public int updateProfile(Mentor model){
		
		return this.jdbcTemplate.update(
			"update mentor set mentor_profile = ? where mentor_id = ?",
			model.getMentor_profile(),
			model.getMentor_id());
	}
	
	public int updateInfo(Mentor model){
		
		return this.jdbcTemplate.update(
			"update mentor set mentor_info = ? where mentor_id = ?",
			model.getMentor_info(),
			model.getMentor_id());
	}
	
	
	public int updatePassword(Mentor model){
		
		return this.jdbcTemplate.update(
			"update mentor set mentor_password = ? where mentor_id = ?",
			model.getMentor_password(),model.getMentor_id());
	}
	
	public int deleteById(int mentor_id){
		
		int result =  this.jdbcTemplate.update(
			"delete from mentor where mentor_id = ?",
			mentor_id);
		
		System.out.println("result : "+result);
		return result;
			
	}

	public Object orderByDefault(int page) {
		List<Mentor> mentorList = this.jdbcTemplate.query(
				"select * from mentor order by mentor_id limit ?,?;", 
				new mentorRowMapper(), 
				(page-1)*this.pagingInfo.getPagingSize(),
				this.pagingInfo.getPagingSize());
		return mentorList.isEmpty() ? null : mentorList;
	}
	
	public Object orderByName(int page) {
		
		List<Mentor> mentorList = this.jdbcTemplate.query(
				"select * from mentor order by mentor_name limit ?,?;", 
				new mentorRowMapper(), 
				(page-1)*this.pagingInfo.getPagingSize(),
				this.pagingInfo.getPagingSize());
		
		return mentorList.isEmpty() ? null : mentorList;
	}
	
	public Object orderByLatest(int page) {
		List<Mentor> mentorList = this.jdbcTemplate.query(
				"select * from mentor order by regist_date desc limit ?,?;", 
				new mentorRowMapper(), 
				(page-1)*this.pagingInfo.getPagingSize(),
				this.pagingInfo.getPagingSize());
		return mentorList.isEmpty() ? null : mentorList;
	}
	
	public Object orderByOldest(int page) {
		List<Mentor> mentorList = this.jdbcTemplate.query(
				"select * from mentor order by regist_date asc limit ?,?;", 
				new mentorRowMapper(), 
				(page-1)*this.pagingInfo.getPagingSize(),
				this.pagingInfo.getPagingSize());
		return mentorList.isEmpty() ? null : mentorList;
	}
	
}
