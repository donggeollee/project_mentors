package com.tje.mentors.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.tje.mentors.services.*;
import com.tje.mentors.setting.PagingInfoByTen;
import com.tje.mentors.utils.*;
import com.tje.mentors.model.*;

@Controller
@RequestMapping(value = "/mentor")
public class MentorController {
	
	@Autowired
	private ImageInsertService imageInsertService;

	@Autowired
	MentorMyWriteLessonCountService mmwlCntService;
	
	@Autowired
	MentorMyLessonMenteeCountAddService mmmcaddService;
	
	@Autowired
	MentorMenteeSearchCntByLessonIdService mmscntblService;
	
	@Autowired
	MentorSearchCountWhoLikesMenteeService mscwmService;
	
	@Autowired
	MentorProfileUpdateService mpupdateService;
	
	@Autowired
	private MentorMyLessonMentoringDeleteService mmlmDelservice;

	@Autowired
	private MentorMyLessonStatusProcessService mmsPservice;

	@Autowired
	MentorRegistService mrService;

	
	@Autowired
	MentorSearchByEmailService msbeService;
	
	@Autowired
	private MentorPasswordUpdateService mpuService;

	@Autowired
	private MentorInfoUpdateService miuService;

	@Autowired
	private MentorSearchInfoService msiService;

	@Autowired
	private MentorMyLessonStatusFinishService mmsfinishService;

	@Autowired
	private MentorMyMenteeListService mmmlService;

	@Autowired
	private MentorMyLessonNumberSearchService mmlnsService;

	@Autowired
	private MentorMyLessonMentoringService mmmService;

	@Autowired
	private MentorMyWriteLessonService mmwlService;

	@Autowired
	private MentorMyLessonWhoLikesMenteeService mmwlmService;

	@Autowired
	private MentorMyLessonWhoLikesByMenteeService mmwlbmService;

	@Autowired
	private MentorMyLessonCountWhoLikesMenteeService mmcwlmService;

	@Autowired
	private PagingInfoByTen pagingInfoByTen;

	@Autowired
	private MentorMyLessonWhoLikesMenteeSearchService mmwmsService;

	@Autowired
	private MentorLoginService mentorLoginService;
	
	@Autowired
	CategorySearchService cssService;

	
	// 안드로이드 APP
	@PostMapping("/regist_app")
	@ResponseBody
	public Object registSubmitApp(Mentor mentor) {

		System.out.println(mentor.getMentor_email());
		
		Boolean flag = false;
		
		HashMap<String,String> result = new HashMap<>();
		
		if (msbeService.service(mentor) == null) {
			if ((int) mrService.service(mentor) > 0) {
				flag = true;
				result.put("result", flag.toString());
				result.put("msg", "");
			} else {
				result.put("result", flag.toString());
				result.put("msg", "회원가입 과정 중에 문제가 발생했습니다");
			}
		} else {
			result.put("result", flag.toString());
			result.put("msg", "이미 사용중인 이메일입니다. (" + mentor.getMentor_email() + ")");
		}
		
		return result;
		
	}
	
	
	
	@GetMapping("/regist")
	public String registForm(HttpSession session) {
		session.setAttribute("registAuth", "registAuth");
		return "member/mentor/regist/step1";
	}

	@PostMapping("/regist/step2")
	public String registStep2Form(HttpServletRequest request, Model model) {
		model.addAttribute("branch", request.getParameter("branch"));
		return "member/mentor/regist/step2";
	}

	@PostMapping("regist/step3")
	public String registStep3Form(Mentor mentor, Model model) {
		model.addAttribute("mentor", mentor);

		return "member/mentor/regist/step3";
	}

	@PostMapping("regist/submit")
	public String registSubmit(Mentor mentor) {
		
		System.out.println("멘토이름 : "+mentor.getName());
		System.out.println("멘토자기소개 : "+mentor.getMentor_info());

		if ((int) mrService.service(mentor) == 0)
			return null;
		else
			return "redirect:/";
	}

	@ResponseBody
	@PostMapping("regist/check")
	public String checkEmail(@RequestParam(value = "mentor_email") String mentor_email) {
		Mentor target = new Mentor();
		target.setMentor_email(mentor_email);
		if (msbeService.service(target) == null)
			return "true";
		else
			return "false";
	}

