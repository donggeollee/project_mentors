package com.tje.mentors.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.Mapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tje.mentors.model.AdminAccount;
import com.tje.mentors.model.DetailLessonView;
import com.tje.mentors.model.Lesson;
import com.tje.mentors.model.LessonStatus;
import com.tje.mentors.model.LessonViewForAdmin;
import com.tje.mentors.model.Mentee;
import com.tje.mentors.model.Mentor;
import com.tje.mentors.model.MyLessonList;
import com.tje.mentors.model.MyMenteeList;
import com.tje.mentors.repository.*;
import com.tje.mentors.services.*;
import com.tje.mentors.setting.PagingInfoByTen;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private MentorSearchByIdService msbyidService;
	
	@Autowired
	private LessonStatusPDetailSelectService lspdsService;
	
	@Autowired
	private DetailLessonSearchService dlsService;
	
	@Autowired
	private MenteeMemberDeleteService menteemdService;
	
	
	@Autowired
	private MenteeSearchByName menteesbnService;
	
	
	@Autowired
	private MenteeSearchByNameCount menteesbcService;
	
	@Autowired
	private MenteeSelectAllService menteeallService;
	
	@Autowired
	private MenteeSelectAllBySortService menteesortallService;
	
	@Autowired
	private MenteeCountService menteeCountService;

	@Autowired
	private AdminAccountCheckService adminAccountCheckService;
	
	@Autowired
	private MentorCountService mentorCountService;
	
	@Autowired
	private MentorSelectAllService mentorSelectAllService;
	
	@Autowired
	private MentorOrderByDefaultService mobdService;
	
	@Autowired
	private MentorOrderByNameService mobnService;
	
	@Autowired
	private MentorOrderByLatestService moblService;
	
	@Autowired
	private MentorOrderByOldestService moboService;
	
	@Autowired
	private MentorSearchByNameService msbnService;
	
	@Autowired
	private MentorMemberDeleteService mmdService;
	
	@Autowired
	private MentorCountByNameService mcbnService;
	
	@Autowired
	private LessonSelectAllService lsaService;
	
	@Autowired
	private LessonViewAdminSelectByNameService lvasbnService;
	
	@Autowired
	private PagingInfoByTen pagingInfoByTen;
	
	@Autowired
	private LessonCountByNameService lcbnService;
	
	@Autowired
	private LessonCountAllService lcaService;
	
	@Autowired
	private LessonCountByFilterService lcbfService;
	
	@Autowired
	private LessonOrderByLatestService loblService;
	
	@Autowired
	private LessonOrderByNameService lobnService;
	
	@Autowired
	private LessonOrderByOldestService loboService;
	
	@Autowired
	private LessonFilterByCategoryBigService lfbcbService;
	
	@Autowired
	private LessonDeleteService ldService;
	
	@GetMapping
	public String loginMain() {
		return "admin/adminLogin";
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
	
	public ArrayList<Integer> pageProcess(int totalCount, int page) {
		int totalPageCount = totalCount / pagingInfoByTen.getPagingSize() +
				(totalCount % pagingInfoByTen.getPagingSize() == 0? 0 : 1);
		
		int startPageNo = (page % pagingInfoByTen.getPageRange() == 0 ? page - 1 : page) / pagingInfoByTen.getPageRange()
				* pagingInfoByTen.getPageRange() + 1;
		
		int endPageNo = startPageNo + pagingInfoByTen.getPageRange() - 1;
		if (endPageNo > totalPageCount)
			endPageNo = totalPageCount;
		
		int beforePageNo = startPageNo != 1 ? startPageNo - pagingInfoByTen.getPageRange() : -1;
		int afterPageNo = endPageNo != totalPageCount ? endPageNo + 1 : -1;
		
		ArrayList<Integer> pageResult = new ArrayList<Integer>();
		pageResult.add(totalPageCount);
		pageResult.add(startPageNo);
		pageResult.add(endPageNo);
		pageResult.add(beforePageNo);
		pageResult.add(afterPageNo);
		pageResult.add(page);
		pageResult.add(totalCount);
		
		return pageResult;
	}
	
	@PostMapping("/login")
	@ResponseBody
	public boolean login(@RequestBody AdminAccount adminAccount,HttpSession session) {
		
		AdminAccount target = (AdminAccount)adminAccountCheckService.service();
		System.out.println(adminAccount.getAdmin_id());
		System.out.println(adminAccount.getAdmin_password());
		if(target.getAdmin_id().equals(adminAccount.getAdmin_id()) && target.getAdmin_password().equals(adminAccount.getAdmin_password())) {
			session.setAttribute("adminLogon", target);
			return true;
		}
		else {
			return false;
		}
	}
	
	@GetMapping("/main")
	public String adminMain() {
		return "admin/adminMain";
	}
	
	@GetMapping("/sidebar")
	public String adminSideBar() {
		return "admin/adminSidebar";
	}
	
	
	@GetMapping({"/manage/mentor", "/manage/mentor/{pageNo}"})
	public String mentorMange(@PathVariable(value = "pageNo", required = false) Integer page, Model model) {
		if(page == null) page = 1;
		int totalCount = (Integer)mentorCountService.service();
		model.addAttribute("mentorCount", totalCount);
		model.addAttribute("mentorList", (List<Mentor>)mentorSelectAllService.service(page));
		model.addAttribute("sortType", "none");
		pageProcess(totalCount, page, model);
		return "admin/mentorManage";
	}
	
	@GetMapping({"/manage/mentor/order/defaults","/manage/mentor/order/defaults/{pageNo}"})
	public String defaultOrderFilter(@PathVariable(value = "pageNo", required = false) Integer page, Model model) {
		if(page == null) page = 1;
		int totalCount = (Integer)mentorCountService.service();
		model.addAttribute("mentorCount", totalCount);
		model.addAttribute("mentorList", (List<Mentor>) mobdService.service(page));
		model.addAttribute("sortType", "none");
		pageProcess(totalCount, page, model);
		return "admin/mentorManage";
	}
	
	@GetMapping({"/manage/mentor/order/name","/manage/mentor/order/name/{pageNo}"})
	public String nameOrderFilter(@PathVariable(value = "pageNo", required = false) Integer page, Model model) {
		if(page == null) page = 1;
		int totalCount = (Integer)mentorCountService.service();
		model.addAttribute("mentorCount", totalCount);
		model.addAttribute("mentorList", (List<Mentor>) mobnService.service(page));
		pageProcess(totalCount, page, model);
		model.addAttribute("sortType", "order");
		model.addAttribute("sortName", "name");
		return "admin/mentorManage";
	}
	
	@GetMapping({"/manage/mentor/order/latest","/manage/mentor/order/latest/{pageNo}"})
	public String latestOrderFilter(@PathVariable(value = "pageNo", required = false) Integer page, Model model) {
		if(page == null) page = 1;
		int totalCount = (Integer)mentorCountService.service();
		model.addAttribute("mentorCount", totalCount);
		model.addAttribute("mentorList", (List<Mentor>) moblService.service(page));
		pageProcess(totalCount, page, model);
		model.addAttribute("sortType", "order");
		model.addAttribute("sortName", "latest");
		return "admin/mentorManage";
	}
	
	@GetMapping({"/manage/mentor/order/oldest", "/manage/mentor/order/oldest/{pageNo}"})
	public String oldestOrderFilter(@PathVariable(value = "pageNo", required = false) Integer page, Model model) {
		if(page == null) page = 1;
		int totalCount = (Integer)mentorCountService.service();
		model.addAttribute("mentorCount", totalCount);
		model.addAttribute("mentorList", (List<Mentor>) moboService.service(page));
		pageProcess(totalCount, page, model);
		model.addAttribute("sortType", "order");
		model.addAttribute("sortName", "oldest");
		return "admin/mentorManage";
	}
	
	@PostMapping("/mentorSearch")
	@ResponseBody
	public HashMap<String, Object> searchByNameFilter(@RequestBody String searchName) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Mentor> resultList = (List<Mentor>) msbnService.service(searchName, 1);
		resultMap.put("mentorSearchResultList", resultList);
		ArrayList<Integer> pageResult = pageProcess((Integer)mcbnService.service(searchName), 1);
		resultMap.put("mentorSearchPageResult", pageResult);
		
		return resultMap;
	}

	@GetMapping("/mentorSearch/{searchValue}/{pageNo}")
	public String mentorSearch(@PathVariable(value = "searchValue", required = false) String searchValue,
			@PathVariable(value = "pageNo", required = false) Integer page, Model model){
		
		if(page == null)	page=1;
		int totalCount = (Integer)mcbnService.service(searchValue);
		List<Mentor> result = (List<Mentor>) msbnService.service(searchValue, page);
		model.addAttribute("mentorCount", totalCount);
		model.addAttribute("mentorList", result);
		pageProcess(totalCount, page, model);
		model.addAttribute("sortType", "search");
		model.addAttribute("sortName", searchValue);
		return "admin/mentorManage";
	}
	
	@PostMapping("/mentorSucession")
	@ResponseBody
	public boolean mentorSuccessionFunction(@RequestBody String target) {
		System.out.println(target);
		String[] arr = target.split(",");
		ArrayList<Integer> targetValue = new ArrayList<Integer>();
		for(int i = 1; i < arr.length; i++) {
			System.out.println(arr[i]);
			targetValue.add(Integer.parseInt(arr[i]));
		}
		
		boolean result = (Boolean)mmdService.service(targetValue);
		
		return result;
		
	}
	
	@GetMapping({"/manage/lesson","/manage/lesson/{pageNo}"})
	public String lessonManage(@PathVariable(value = "pageNo", required = false) Integer page, Model model) {
		
		if(page == null) page = 1;
		List<LessonViewForAdmin> result = (List<LessonViewForAdmin>)lsaService.service(page);
		
		int totalCount = (Integer)lcaService.service();
		model.addAttribute("lessonList", result);
		model.addAttribute("lessonCount", totalCount);
		model.addAttribute("sortType", "none");
		pageProcess(totalCount, page, model);
		return "admin/lessonManage";
	}
	
	@PostMapping("/lessonSearch")
	@ResponseBody
	public HashMap<String, Object> lessonSearch(@RequestBody String searchValue){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("lessonSearchResultList", (List<LessonViewForAdmin>) lvasbnService.service(searchValue, 1));
		ArrayList<Integer> pageResult = pageProcess((Integer)lcbnService.service(searchValue), 1);
		resultMap.put("lessonSearchPageResult", pageResult);
		
		return resultMap;
		
	}
	
	@GetMapping("/lessonSearch/{searchValue}/{pageNo}")
	public String lessonSearch(@PathVariable(value = "searchValue", required = false) String searchValue,
			@PathVariable(value = "pageNo", required = false) Integer page, Model model){
		
		if(page == null)	page=1;
		int totalCount = (Integer)lcbnService.service(searchValue);
		List<LessonViewForAdmin> result = (List<LessonViewForAdmin>) lvasbnService.service(searchValue, page);
		model.addAttribute("lessonCount", totalCount);
		model.addAttribute("lessonList", result);
		pageProcess(totalCount, page, model);
		model.addAttribute("sortType", "search");
		model.addAttribute("sortName", searchValue);
		return "admin/lessonManage";
	}
	
	@GetMapping({"/manage/lesson/order/{sort}","/manage/lesson/order/{sort}/{pageNo}"})
	public String order(@PathVariable(value = "sort", required = false) String target,
			@PathVariable(value = "pageNo", required = false) Integer page,
			Model model) {
		if(page == null)	page=1;
		List<LessonViewForAdmin> result = null;
		if(target.equals("name")) {
			result = (List<LessonViewForAdmin>) lobnService.service(page);
		} else if(target.equals("latest")) {
			result = (List<LessonViewForAdmin>) loblService.service(page);
		} else if(target.equals("oldest")) {
			result = (List<LessonViewForAdmin>) loboService.service(page);
		} else {
			return "redirect:" + "/admin/manage/lesson";
		}
		int totalCount = (Integer)lcaService.service();
		model.addAttribute("lessonCount", totalCount);
		model.addAttribute("lessonList", result);
		model.addAttribute("sortType", "order");
		model.addAttribute("sortName", target);
		pageProcess(totalCount, page, model);
		return "admin/lessonManage";
	}
	
	@GetMapping({"/manage/lesson/category/{big}","/manage/lesson/category/{big}/{pageNo}"})
	public String filterCategory(@PathVariable(value = "big") String target,
					@PathVariable(value = "pageNo", required = false) Integer page, Model model) {
		
		if(page == null)	page=1;
		List<LessonViewForAdmin> result = null;
		if(target.equals("IT") || target.equals("Music") || target.equals("Exercise") || target.equals("Cook") || target.equals("Language")) {
			result = (List<LessonViewForAdmin>) lfbcbService.service(target, page);
		} else {
			return "redirect:" + "/admin/manage/lesson";
		}
		int totalCount = (Integer)lcbfService.service(target);
		model.addAttribute("lessonCount", totalCount);
		model.addAttribute("lessonList", result);
		model.addAttribute("sortType", "category");
		model.addAttribute("sortName", target);
		pageProcess(totalCount, page, model);
		return "admin/lessonManage";
	}
	
	@PostMapping("/lessonSucession")
	@ResponseBody
	public boolean lessonSuccessionFunction(@RequestBody String target) {
		System.out.println(target);
		String[] arr = target.split(",");
		ArrayList<Integer> targetValue = new ArrayList<Integer>();
		for(int i = 1; i < arr.length; i++) {
			System.out.println(arr[i]);
			targetValue.add(Integer.parseInt(arr[i]));
		}
		
		boolean result = (Boolean)ldService.service(targetValue);
		
		return result;
		
	}
	
	
	// 3) BY_JIEUN - MENTEE MAIN MANAGE 
		@GetMapping(value = {"/manage/mentee/{pageNo}","/manage/mentee"})
		public String menteeMangaeList(
			 @PathVariable(value = "pageNo", required = false) Integer page, 
			 Model model) {
			
			if( page == null ) {
				page = 1;
			}
				
			// 占�? 硫섑떚 移댁슫??/ ?占쎌씠吏� ?占쎌씠吏� 媛쒖닔 媛�?占쎌삤占�? 
			int totalCount = (Integer) menteeCountService.service();
					
			pageProcess(totalCount, page, model);
					
		 	     
		    model.addAttribute("menteelist", (List<Mentee>)menteeallService.service(page));
		    model.addAttribute("menteeCount", totalCount);
		    model.addAttribute("sortType","none");
		    
		      return "admin/menteeManage";
		   }
		
		
		
		@GetMapping(value = {"/manage/mentee/order/{sortName}/{pageNo}",
							"/manage/mentee/order/{sortName}"})
		public String menteeMange(Model model,
				@PathVariable(value = "pageNo",required = false)Integer page,
				@PathVariable(value = "sortName",required = false)String sortName) {
			
			
			if( sortName == null) {
				sortName = "defaultOrder";
			}

			if( page == null ) {
				page = 1;
			}
			// ?占쎌씠吏�?? ?占쎈낫, ?占쎈젹 ?占쎈쫫 占�? ?占쎌뼱二쇨퀬 
			// (sort)占�? 硫섑떚 紐⑸줉 媛�?占쎌삤占�?
			
			// 占�? 硫섑떚 移댁슫??/ ?占쎌씠吏� ?占쎌씠吏� 媛쒖닔 媛�?占쎌삤占�? 
			int totalCount = (Integer) menteeCountService.service();
			
			pageProcess(totalCount, page, model);
			
			model.addAttribute("menteelist",(List<Mentee>)menteesortallService.service(page,sortName));
			model.addAttribute("sortName",sortName);
			model.addAttribute("sort",sortName+"/");
			model.addAttribute("sortType","order");
			
			return "admin/menteeManage";
		}
		
		@PostMapping("/menteeSearch")
		@ResponseBody
		public HashMap<String, Object> searchByNameMenteeFilter(
				@RequestBody String searchName,Model model) {
			int page = 1;
			int totalCount = (Integer) menteesbcService.service(searchName);
			
			int totalPageCount = totalCount / pagingInfoByTen.getPagingSize() +
			(totalCount % pagingInfoByTen.getPagingSize() == 0? 0 : 1); 
					
					
			int startPageNo =
					(page % pagingInfoByTen.getPageRange() == 0 ? page-1 : page)
					/ pagingInfoByTen.getPageRange() * pagingInfoByTen.getPageRange() + 1;
					
			int endPageNo = startPageNo + pagingInfoByTen.getPageRange() -1;
			if (endPageNo > totalPageCount)
				endPageNo = totalPageCount;
					
			int beforePageNo = startPageNo != 1 ? startPageNo - pagingInfoByTen.getPageRange() : -1;
			int afterPageNo = endPageNo != totalPageCount ? endPageNo +1 : -1;
					
			ArrayList<Integer> pageList = new ArrayList<Integer>();
			pageList.add(totalPageCount);
			pageList.add(startPageNo);
			pageList.add(endPageNo);
			pageList.add(beforePageNo);
			pageList.add(afterPageNo);
			pageList.add(page);
			pageList.add(totalCount);
			
			List<Mentee> resultList = (List<Mentee>) menteesbnService.service(searchName,page);
			
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("resultList", resultList);
			resultMap.put("pagingList", pageList);
			
			
			return resultMap;
			
		}
		
		@GetMapping(value = "/menteeSearch/{searchValue}/{pageNo}")
			public String menteeSearchItem(Model model,
			@PathVariable(value = "pageNo",required = false)Integer page,
			@PathVariable(value = "searchValue",required = false)String searchValue) {
			
			if( page == null ) {
			page = 1;
			}
			 
			int totalCount = (Integer) menteesbcService.service(searchValue);
			
			pageProcess(totalCount, page, model);
			
			List<Mentee> resultList = (List<Mentee>) menteesbnService.service(searchValue,page);
			
			model.addAttribute("menteelist",resultList);
			model.addAttribute("search",searchValue+"/");
			model.addAttribute("sortType","nameSearch");
			model.addAttribute("menteeCount",totalCount);
			
			return "admin/menteeManage";
		}
		
		@PostMapping("/menteeSucession")
		@ResponseBody
		public boolean menteeSuccessionFunction(@RequestBody String target) {
			System.out.println(target);
			String[] arr = target.split(",");
			ArrayList<Integer> targetValue = new ArrayList<Integer>();
			for(int i = 1; i < arr.length; i++) {
				System.out.println(arr[i]);
				targetValue.add(Integer.parseInt(arr[i]));
			}
			
			boolean result = (Boolean)menteemdService.service(targetValue); 
			
			return result;
			    
		}
	
		@PostMapping("/manage/lessonDetail")
		@ResponseBody
		public HashMap<String, Object> lessonDetail(@RequestBody Lesson lesson,Model model) {
				
			// lesson detail view service
			DetailLessonView detailLessonView = (DetailLessonView) dlsService.service(lesson);
			
			int lesson_id = detailLessonView.getLesson_id();
			// lesson_stauts "P" -> search service
			ArrayList<MyMenteeList> myMenteeList =(ArrayList<MyMenteeList>)lspdsService.service(lesson_id);
		
			for(MyMenteeList tmpppp : myMenteeList) {
				System.out.println(tmpppp.getMentee_name());
			}
			
			// mentor search service
			Mentor mentor = new Mentor();
			mentor.setMentor_id(detailLessonView.getMentor_id());
			Mentor mentorInfoList = (Mentor)msbyidService.service(mentor);
			
			
			HashMap<String, Object> resultMap = new HashMap<>();
			resultMap.put("mentorInfoList", mentorInfoList);
			resultMap.put("lessonDetail", detailLessonView);
			resultMap.put("MenteeList", myMenteeList);
			
			
			
			return resultMap;
			    
		}
		
		@GetMapping("/logout")
		public String logout(HttpSession session) {
			if (session.getAttribute("adminLogon") != null)
				session.invalidate();
			return "redirect:/admin/";
		}
}
