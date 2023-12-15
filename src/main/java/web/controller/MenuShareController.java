package web.controller;

import java.util.Arrays;
import java.util.Date;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import web.dto.Basket;
import web.dto.Board;
import web.dto.Booking;
import web.dto.Comment;
import web.dto.FileTb;
import web.dto.Like;
import web.dto.Rent;
import web.dto.User;
import web.service.face.MenuShareService;
import web.util.Paging;

@Controller
@RequestMapping("/share")
public class MenuShareController {
	
	//로그 객체 
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	
	@Autowired MenuShareService menuShareFace;
	
	@GetMapping("/list")
	public String list(
			Board board, Paging param
			, Model model,FileTb file
			, Like like, Basket basket
			, HttpSession session) {
		logger.info("list get");
		
		//페이징 계산
		Paging paging = menuShareFace.getPaging(param);
		paging.setUserId((String)session.getAttribute("id"));
		
		//나눔 게시판 조회
		List<Map<String, Object>> list = menuShareFace.selectBoardStatus(paging, board);
		
		logger.info("리스또{}",list);
		model.addAttribute("list",list);
		model.addAttribute("paging",paging);
		
		//댓글 수 조회
 		for (Map<String, Object> postMap : list) {
 			String boardNo = postMap.get("BOARD_NO").toString(); 
 			int cmtCnt = menuShareFace.getCmtCnt(boardNo);
 			postMap.put("cmtCnt", cmtCnt);
		}
		
		logger.info("메뉴{}",paging);
		logger.info("카테고리 들어오나?{}",param.getCate());

		
		return "menu/share/list";
	}
	
	//게시판 목록 리스트타입 띄우기
	@GetMapping("/listType")
	public String listType( 
			Paging param, Model model
			, Board board) {
		logger.info("param : {}", param);
		
		//페이징 계산
		Paging paging = menuShareFace.getPaging(param);
		
		//게시글 목록 조회
		List<Map<String, Object>> list = menuShareFace.selectBoardStatus(paging, board); 
		model.addAttribute("paging", paging);
		model.addAttribute("list", list);
		
		//게시글마다 댓글 몇개 달렸는지 카운트
       for (Map<String, Object> postMap : list) {
          String boardNo = postMap.get("BOARD_NO").toString(); 
          int cmtCnt = menuShareFace.getCmtCnt(boardNo);
          postMap.put("cmtCnt", cmtCnt);
      }
		
		return "menu/share/listType";
	}
	//검색한 게시판 목록 그리드타입 띄우기
		@GetMapping("/search")
		public String search( Board board, Model model, Paging param ) {
			logger.info("검색주제 : {}", param.getSelectSub());
			logger.info("검색어 : {}", param.getSearchText());
			logger.info("검색한 메뉴 : {}", param.getMenu());
			logger.info("검색한 카테 : {}", param.getCate());
			
			//페이징 계산
			Paging paging = menuShareFace.getPaging(param);
			logger.info("검색된 게시글 수  : {}", paging.getTotalCount());
			
			List<Map<String, Object>> list = menuShareFace.searchList(paging);
			logger.info("검색된 게시글 내용  : {}", list);
			
			model.addAttribute("paging", paging);
			model.addAttribute("list", list);
			
			return "menu/share/searchList";
		}
		
		//검색한 게시판 목록 리스트타입 띄우기
		@GetMapping("/searchType")
		public String searchType( Board board, Model model, Paging param ) {
			logger.info("검색주제 : {}", param.getSelectSub());
			logger.info("검색어 : {}", param.getSearchText());
			logger.info("검색한 메뉴 : {}", param.getMenu());
			logger.info("검색한 카테 : {}", param.getCate());
			
			//페이징 계산
			Paging paging = menuShareFace.getPaging(param);
			logger.info("검색된 게시글 수  : {}", paging.getTotalCount());
			
			List<Map<String, Object>> list = menuShareFace.searchList(paging);
			logger.info("검색된 게시글 내용  : {}", list);
			
			model.addAttribute("paging", paging);
			model.addAttribute("list", list);
			
			return "menu/share/searchType";
		}
	
	@RequestMapping("/view")
	public String view(
			Board board, HttpSession session
			, Model model
			) {
		Board view = menuShareFace.view(board);
		logger.info("보드넘버{}",view);
		model.addAttribute("view", view);
		
		//첨부파일 정보 전달
		List<FileTb> boardfile = menuShareFace.getAttachFile( board );
		model.addAttribute("boardfile", boardfile);
		
		
		//추천 상태 조회
		Like like = new Like();
		like.setBoardNo(board.getBoardNo()); //게시글 번호
		like.setLikeId((String)session.getAttribute("id")); //로그인한 아이디

		//추천 상태 전달
		boolean isLike = menuShareFace.isLike(like);
		model.addAttribute("isLike", isLike);
		model.addAttribute("cntLike", menuShareFace.getTotalCntLike(like));
		
		return "menu/share/view";
	}
	
	//대여 처리
	@PostMapping("/rent")
	public String rent( Rent rentParam, Model model ) {
		logger.info("결제파라미터 : {}", rentParam);
		
		//대여신청 대기처리
		menuShareFace.rent(rentParam);
		
		return "jsonView";
	}
	
