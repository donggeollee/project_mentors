package com.tje.mentors.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.tje.mentors.model.Mentee;
import com.tje.mentors.model.Mentor;
import com.tje.mentors.repository.MentorDAO.mentorRowMapper;
import com.tje.mentors.setting.*;

@Repository
public class MenteeDAO {

	@Autowired
	private PagingInfoByTen pagingInfoByTen;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
			
	class mentiRowMapper implements RowMapper<Mentee>{
		@Override
		public Mentee mapRow(ResultSet rs, int rowNum) throws SQLException {
			Mentee mentee = new Mentee(
					rs.getInt("mentee_id"),
					rs.getString("mentee_email"),
					rs.getString("mentee_name"),
					rs.getString("mentee_password"),
					rs.getString("mentee_profile"),//선택사항
					rs.getString("simple_login_CK"),//선택사항
					rs.getTimestamp("regist_date"));		
			return mentee;
		}
		
	}
	
	public int insert(Mentee model) {
		return this.jdbcTemplate.update(
				"insert into mentee values (null, ?, ?, ?, null, ?, now())", 
				model.getMentee_email(),
				model.getMentee_name(),
				model.getMentee_password() == null|| model.getMentee_password().length() == 0 ? null : model.getMentee_password() ,
				model.getSimple_login_CK());
	}
	
	public Object selectByEmail(Mentee model){
		
		Mentee loginMember = null;
		
		try {
			loginMember = this.jdbcTemplate.queryForObject(
			"select * from mentee where mentee_email = ?",
			new mentiRowMapper(),
			model.getMentee_email());
			
			return loginMember;
		} catch (Exception e) {
			return null;
		}
		
	}
	
	
	public Object selectById(Mentee model){
		
		Mentee loginMember = null;
		
		try {
			loginMember = this.jdbcTemplate.queryForObject(
			"select * from mentee where mentee_id = ?",
			new mentiRowMapper(),
			model.getMentee_id());
			
			return loginMember;
		} catch (Exception e) {
			return null;
		}
		
	}
	
	public Object selectById(int id){
		
		Mentee loginMember = null;
		
		try {
			loginMember = this.jdbcTemplate.queryForObject(
					"select * from mentee where mentee_id = ?",
					new mentiRowMapper(),
					id);
			
			return loginMember;
		} catch (Exception e) {
			return null;
		}
		
	}
	
	public int updatePassword(Mentee model){
		
		return this.jdbcTemplate.update(
			"update mentee set mentee_password = ? where mentee_id = ?",
			model.getMentee_password(),model.getMentee_id());
	}
	
	public int updateProfile(Mentee model){
		
		return this.jdbcTemplate.update(
			"update mentee set mentee_profile = ? where mentee_id = ?",
			model.getMentee_profile(), model.getMentee_id());
	}
	
	public int deleteById(int mentee_id){
		
		return this.jdbcTemplate.update(
			"delete from mentee where mentee_id = ?",
			mentee_id);
	}
	
	// 지은 추가 - 관리자 페이지 (멘티 이름 검색)
	public Object selectByName(String searchName,int page){
		
		List<Mentee> result =  this.jdbcTemplate.query(
			"select * from mentee where mentee_name like ? limit ?,?",
			new mentiRowMapper(), "%"+searchName+"%",
			(page-1)*this.pagingInfoByTen.getPagingSize(),
			this.pagingInfoByTen.getPagingSize());
		
		return result.isEmpty() ? null : result;
	}
	

	// 지은 추가 - 관리자 페이지 (멘티 이름 검색 카운트)
	public int selectByNameCount(String searchName){
		
		return this.jdbcTemplate.queryForObject(
			"select count(*) from mentee where mentee_name like ? ",
			Integer.class, "%"+searchName+"%");
	}
	
	
	// 지은 추가 - 관리자 페이지 (멘티수 관리)
	public int countAll() {
		return this.jdbcTemplate.queryForObject
				("select count(*) from mentee;", Integer.class); 
	}
		
	
	// 지은 추가 - 관리자 페이지 (멘티 리스트)
	public Object selectAll(int page) {
		List<Mentee> menteeList = this.jdbcTemplate.query
				("select * from mentee limit ?,?;", new mentiRowMapper(),
				(page-1)*this.pagingInfoByTen.getPagingSize(),
				this.pagingInfoByTen.getPagingSize());
		return menteeList.isEmpty() ? null : menteeList;
	}

	
	// 지은 추가 - 관리자 페이지 (멘티 정렬 디폴트 mentee_id)
	public Object orderByDefault(int page) {
		List<Mentee> menteeList = this.jdbcTemplate.query
				("select * from mentee order by mentee_id limit ?,?;", 
				new mentiRowMapper(),
				(page-1)*this.pagingInfoByTen.getPagingSize(),
				this.pagingInfoByTen.getPagingSize());
		return menteeList.isEmpty() ? null : menteeList;
	}
	// 지은 추가 - 관리자 페이지 (멘티 정렬)
	public Object orderByName(int page) {
		List<Mentee> menteeList = this.jdbcTemplate.query
				("select * from mentee order by mentee_name limit ?,?;", 
				new mentiRowMapper(),
				(page-1)*this.pagingInfoByTen.getPagingSize(),
				this.pagingInfoByTen.getPagingSize());
		return menteeList.isEmpty() ? null : menteeList;
	}
	// 지은 추가 - 관리자 페이지 (멘티 정렬)
	public Object orderByLatest(int page) {
		List<Mentee> menteeList = this.jdbcTemplate.query
				("select * from mentee order by regist_date desc limit ?,?;", 
				new mentiRowMapper(),
				(page-1)*this.pagingInfoByTen.getPagingSize(),
				this.pagingInfoByTen.getPagingSize());
		return menteeList.isEmpty() ? null : menteeList;
	}
	// 지은 추가 - 관리자 페이지 (멘티 정렬)
	public Object orderByOldest(int page) {
		List<Mentee> menteeList = this.jdbcTemplate.query
				("select * from mentee order by regist_date asc limit ?,?;", 
				new mentiRowMapper(),
				(page-1)*this.pagingInfoByTen.getPagingSize(),
				this.pagingInfoByTen.getPagingSize());
		return menteeList.isEmpty() ? null : menteeList;
	}
	// 지은 추가 - 관리자 페이지 (멘티 정렬)
	public Object orderBySimpleLogin(int page) {
		List<Mentee> menteeList = this.jdbcTemplate.query
				("select * from mentee order by simple_login_CK limit ?,?;", 
				new mentiRowMapper(),
				(page-1)*this.pagingInfoByTen.getPagingSize(),
				this.pagingInfoByTen.getPagingSize());
		
		return menteeList.isEmpty() ? null : menteeList;
	}
}
