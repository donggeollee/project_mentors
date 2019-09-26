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

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
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

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.tje.mentors.model.*;
import com.tje.mentors.social.*;
import com.tje.mentors.utils.UploadFileUtils;
import com.tje.mentors.services.*;
import com.tje.mentors.setting.PagingInfo;
import com.tje.mentors.setting.PagingInfoByFour;

@Controller
@RequestMapping("/mentee")
public class MenteeController {
	
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;
	
	@Autowired
	private MenteePasswordUpdateService mpuService;
	
	@Autowired
	private MenteeSearchByIdService msbidService;
	
	@Autowired
	private MenteeProfileUpdateService miuServie;
	
	@Autowired
	private MenteeSearchByEmailService msbeService; 
			
	@Autowired
	private MenteeInsertService miService;
	
	@Autowired
	private MenteeRegistService mrService;
	
	@Autowired
	private LessonFilterCountService lfcService;
	
	@Autowired
	private PagingInfoByFour pagingInfoByFour;
	
	@Autowired
	private MenteeMyLikedLessonSearchAscService mmllascService;
	
	@Autowired
	private MenteeMyLikedLessonSearchDescService mmlldescService;
	
	
	@Autowired
	private MenteeMyLikedLessonCountService mmllcService;
	
	
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

	@GetMapping(value = "/login")
	public String Login(Model model, @CookieValue(value = "REMEMBER", required = false) Cookie rCookie) {
		if(rCookie != null) {
			String[] emailTmp = rCookie.getValue().split("@");
			model.addAttribute("email_idd", emailTmp[0]);
			model.addAttribute("email_typee", emailTmp[1]);
		}
		return "member/mentee/login/login";
	}
	
	@PostMapping(value = "/login")
	@ResponseBody
	public Boolean LoginProcess(@RequestBody Mentee mentee, HttpSession session) {
		
		Mentee target = (Mentee)msbeService.service(mentee);
		if(target == null)
			return false;
		else {
			if(target.getMentee_password().equals(mentee.getMentee_password())) {
				session.setAttribute("loginMember", target);
				session.setAttribute("memberType", "mentee");
				return true;
			}
			else
				return false;
		}
		
	}
	@PostMapping(value = "/login/cookie")
	@ResponseBody
	public Boolean CoookieProcess(@RequestBody Boolean isRemember, HttpServletResponse res, HttpServletRequest req) {
		
		HttpSession session = req.getSession(false);
		
		if(isRemember) {
			res.addCookie(new Cookie("REMEMBER", ((Mentee)session.getAttribute("loginMember")).getMentee_email()));
		}else {
			Cookie tmp = new Cookie("REMEMBER", null);
			tmp.setMaxAge(0);
			res.addCookie(tmp);			
		}
		return true;
		
	}
	
	// 안드로이드 app 
	
	
		@PostMapping(value = "/regist/app")	
		@ResponseBody
		
