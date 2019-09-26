package com.tje.mentors.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.tje.mentors.model.*;
import com.tje.mentors.services.CategorySearchService;
import com.tje.mentors.services.DetailLessonSearchService;
import com.tje.mentors.services.ImageInsertService;
import com.tje.mentors.services.ImageSearchByLessonService;
import com.tje.mentors.services.LessonFilterCountService;
import com.tje.mentors.services.LessonListFilterService;
import com.tje.mentors.services.LessonListForAndroidService;
import com.tje.mentors.services.LikeCheckService;
import com.tje.mentors.services.LikeCheckService;
import com.tje.mentors.services.LessonApplyInsertService;
import com.tje.mentors.services.LikeListSearchByMenteeService;
import com.tje.mentors.services.MenteeSearchByIdService;
import com.tje.mentors.services.MentorSearchByIdService;
import com.tje.mentors.services.ReviewSearchByLessonIDService;
import com.tje.mentors.services.SmallCategorySearchService;
import com.tje.mentors.setting.PagingInfo;
import com.tje.mentors.utils.UploadFileUtils;

@Controller
public class LessonController {

	
	@Autowired
	private CategorySearchService csService;
	@Autowired
	private LessonListFilterService llfService;
	@Autowired
	private LessonFilterCountService lfcService;

	@Autowired
	private PagingInfo pagingInfo;

	@Autowired
	private DetailLessonSearchService detailLessonSearchService;

	@Autowired
	private MentorSearchByIdService mentorSearchByIdService;

	@Autowired
	private ImageSearchByLessonService imageSearchByLessonService;

	@Autowired
	private ReviewSearchByLessonIDService reviewSearchByLessonIDService;

	@Autowired
	private LikeCheckService lcService;

	@Autowired
	private LikeListSearchByMenteeService llsmService;

	@Autowired
	private MenteeSearchByIdService menteeSearchByIdService;

	@Autowired
	private LessonApplyInsertService lessonApplyInsertService;
	
	@Autowired
	private ImageInsertService imageInsertService;
	
	@Autowired
	private LessonListForAndroidService llfaService;
	
	@Autowired // 硫섑넗 ?占쎌뒯 ?占쎌꽦 ?占쎈퉬?? - ?占쏙옙? 移댄뀒怨좊━ 寃?? ?占쎈퉬??
	private SmallCategorySearchService smallCategorySearchService;

	@GetMapping("/lesson/choiceBigCate")
	public String choiceBigCateForm() {
		return "lesson/choice_big_cate";
	}

	// 처음에 게시판 리스트에 들어왔을 때 
	// 카테고리 다 클릭
	// 지역 전체
	// 페이지 1
	// 정렬 최신순

	@GetMapping("/lesson/lessonList/{bigCate}")
	public String lessonListNoPageIT(@PathVariable(value = "bigCate") String bigCate, HttpSession session,
			Model model) {
		// model에 넣어줄 값
		HashMap<String, Object> values = new HashMap<String, Object>();

		// like 세팅
		Mentee mentee = null;
		List<LikeTable> likeList = null;
		if (session.getAttribute("memberType") != null && session.getAttribute("loginMember") != null
				&& session.getAttribute("memberType").equals("mentee")) {
			mentee = (Mentee) session.getAttribute("loginMember");
			likeList = (List<LikeTable>) llsmService.service(mentee);
		}

		values.put("likeList", likeList);

		// 카테고리 목록 생
		String smallCates = (String) csService.service(bigCate);
		String[] arrSmallCate = smallCates.split(",");
		// 검색 dao에 들어가는 카테고리 개수가 유동적이어서 list로 변환
		ArrayList<String> cateList = new ArrayList<String>();
		for (String smallCate : arrSmallCate) {
			cateList.add(smallCate);
		}
		// 필터에 맞는 게시글 리스트 생성 ( 카테고리, 지역, 정렬, 페이지 )
		String location = "all all";
		String[] daoLoc = location.split(" ");

		HashMap<String, Integer> pageMap = pageSetting(1, smallCates, daoLoc);

		List<Lesson> lessonList = (List<Lesson>) llfService.service(bigCate, cateList, daoLoc, "theLatest", 1);

		values.put("bigCate", bigCate);
		values.put("arrSmallCate", arrSmallCate);
		values.put("lessonList", lessonList); 
		values.put("pageMap", pageMap);
		values.put("first", true);
		model.addAttribute("values", values);
		return "lesson/lesson_list";
	}