	@GetMapping(value = {"/myWriteLesson","/myWriteLesson/{pageNo}"})
	public String mylessonForm(Lesson lesson, HttpServletRequest request, 
			@PathVariable(value = "pageNo",required = false)Integer page, Model model) {
		
		
		if (page == null) {
			page = 1;
		}
		
		
		HttpSession session = request.getSession(false);
		Mentor mentor = (Mentor) session.getAttribute("loginMember");
		int mentor_id = (int) mentor.getMentor_id();
	
		int totalCount = (Integer)mmwlCntService.service(mentor_id);
		
		pageProcess(totalCount, page, model);

		lesson.setMentor_id(mentor_id);

		model.addAttribute("mentor_classlist", mmwlService.service(lesson,page));

		return "member/mentor/personal/my_write_class";
	}

	
	public void pageProcess(int totalCount, int page, Model model) {
		int totalPageCount = totalCount / pagingInfoByTen.getPagingSize() +
				(totalCount % pagingInfoByTen.getPagingSize() == 0? 0 : 1);

		int startPageNo = (page % pagingInfoByTen.getPageRange() == 0 ? page - 1 : page) / pagingInfoByTen.getPageRange()
				* pagingInfoByTen.getPageRange() + 1;

		int endPageNo = startPageNo + pagingInfoByTen.getPageRange() - 1;
		if (endPageNo > totalPageCount)
			endPageNo = totalPageCount;

		int beforePageNo = startPageNo != 1 ? startPageNo - pagingInfoByTen.getPageRange() : -1;
		int afterPageNo = endPageNo != totalPageCount ? endPageNo + 1 : -1;

		model.addAttribute("totalPageCount", totalPageCount);
		model.addAttribute("startPageNo", startPageNo);
		model.addAttribute("endPageNo", endPageNo);
		model.addAttribute("beforePageNo", beforePageNo);
		model.addAttribute("afterPageNo", afterPageNo);
		model.addAttribute("curPage", page);
	}
	
	@GetMapping(value = { "/myLessonPicklist", "/myLessonPicklist/{pageNo}",
			"/myLessonPicklist/sort/{sortName}", "/myLessonPicklist/sort/{sortName}/{pageNo}" })
	public String mylessonPickList(@PathVariable(value = "sortName", required = false) String sortName,
			@PathVariable(value = "pageNo", required = false) Integer page, HttpServletRequest request, Model model) {

		// System.out.println("sortName:"+sortName);

		/* 지?��? 추�? ?�정 - 0731 */
		if (sortName == null) {
			sortName = "orderByLikeDesc";
		}

		HttpSession session = request.getSession(false);
		Mentor mentor = (Mentor) session.getAttribute("loginMember");

		// ?占쎌옱 ?占쎌씠吏 ?占쎈낫, 硫섑떚李쒗븳紐⑸줉 ?占쎈낫 2媛吏
		HashMap<String, Object> args = new HashMap<String, Object>();
		if (page == null) {
			page = 1;
		}

		args.put("curPageNo", page);
		MenteeWhoLikesMe mwlm = new MenteeWhoLikesMe();
		mwlm.setMentor_id(mentor.getMentor_id());
		args.put("mentor_id", mwlm);
		args.put("sortName", sortName);

		// ?�재 ?�이지 ?�보?? 개수��?? 찾아?�는 ?�비??
		model.addAttribute("total_list", mmwlbmService.service(args));

		HashMap<String, Integer> result = (HashMap<String, Integer>) mmcwlmService.service(mwlm);

		// ?占쎌껜 由ъ뒪?占쎌쓽 媛쒖닔
		model.addAttribute("total_count", result.get("totalCount"));

		
		int totalPageCount = (int) result.get("totalPageCount");

		int startPageNo = (page % pagingInfoByTen.getPageRange() == 0 ? page - 1 : page) / pagingInfoByTen.getPageRange()
				* pagingInfoByTen.getPageRange() + 1;

		int endPageNo = startPageNo + pagingInfoByTen.getPageRange() - 1;
		if (endPageNo > totalPageCount)
			endPageNo = totalPageCount;

		int beforePageNo = startPageNo != 1 ? startPageNo - pagingInfoByTen.getPageRange() : -1;
		int afterPageNo = endPageNo != totalPageCount ? endPageNo + 1 : -1;

		model.addAttribute("totalPageCount", totalPageCount);
		model.addAttribute("startPageNo", startPageNo);
		model.addAttribute("endPageNo", endPageNo);
		model.addAttribute("beforePageNo", beforePageNo);
		model.addAttribute("afterPageNo", afterPageNo);
		model.addAttribute("curPage", page);

		model.addAttribute("pickme_menteelist", mmwlbmService.service(args));
		model.addAttribute("sort", "sort/" + sortName + "/");
		model.addAttribute("sortName", sortName);
		model.addAttribute("sortType","none");

		return "member/mentor/personal/my_class_mentee_pick";

	}

