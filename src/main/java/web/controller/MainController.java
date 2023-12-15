package web.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import web.dto.Banner;
import web.dto.Board;
import web.dto.Business;
import web.dto.FileTb;
import web.service.face.MainService;
import web.util.Paging;

@Controller
public class MainController {
	private final Logger logger = LoggerFactory.getLogger( this.getClass() );

	@Autowired MainService mainService;
	
	//메인배너 불러오기
	@GetMapping("/main")
	public String main(
			Model model,
			Board board,
			FileTb file,
			Paging param,
			Business business
			) {
		logger.info("메인화면 진입");
		
		//페이징 계산-검색용
//		Paging paging = mainService.getPaging(param);
//		logger.info("{}", paging);

		
		//배너 조회,출력
		List<Banner> bannerNames = new ArrayList<Banner>();
		bannerNames = mainService.getBannerNo();
//		logger.info(bannerNames.toString());
		model.addAttribute("file", bannerNames);
		
		//최신 게시글 조회 출력_대여게시판
		List<Map<String, Object>> listRent = mainService.getBoardRentInfo();
//		logger.info("메인에 출력할 대여 list : {}", listRent);
		model.addAttribute("boardRentInfo", listRent);
		model.addAttribute("boardNo", board.getBoardNo());
		
		//최신 게시글 조회 출력_나눔게시판
		List<Map<String, Object>> listShare = mainService.getBoardShareInfo();
//		logger.info("메인에 출력할 나눔 list : {}", listShare);
		model.addAttribute("boardShareInfo", listShare);
		
		//니딧 인증 업체
		List<Map<String, Object>> listBusiness = mainService.getBusinessInfo();
//		logger.info("메인에 출력할 업체 list : {}", listBusiness);
		model.addAttribute("businessInfo", listBusiness);
		
		//오늘의 인기 게시글
		List<Map<String, Object>> listCommu = mainService.getCommuByLike();
//		logger.info("메인에 출력할 커뮤 list : {}", listCommu);
		model.addAttribute("commuHit", listCommu);
		
		
		return "main/main";
	}//@Get main() End.
	
	//전체검색 목록
//    @GetMapping("/mainSearch")
//    public String mainSearch() {
//    	return "main/mainSearch";
//    }

	//----------------------------------------------------
	
	//검색
	//게시판 목록 그리드타입 띄우기
//	@PostMapping("/mainSearch")
//	public String list( Paging param, Model model ) {
//		logger.info("param : {}", param);
//		
//		//페이징 계산
//		Paging paging = mainService.getPaging(param);
//		
//		//게시글 목록 조회
//		List<Map<String, Object>> list = mainService.list(paging); 
//		model.addAttribute("paging", paging);
//		model.addAttribute("list", list);
//		
//		return "main/mainSearch";
//	}
    
	//검색한 게시판 목록 리스트타입 띄우기
	@GetMapping("/mainSearch")
	public String mainSearch( Board board, Model model, Paging param ) {
		logger.info("mainSeacrh[GET]");
		logger.info("검색주제 : {}", param.getSelectSub());
		logger.info("검색어 : {}", param.getSearchText());
		logger.info("검색한 메뉴 : {}", param.getMenu());
		logger.info("검색한 카테 : {}", param.getCate());
		
		//페이징 계산
		Paging paging = mainService.getPaging(param);
		logger.info("검색된 게시글 수  : {}", paging.getTotalCount());
		
		List<Map<String, Object>> list = mainService.searchList(paging);
		logger.info("검색된 게시글 내용  : {}", list);
		
		model.addAttribute("paging", paging);
		model.addAttribute("list", list);
		
		return "main/mainSearch";
	}
	
	
	
    
	//내 주변지도
	@GetMapping("/admin/mainpageMap")
	public String map() {
//		logger.info("/admin/mainpageMap");
		return "/admin/mainpageMap";
	}
}
