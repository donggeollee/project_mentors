package com.tje.mentors.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.tje.mentors.model.MessageSender;

@Repository
public class MessageSenderDAO {
	private JdbcTemplate jdbcTemplate;

	@Autowired
	public MessageSenderDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	class MessageSenderRowMapper implements RowMapper<MessageSender> {

		@Override
		public MessageSender mapRow(ResultSet rs, int rowNum) throws SQLException {
			MessageSender messageSender = new MessageSender(rs.getInt("chat_id"), rs.getString("mentee_name"),
					rs.getString("mentor_name"));
			return messageSender;
		}
	}
	
	

	  public Object recentSenderIsMentee(int mentor_id) {
	      String SQL = "select chat_id, mentee_name, mentor_name, max(write_date) as write_date, count(write_date) as count from chatdetailview "
	      		+ "where mentor_id = ? and sender_type='mentee' and read_check = 0 "
	    		  +"group by chat_id order by max(write_date)";
	    		  
	      return this.jdbcTemplate.query(SQL, new MessageSenderRowMapper(), mentor_id);
	   }


	public Object recentSenderIsMentor(int mentee_id) {
		String SQL = "select chat_id, mentee_name, mentor_name, max(write_date) as write_date, count(write_date) as count from chatdetailview "
	      		+ "where mentee_id = ? and sender_type='mentor' and read_check = 0 "
	    		  +"group by chat_id order by max(write_date)";
		return this.jdbcTemplate.query(SQL, new MessageSenderRowMapper(), mentee_id);
	}
	
	public int unreadCountMentor(int mentor_id) {
		String SQL = "select count(if (read_check=0, 1, null)) from chatdetailview where mentor_id = ? and sender_type='mentee'";
		return this.jdbcTemplate.queryForObject(SQL, Integer.class, mentor_id);
	}
	
	public int unreadCountMentee(int mentee_id) {
		String SQL = "select count(if (read_check=0, 1, null)) from chatdetailview where mentee_id = ? and sender_type='mentor'";
		return this.jdbcTemplate.queryForObject(SQL, Integer.class, mentee_id);
	}

}
