package web.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import web.dto.Basket;
import web.dto.Board;
import web.dto.Comment;
import web.dto.FileTb;
import web.dto.Like;
import web.dto.Rent;
import web.dto.User;
import web.service.face.MenuRentService;
import web.util.Paging;

@Controller
@RequestMapping("/rent")
public class MenuRentController {
	private final Logger logger = LoggerFactory.getLogger( this.getClass() );
	
	@Autowired private MenuRentService menuRentService;
	
	//게시판 목록 그리드타입 띄우기
	@GetMapping("/list")
	public String list( Paging param, Model model, HttpSession session ) {
		
		//페이징 계산
		Paging paging = menuRentService.getPaging(param);
		//각 유저가 찜한 상품목록 조회를 위한 Id 저장
		paging.setUserId((String)session.getAttribute("id"));
		
		//게시글 목록 조회
		List<Map<String, Object>> list = menuRentService.list(paging);
		model.addAttribute("paging", paging);
		model.addAttribute("list", list);
		
 		//게시글마다 댓글 몇개 달렸는지 카운트
 		for (Map<String, Object> postMap : list) {
 			String boardNo = postMap.get("BOARD_NO").toString(); 
 			int cmtCnt = menuRentService.getCmtCnt(boardNo);
 			postMap.put("cmtCnt", cmtCnt);
		}
		
		return "menu/rent/list";
	}
	
	//게시판 목록 리스트타입 띄우기
	@GetMapping("/listType")
	public String listType( Paging param, Model model ) {
		
		//페이징 계산
		Paging paging = menuRentService.getPaging(param);
		
		//게시글 목록 조회
		List<Map<String, Object>> list = menuRentService.list(paging); 
		model.addAttribute("paging", paging);
		model.addAttribute("list", list);

 		//게시글마다 댓글 몇개 달렸는지 카운트
 		for (Map<String, Object> postMap : list) {
 			String boardNo = postMap.get("BOARD_NO").toString(); 
 			int cmtCnt = menuRentService.getCmtCnt(boardNo);
 			postMap.put("cmtCnt", cmtCnt);
		}		
		
		return "menu/rent/listType";
	}

	//검색한 게시판 목록 그리드타입 띄우기
	@GetMapping("/search")
	public String search( Board board, Model model, Paging param, HttpSession session ) {
		
		//페이징 계산
		Paging paging = menuRentService.getPaging(param);
		//각 유저가 찜한 상품목록 조회를 위한 Id 저장
		paging.setUserId((String)session.getAttribute("id"));
		
		//게시글 목록 조회
		List<Map<String, Object>> list = menuRentService.searchList(paging);
		model.addAttribute("paging", paging);
		model.addAttribute("list", list);

 		//게시글마다 댓글 몇개 달렸는지 카운트
 		for (Map<String, Object> postMap : list) {
 			String boardNo = postMap.get("BOARD_NO").toString(); 
 			int cmtCnt = menuRentService.getCmtCnt(boardNo);
 			postMap.put("cmtCnt", cmtCnt);
		}		
		
		return "menu/rent/searchList";
	}
	
	//검색한 게시판 목록 리스트타입 띄우기
	@GetMapping("/searchType")
	public String searchType( Board board, Model model, Paging param ) {
		
		//페이징 계산
		Paging paging = menuRentService.getPaging(param);
		
		//게시글 목록 조회
		List<Map<String, Object>> list = menuRentService.searchList(paging);
		model.addAttribute("paging", paging);
		model.addAttribute("list", list);

 		//게시글마다 댓글 몇개 달렸는지 카운트
 		for (Map<String, Object> postMap : list) {
 			String boardNo = postMap.get("BOARD_NO").toString(); 
 			int cmtCnt = menuRentService.getCmtCnt(boardNo);
 			postMap.put("cmtCnt", cmtCnt);
		}		
 		
		return "menu/rent/searchType";
	}
	
	//게시글 상세 조회
	@GetMapping("/view")
	public String view( Board board, Model model, HttpSession session ) {

		//게시글 번호를 전달받지 못하면 목록으로 이동
		if( board.getBoardNo() < 1 ) {
			return "redirect:/rent/list";
		}
		
		//게시글 상세 조회
		board = menuRentService.view(board);
		model.addAttribute("board", board);
		logger.info(board.toString());
		
		//첨부파일 정보 전달
		List<FileTb> fileTb = menuRentService.getAttachFile( board );
		model.addAttribute("fileTb", fileTb);
		
		//추천 상태 조회
		Like like = new Like();
		like.setBoardNo(board.getBoardNo()); //게시글 번호
		like.setLikeId((String)session.getAttribute("id")); //로그인한 아이디

		//추천 상태 전달
		boolean isLike = menuRentService.isLike(like);
		model.addAttribute("isLike", isLike);
		model.addAttribute("cntLike", menuRentService.getTotalCntLike(like));
		
		//대여상태 조회
		List<Map<String, Object>> status = menuRentService.getStatus(board);
		logger.info("status : {}", status);
		model.addAttribute("status", status);
		
		return "menu/rent/view";
	}