	@PostMapping(value = "/menteeNameSearch")
	@ResponseBody
	public HashMap<String, Object> menteeNameSearch(@RequestBody MenteeWhoLikesMe mwlm, 
			HttpServletRequest request, Model model) {
		

		HttpSession session = request.getSession(false);
		Mentor mentor = (Mentor) session.getAttribute("loginMember");


		mwlm.setMentor_id(mentor.getMentor_id());

		HashMap<String, Integer> result = (HashMap<String, Integer>) mscwmService.service(mwlm);
		int page = 1;
		int totalPageCount = (int) result.get("totalPageCount");
		int totalCount = (int) result.get("totalCount");
		
		int startPageNo = (page % pagingInfoByTen.getPageRange() == 0 ? page - 1 : page) / pagingInfoByTen.getPageRange()
				* pagingInfoByTen.getPageRange() + 1;

		int endPageNo = startPageNo + pagingInfoByTen.getPageRange() - 1;
		if (endPageNo > totalPageCount)
			endPageNo = totalPageCount;

		int beforePageNo = startPageNo != 1 ? startPageNo - pagingInfoByTen.getPageRange() : -1;
		int afterPageNo = endPageNo != totalPageCount ? endPageNo + 1 : -1;
		
		ArrayList<Integer> pageList = new ArrayList<Integer>();
		pageList.add(totalPageCount);
		pageList.add(startPageNo);
		pageList.add(endPageNo);
		pageList.add(beforePageNo);
		pageList.add(afterPageNo);
		pageList.add(page);
		pageList.add(totalCount);
		
		List<MenteeWhoLikesMe> Searchresult = (List<MenteeWhoLikesMe>) mmwmsService.service(mwlm,page);

		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("Searchresult", Searchresult);
		resultMap.put("pagingList", pageList);
		
		if (totalCount != 0) {
			return resultMap;
		}
		
		return null;
	}

	@GetMapping(value = "/menteeNameSearch/{searchValue}/{pageNo}")
	public String menteeSearchItem(Model model,
	@PathVariable(value = "pageNo",required = false)Integer page,
	@PathVariable(value = "searchValue",required = false)String searchValue,
	HttpServletRequest request) {
	
	HttpSession session = request.getSession(false);
	Mentor mentor = (Mentor) session.getAttribute("loginMember");

	MenteeWhoLikesMe mwlm = new MenteeWhoLikesMe();
	mwlm.setMentee_name(searchValue);
	mwlm.setMentor_id(mentor.getMentor_id());
	
	
	if( page == null ) {
	page = 1;
	}
	
	HashMap<String, Integer> result = (HashMap<String, Integer>) mscwmService.service(mwlm);
	int totalCount = (int) result.get("totalCount");
	
	pageProcess(totalCount, page, model);

	List<MenteeWhoLikesMe> resultList = (List<MenteeWhoLikesMe>) mmwmsService.service(mwlm,page);
	
	
	model.addAttribute("pickme_menteelist",resultList);
	model.addAttribute("search",searchValue+"/");
	model.addAttribute("sortType","searchMentee");
	model.addAttribute("total_count",totalCount);
	
	return "member/mentor/personal/my_class_mentee_pick";
}
	
	@GetMapping(value = "/mentoring")
	public String mylessonMentoring(HttpServletRequest request, Model model,
			@PathVariable(value = "pageNo", required = false) Integer page, LessonApplyToMentorView mentorview) {

		HttpSession session = request.getSession(false);
		Mentor mentor = (Mentor) session.getAttribute("loginMember");

		mentorview.setMentor_id(mentor.getMentor_id());

		model.addAttribute("mentoring_list", mmmService.service(mentorview));

		return "member/mentor/personal/my_class_mentoring";
	}



