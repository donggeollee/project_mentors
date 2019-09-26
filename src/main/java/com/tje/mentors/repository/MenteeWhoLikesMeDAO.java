package com.tje.mentors.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.tje.mentors.model.*;
import com.tje.mentors.setting.PagingInfoByTen;

@Repository
public class MenteeWhoLikesMeDAO {
	
	@Autowired
	private PagingInfoByTen pagingInfo;
	
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public MenteeWhoLikesMeDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	class MenteeWhoLikesMeRowMapper implements RowMapper<MenteeWhoLikesMe> {
		@Override
		public MenteeWhoLikesMe mapRow(ResultSet rs, int rowNum) throws SQLException {
			
			MenteeWhoLikesMe obj = new MenteeWhoLikesMe(
					rs.getInt(1), rs.getInt(2), rs.getInt(3), 
					rs.getString(4), rs.getString(5), rs.getString(6), rs.getInt(7));
			
			return obj;
		}
	}
	
	public Object select(Mentor mentor) {
		return this.jdbcTemplate.query(
				"select * from MenteeWhoLikesMe where mentor_id = ?",
				new MenteeWhoLikesMeRowMapper(), mentor.getMentor_id());
	}
	
	/* 지은 추가 수정사항 - 이름 검색 */
	public Object selectByName(MenteeWhoLikesMe model, int page) {
		return this.jdbcTemplate.query(
				"select * from MenteeWhoLikesMe where mentor_id = ? and mentee_name like ? limit ?,?",
				new MenteeWhoLikesMeRowMapper(), model.getMentor_id(), "%"+model.getMentee_name()+"%",
				(page-1)*this.pagingInfo.getPagingSize(),
				this.pagingInfo.getPagingSize());
	}
	

	 //지은 추가 수정사항 - 이름 검색 페이징 카운트  페이징 처리
	public Integer selectSearchByNameCount(MenteeWhoLikesMe model) {
		return this.jdbcTemplate.queryForObject(
				"select count(*) from MenteeWhoLikesMe where mentor_id = ? and mentee_name like ? ;",
				Integer.class,model.getMentor_id(), "%"+model.getMentee_name()+"%");
	}
	
	
	
	/* 지은 추가 수정사항 - 페이징 카운트 */
	public Integer selectByIDCount(MenteeWhoLikesMe model) {
		return this.jdbcTemplate.queryForObject(
				"select count(*) from MenteeWhoLikesMe where mentor_id = ?;",
				Integer.class,model.getMentor_id());
	}
	
	/* 지은 추가 수정사항 - 페이징 처리 - 정렬 (찜 최신 순 / 기본값)*/
	public Object selectByMentee(int page, MenteeWhoLikesMe model) {
		List<MenteeWhoLikesMe> result = this.jdbcTemplate.query(
				"select * from MenteeWhoLikesMe where mentor_id = ? order by like_id desc limit ?,?",
				new MenteeWhoLikesMeRowMapper(), model.getMentor_id(), 
				(page-1)*this.pagingInfo.getPagingSize(),
				this.pagingInfo.getPagingSize());
		
		System.out.println((page-1)*this.pagingInfo.getPagingSize());
		System.out.println(this.pagingInfo.getPagingSize());
		return result.isEmpty() ? null : result;
	}
	
	/* 지은 추가 수정사항 - 페이징 처리 - 정렬 (찜 과거 순) */
	public Object selectByMenteeAsc(int page, MenteeWhoLikesMe model) {
		List<MenteeWhoLikesMe> result = this.jdbcTemplate.query(
				"select * from MenteeWhoLikesMe where mentor_id = ? order by like_id asc limit ?,?",
				new MenteeWhoLikesMeRowMapper(), model.getMentor_id(), 
				(page-1)*this.pagingInfo.getPagingSize(),
				this.pagingInfo.getPagingSize());
		
		return result.isEmpty() ? null : result;
	}	
	
	/* 지은 추가 수정사항 - 페이징 처리  - 정렬 (클래스명 순) */
	public Object selectByMenteeOrderByClass(int page, MenteeWhoLikesMe model) {
		List<MenteeWhoLikesMe> result = this.jdbcTemplate.query(
				"select * from MenteeWhoLikesMe where mentor_id = ? order by title asc limit ?,?",
				new MenteeWhoLikesMeRowMapper(), model.getMentor_id(), 
				(page-1)*this.pagingInfo.getPagingSize(),
				this.pagingInfo.getPagingSize());
		
		return result.isEmpty() ? null : result;
	}
	
	
	
	/* 지은 추가 수정사항 - 정렬 (이름순) */
	public Object selectByMenteeName(int page, MenteeWhoLikesMe model) {
		List<MenteeWhoLikesMe> result = this.jdbcTemplate.query(
				"select * from MenteeWhoLikesMe where mentor_id = ? order by mentee_name limit ?,?",
				new MenteeWhoLikesMeRowMapper(), model.getMentor_id(),
				(page-1)*this.pagingInfo.getPagingSize(),
				this.pagingInfo.getPagingSize());
		
		return result.isEmpty() ? null : result;
	}
	
	
}