	//파일 다운로드
	@GetMapping("/download")
	public String down( FileTb fileTb, Model model ) {
		
		//첨부파일 정보 조회
		fileTb = menuRentService.getFile( fileTb );
		model.addAttribute("downFile", fileTb);
		
		return "down";
	}

	//대여 처리
	@PostMapping("/rent")
	public String rent( Rent rentParam, Model model ) {
		logger.info("결제파라미터 : {}", rentParam);
		
		//대여신청 대기처리
		menuRentService.rent(rentParam);
		
		return "jsonView";
	}
	
	//게시글 작성 폼
	@GetMapping("/write")
	public String write( User user, Model model, HttpSession session ) {
		
 		user.setId((String)session.getAttribute("id"));
 		User writeUser = menuRentService.writeAddrSelect(user);
 		model.addAttribute("user", writeUser);
 		logger.info("바뀐주소 : {}", writeUser);
 		
		return "menu/rent/write";
	}
	
	//게시글 작성 처리
	@PostMapping("/write")
	public String writeProc( Board writeParam, List<MultipartFile> file, HttpSession session ) {
		logger.info("writeParam : {}", writeParam );
		
		//작성자 id, nick 세팅
		writeParam.setWriterId((String) session.getAttribute("id"));
		writeParam.setWriterNick((String) session.getAttribute("nick"));
		
		//게시글 저장
		menuRentService.write( writeParam, file );
		
		return "redirect:/rent/view?boardNo=" + writeParam.getBoardNo() + "&menu=" + writeParam.getMenu() + "&cate=" + writeParam.getCate();
	}							

	//게시글 수정 폼
	@GetMapping("/update")
	public String update(Board updateParam, Model model) {
		
		if( updateParam.getBoardNo() < 1 ) {
			return "redirect:./list";
		}
		//상세보기 페이지 아님 표시
		updateParam.setHit(-1);
		
		
		//상세보기 게시글 조회
		updateParam = menuRentService.view(updateParam);
		model.addAttribute("updateBoard", updateParam);
		
		//첨부파일 정보 전달
		List<FileTb> boardfile = menuRentService.getAttachFile( updateParam );
		model.addAttribute("boardfile", boardfile);
		
		return "menu/rent/update";
	} 

	//게시글 수정 처리
	@PostMapping("/update")
	public String updateProc(
			Board updateParam
			, List<MultipartFile> file
			, int[] delFileno
			, HttpSession session
			, Model model) {
		
		logger.info("updateParam {}", updateParam);
		logger.info("file {}", file);
		logger.info("delFileno {}", Arrays.toString(delFileno));


		updateParam.setWriterId((String) session.getAttribute("id"));
		updateParam.setWriterNick((String) session.getAttribute("nick"));
		
		menuRentService.updateBoard(updateParam, file, delFileno);
		
		return "redirect:/rent/view?boardNo=" + updateParam.getBoardNo() + "&menu=" + updateParam.getMenu() + "&cate=" + updateParam.getCate();
		 
	} 

	//게시글 삭제
	@RequestMapping("/delete")
	public String delete(Board board, HttpSession session) {
		board.setWriterId((String) session.getAttribute("id"));
		menuRentService.delete(board);
		
		return "redirect:/rent/list?menu=" + board.getMenu() + "&cate=" + board.getCate();
	}

	//추천 적용
	@GetMapping("/like")
	public ModelAndView like( Like like, ModelAndView mav, HttpSession session  ) {
		
		//추천 정보 토글
		like.setLikeId((String) session.getAttribute("id"));
		boolean result = menuRentService.like(like);
		mav.addObject("result", result);
		
		//추천 수 조회
		int cnt = menuRentService.getTotalCntLike(like);
		mav.addObject("cnt", cnt);

		mav.setViewName("jsonView");
		
		return mav;
	}
	
	//댓글 입력하기
	@PostMapping("/comment")
	public String insert(Comment commentParam, Board board) {
		
		menuRentService.commentInsert(commentParam);
		
		return "redirect: /rent/view?boardNo=" + board.getBoardNo();
	}
	
	//댓글 불러오기
	@GetMapping("/comment/list")
	public String viewComment(Comment commentParam, Model model) {
		logger.info("commentParam: {}", commentParam);
		
		//댓글 목록 조회
		List<Map<String,Object>> commentList = menuRentService.viewComment(commentParam);
		model.addAttribute("commentList", commentList);
		
		return "jsonView";
	}
	
	//댓글 삭제
	@GetMapping("/comment/delete")
	public String delete(Comment commentDelete) {
		logger.info("commentDelete : {}", commentDelete);
		
		menuRentService.delete(commentDelete);
		
		return "jsonView";
	}
	
	@RequestMapping("/basket")
	public String basket(Basket basket, Model model, HttpSession session) {
		
		basket.setBasketId((String)session.getAttribute("id"));
		
		boolean bas = menuRentService.checkBasket(basket);
		model.addAttribute("check", bas);
		
		return "jsonView";
	}
	
}
