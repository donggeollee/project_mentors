package com.tje.mentors.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import com.tje.mentors.model.RequestChat;

@Repository
public class RequestChatDAO {
	private JdbcTemplate jdbcTemplate;

	@Autowired
	public RequestChatDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	class RequestChatRowMapper implements RowMapper<RequestChat> {

		@Override
		public RequestChat mapRow(ResultSet rs, int rowNum) throws SQLException {
			RequestChat requestChat = new RequestChat(rs.getInt("chat_id"), rs.getInt("mentee_id"),
					rs.getInt("mentor_id"));
			return requestChat;
		}
	}

	public Object selectById(RequestChat requestChat) {
		String query = "select * from request_chat where chat_id = ?";		
		try {
			return this.jdbcTemplate.queryForObject(query, new RequestChatRowMapper(), requestChat.getChat_id());
		} catch (DataAccessException e) {
			e.printStackTrace();
			return null;			
		}
	}
	
	public Object selectByMentee(RequestChat requestChat) {
		String query = "select * from request_chat where mentee_id = ?";
		return this.jdbcTemplate.query(query, new RequestChatRowMapper(), requestChat.getMentee_id());
	}
	
	// 레슨상세보기에서 멘토에게 문의하기를 눌렀을 때 멘티id와 멘토id로 채팅방 조회
	// 채팅방이 존재하지 않아서 DataAccessException이 발생하면 insert() 실행
	public Object selectByMenteeAndMentor(RequestChat requestChat) {
		String query = "select * from request_chat where mentee_id = ? and mentor_id = ?";
		try {
			return this.jdbcTemplate.queryForObject(query, new RequestChatRowMapper(), requestChat.getMentee_id(), requestChat.getMentor_id());
		} catch (DataAccessException e) {
			return insert(requestChat);
		}
	}
	
	// 게시글 상세보기에서 문의하기를 눌렀을때 레코드 추가
	public int insert(RequestChat requestChat) {
		String query = "insert into request_chat values(0, ?, ?)";
		KeyHolder keyHolder = new GeneratedKeyHolder();
		this.jdbcTemplate.update(new PreparedStatementCreator() {
			
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pstmt = con.prepareStatement(query, new String[] {"chat_id"});
				pstmt.setInt(1, requestChat.getMentee_id());
				pstmt.setInt(2, requestChat.getMentor_id());
				return pstmt;
			}
		}, keyHolder);
		return keyHolder.getKey().intValue();
	}
	
	// ?
	public int delete(RequestChat requestChat) {
		String query = "delete from request_chat where chat_id = ?";
		return this.jdbcTemplate.update(query, requestChat.getChat_id());
	}
}