	@PostMapping(value = "mentoring/accept")
	@ResponseBody
	public Boolean submitMentoring(HttpServletRequest request, @RequestBody LessonApply lessonAply,
			LessonStatus lessonStatus) {

		HttpSession session = request.getSession(false);
		Mentor mentor = (Mentor) session.getAttribute("loginMember");
		lessonAply.setMentor_id(mentor.getMentor_id());
		int lesson_id = lessonAply.getLesson_id();
		
		
		Boolean ApplyRes = false;
		Boolean StatusRes = false;
		Boolean totalRes = false;
		Boolean menteeAddRes = false;
		
		// 1) lesson_apply -> delete service
		ApplyRes = (Boolean) mmlmDelservice.service(lessonAply);

		lessonStatus.setMentor_id(mentor.getMentor_id());
		lessonStatus.setMentee_id(lessonAply.getMentee_id());
		lessonStatus.setLesson_id(lessonAply.getLesson_id());
		
		if (ApplyRes = true) {

			// 2) lesson_status P insert
			StatusRes = (Boolean) mmsPservice.service(lessonStatus);
				
			if (StatusRes == true) {
				// mentoring accept -> menteeCount +1 (lessons_status = 'P' select count )
				int menteeCnt = (int) mmscntblService.service(lesson_id);
				
				// lesson table update (menteeCnt)
				if ( menteeCnt != 0) {
					menteeAddRes = (Boolean)mmmcaddService.service(menteeCnt, lesson_id);
				}
				
				totalRes = true;
			}

		}

		return totalRes;
	}

	// 멘토��?? ?�청 거절 ??
	@PostMapping(value = "mentoring/reject")
	@ResponseBody
	public Boolean rejectMentoring(HttpServletRequest request, @RequestBody LessonApply lessonAply) {

		HttpSession session = request.getSession(false);
		Mentor mentor = (Mentor) session.getAttribute("loginMember");
		lessonAply.setMentor_id(mentor.getMentor_id());

		Boolean ApplyRes = false;
		ApplyRes = (Boolean) mmlmDelservice.service(lessonAply);
		if (ApplyRes) {
			System.out.println("?占쎌껌?占쎈씫嫄곗젅 ?占쎄났");
			return ApplyRes;
		}

		return ApplyRes;
	}

	
	@GetMapping(value = "menteelist")
	public String menteeList(HttpServletRequest request, MyMenteeList mymentee, Model model, LessonStatus status) {

		HttpSession session = request.getSession(false);
		Mentor mentor = (Mentor) session.getAttribute("loginMember");
		mymentee.setMentor_id(mentor.getMentor_id());

		
		status.setMentor_id(mentor.getMentor_id());
		// HashMap<String, Object> res = new HashMap<String, Object>();
		// res.put("lesson_num", mmlnsService.service(lesson));

		ArrayList<List<MyMenteeList>> result = new ArrayList<List<MyMenteeList>>();
		List<MyMenteeList> lesson_info = (List<MyMenteeList>) mmlnsService.service(mentor.getMentor_id());
		List<MyMenteeList> mentee_list = null;
		for (int i = 0; i < lesson_info.size(); i++) {
			System.out.println(lesson_info.get(i).getLesson_id());
			int search_lesson_id = lesson_info.get(i).getLesson_id();

			mentee_list = (List<MyMenteeList>) mmmlService.service(mentor.getMentor_id(), search_lesson_id);

			result.add(mentee_list);
		}

		model.addAttribute("title_list", lesson_info);
		model.addAttribute("mentee_list", result);

		// model.addAttribute("mymenteelist",mmmlService.service(mymentee));

		return "member/mentor/personal/my_mentee_list";
	}

	// ?�의 멘티 리스?? ?? 가?�오��??
	@PostMapping(value = "/menteelist/listcount")
	@ResponseBody
	public void getMoreContents(HttpServletRequest request, MyMenteeList menteelist) {

	}

	
	// 멘토��?? ?�료?�기 ?�행
	@ResponseBody
	@PostMapping(value = "/menteelist/complete")
	public Boolean completeForm(@RequestBody LessonStatus lessonstatus, HttpServletRequest request) {

		HttpSession session = request.getSession(false);
		Mentor mentor = (Mentor) session.getAttribute("loginMember");
		lessonstatus.setMentor_id(mentor.getMentor_id());

		System.out.println("?占쎌뒯id:" + lessonstatus.getLesson_id());
		System.out.println("硫섑떚id:" + lessonstatus.getMentee_id());
		Boolean result = false;

		if ((Boolean) mmsfinishService.service(lessonstatus)) {
			result = true;
		}

		System.out.println(result);
		return result;
	}

