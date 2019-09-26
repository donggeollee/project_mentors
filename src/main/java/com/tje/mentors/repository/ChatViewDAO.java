package com.tje.mentors.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.tje.mentors.model.ChatView;

@Repository
public class ChatViewDAO {
	private JdbcTemplate jdbcTemplate;
	public ChatViewDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	class ChatViewRowMapper implements RowMapper<ChatView> {

		@Override
		public ChatView mapRow(ResultSet rs, int rowNum) throws SQLException {
			ChatView chatView = new ChatView(rs.getInt("chat_id"), rs.getInt("mentor_id"),
					rs.getInt("mentee_id"), rs.getInt("sender"), rs.getInt("receiver"),
					rs.getString("contents"), rs.getDate("write_date"));
			return chatView;
		}
	}
	
	// 채팅방 번호로 채팅 내역 조회
	public Object selectById(ChatView chatView) {
		String query = "select * from chat_view where chat_id = ?";		
		try {
			return this.jdbcTemplate.queryForObject(query, new ChatViewRowMapper(), chatView.getChat_id());
		} catch (DataAccessException e) {
			e.printStackTrace();
			return null;			
		}
	}
	
	
//	public int insert(ChatView chatView) {
//		String query = "insert into chat_view values(?, ?, ?, ?, ?, ?, now())";
//		return this.jdbcTemplate.update(query, chatView.getChat_id(), chatView.getMentor_id(), chatView.getMentee_id(), chatView.getSender(),
//				chatView.getReceiver(), chatView.getContent());
//	}
	
}