	// 카테고리 설정하고 페이지클릭하여 들어왔을 때
	// 지역찾기 했을 때
	@GetMapping("/lesson/lessonList/{bigCate}/{page}")
	public String getMethodForm(@PathVariable(value = "bigCate") String bigCate, @PathVariable(value = "page") int page,
			@RequestParam("alignment") String alignmentParam,
			@RequestParam("checkedSmallCate") String checkedSmallCateParam,
			@RequestParam("location") String locationParam, HttpSession session, Model model) {

		HashMap<String, Object> values = new HashMap<String, Object>();

		Mentee mentee = null;
		List<LikeTable> likeList = null;
		if (session.getAttribute("memberType") != null && session.getAttribute("loginMember") != null
				&& session.getAttribute("memberType").equals("mentee")) {
			mentee = (Mentee) session.getAttribute("loginMember");
			likeList = (List<LikeTable>) llsmService.service(mentee);
		}

		values.put("likeList", likeList);

		String arrSamllCate = (String)csService.service(bigCate);

		String checkedSmallCate = checkedSmallCateParam.substring(0, checkedSmallCateParam.length() - 1);
		String[] arrCheckedSmallCate = checkedSmallCate.split(",");
		String[] daoLoc = locationParam.split(",");

		// daoLoc 값이 변환되기 전에 넘김
		String si = new String(daoLoc[0]);
		String gu = new String(daoLoc[1]);
		values.put("si", si);
		values.put("gu", gu);

		for (int i = 0; i < daoLoc.length; i++) {
			if (daoLoc[i].contains("전체"))
				daoLoc[i] = "all";
		}

		ArrayList<String> cateList = new ArrayList<String>();
		for (String smallCate : arrCheckedSmallCate) {
			cateList.add(smallCate);
		}
		HashMap<String, Integer> pageMap = pageSetting(page, checkedSmallCate, daoLoc);

		List<Lesson> lessonList = (List<Lesson>) llfService.service(bigCate, cateList, daoLoc, alignmentParam, page);

		values.put("bigCate", bigCate);
		values.put("arrSmallCate", arrSamllCate);
		values.put("lessonList", lessonList);
		values.put("pageMap", pageMap);
		values.put("first", false);
		// 작은카테고리들, 지역, 정렬이 어떤 것들이 체크되어있었는지 알려줄 값 전달,
		values.put("arrCheckedSmallCate", arrCheckedSmallCate);
		values.put("alignmentParam", alignmentParam);
		model.addAttribute("values", values);
		return "lesson/lesson_list";
	}

	// 카테고리 필터 비동기 방식 
	@ResponseBody
	@PostMapping("/lesson/lessonList/{bigCate}")
	public HashMap<String, Object> ansync(@RequestBody ListFilter listFilter, String bigCate, HttpSession session,
			Model model) {

		HashMap<String, Object> values = new HashMap<String, Object>();

		Mentee mentee = null;
		List<LikeTable> likeList = null;
		if (session.getAttribute("memberType") != null && session.getAttribute("loginMember") != null
				&& session.getAttribute("memberType").equals("mentee")) {
			mentee = (Mentee) session.getAttribute("loginMember");
			likeList = (List<LikeTable>) llsmService.service(mentee);
		}

		values.put("likeList", likeList);

		String daobigCate = bigCate;
		String alignment = listFilter.getAlignment();
		String checkedSmallCate = listFilter.getCheckedSmallCate();
		String location = listFilter.getLocation();
		System.out.println("controller location : " + location);
		String[] daoLoc = location.split(",");

		for (int i = 0; i < daoLoc.length; i++) {
			if (daoLoc[i].contains("전체"))
				daoLoc[i] = "all";
		}
		String smallCates = checkedSmallCate.substring(0, checkedSmallCate.length() - 1);
		String[] arrSmallCate = smallCates.split(",");
		// 검색 dao에 들어가는 카테고리 개수가 유동적이어서 list로 변환
		ArrayList<String> cateList = new ArrayList<String>();
		for (String smallCate : arrSmallCate) {
			cateList.add(smallCate);
		}

		List<Lesson> lessonList = (List<Lesson>) llfService.service(daobigCate, cateList, daoLoc, alignment, 1);

		HashMap<String, Integer> pageMap = pageSetting(1, checkedSmallCate, daoLoc);

		values.put("pageMap", pageMap);
		values.put("lessonList", lessonList);
		return values;
	}