	@GetMapping(value = "myPage")
	public String myinfoForm() {

		return "member/mentor/personal/my_page";
	}
	
	@GetMapping(value = "mypageapp")
	@ResponseBody
	public Object myPage(HttpSession session) {
		if (session == null)
			return false;
		return session.getAttribute("loginMember");
	}

	@PostMapping(value = "/myPage/infoupdate")
	@ResponseBody
	public Boolean updateinfo(@RequestBody Mentor mentor, HttpServletRequest request) {

		HttpSession session = request.getSession(false);

		Boolean result = false;

		// ?占쎈뜲?占쏀듃 ?占쎄났 ?占쎈퉬??
		if ((Boolean) miuService.service(mentor)) {
			result = true;


			// ?�의 ?�데?�트 ?? ?�보��?? 가?��??? ?�로 ?�션?? ?�어주기
			session.setAttribute("loginMember", msiService.service(mentor));

		}
		;

		return result;
	}

	@PostMapping(value = "/myPage/passwordCheck")
	@ResponseBody
	public Boolean passwordCkForm(@RequestBody Mentor mentor, HttpServletRequest request) {

		HttpSession session = request.getSession(false);

		Boolean result = false;

		// ?占쎌옱 鍮꾬옙?踰덊샇 ?占쎈젰 ?占쎌튂 ?占쏙옙? ?占쎌씤
		Mentor target = (Mentor) msiService.service(mentor);

		if (mentor.getMentor_password().equals(target.getMentor_password())) {

			result = true;
		}

		return result;
	}

	@PostMapping(value = "/myPage/updatePasswordCk")
	@ResponseBody
	public Boolean passwordUpdateForm(@RequestBody Mentor mentor, HttpServletRequest request) {

		HttpSession session = request.getSession(false);

		System.out.println(mentor.getMentor_id());
		System.out.println(mentor.getMentor_password());

		Boolean result = false;

		// 비�?번호 변��?? ?�공 ?��? ?�비??

		if ((Boolean) mpuService.service(mentor)) {
			result = true;
		}

		return result;
	}
	
	//@Autowired
	//private String uploadPath;
	private static final Logger logger = 
			LoggerFactory.getLogger(MentorController.class);
	
	@ResponseBody
	@PostMapping(value="/myPage/profilUpdate", produces = "text/plain;charset=utf-8")
	public String uploadAjaxSubmit(MultipartFile file,HttpServletRequest request) throws IOException{
		logger.info("originalName:"+file.getOriginalFilename());
		logger.info("size:"+file.getSize());
		logger.info("contentType:"+file.getContentType());

		
		String RealPath = request.getSession().getServletContext().getRealPath("/resources/profiles");
		
		File dirPath = new File(RealPath);
		
		// ?�렉?�리가 존재?��? ?�으��?
		if( !dirPath.exists()) {
			dirPath.mkdir(); // ?�렉?�리 ?�성

		}
		
		//ResponseEntity<String> fileName = new ResponseEntity<String>(UploadFileUtils.uploadFile(uploadPathNoView, file.getOriginalFilename(), file.getBytes()), HttpStatus.OK);
		
		String realFileName = UploadFileUtils.uploadFile(RealPath, file.getOriginalFilename(), file.getBytes());
		
		String saveFileName = realFileName.replaceAll("/", "");
		
		HttpSession session = request.getSession(false);
		Mentor mentor = (Mentor) session.getAttribute("loginMember");
		mentor.setMentor_profile(saveFileName);
		
		if( (Boolean)mpupdateService.service(mentor)) {
			session.setAttribute("loginMember", msiService.service(mentor));
			return saveFileName;
		}
		
		return null; 
		
	}
	

	@GetMapping("/login")
	public String mentorLogin(Model model, @CookieValue(value = "REMEMBER", required = false) Cookie rCookie) {
		if (rCookie != null) {
			String[] emailTmp = rCookie.getValue().split("@");
			model.addAttribute("email_idd", emailTmp[0]);
			model.addAttribute("email_typee", emailTmp[1]);
		}
		return "member/mentor/login/login";
	}

