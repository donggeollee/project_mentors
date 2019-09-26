package com.tje.mentors.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.tje.mentors.model.RequestContents;

// 채팅 내용
@Repository
public class RequestContentsDAO {
	private JdbcTemplate jdbcTemplate;
	@Autowired
	public RequestContentsDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	class RequestContentsRowMapper implements RowMapper<RequestContents> {

		@Override
		public RequestContents mapRow(ResultSet rs, int rowNum) throws SQLException {
			RequestContents requestContents = new RequestContents(rs.getInt("chat_id"), rs.getInt("sender"), rs.getString("sender_type"),
					rs.getInt("receiver"), rs.getString("contents"), rs.getDate("write_date"), rs.getInt("read_check"));
			return requestContents;
		}
	}
	
	// chat_id로 메시지 내용 검색
	public List<RequestContents> selectAllById(int chat_id) {
		String query = "select * from request_contents where chat_id = ?";
		try {
			return this.jdbcTemplate.query(query, new RequestContentsRowMapper(), chat_id);
		} catch (DataAccessException e) {
			e.printStackTrace();
			return null;
		}
	}	
	
	// 채팅창에서 전송버튼을 눌렀을때의 레코드 추가
	public int insert(RequestContents requestContents) {
		String query = "insert into request_contents values(?, ?, ?, ?, ?, now(), 0)";
		return this.jdbcTemplate.update(query, requestContents.getChat_id(), requestContents.getSender(), requestContents.getSender_type(), requestContents.getReceiver(), requestContents.getContents());
	}
	
	// 채팅방으로 들어갔을 때 메시지 읽음 처리
	public int read(int chat_id, String sender_type) {
		String query;
		if(sender_type.equals("mentor"))
			query = "update request_contents set read_check = 1 where chat_id = ? and sender_type = 'mentee'";
		else
			query = "update request_contents set read_check = 1 where chat_id = ? and sender_type = 'mentor'";
		return this.jdbcTemplate.update(query, chat_id);
	}
	
	// ??
	public int delete(RequestContents requestContents) {
		String query = "delete from request_contents where chat_id = ?";
		return this.jdbcTemplate.update(query, requestContents.getChat_id());
	}
}
