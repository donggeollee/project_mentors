package com.tje.mentors.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import com.tje.mentors.model.DetailLessonView;
import com.tje.mentors.model.Lesson;
import com.tje.mentors.model.LessonApply;
import com.tje.mentors.setting.PagingInfo;

@Repository
public class LessonDAO {
	
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private PagingInfo pagingInfo;
	@Autowired
	public LessonDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	private class LessonRowMapper implements RowMapper<Lesson> {
		public Lesson mapRow(ResultSet rs, int rowNum) throws SQLException {
			Lesson obj = new Lesson(
					rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4),
					rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getInt(9),
					rs.getInt(10), rs.getString(11), rs.getDouble(12),
					rs.getInt(13), rs.getInt(14), rs.getDate(15));
			return obj;
		}
	}
	
	private class LessonIdMapper implements RowMapper<Lesson> {
		public Lesson mapRow(ResultSet rs, int rowNum) throws SQLException {
			Lesson obj = new Lesson(
					rs.getInt("lesson_id"));
			return obj;
		}
	}
	
	// 멘토가 레슨 등록했을 때 
	public int insert(Lesson obj) {
		
		String query = "insert into lesson values (0,?,?,?,?,?,?,?,?,?,?,0,0,0,now())";
		KeyHolder keyHolder = new GeneratedKeyHolder();
		this.jdbcTemplate.update(new PreparedStatementCreator() {
			
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				// TODO Auto-generated method stub
				PreparedStatement pstmt = con.prepareStatement(query, new String[] {"lesson_id"});
				pstmt.setInt(1, obj.getMentor_id());
				pstmt.setString(2, obj.getCategory_big());
				pstmt.setString(3, obj.getCategory_small());
				pstmt.setString(4, obj.getLocation());
				pstmt.setString(5, obj.getTitle());
				pstmt.setString(6, obj.getLesson_info());
				pstmt.setString(7, obj.getCurriculum());
				pstmt.setInt(8, obj.getPrice());
				pstmt.setInt(9, obj.getTotal_round());
				pstmt.setString(10, obj.getLesson_thumnail());
				return pstmt;
			}
		}, keyHolder);
		
		return keyHolder.getKey().intValue();

	} 
	
		// 멘토가 레슨 수정했을 때 
	public int update(Lesson obj) {
		
		String query = "update lesson set category_big=?, category_small=?, location=?, title=?, lesson_info=?, curriculum=?, price=?, total_round=? where lesson_id = ?;";
		return this.jdbcTemplate.update(
				query,
				obj.getCategory_big(),
				obj.getCategory_small(),
				obj.getLocation(),
				obj.getTitle(),
				obj.getLesson_info(),
				obj.getCurriculum(),
				obj.getPrice(),
				obj.getTotal_round(),
				obj.getLesson_id());
		
	} 
	
	// android lesson search repository
	public Object search(String str) {
		List<Lesson> value = this.jdbcTemplate.query(
				"select * from lesson where title like ? or category_big like ? or category_small like ?",
				new LessonRowMapper(),
				"%"+str.trim()+"%","%"+str.trim()+"%","%"+str.trim()+"%"
				);
		return value.isEmpty()? null:value;
	}
	

	// 메인화면 리뷰 평점 순으로 정렬한 레슨 리스트 3개(평점 순으로 바꿔도 됨)
	public Object mainLessonListOrderByScore() {
			List<Lesson> value = this.jdbcTemplate.query(
				"select * from lesson order by avg_score desc limit 0,3",
				new LessonRowMapper());
		return value.isEmpty() ? null : value;
	}
		
	// 메인에서 레슨 탐색할 때
	public Object selectAllByCategory(Lesson obj) {
		List<Lesson> value = this.jdbcTemplate.query(
				"select * from lesson where category_big = ? and category_small = ? ",
				new LessonRowMapper(),
				obj.getCategory_big(),obj.getCategory_small());
		
		return value.isEmpty() ? null : value;
	}
	
	// 대분류 선택해서 레슨 리스트 받을 때
	public Object selectAllByBigCategory(Lesson obj) {
		List<Lesson> value = this.jdbcTemplate.query(
				"select * from lesson where category_big = ?",
				new LessonRowMapper(),obj.getCategory_big());
		
		return value.isEmpty() ? null : value;
	}
	 
	  // 대분류 선택해서 레슨 리스트 받은 후, 사용자의 선택에 선택에 따라 필터 검색이 이루어질 때 
	  public Object selectAllByFilter(
			  String bigCategory, ArrayList<String> smallCategories,
			  String location ,String align, int lessonPage) {
			 
		  List<Lesson> value = null;
		if( align.equals("write_date desc")) {
		
			String[] arrAlign = align.split(" ");
			  if( smallCategories.size() == 0 ) {
				value = new ArrayList<Lesson>();
			  } else if (smallCategories.size() == 1){ 
				  value = this.jdbcTemplate.query( 
						"select * from lesson where category_small = ?"
						+ " and location like ? order by write_date desc limit ?, ?",
						new LessonRowMapper(), 
						smallCategories.get(0), "%"+location+"%",
						(lessonPage - 1) * pagingInfo.getPagingSize(), pagingInfo.getPagingSize());
			  } else if (smallCategories.size() == 2){
				  value = this.jdbcTemplate.query(
						"select * from lesson where (category_small = ? or category_small = ?)"
						+ " and location like ? order by write_date desc limit ?, ?",
						new LessonRowMapper(),
						smallCategories.get(0),smallCategories.get(1) ,"%"+location+"%",
						(lessonPage - 1) * pagingInfo.getPagingSize(), pagingInfo.getPagingSize());
			  } else if (smallCategories.size() == 3){
				  value = this.jdbcTemplate.query(
						"select * from lesson where (category_small = ? or category_small = ? or category_small = ?)"
						+ " and location like ? order by write_date desc limit ?, ?",
						new LessonRowMapper(),
						smallCategories.get(0),smallCategories.get(1),smallCategories.get(2)
								,"%"+location+"%",
						(lessonPage - 1) * pagingInfo.getPagingSize(), pagingInfo.getPagingSize());
			  } else if (smallCategories.size() == 4){
				  value = this.jdbcTemplate.query(
						"select * from lesson where (category_small = ? or category_small = ? or category_small = ? or category_small = ?)"
						+ " and location like ? order by write_date desc limit ?, ?",
						new LessonRowMapper(),
						smallCategories.get(0),smallCategories.get(1),smallCategories.get(2),smallCategories.get(3)
								,"%"+location+"%", 
						(lessonPage - 1) * pagingInfo.getPagingSize(), pagingInfo.getPagingSize());
			  } else if (smallCategories.size() == 5){
				  value = this.jdbcTemplate.query(
						"select * from lesson where (category_small = ? or category_small = ? or category_small = ? or category_small = ? or category_small = ?)"
						+ " and location like ? order by write_date desc limit ?, ?",
						new LessonRowMapper(),
						smallCategories.get(0),smallCategories.get(1),smallCategories.get(2),smallCategories.get(3),smallCategories.get(4)
								,"%"+location+"%",
						(lessonPage - 1) * pagingInfo.getPagingSize(), pagingInfo.getPagingSize());
			  }
		  } else if ( align.equals("write_date") ) {
			
			  if( smallCategories.size() == 0 ) {
					value = new ArrayList<Lesson>();
				  } else if (smallCategories.size() == 1){
					  value = this.jdbcTemplate.query( 
							"select * from lesson where category_small = ?"
							+ " and location like ? order by write_date limit ?, ?",
							new LessonRowMapper(),
							smallCategories.get(0), "%"+location+"%",
							(lessonPage - 1) * pagingInfo.getPagingSize(), pagingInfo.getPagingSize());
				  } else if (smallCategories.size() == 2){
					  value = this.jdbcTemplate.query(
							"select * from lesson where (category_small = ? or category_small = ?)"
							+ " and location like ? order by write_date limit ?, ?",
							new LessonRowMapper(),
							smallCategories.get(0),smallCategories.get(1) ,"%"+location+"%",
							(lessonPage - 1) * pagingInfo.getPagingSize(), pagingInfo.getPagingSize());
				  } else if (smallCategories.size() == 3){
					  value = this.jdbcTemplate.query(
							"select * from lesson where (category_small = ? or category_small = ? or category_small = ?)"
							+ " and location like ? order by write_date limit ?, ?",
							new LessonRowMapper(),
							smallCategories.get(0),smallCategories.get(1),smallCategories.get(2)
									,"%"+location+"%", 
							(lessonPage - 1) * pagingInfo.getPagingSize(), pagingInfo.getPagingSize());
				  } else if (smallCategories.size() == 4){
					  value = this.jdbcTemplate.query(
							"select * from lesson where (category_small = ? or category_small = ? or category_small = ? or category_small = ?)"
							+ " and location like ? order by write_date limit ?, ?",
							new LessonRowMapper(),
							smallCategories.get(0),smallCategories.get(1),smallCategories.get(2),smallCategories.get(3)
									,"%"+location+"%", 
							(lessonPage - 1) * pagingInfo.getPagingSize(), pagingInfo.getPagingSize());
				  } else if (smallCategories.size() == 5){
					  value = this.jdbcTemplate.query(
							"select * from lesson where (category_small = ? or category_small = ? or category_small = ? or category_small = ? or category_small = ?)"
							+ " and location like ? order by write_date limit ?, ?",
							new LessonRowMapper(),
							smallCategories.get(0),smallCategories.get(1),smallCategories.get(2),smallCategories.get(3),smallCategories.get(4)
									,"%"+location+"%", 
							(lessonPage - 1) * pagingInfo.getPagingSize(), pagingInfo.getPagingSize());
				  }
		  } else if ( align.equals("avg_score desc") ) {
		
			  if( smallCategories.size() == 0 ) {
					value = new ArrayList<Lesson>();
				  } else if (smallCategories.size() == 1){
					  value = this.jdbcTemplate.query( 
							"select * from lesson where category_small = ?"
							+ " and location like ? order by avg_score desc limit ?, ?",
							new LessonRowMapper(),
							smallCategories.get(0), "%"+location+"%",
							(lessonPage - 1) * pagingInfo.getPagingSize(), pagingInfo.getPagingSize());
				  } else if (smallCategories.size() == 2){
					  value = this.jdbcTemplate.query(
							"select * from lesson where (category_small = ? or category_small = ?)"
							+ " and location like ? order by avg_score desc limit ?, ?",
							new LessonRowMapper(),
							smallCategories.get(0),smallCategories.get(1) ,"%"+location+"%", 
							(lessonPage - 1) * pagingInfo.getPagingSize(), pagingInfo.getPagingSize());
				  } else if (smallCategories.size() == 3){
					  value = this.jdbcTemplate.query(
							"select * from lesson where (category_small = ? or category_small = ? or category_small = ?)"
							+ " and location like ? order by avg_score desc limit ?, ?",
							new LessonRowMapper(),
							smallCategories.get(0),smallCategories.get(1),smallCategories.get(2)
									,"%"+location+"%", 
							(lessonPage - 1) * pagingInfo.getPagingSize(), pagingInfo.getPagingSize());
				  } else if (smallCategories.size() == 4){
					  value = this.jdbcTemplate.query(
							"select * from lesson where (category_small = ? or category_small = ? or category_small = ? or category_small = ?)"
							+ " and location like ? order by avg_score desc limit ?, ?",
							new LessonRowMapper(),
							smallCategories.get(0),smallCategories.get(1),smallCategories.get(2),smallCategories.get(3)
									,"%"+location+"%",
							(lessonPage - 1) * pagingInfo.getPagingSize(), pagingInfo.getPagingSize());
				  } else if (smallCategories.size() == 5){
					  value = this.jdbcTemplate.query(
							"select * from lesson where (category_small = ? or category_small = ? or category_small = ? or category_small = ? or category_small = ?)"
							+ " and location like ? order by avg_score desc limit ?, ?",
							new LessonRowMapper(),
							smallCategories.get(0),smallCategories.get(1),smallCategories.get(2),smallCategories.get(3),smallCategories.get(4)
									,"%"+location+"%", 
							(lessonPage - 1) * pagingInfo.getPagingSize(), pagingInfo.getPagingSize());
				  }
		  } else if ( align.equals("avg_score") ) {
			
			  if( smallCategories.size() == 0 ) {
					value = new ArrayList<Lesson>();
				  } else if (smallCategories.size() == 1){
					  value = this.jdbcTemplate.query( 
							"select * from lesson where category_small = ?"
							+ " and location like ? order by avg_score limit ?, ?",
							new LessonRowMapper(),
							smallCategories.get(0), "%"+location+"%",
							(lessonPage - 1) * pagingInfo.getPagingSize(), pagingInfo.getPagingSize());
				  } else if (smallCategories.size() == 2){
					  value = this.jdbcTemplate.query(
							"select * from lesson where (category_small = ? or category_small = ?)"
							+ " and location like ? order by avg_score limit ?, ?",
							new LessonRowMapper(),
							smallCategories.get(0),smallCategories.get(1) ,"%"+location+"%",
							(lessonPage - 1) * pagingInfo.getPagingSize(), pagingInfo.getPagingSize());
				  } else if (smallCategories.size() == 3){
					  value = this.jdbcTemplate.query(
							"select * from lesson where (category_small = ? or category_small = ? or category_small = ?)"
							+ " and location like ? order by avg_score limit ?, ?",
							new LessonRowMapper(),
							smallCategories.get(0),smallCategories.get(1),smallCategories.get(2)
									,"%"+location+"%",
							(lessonPage - 1) * pagingInfo.getPagingSize(), pagingInfo.getPagingSize());
				  } else if (smallCategories.size() == 4){
					  value = this.jdbcTemplate.query(
							"select * from lesson where (category_small = ? or category_small = ? or category_small = ? or category_small = ?)"
							+ " and location like ? order by avg_score limit ?, ?",
							new LessonRowMapper(),
							smallCategories.get(0),smallCategories.get(1),smallCategories.get(2),smallCategories.get(3)
									,"%"+location+"%",
							(lessonPage - 1) * pagingInfo.getPagingSize(), pagingInfo.getPagingSize());
				  } else if (smallCategories.size() == 5){
					  value = this.jdbcTemplate.query(
							"select * from lesson where (category_small = ? or category_small = ? or category_small = ? or category_small = ? or category_small = ?)"
							+ " and location like ? order by avg_score limit ?, ?",
							new LessonRowMapper(),
							smallCategories.get(0),smallCategories.get(1),smallCategories.get(2),smallCategories.get(3),smallCategories.get(4)
									,"%"+location+"%",
							(lessonPage - 1) * pagingInfo.getPagingSize(), pagingInfo.getPagingSize());
				  }
		  }
		  return value.isEmpty() ? null : value;
	  }
	 		
	  // 필터나 조건에 맞는 전체 결과 수 조회, 페이징 전체 레슨 수 구하기 위해: 카테고리, location
		public int selectFilterCount( 
				 ArrayList<String> smallCateList,String location) {
			int result = 0;
			if ( smallCateList.size() == 1) {
				result = this.jdbcTemplate.queryForObject(
					"select count(*) from lesson where category_small = ? "
					+ "and location like ?",
					Integer.class, 
					smallCateList.get(0), "%"+location+"%");
			} else if (smallCateList.size() == 2) {
				result = this.jdbcTemplate.queryForObject(
					"select count(*) from lesson where (category_small = ? or category_small = ?)"
					+ "and location like ?",
					Integer.class,
					smallCateList.get(0),smallCateList.get(1),
					 "%"+location+"%");
			} else if (smallCateList.size() == 3) {
			result = this.jdbcTemplate.queryForObject(
					"select count(*) from lesson where (category_small = ? or category_small = ? or category_small = ?)"
					+ "and location like ?",
					Integer.class,
					smallCateList.get(0),smallCateList.get(1),smallCateList.get(2),
					 "%"+location+"%");
			} else if (smallCateList.size() == 4) {
			result = this.jdbcTemplate.queryForObject(
					"select count(*) from lesson where (category_small = ? or category_small = ? or category_small = ? or category_small = ?)"
					+ "and location like ?",
					Integer.class,
					smallCateList.get(0),smallCateList.get(1),smallCateList.get(2),smallCateList.get(3),
					 "%"+location+"%");
			} else if (smallCateList.size() == 5) {
				result = this.jdbcTemplate.queryForObject(
					"select count(*) from lesson where (category_small = ? or category_small = ? or category_small = ? or category_small = ? or category_small = ?) "
					+ "and location like ?",
					Integer.class,
					smallCateList.get(0),smallCateList.get(1),smallCateList.get(2),smallCateList.get(3),smallCateList.get(4),
					 "%"+location+"%");
			} 
			return result;
		}
		
		// 지은 추가 (멘토 마이 페이지 - 내가 작성한 레슨의 목록 카운트)
		public int selectLessonCnt(int mentor_id) {
			return this.jdbcTemplate.queryForObject(
					"select count(*) from lesson where mentor_id = ?",Integer.class,
					mentor_id);
		}
		
		/* 지은 - DAO 추가 부분 - selectAllByMentorId
		 멘토가 작성한 글 목록 확인 
		 */
		public Object selectAllByMentorId(Lesson obj, int page) {
			
			List<Lesson> result = this.jdbcTemplate.query(
					"select * from lesson where mentor_id = ? limit ?,?", 
					new LessonRowMapper(), obj.getMentor_id(),
					(page-1)*this.pagingInfo.getPagingSize(),
					this.pagingInfo.getPagingSize());
			
			return result.isEmpty() ? null : result;
		}
		
		//* 지은 - 추가 (멘토 마이페이지 - 내가 작성한 레슨 번호를 가져오기) *//
		public Object selectByMentor(Lesson obj) {
			return this.jdbcTemplate.query(
					"select distinct lesson_id  from lesson where mentor_id = ?", 
					new LessonIdMapper(),obj.getMentor_id());
		}
		
		public int delete(int lesson_id) {
			return this.jdbcTemplate.update("delete from lesson where lesson_id = ?", lesson_id);
		}
		
		// *jieun add - 0805
		// mentor my page - mentorig accept event -> mentee_count +1 add

		public int menteeCntupdate(int menteeCnt, int lesson_id) {
			return this.jdbcTemplate.update(
					"update lesson set mentee_count = ? where lesson_id = ?", 
					menteeCnt,lesson_id);
		}
		
		public int updateLessonThumnail(Lesson obj) {
			return this.jdbcTemplate.update(
					"update lesson set lesson_thumnail = ? where lesson_id = ?", 
					obj.getLesson_thumnail(), obj.getLesson_id());
		
		}
		
		
		public Object selectByAndroid(Lesson model) {
	         List<Lesson> lessonList = null;
	            
	         lessonList  = this.jdbcTemplate.query("select * from lesson where category_big = ?", 
	               new LessonRowMapper(),model.getCategory_big());
	         
	         return lessonList;
	      }
		
	
}