	@PostMapping("/login")
	@ResponseBody
	public boolean mentorLoginEmailCk(@RequestBody Mentor mentor, HttpSession session) {

		Mentor target = (Mentor) mentorLoginService.service(mentor);
		if (target != null) {

			if (mentor.getMentor_password().equals(target.getMentor_password())) {

				session.setAttribute("loginMember", target);
				session.setAttribute("memberType", "mentor");

				return true;
			}
		}

		return false;
	}
	
	// 안드로이드 로그인
	@PostMapping("/login/app")
	@ResponseBody
	public Object mentorLoginEmailCkapp(Mentor mentor, HttpSession session) {
		
		System.out.println("mentor app login");
		System.out.println(mentor.getMentor_email() + mentor.getMentor_password());

		HashMap<String,String> result = new HashMap<>();
		Boolean flag = false;
		
		
		Mentor target = (Mentor) mentorLoginService.service(mentor);
		if (target != null) {

			if (mentor.getMentor_password().equals(target.getMentor_password())) {
				flag = true;
				result.put("result", flag.toString());
				result.put("login_msg", "");
				
				session.setAttribute("loginMember", target);
				session.setAttribute("memberType", "mentor");
			
			} else {
				result.put("result", flag.toString());
				result.put("login_msg", "비밀번호를 확인해주세요!");
			}
		}

		return result;
	}

	// 안드로이드 로그인 
	@GetMapping("/app_logout")
	@ResponseBody
	public Object app_logout(HttpServletRequest req) {
		System.out.println("app_logout 실행 ");
		HttpSession session = req.getSession(false);
		
		Mentor loginMember = (Mentor)session.getAttribute("loginMember");
		//System.out.printf("loginMember : %s\n",loginMember.getMentee_email());
		

		Mentor tmp = (Mentor)session.getAttribute("loginMember");
		System.out.println(tmp == null? null:tmp.getMentor_email());
		
		HashMap<String,String> result = new HashMap<>();
		
		Boolean flag = false;
		
		if (loginMember == null) {
			result.put("result", flag.toString());
			result.put("logout_msg", "로그인이 되어있지 않습니다");
		} else {
			flag = true;
			result.put("result", flag.toString());
			result.put("logout_msg", loginMember.getMentor_email()+"계정의 로그아웃이 완료되었습니다.");
			session.removeAttribute("loginMember");
		}
		
		
	 return result;
	}
	
	
	// 안드로이드 로그인 멘토 정보 찾기 
		@GetMapping("/search/app")
		@ResponseBody
		public Object searchMentorApp(HttpServletRequest req) {
			System.out.println("searchMentorApp 실행 ");
			HttpSession session = req.getSession(false);
			
			Mentor loginMember = (Mentor)session.getAttribute("loginMember");
			System.out.printf("loginMember : %s\n",loginMember.getMentor_email());
			System.out.printf("cate : %s\n",loginMember.getMentor_categoryBig());
			
			Lesson lesson = new Lesson();
			lesson.setCategory_big(loginMember.getMentor_categoryBig());
			
			String smallCates = (String)cssService.service(lesson.getCategory_big());
			String[] arrSmallCate = smallCates.split(",");
			ArrayList<String> cateList = new ArrayList<String>();
			for ( String smallCate : arrSmallCate) {
				cateList.add(smallCate);
			}
			

			//Mentor tmp = (Mentor)session.getAttribute("loginMember");
			//System.out.println(tmp == null? null:tmp.getMentor_email());
			
			//HashMap<String,String> result = new HashMap<>();
			//result.put("cateList", cateList);
			
			//result.put("", value)
			
			
		 return cateList;
		}
	// 硫섑넗 濡쒓렇?? ?占쎈찓?? 荑좏궎 ?占쎌꽦
	@PostMapping(value = "/login/cookie")
	@ResponseBody
	public Boolean CoookieProcess(@RequestBody Boolean isRemember, HttpServletResponse res, HttpServletRequest req) {

		HttpSession session = req.getSession(false);

		if (isRemember) {
			res.addCookie(new Cookie("REMEMBER", ((Mentor) session.getAttribute("loginMember")).getMentor_email()));
		} else {
			Cookie tmp = new Cookie("REMEMBER", null);
			tmp.setMaxAge(0);
			res.addCookie(tmp);
		}
		return true;

	}