	@GetMapping("/write")
	public String write( User user, Model model, HttpSession session  ) {
		
 		user.setId((String)session.getAttribute("id"));
 		User writeUser = menuShareFace.writeAddrSelect(user);
 		model.addAttribute("user", writeUser);
 		logger.info("바뀐주소 : {}", writeUser);
		return "menu/share/write";
	}
	
	@PostMapping("/write")
	public String writeProc(
		Board writerContent,
		HttpSession session,
		List<MultipartFile> upFile
			) {
		writerContent.setWriterId((String)session.getAttribute("id"));
		writerContent.setWriterNick((String)session.getAttribute("nick"));
		//글작성
		menuShareFace.write(writerContent,upFile);
		logger.info("writerContent{}",writerContent);
		
		return "redirect:/share/view?boardNo=" + writerContent.getBoardNo() + "&menu=" + writerContent.getMenu() + "&cate=" + writerContent.getCate();
	}
	
	@GetMapping("/update")
	public String update(Board updateParam, Model model) {
		
		if( updateParam.getBoardNo() < 1 ) {
			return "redirect:./list";
		}
		//상세보기 페이지 아님 표시
		updateParam.setHit(-1);
		
		
		//상세보기 게시글 조회
		updateParam = menuShareFace.view(updateParam);
		model.addAttribute("updateBoard", updateParam);
		
		//첨부파일 정보 전달
		List<FileTb> boardfile = menuShareFace.getAttachFile( updateParam );
		model.addAttribute("boardfile", boardfile);

		
		
		return "menu/share/update";
		
	}
	
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
		
		menuShareFace.updateBoard(updateParam, file, delFileno);
		
		return "redirect:./view?boardNo=" + updateParam.getBoardNo() + "&menu=" + updateParam.getMenu() + "&cate=" + updateParam.getCate();
	}
	
	@RequestMapping("/delete")
	public String delete(Board deleteParam, Model model) {
		
		if( deleteParam.getBoardNo() < 1 ) {
			return "redirect:/share/list";
		}

		menuShareFace.delete( deleteParam );
		
		return "redirect:./list?menu=" + deleteParam.getMenu() + "&cate=" + deleteParam.getCate();
	
	}
	
	@RequestMapping("/like")
	public ModelAndView like( Like like, ModelAndView mav, HttpSession session  ) {
		logger.info("like : {}", like);
		
		//추천 정보 토글
		like.setLikeId((String) session.getAttribute("id"));
		boolean result = menuShareFace.like(like);
		mav.addObject("result", result);
		
		//추천 수 조회
		int cnt = menuShareFace.getTotalCntLike(like);
		mav.addObject("cnt", cnt);

		mav.setViewName("jsonView");
		
		return mav;
	}
	
	//댓글입력
	@PostMapping("/comment/insert")
	public String commentinsert(
			Comment comment, HttpSession session
			, Model model) {
		comment.setWriterId((String)session.getAttribute("id"));
		comment.setWriterNick((String)session.getAttribute("nick"));
		
		logger.info("코멘트나와야함{}",comment);
		
		//댓글 입력
		menuShareFace.commentinsert(comment);
		
		return "redirect:/share/comment/list?boardNo=" + comment.getBoardNo();
	}
	
	//댓글 리스트
	@GetMapping("/comment/list")
	public String list(
			Comment comment
			, HttpSession session
			, Model model) {
		comment.setWriterId((String)session.getAttribute("id"));
		comment.setWriterNick((String)session.getAttribute("nick"));
		//댓글 리스트 전달
		List<Map<String,Object>> commentList = menuShareFace.list(comment);
		model.addAttribute("commentList", commentList);
		
		return "jsonView";
		
	}
	
	//댓글 삭제
	@RequestMapping("/comment/delete")
	public String delete(Comment commentDelete) {
		logger.info("commentDelete : {}", commentDelete);
		
		menuShareFace.commentdelete(commentDelete);
		
		return "jsonView";
	}
	@GetMapping("/book")
	public String book() {
		
		return "menu/share/book";
		
	}
	
	@PostMapping("/book")
	@ResponseBody
	public boolean book(
			Booking book, HttpSession session
			, Model model) {
		book.setBookerId((String)session.getAttribute("id"));
		logger.info("예약정보{}", book);
		logger.info("나와라잇{}", book.getStartTime());
		logger.info("나와라잇2{}", book.getEndTime());
		
		model.addAttribute("currentDate", new Date());
		model.addAttribute("today", new Date());
		
		//예약 확인
		boolean check = menuShareFace.checkBook(book);
		logger.info("예약 확인{}",check);
		model.addAttribute("check",check);
		
		return check;
		
	}
	
	@RequestMapping("/basket")
	public String basket(
			Basket basket, Model model
			, HttpSession session) {
		logger.info("바스켓이다옹{}",basket);
		
		basket.setBasketId((String)session.getAttribute("id"));
		
		boolean bas = menuShareFace.checkBasket(basket);
		logger.info("찜여부{}",bas);
		model.addAttribute("check", bas);
		
		return "jsonView";
	}
	

	
	
	
	
	
	
	
	
	

}