		public Object insertSubmitApp(Mentee mentee) {
			
			Boolean result = false;
			
			HashMap<String,String> totalRes = new HashMap<>();
			
	 
			if(msbeService.service(mentee) == null ) {
				
				String member_type = "멘토스";
				mentee.setSimple_login_CK(member_type);
				System.out.println(mentee.getMentee_password());
			
				if( (Boolean)mrService.service(mentee) ==  true) {
						result = true;
						totalRes.put("result", result.toString());
						totalRes.put("msg", "회원가입 성공");
					}		 
			} else {
				
				totalRes.put("result", result.toString());
				totalRes.put("msg", "이미 사용중인 이메일입니다.(" + mentee.getMentee_email() + ")");
				
			}
		

			System.out.println(result);
			return totalRes;
		}
		
		
			@PostMapping(value = "/login/app")
			@ResponseBody
			public Object LoginProcessApp(Mentee mentee, HttpServletRequest req) {
				
				HttpSession session = req.getSession(false);
				System.out.println(mentee.getMentee_email());
				Mentee login_id = null;
				
				if ( session != null) {
					login_id = (Mentee)session.getAttribute("loginMember");
				}
				
				HashMap<String, String> result = new HashMap<>();
				
				Boolean flag = false;
				
				if(login_id != null ) {
					result.put("result", flag.toString());
					result.put("login_msg", "이미 로그인 되어 있는 사용자입니다 .("+login_id.getMentee_email()+")"); 
					
				} else  {
					result.put("login_msg", "");
					session = req.getSession(true);
					Mentee target = (Mentee)msbeService.service(mentee);
					if(target != null) {
						if(target.getMentee_password().equals(mentee.getMentee_password())) {
							flag = true;
							session.setAttribute("loginMember", target);
							session.setAttribute("memberType", "mentee");
						
					} else {
						result.put("login_msg", "아이디와 비밀번호를 확인해주세요");
							
						}
						result.put("result",flag.toString());
					}
						
				}
				System.out.println(flag);
				return result;
				
			}

		
		@RequestMapping("/naverLogin/app")
		@ResponseBody
		public Boolean app_login(@RequestParam(value = "mentee_email")String mentee_email,
								@RequestParam(value = "mentee_name")String mentee_name,
								HttpSession session) { 
			
			System.out.println("naver_login 실행");
			System.out.printf("email -> %s, nickname -> %s\n", mentee_email, mentee_name);

			
			Mentee target = new Mentee();
			target.setMentee_email(mentee_email);
			target.setMentee_name(mentee_name);
			target.setSimple_login_CK("네이버");
			
			//HttpSession session = request.getSession(true);
			
			Mentee searchMentee = (Mentee)msbeService.service(target);
		
			Boolean flag = false;
			
			
			if(searchMentee == null) {
				if((Integer)miService.service(target) > 0 ) {
						flag = true;
						if ( session != null) {
						session.setAttribute("loginMember", target);
						session.setAttribute("memberType", "mentee");
						}

						Mentee tmp = (Mentee)session.getAttribute("loginMember");
						System.out.println(tmp == null? null:tmp.getMentee_email());
					} else  {
						flag = false;
					}
				} else {
					flag = true;
					System.out.println("이미 가입된 회원 - 로그인 성공");
					if ( session != null) {
					session.setAttribute("loginMember", target);
					session.setAttribute("memberType", "mentee");
					}
					
					Mentee tmp = (Mentee)session.getAttribute("loginMember");
					System.out.println(tmp == null? null:tmp.getMentee_email());
				}

			return flag;
			
		}
		
	
		@GetMapping("/app_logout")
		@ResponseBody
		public Object app_logout(HttpServletRequest req) {
			System.out.println("app_logout 실행 ");
			HttpSession session = req.getSession(false);
			
			Mentee loginMember = (Mentee)session.getAttribute("loginMember");
			//System.out.printf("loginMember : %s\n",loginMember.getMentee_email());
			

			Mentee tmp = (Mentee)session.getAttribute("loginMember");
			System.out.println(tmp == null? null:tmp.getMentee_email());
			
			HashMap<String,String> result = new HashMap<>();
			
			Boolean flag = false;
			
			if (loginMember == null) {
				result.put("result", flag.toString());
				result.put("logout_msg", "로그인이 되어있지 않습니다");
			} else {
				flag = true;
				result.put("result", flag.toString());
				result.put("logout_msg", loginMember.getMentee_email()+"계정의 로그아웃이 완료되었습니다.");
				session.removeAttribute("loginMember");
			}
			
			
		 return result;
		}
		
		
	@PostMapping(value = "/loginSuccess")
	@ResponseBody
	public boolean loginSuccess(@RequestBody String data, HttpSession session) {

		System.out.println("data :" + data);
		com.google.gson.JsonParser parser = new com.google.gson.JsonParser();
        JsonElement element = parser.parse(data);
        
        JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
        JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
        
        String nickname = properties.getAsJsonObject().get("nickname").getAsString();
        String email = kakao_account.getAsJsonObject().get("email").getAsString();
        System.out.println(nickname);
        System.out.println(email);
        
        Mentee model = new Mentee();
        model.setMentee_email(email);
        Mentee result = (Mentee)msbeService.service(model);
		if(result == null) {
			model.setMentee_name(nickname);
			model.setSimple_login_CK("카카오");
			if((Integer)miService.service(model) < 1)
				return false;
			
			session.setAttribute("loginMember", model);
			session.setAttribute("memberType", "mentee");
			return true;
		}
		
		session.setAttribute("loginMember", result);
		session.setAttribute("memberType", "mentee");

		return true;
	}