	// 안드로이드 레슨찾기 서버
		@GetMapping("/lesson/lessonListApp/{bigCate}/{smallCate}")
		@ResponseBody
		public Object lessonListApp(
				@PathVariable(value = "bigCate") String bigCate,
				@PathVariable(value = "smallCate") String smallCate,
				HttpSession session ) {
			
			System.out.println("androidApp bigCate : " + bigCate);
			System.out.println("androidApp smallCate: " + smallCate);
			
			HashMap<String, Object> values = new HashMap<String, Object>();

			String[] arrSmallCate = ((String)csService.service(bigCate)).split(","); 
			
			Lesson model = new Lesson();
			model.setCategory_big(bigCate);

			List<Lesson> lessonList = (List<Lesson>) llfaService.service(model);
			
			HashMap<String, ArrayList<Lesson>> eachListbyCateMap = new HashMap<String, ArrayList<Lesson>>();
			
			for ( int i = 0 ; i < arrSmallCate.length ; i++) {
				System.out.println(arrSmallCate[i]);
				
				ArrayList<Lesson> lessonListbyCate = new ArrayList<Lesson>();
				eachListbyCateMap.put(arrSmallCate[i], lessonListbyCate);
			}
			
			for ( int i = 0 ; i < lessonList.size() ; i++) {
				System.out.println(lessonList.size());
				eachListbyCateMap.get(lessonList.get(i).getCategory_small()).add(lessonList.get(i));
			}
			
			values.put("eachListbyCateMap", eachListbyCateMap);
			values.put("smallCate", arrSmallCate);
			values.put("lessonList", lessonList);

			return values;
		}

	
	
	// 페이징 전용 메소드 --> 지역 까지 필요로 할때 : 카테고리, 지역, 페이지클릭
	// 현재 페이지에 다른 startPage,endPage,beforePage,afterPage,... 
	private HashMap<String, Integer> pageSetting(int page, String smallCategories, String[] location) {
		int totalLessonCount = (int) lfcService.service(smallCategories, location);
		return pagingUtil(page, totalLessonCount);

	}

	private HashMap<String, Integer> pagingUtil(int page, int totalLessonCount) {
		HashMap<String, Integer> pageMap = new HashMap<String, Integer>();

		int totalPage = totalLessonCount % pagingInfo.getPagingSize() == 0
				? totalLessonCount / pagingInfo.getPagingSize()
				: totalLessonCount / pagingInfo.getPagingSize() + 1;

		Integer startPage = (page % pagingInfo.getPagingWidth() == 0 ? page - 1 : page) / pagingInfo.getPagingWidth()
				* pagingInfo.getPagingWidth() + 1;
		Integer endPage = startPage + pagingInfo.getPagingWidth() - 1;
		if (endPage > totalPage)
			endPage = totalPage;

		Integer afterPage = endPage < totalPage ? endPage + 1 : -1;
		Integer beforePage = startPage == 1 ? -1 : startPage - 1;

		Integer curPage = page;
		pageMap.put("startPage", startPage);
		pageMap.put("endPage", endPage);
		pageMap.put("afterPage", afterPage);
		pageMap.put("beforePage", beforePage);
		pageMap.put("curPage", curPage);

		return pageMap;
	}

