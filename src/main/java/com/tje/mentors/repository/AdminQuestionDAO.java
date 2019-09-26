package com.tje.mentors.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.tje.mentors.model.*;

// 멘토/멘티가 문의글 작성 시 업데이트 되는 모델 클래스 

// 멘토/멘티 게시글 상세보기 시 화면에 출력되는 모델은 mento/menti를 사용

@Repository
public class AdminQuestionDAO {

	private JdbcTemplate jdbcTemplate;

	@Autowired
	public AdminQuestionDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	class AdminRowMapper implements RowMapper<AdminQuestion> {
		@Override
		public AdminQuestion mapRow(ResultSet rs, int rowNum) throws SQLException {
			AdminQuestion adminQuestion = new AdminQuestion(
					rs.getInt(1), 
					rs.getInt(2),
					rs.getString(3),
					rs.getString(4),
					rs.getString(5),
					rs.getString(6),
					rs.getDate(7));

			return adminQuestion;
		}
	}
		// 세션에 저장되어 있는 멤버 타입을 확인 한 후, 타입에 맞는 문의글을 찾아와야함
		// 멘토/멘티(둘다 상관없이, mento/menti 값을 받아와서 문의글 작성 시 추가)
		public int insert(AdminQuestion model) {
			
			return this.jdbcTemplate.update(
					"insert into admin_question values(null,?,?,?,'N',?,now())",
					model.getSender_id(),model.getTitle(),model.getContent(),
					model.getMember_type());
		}
		
	
		// 관리자가 답변 등록 시 답변등록 체크 여부 update
		public int update(AdminQuestion model) {
			return this.jdbcTemplate.update(
					"update admin_question set reply_ck = 'Y' where admin_req_id = ?",
					model.getAdmin_req_id());
		}
		
		
		
	


}