	@RequestMapping(value = "/naverlogin", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String login(Model model, HttpSession session) {

		System.out.println("네이버로그인");
		
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		// https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
		// redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
		System.out.println("?�이�?:" + naverAuthUrl);

		model.addAttribute("url", naverAuthUrl);
		return naverAuthUrl;
	}

	@RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
			throws IOException, ParseException {
		System.out.println("?�기?? callback");
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		apiResult = naverLoginBO.getUserProfile(oauthToken); // String?�식?? json?�이??
		/**
		 * apiResult json 구조 {"resultcode":"00", "message":"success",
		 * "response":{"id":"33666449","nickname":"shinn****","age":"20-29","gender":"M","email":"shinn0608@naver.com","name":"\uc2e0\ubc94\ud638"}}
		 **/
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;

		JSONObject response_obj = (JSONObject) jsonObj.get("response");

		String email = (String) response_obj.get("email");
		String name = (String) response_obj.get("name");
		System.out.println(name);
		System.out.println(email);
		
		Mentee target = new Mentee();
		target.setMentee_email(email);
        Mentee result = (Mentee)msbeService.service(target);
		if(result == null) {
			target.setMentee_name(name);
			target.setSimple_login_CK("네이버");
			if((Integer)miService.service(target) < 1)
				return "error/menteeLoginError";
			
			session.setAttribute("loginMember", target);
			session.setAttribute("memberType", "mentee");
			
			return "index";
		}
		
		
		session.setAttribute("loginMember", result);
		session.setAttribute("memberType", "mentee");

		System.out.println((Mentee)session.getAttribute("loginMember") == null);
		System.out.println((String)session.getAttribute("memberType"));
		
		return "index";
	}

	@GetMapping(value = "/regist")
	public String insertForm(Mentee mentee) {
		
		return "member/mentee/regist/regist";
	}
	
	@PostMapping(value = "/regist_emailCK")	
	@ResponseBody
	public Boolean emailCK(@RequestBody Mentee mentee) {
		
		System.out.println(mentee.getMentee_email());
		
		Boolean result = false;

		if(msbeService.service(mentee) == null ) {
			 result = true;
		}
		System.out.println(result);
		return result;
	}
	
	@PostMapping(value = "/regist")	
	@ResponseBody
	public Boolean insertSubmit(@RequestBody Mentee mentee) {
	
		Boolean result = false;

		String member_type = "멘토스";
		mentee.setSimple_login_CK(member_type);
		System.out.println(mentee.getMentee_password());

		if( (Boolean)mrService.service(mentee) ==  true) {
			result = true;
		}
		return result;
	}
	
	@Autowired 
	private MenteeMyPLessonSearchService  menteeMyPLessonSearchService;
	
	@Autowired 
	private MenteeMyFLessonSearchService  menteeMyFLessonSearchService;
	
	@Autowired 
	private MenteeReviewSearchService  menteeReviewSearchService;
	

	@GetMapping("/myLesson")
	public String myAllLesson(HttpServletRequest req,Model model) {

		HttpSession session = req.getSession(false);
		if( session == null ) {
			return null;
		}
		
		Mentee mentee = (Mentee)session.getAttribute("loginMember");
		List<MyLessonList> pLessonList = (List<MyLessonList>)menteeMyPLessonSearchService.service(mentee.getMentee_id());
		List<MyLessonList> fLessonList = (List<MyLessonList>)menteeMyFLessonSearchService.service(mentee.getMentee_id());
		
		List<Integer> reviewCheckLessonList = new ArrayList<Integer>();
			
		for( MyLessonList flist : fLessonList ) {
			int target = flist.getLesson_id();
			boolean result = menteeReviewSearchService.service(target, mentee.getMentee_id());
			if( result ) {
				reviewCheckLessonList.add(target);
			}
		};
		
		model.addAttribute("pLessonList", pLessonList);
		model.addAttribute("fLessonList", fLessonList);
		model.addAttribute("reviewCheckLessonList", reviewCheckLessonList);

		
		return "member/mentee/personal/my_all_lesson";
	}
	
	@Autowired 
	private MenteeReviewWriteService  menteeReviewWriteService;
	

	@Autowired 
	private MenteeMyLikedLessonSearchDescService  menteeMyLikedLessonSearchDescService;
	
	@Autowired 
	private MenteeMyLikedLessonSearchAscService  menteeMyLikedLessonSearchAscService;
	
	@Autowired 
	private MenteeMyMentorViewService menteeMyMentorViewService;
	
	
	@PostMapping("/myLesson/review")
	@ResponseBody
	public Boolean myLessonReviewWrite(HttpServletRequest req, @RequestBody Review review) {
		
		HttpSession session = req.getSession(false);
		if( session == null ) {
			return false;
		}
				
		Mentee mentee = (Mentee)session.getAttribute("loginMember");
		
		System.out.println("레슨아이디 : " + review.getLesson_id());
		System.out.println("리뷰내용 : "+ review.getContent());
		System.out.println("리뷰점수 : " +review.getScore());	
		
		review.setMentee_id(mentee.getMentee_id());
		
		boolean result = (boolean)menteeReviewWriteService.service(review);
		
			
		return result;
	}
	
	
	
	@GetMapping("/myLikeLesson")
	public String myLikeLessonNoPage(
			Model model,
			HttpServletRequest req
			) {
		return myLikeLesson(model,req,1);
	}
	
	@Autowired
	private LikeDeleteService ldService;
	
	@GetMapping("/myLikeLesson/{page}")
	public String myLikeLessonWithPage(
			Model model,
			HttpServletRequest req,
			@PathVariable(value="page")int page
			) {
		return myLikeLesson(model,req,page);
	}
	
	public String myLikeLesson(
			Model model,
			HttpServletRequest req,
			int page
		) {
		HttpSession session = req.getSession(false);
		if( session == null ) {
			return null;
		}
		
		
		
		Mentee mentee = (Mentee)session.getAttribute("loginMember");
		
		String strLesson_id = (String)req.getParameter("lesson_id");
		if( strLesson_id != null ) {
			String title = req.getParameter("title");
			int lesson_id = Integer.parseInt(strLesson_id);
			int mentee_id = mentee.getMentee_id();
			LikeTable obj = new LikeTable(0, lesson_id, mentee_id);
			if ((int)ldService.service(obj) == 1) {
				model.addAttribute("deleteMsg", title+"레슨에 대한 찜이 취소 되었습니다.");
			}
		}
		
		
		HashMap<String, Integer> pageMap = 
				(HashMap<String, Integer>)pageSetting(mentee.getMentee_id(), page);

		String align = (String)req.getParameter("align");
		
		List<MyLikedList> likedList = null;
		
		if (align != null) {
			if ( align.equals("desc")) {
				likedList = 
						(List<MyLikedList>)mmlldescService.service(mentee.getMentee_id(), page);
			} else {
				likedList = 
						(List<MyLikedList>)mmllascService.service(mentee.getMentee_id(), page);
			}
			model.addAttribute("alignment", align);
		} else {
			likedList = 
					(List<MyLikedList>)mmllascService.service(mentee.getMentee_id(), page);
			model.addAttribute("alignment", "desc"); 
		} 
		model.addAttribute("likedList", likedList);
		model.addAttribute("pageMap", pageMap);
		
		return "member/mentee/personal/my_like_lesson";
	}
	
	@ResponseBody
	@PostMapping("/myLikeLesson/alignAjax")
	public HashMap<String, Object> alignAjax(
			@RequestBody String align,
			HttpSession session){
		HashMap<String, Object> values = new HashMap<String, Object>();
		
		Mentee mentee = (Mentee)session.getAttribute("loginMember");
		
		List<MyLikedList> likedList = null;
		if (align.equals("desc")) {
			likedList = 
					(List<MyLikedList> )mmlldescService.service(mentee.getMentee_id(), 1);
		} else {
			likedList = 
					(List<MyLikedList> )mmllascService.service(mentee.getMentee_id(), 1);
		}
		HashMap<String, Integer> pageMap = 
				pageSetting(mentee.getMentee_id(), 1); 
		values.put("likedList",likedList);
		values.put("pageMap", pageMap);

		return values;
	}
	
	
	
	@GetMapping("/myMentor")
	public String myMentor(HttpServletRequest req, Model model) {
		
		HttpSession session = req.getSession(false);
		if( session == null ) {
			return null;
		}
				
		Mentee mentee = (Mentee)session.getAttribute("loginMember");
		
		List<MyMentor> myMentorList =  (List<MyMentor>)menteeMyMentorViewService.service(mentee.getMentee_id());
		model.addAttribute("myMentorList", myMentorList);
		
		return "member/mentee/personal/my_mentor";
	}
	
	
	@ResponseBody
	@PostMapping(value="/myPage/profilUpdate", produces = "text/plain;charset=utf-8")
	public String uploadAjaxSubmit(MultipartFile file,HttpServletRequest request) throws IOException{
		

		
		String RealPath = request.getSession().getServletContext().getRealPath("/resources/profiles");
		
		File dirPath = new File(RealPath);
		
		
		if( !dirPath.exists()) {
			dirPath.mkdir(); 

		}
		
		//ResponseEntity<String> fileName = new ResponseEntity<String>(UploadFileUtils.uploadFile(uploadPathNoView, file.getOriginalFilename(), file.getBytes()), HttpStatus.OK);
		
		String realFileName = UploadFileUtils.uploadFile(RealPath, file.getOriginalFilename(), file.getBytes());
		
		String saveFileName = realFileName.replaceAll("/", "");
		
		HttpSession session = request.getSession(false);
		Mentee mentee = (Mentee) session.getAttribute("loginMember");
		mentee.setMentee_profile(saveFileName);
		
		
		if( (Boolean)miuServie.service(mentee)) {
			session.setAttribute("loginMember", msbidService.service(mentee.getId()));
			return saveFileName;
		}
		
		return null; 
		
	}
	

	@GetMapping("/myPage")
	public String myPage() {

		return "member/mentee/personal/my_page";
	}
	
	@PostMapping(value = "/myPage/passwordCheck")
	@ResponseBody
	public Boolean passwordCkForm(@RequestBody Mentee mentee, HttpServletRequest request) {

		HttpSession session = request.getSession(false);

		Boolean result = false;

	
		Mentee target = (Mentee) msbidService.service(mentee.getMentee_id());

		if (mentee.getMentee_password().equals(target.getMentee_password())) {

			result = true;
		}

		return result;
	}
	
	@PostMapping(value = "/myPage/updatePasswordCk")
	@ResponseBody
	public Boolean passwordUpdateForm(@RequestBody Mentee mentee, HttpServletRequest request) {

		HttpSession session = request.getSession(false);

		System.out.println(mentee.getMentee_id());
		System.out.println(mentee.getMentee_password());

		Boolean result = false;

		// 비�?번호 변��?? ?�공 ?��? ?�비??

		if ((Boolean) mpuService.service(mentee)) {
			result = true;
		}

		return result;
	}
	
	@GetMapping(value = "mypageapp")
	@ResponseBody
	public Object myPage(HttpSession session) {
		if (session == null)
			return false;
		return session.getAttribute("loginMember");
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		if (session.getAttribute("loginMember") != null)
			session.invalidate();
		return "redirect:/";
	}
	
	 private HashMap<String, Integer> pageSetting(int mentee_id,int page){
			int totalLessonCount = (int)mmllcService.service(mentee_id);	 
			return pagingUtil(page, totalLessonCount);
	}
	 
	private  HashMap<String, Integer> pagingUtil(int page, int totalLessonCount) {
		HashMap<String, Integer> pageMap = new HashMap<String, Integer>();
		
		int totalPage = totalLessonCount % pagingInfoByFour.getPagingSize() == 0 ? 
						totalLessonCount/pagingInfoByFour.getPagingSize() : 
						totalLessonCount/pagingInfoByFour.getPagingSize() + 1;
		
		Integer startPage = (page % pagingInfoByFour.getPagingWidth() == 0 ? page -1 : page)
						/ pagingInfoByFour.getPagingWidth() * pagingInfoByFour.getPagingWidth() + 1;
		Integer endPage = startPage + pagingInfoByFour.getPagingWidth() - 1 ;
		if( endPage > totalPage)
			endPage = totalPage;
		
		Integer afterPage = endPage < totalPage ? endPage + 1 : -1;
		Integer beforePage = startPage == 1 ? -1 : startPage -  1; 
		
		Integer curPage = page;
		pageMap.put("startPage", startPage);
		pageMap.put("endPage", endPage);
		pageMap.put("afterPage", afterPage);
		pageMap.put("beforePage", beforePage);
		pageMap.put("curPage", curPage);
		
		return pageMap;
	}
}