	@GetMapping("/lesson/detail/{lessonNo}")
	public String lessonDetail(@PathVariable(value = "lessonNo", required = true) Integer lessonNo, Model model,
			HttpSession session) {
		Lesson lesson = new Lesson();
		lesson.setLesson_id(lessonNo);

		int mentee_id = 0;
		if (session.getAttribute("memberType") != null && session.getAttribute("loginMember") != null
				&& session.getAttribute("memberType").equals("mentee")) {
			mentee_id = ((Mentee) session.getAttribute("loginMember")).getMentee_id();
		}

		LikeTable likeTable = new LikeTable(0, lessonNo, mentee_id);
		likeTable = (LikeTable) lcService.service(likeTable); // ?�으�??? null ?�옴
		if (likeTable == null) {
			model.addAttribute("like_check", 1);
		} else {
			model.addAttribute("like_check", 0);
		}

		DetailLessonView target = (DetailLessonView) detailLessonSearchService.service(lesson);
		Mentor tmp = new Mentor();
		tmp.setMentor_id(target.getMentor_id());
		Image strFileName = (Image) imageSearchByLessonService.service(target.getLesson_id());
		System.out.println(strFileName);
		
		String[] tempList = null;
		ArrayList<String> imageList = new ArrayList<String>();
		
		
		
		
		if( strFileName != null) {
			tempList = strFileName.getFile_name().split(",");
			
			for ( int i = 0 ; i < tempList.length ; i++ ) {
				imageList.add(tempList[i]);
			}
		} else {
			imageList.add("no_image.jpg");
			
			
		}
		
		
		
		List<Review> reviewList = (List<Review>) reviewSearchByLessonIDService.service(target.getLesson_id());
		ArrayList<Mentee> writerList = new ArrayList<Mentee>();
		if (reviewList != null)
			for (Review item : reviewList) {
				writerList.add((Mentee) menteeSearchByIdService.service(item.getMentee_id()));
			}
		model.addAttribute("targetLesson", target);
		model.addAttribute("targetMentor", (Mentor) mentorSearchByIdService.service(tmp));
		model.addAttribute("targetImageList", imageList);
		model.addAttribute("targetReviewList", reviewList);
		model.addAttribute("targetReviewWriterList", writerList);
		
		return "lesson/detail";
	}

	@GetMapping("/lesson/detailForRestApi/{lessonNo}")
	@ResponseBody
	public Object lessonDetailForAndroid(
			@PathVariable(value = "lessonNo", required = true) Integer lessonNo ) {
		System.out.println(lessonNo + "값 전달 및 매핑메소드 실행");
		
		HashMap<String, Object> values = new HashMap<String, Object>();
		
		Lesson lesson = new Lesson();
		lesson.setLesson_id(lessonNo);


		DetailLessonView target = (DetailLessonView) detailLessonSearchService.service(lesson);
		Mentor tmp = new Mentor();
		tmp.setMentor_id(target.getMentor_id());
		Image strFileName = (Image) imageSearchByLessonService.service(target.getLesson_id());
		
		String[] imageList = null;
		if ( strFileName != null ) {
			imageList = strFileName.getFile_name().split(",");
		}
		
		List<Review> reviewList = (List<Review>) reviewSearchByLessonIDService.service(target.getLesson_id());
		ArrayList<Mentee> writerList = new ArrayList<Mentee>();
		if (reviewList != null)
			for (Review item : reviewList) {
				writerList.add((Mentee) menteeSearchByIdService.service(item.getMentee_id()));
			}
		
		values.put("targetLesson", target);
		values.put("targetMentor", (Mentor) mentorSearchByIdService.service(tmp));
		values.put("targetImageList", imageList);
		values.put("targetReviewList", reviewList);
		values.put("targetReviewWriterList", writerList);
		
		return values;
	}
	
	
	@GetMapping("/lesson/update/detail/{lessonNo}")
	public String lessonUpdate(@PathVariable(value = "lessonNo", required = true) Integer lessonNo, Model model) {
		Lesson lesson = new Lesson();
		lesson.setLesson_id(lessonNo);
		
		DetailLessonView target = (DetailLessonView) detailLessonSearchService.service(lesson);
		Image strFileName = (Image) imageSearchByLessonService.service(target.getLesson_id());
		System.out.println(strFileName);
		
		String[] imageList = strFileName.getFile_name().split(",");
		Mentor tmp = new Mentor();
		tmp.setMentor_id(target.getMentor_id());
		Mentor mentor = (Mentor) mentorSearchByIdService.service(tmp);
		Category_name category = (Category_name)smallCategorySearchService.service(mentor.getMentor_categoryBig());
		String small_category = category.getSmall();
		String [] small_category_words = small_category.split(",");
		
		for( String word : small_category_words ) {
			System.out.println(word);
		}
		
		model.addAttribute("small_category", small_category_words);
		
		model.addAttribute("targetLesson", target);
		model.addAttribute("targetImageList", imageList);
		return "member/mentor/update";
	}
	
