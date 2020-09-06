package com.tje.mentors.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.tje.mentors.model.*;

@Repository
public class AdminAccountDAO {

	private JdbcTemplate jdbcTemplate;

	@Autowired
	public AdminAccountDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	class AdminAccountRowMapper implements RowMapper<AdminAccount> {
		@Override
		public AdminAccount mapRow(ResultSet rs, int rowNum) throws SQLException {
			AdminAccount adminAccount = new AdminAccount(
					rs.getString(1), 
					rs.getString(2));

			return adminAccount;
		}

	}
	
	
	public Object select(){
		
		try {
			
		return this.jdbcTemplate.queryForObject
				("select * from adminaccount",new AdminAccountRowMapper());
		
		}catch (Exception e) {
			System.out.println("22222");
			return null;
		}
	}

}
