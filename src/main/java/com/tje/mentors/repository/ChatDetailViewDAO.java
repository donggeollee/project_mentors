package com.tje.mentors.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.tje.mentors.model.ChatDetailView;

@Repository
public class ChatDetailViewDAO {
	private JdbcTemplate jdbcTemplate;

	public ChatDetailViewDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	class ChatDetailViewRowMapper implements RowMapper<ChatDetailView> {

		@Override
		public ChatDetailView mapRow(ResultSet rs, int rowNum) throws SQLException {
			ChatDetailView chatView = new ChatDetailView(rs.getInt("chat_id"), rs.getInt("mentor_id"),
					rs.getString("mentor_name"), rs.getInt("mentee_id"), rs.getString("mentee_name"),
					rs.getInt("sender"), rs.getString("sender_type"), rs.getInt("receiver"), rs.getString("contents"),
					rs.getTimestamp("write_date").toLocalDateTime(), rs.getInt("read_check"));
			return chatView;
		}
	}
	
	class ChatDetailViewWithUnreadCountRowMapper implements RowMapper<ChatDetailView> {

		@Override
		public ChatDetailView mapRow(ResultSet rs, int rowNum) throws SQLException {
			ChatDetailView chatView = new ChatDetailView(rs.getInt("chat_id"), rs.getInt("mentor_id"),
					rs.getString("mentor_name"), rs.getInt("mentee_id"), rs.getString("mentee_name"),
					rs.getInt("sender"), rs.getString("sender_type"), rs.getInt("receiver"), rs.getString("contents"),
					rs.getTimestamp("write_date").toLocalDateTime(), 0, rs.getInt("unread_count"));
			return chatView;
		}
	}

	// 채팅방 번호로 채팅 내역 조회
	public Object selectById(int chat_id) {
		String query = "select * from chatdetailview where chat_id = ?";
			return this.jdbcTemplate.query(query, new ChatDetailViewRowMapper(), chat_id);
		
	}
	
	// 멘토일 때 나와 채팅중인 목록 조회
	public Object selectByMentorId(int mentor_id) {
		String query = "select c.chat_id as chat_id, mentor_id, mentor_name, mentee_id, mentee_name, sender, sender_type, receiver, contents, write_date, unread_count "
				+ "from chatdetailview c inner join ( select chat_id, count(if (read_check = 0 and sender_type='mentee', 1, null) ) as unread_count "
				+ "from chatdetailview where mentor_id = ? group by chat_id ) d where c.chat_id = d.chat_id and write_date in (select max(write_date)"
				+ "from chatdetailview where mentor_id = ? group by chat_id ) order by write_date desc";
			return this.jdbcTemplate.query(query, new ChatDetailViewWithUnreadCountRowMapper(), mentor_id, mentor_id);
	}
	
	// 멘티일 때 나와 채팅중인 목록 조회
	public Object selectByMenteeId(int mentee_id) {
		String query = "select c.chat_id as chat_id, mentor_id, mentor_name, mentee_id, mentee_name, sender, sender_type, receiver, contents, write_date, unread_count "
				+ "from chatdetailview c inner join ( select chat_id, count(if (read_check = 0 and sender_type='mentor', 1, null) ) as unread_count "
				+ "from chatdetailview where mentee_id = ? group by chat_id ) d where c.chat_id = d.chat_id and write_date in (select max(write_date)"
				+ "from chatdetailview where mentee_id = ? group by chat_id ) order by write_date desc";
			return this.jdbcTemplate.query(query, new ChatDetailViewWithUnreadCountRowMapper(), mentee_id, mentee_id);
	}
	

	
//	public int insert(ChatView chatView) {
//		String query = "insert into chat_view values(?, ?, ?, ?, ?, ?, now())";
//		return this.jdbcTemplate.update(query, chatView.getChat_id(), chatView.getMentor_id(), chatView.getMentee_id(), chatView.getSender(),
//				chatView.getReceiver(), chatView.getContent());
//	}
	
}