	@PostMapping("/lesson/applyMentoring")
	@ResponseBody
	public boolean applyMentoring(@RequestBody Lesson target, HttpServletRequest req) {

		HttpSession session = req.getSession(false);
		Mentee loginMentee = (Mentee) session.getAttribute("loginMember");
		LessonApply lessonApply = new LessonApply();
		lessonApply.setLesson_id(target.getLesson_id());
		lessonApply.setMentor_id(target.getMentor_id());
		lessonApply.setMentee_id(loginMentee.getMentee_id());

		if (lessonApplyInsertService.service(lessonApply) > 0)
			return true;

		return false;
	}
	

	
	
	private static final Logger logger = LoggerFactory.getLogger(MentorController.class);

	@ResponseBody
	@PostMapping(value = "/lesson/firstImageUpload", produces = "text/plain;charset=utf-8")
	public String uploadAjaxThumnail(MultipartFile file, HttpServletRequest request) throws IOException {
		logger.info("originalName:" + file.getOriginalFilename());
		logger.info("size:" + file.getSize());
		logger.info("contentType:" + file.getContentType());

		String RealPath = request.getSession().getServletContext().getRealPath("/resources/lessonImage");

		File dirPath = new File(RealPath);
		// 디렉토리가 존재하지 않으면 디렉토리 생성
		if (!dirPath.exists()) {
			dirPath.mkdir();
		}

		// ResponseEntity<String> fileName = new
		// ResponseEntity<String>(UploadFileUtils.uploadFile(uploadPathNoView,
		// file.getOriginalFilename(), file.getBytes()), HttpStatus.OK);

		String realFileName = UploadFileUtils.uploadFile(RealPath, file.getOriginalFilename(), file.getBytes());

		String saveFileName = realFileName.replaceAll("/", "");

		return saveFileName;

	}

	@ResponseBody
	@PostMapping(value = "/lesson/lessonImageUpload", produces = "text/plain;charset=utf-8")
	public String uploadLessonImage(MultipartFile file, HttpServletRequest request) throws IOException {
		logger.info("originalName:" + file.getOriginalFilename());
		logger.info("size:" + file.getSize());
		logger.info("contentType:" + file.getContentType());

		String RealPath = request.getSession().getServletContext().getRealPath("/resources/lessonImage");

		File dirPath = new File(RealPath);

	
		if (!dirPath.exists()) {
			dirPath.mkdir();
		}

		// ResponseEntity<String> fileName = new
		// ResponseEntity<String>(UploadFileUtils.uploadFile(uploadPathNoView,
		// file.getOriginalFilename(), file.getBytes()), HttpStatus.OK);

		String realFileName = UploadFileUtils.uploadFile(RealPath, file.getOriginalFilename(), file.getBytes());

		String saveFileName = realFileName.replaceAll("/", "");

		return saveFileName;

	}

	@PostMapping("/lesson/lessonImageListUpload/{lessonID}")
	@ResponseBody
	public boolean uploadLessonImageList(@RequestBody String str, @PathVariable("lessonID") int lesson_id) {

		Image target = new Image();
		target.setLesson_id(lesson_id);
		target.setFile_name(str);

		if(imageInsertService.service(target) > 0)
			return true;
		
		return false;

	}

}
