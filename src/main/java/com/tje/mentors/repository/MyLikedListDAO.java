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
import com.tje.mentors.setting.PagingInfo;
import com.tje.mentors.setting.PagingInfoByFour;

@Repository
public class MyLikedListDAO {
	
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private PagingInfoByFour pagingInfoByFour;
	
	
	@Autowired
	public MyLikedListDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	class MyLikedListRowMapper implements RowMapper<MyLikedList> {
		@Override
		public MyLikedList mapRow(ResultSet rs, int rowNum) throws SQLException {
			MyLikedList obj = new MyLikedList(
					rs.getInt(1), 
					rs.getInt(2), 
					rs.getInt(3),
					rs.getString(4),
					rs.getString(5),
					rs.getString(6),
					rs.getString(7),
					rs.getDouble(8),
					rs.getInt(9)
					);
			return obj;
		}
	}
	
	public Object selectAllDesc(int mentee_id,int page) {
		List<MyLikedList> result = jdbcTemplate.query(
				"select * from mylikedlist where mentee_id = ? order by like_id desc limit ?,?", 
				new MyLikedListRowMapper(), mentee_id,
				(page - 1) * pagingInfoByFour.getPagingSize(), pagingInfoByFour.getPagingSize());
		
		return result;
	}
	
	public Object selectAllAsc(int mentee_id,int page) {
		List<MyLikedList> result = jdbcTemplate.query(
				"select * from mylikedlist where mentee_id = ? order by like_id limit ?,?", 
				new MyLikedListRowMapper(), mentee_id,
				(page - 1) * pagingInfoByFour.getPagingSize(), pagingInfoByFour.getPagingSize());
		
		return result;
	}
	
	public Integer selectLikedCount(int mentee_id) {
		try {
			return this.jdbcTemplate.queryForObject(
					"select count(*) from liketable where mentee_id = ?",
					Integer.class, mentee_id);
		} catch (Exception e) {
			return null;
		}
		
	}
	
	
	
	
}
