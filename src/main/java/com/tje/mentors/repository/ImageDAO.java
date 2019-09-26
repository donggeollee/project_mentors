package com.tje.mentors.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.tje.mentors.model.Image;

@Repository
public class ImageDAO {
	
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public ImageDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	class ImageRowMapper implements RowMapper<Image> {
		@Override
		public Image mapRow(ResultSet rs, int rowNum) throws SQLException {
			Image obj = new Image(
					rs.getInt(1),
					rs.getInt(2),
					rs.getString(3)
					);
			return obj;
		}
	}
	
	public Object select(int lesson_id) {
		System.out.println("레슨ID : " + lesson_id);
		try {
			return this.jdbcTemplate.queryForObject(
					"select * from image where lesson_id = ?", 
					new ImageRowMapper(), lesson_id);
		}catch (Exception e) {
			return null;
		}
	}
	
	public int insert(Image target) {
		return this.jdbcTemplate.update("insert into image values(0,?,?)",target.getLesson_id(), target.getFile_name());
	}
}
