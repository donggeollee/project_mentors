package com.tje.mentors.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.tje.mentors.model.ChattingAlarmView;

public class ChattingAlarmViewDAO {
	private JdbcTemplate jdbcTemplate;

	public ChattingAlarmViewDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	class ChattingAlarmViewRowMapper implements RowMapper<ChattingAlarmView> {

		@Override
		public ChattingAlarmView mapRow(ResultSet rs, int rowNum) throws SQLException {
			ChattingAlarmView chattingAlarmView = new ChattingAlarmView(rs.getString("sender"),
					rs.getString("receiver"), rs.getDate("write_date"));
			return chattingAlarmView;
		}
	}

	public Object selectByReceiver(ChattingAlarmView chattingAlarmView) {
		String query = "select distinct * from chattingalarmview where receiver = ? order by time desc limit(?,?)";
		return this.jdbcTemplate.query(query, new ChattingAlarmViewRowMapper(), chattingAlarmView.getReceiver());
	}
	

}