	@GetMapping("/home")
	public String mentorHome() {

		return "member/mentor/home";
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		if (session.getAttribute("loginMember") != null)
			session.invalidate();
		return "redirect:/";
	}

	
	/**/
	
	@Autowired // 멘토 ?�슨 ?�성 ?�비??
	private MentorWriteLessonService mentorWriteLessonService;
	
	@Autowired // 硫섑넗 ?占쎌뒯 ?占쎌꽦 ?占쎈퉬??
	private MentorUpdateLessonService mentorUpdateLessonService;
	
	@Autowired // 멘토 ?�슨 ?�성 ?�비?? - ?��? 카테고리 검?? ?�비??
	private SmallCategorySearchService smallCategorySearchService;

	
	/* ?�라 멘토 ?�슨 글 ?�성 부��?? */
	@GetMapping("/lesson/write")
	public String mentorWriteLesson(HttpServletRequest req, Model model) {
		
		HttpSession session = req.getSession(false);
		if (session == null) {
			return null;
		}
		Mentor mentor = (Mentor)session.getAttribute("loginMember");
		
	
		//?��? 카테고리 검?? (?�슨 ?�성 ??, 카테고리 분류 select?? ?�션?�로 ?�어��?? ?�보)
		Category_name category = (Category_name)smallCategorySearchService.service(mentor.getMentor_categoryBig());
		String small_category = category.getSmall();
		String [] small_category_words = small_category.split(",");
		
		for( String word : small_category_words ) {
			System.out.println(word);
		}
		
		model.addAttribute("small_category", small_category_words);

		return "member/mentor/lesson/write";
	}


	// 멘토 ?�슨 글 ?�성
	@PostMapping("/lesson/write")
	@ResponseBody
	public int lessonWriteSubmit(@RequestBody Lesson lesson, HttpServletRequest req) {

		HttpSession session = req.getSession(false);
		if (session == null) {
			return 0;
		}

		Mentor mentor = (Mentor) session.getAttribute("loginMember");
		
		lesson.setMentor_id(mentor.getMentor_id());
		lesson.setCategory_big(mentor.getMentor_categoryBig());
				
		
		return (int)mentorWriteLessonService.service(lesson);
		//List<String>
		
	}

	@PostMapping("/lesson/update")
	@ResponseBody
	public int lessonUpdateSubmit(@RequestBody Lesson lesson, HttpServletRequest req) {

		HttpSession session = req.getSession(false);
		if (session == null) {
			return 0;
		}

		Mentor mentor = (Mentor) session.getAttribute("loginMember");
		
		lesson.setMentor_id(mentor.getMentor_id());
		lesson.setCategory_big(mentor.getMentor_categoryBig());

		System.out.println(lesson.getLesson_id());
		
		return (int)mentorUpdateLessonService.service(lesson);
		//List<String>
		
	}
	
	
	// 안드로이드 레슨 작성 
		@PostMapping(value = "/lesson/write/app")
		@ResponseBody
		public  Boolean uploadLessonApp(Lesson lesson ,HttpServletRequest request) {
			//logger.info("originalName:" + file.getOriginalFilename());
			//logger.info("size:" + file.getSize());
			//logger.info("contentType:" + file.getContentType());
			System.out.println("lesson write");
			
			//System.out.println(location);
			System.out.println(lesson.getTitle());
			System.out.println(lesson.getCategory_small());
			
			boolean flag = false;
			
			HttpSession session = request.getSession(false);
			if(session == null) {
				flag = false;
			}
			
			Mentor mentor = (Mentor) session.getAttribute("loginMember");
			System.out.println(mentor.getMentor_categoryBig());
			
			lesson.setMentor_id(mentor.getMentor_id());
			lesson.setCategory_big(mentor.getMentor_categoryBig());
			

		

			if((int) mentorWriteLessonService.service(lesson) > 0) {
				
				flag = true;
			}
			
			
			return flag;

		}
		@ResponseBody
		@PostMapping(value = "/lesson/imageApp", produces = "text/plain;charset=utf-8")
		public String uploadAjaxThumnail(MultipartFile file, HttpServletRequest request) throws IOException {
			
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

}
