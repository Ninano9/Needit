package web.controller;

import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
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
import web.dto.User;
import web.service.face.MenuPleaseService;
import web.util.Paging;

@Controller
@RequestMapping("/please")
public class MenuPleaseController {
   private final Logger logger = LoggerFactory.getLogger( this.getClass() );
   
   @Autowired private MenuPleaseService menuPleaseService;
   
 //게시판 목록 띄우기 그리드타입
 	@GetMapping("/list")
 	public String list( Paging param, Model model, HttpSession session ) {
 		logger.info("param : {}", param);
 		
 		//페이징 계산
 		Paging paging = menuPleaseService.getPaging(param);
 		
 		//각 유저가 찜한 상품목록 조회를 위한 Id 저장
 		paging.setUserId((String)session.getAttribute("id"));
 		
 		//게시글 목록 조회
 		List<Map<String, Object>> list = menuPleaseService.list(paging); 
 		model.addAttribute("paging", paging);
 		logger.info("list: {}", list);
 		
 		
 		//게시글마다 댓글 몇개 달렸는지 카운트
 		for (Map<String, Object> postMap : list) {
 			String boardNo = postMap.get("BOARD_NO").toString(); 
 			int cmtCnt = menuPleaseService.getCmtCnt(boardNo);
 			postMap.put("cmtCnt", cmtCnt);
		}
 		
 		model.addAttribute("list", list);

 		
 		return "menu/please/list";
 	}
   
 	
 	
 	//게시판 목록 리스트타입 띄우기
 	@GetMapping("/listType")
 	public String listType( Paging param, Model model ) {
 		logger.info("param : {}", param);
 		
 		//페이징 계산
 		Paging paging = menuPleaseService.getPaging(param);
 		
 		//게시글 목록 조회
 		List<Map<String, Object>> list = menuPleaseService.list(paging); 
 		model.addAttribute("paging", paging);
 		logger.info("list: {}", list);
 		
 		//게시글마다 댓글 몇개 달렸는지 카운트
 		for (Map<String, Object> postMap : list) {
 			String boardNo = postMap.get("BOARD_NO").toString(); 
 			int cmtCnt = menuPleaseService.getCmtCnt(boardNo);
 			postMap.put("cmtCnt", cmtCnt);
		}
 		
 		model.addAttribute("list", list);
 		
 		return "menu/please/listType";
 	}
 	
 	//검색한 게시판 목록 그리드타입 띄우기
 	@GetMapping("/search")
	public String search( Board board, Model model, Paging param, HttpSession session ) {
		
		//페이징 계산
		Paging paging = menuPleaseService.getPaging(param);
		//각 유저가 찜한 상품목록 조회를 위한 Id 저장
		paging.setUserId((String)session.getAttribute("id"));
		
		//게시글 목록 조회
		List<Map<String, Object>> list = menuPleaseService.searchList(paging);
		model.addAttribute("paging", paging);
		
		
		//게시글마다 댓글 몇개 달렸는지 카운트
 		for (Map<String, Object> postMap : list) {
 			String boardNo = postMap.get("BOARD_NO").toString(); 
 			int cmtCnt = menuPleaseService.getCmtCnt(boardNo);
 			postMap.put("cmtCnt", cmtCnt);
		}
		
		model.addAttribute("list", list);
		
		return "menu/please/searchList";
	}
 	
 	//검색한 게시판 목록 리스트타입 띄우기
 		@GetMapping("/searchType")
 		public String searchType( Board board, Model model, Paging param ) {
 			
 			//페이징 계산
 			Paging paging = menuPleaseService.getPaging(param);
 			
 			//게시글 목록 조회
 			List<Map<String, Object>> list = menuPleaseService.searchList(paging);
 			model.addAttribute("paging", paging);
 			
 			//게시글마다 댓글 몇개 달렸는지 카운트
 	 		for (Map<String, Object> postMap : list) {
 	 			String boardNo = postMap.get("BOARD_NO").toString(); 
 	 			int cmtCnt = menuPleaseService.getCmtCnt(boardNo);
 	 			postMap.put("cmtCnt", cmtCnt);
 			}
 			
 			model.addAttribute("list", list);
 			
 			return "menu/please/searchType";
 		}
 	
 	//게시판 상세 조회
	@RequestMapping("/view")
	public String view( Board board, Model model, HttpSession session ) {

		//게시글 번호를 전달받지 못하면 목록으로 이동
		if( board.getBoardNo() < 1 ) {
			return "redirect:/please/list";
		}
		
		//게시글 상세 조회
		board = menuPleaseService.view(board);
		model.addAttribute("board", board);
		
		//첨부파일 정보 전달
		List<FileTb> fileTb = menuPleaseService.getAttachFile( board );
		model.addAttribute("fileTb", fileTb);
		
		//추천 상태 조회
		Like like = new Like();
		like.setBoardNo(board.getBoardNo()); //게시글 번호
		like.setLikeId((String)session.getAttribute("id")); //로그인한 아이디

		//추천 상태 전달
		boolean isLike = menuPleaseService.isLike(like);
		model.addAttribute("isLike", isLike);
		model.addAttribute("cntLike", menuPleaseService.getTotalCntLike(like));		
		
		
		return "menu/please/view";
	}

   
   
   
   
   //게시글 작성 폼
 	@GetMapping("/write")
 	public String write(User user, Model model, HttpSession session ) {
 		
 		
 		user.setId((String)session.getAttribute("id"));
 		User writeUser = menuPleaseService.writeAddrSelect(user);
 		model.addAttribute("user", writeUser);
 		logger.info("바뀐주소 : {}", writeUser);
 		
 		return "menu/please/write";
 	}
 	
 	//게시글 작성 처리
 	@PostMapping("/write")
 	public String writeProc( Board writeParam, List<MultipartFile> file, HttpSession session) {
 		
 		logger.info("writeParam : {}", writeParam );
 		
 		
 		//작성자 id, nick 세팅
 		writeParam.setWriterId((String) session.getAttribute("id"));
 		writeParam.setWriterNick((String) session.getAttribute("nick"));
 		
 		
 		
 		//게시글 저장
 		menuPleaseService.write( writeParam, file );
 		
 		return "redirect:/please/view?boardNo=" + writeParam.getBoardNo();
 	}
   
   
   	//파일 다운로드
 	@RequestMapping("/download")
 	public String down( FileTb fileTb, Model model ) {
 		
 		//첨부파일 정보 조회
 		fileTb = menuPleaseService.getFile( fileTb );
 		model.addAttribute("downFile", fileTb);
 		
 		return "down";
 	}
   
   
   
   //글수정
   @GetMapping("/update")
   public String update(Board updateParam, Model model) {
	   
	   if (updateParam.getBoardNo() < 1) {
		   return "redirect:./list";
	   }
		
		//상세보기 페이지 아님 표시
	 	updateParam.setHit(-1);
	   
	 	
	   //상세보기 게시글 조회
	   	updateParam = menuPleaseService.view(updateParam);
	   	model.addAttribute("updateBoard", updateParam);
	   	
	   	//첨부파일 정보 전달
	   	List<FileTb> fileTb = menuPleaseService.getAttachFile(updateParam);
	   	model.addAttribute("fileTb", fileTb);
	   	
	   	
		return "menu/please/update";
		   
   }
   
   @PostMapping("/update")
   public String updateProc(
		   
		   Board updateParam
		   , List<MultipartFile> file
		   , int[] delFileno
		   
		   ,HttpSession session
		   ,Model model
		   
		   ) {
	   
	   logger.info("updateParam: {}", updateParam);
	   logger.info("file: {}", file);
	   logger.info("delFileno: {}", Arrays.toString(delFileno) );
	   
	   
	   updateParam.setWriterId((String) session.getAttribute("id"));
	   updateParam.setWriterNick((String) session.getAttribute("nick"));
	   
	   
	   menuPleaseService.update(updateParam, file, delFileno);
	   
	   return "redirect:./view?boardNo=" + updateParam.getBoardNo();
   }
   
   
   //글삭제
   @RequestMapping("/delete")
   public String delete(Board deleteParam, Model model ) {
	   
	   if( deleteParam.getBoardNo() < 1 ) {
			return "redirect:/please/list";
		}
	   
	   menuPleaseService.delete(deleteParam);
	   
	   return "redirect:./list?menu=" + deleteParam.getMenu() + "&cate=" + deleteParam.getCate();
   }
   
   
   	//추천 적용
 	@RequestMapping("/like")
 	public ModelAndView like( Like like, ModelAndView mav, HttpSession session  ) {
 		logger.info("like : {}", like);
 		
 		//추천 정보 토글
 		like.setLikeId((String) session.getAttribute("id"));
 		boolean result = menuPleaseService.like(like);
 		mav.addObject("result", result);
 		
 		//추천 수 조회
 		int cnt = menuPleaseService.getTotalCntLike(like);
 		mav.addObject("cnt", cnt);

 		mav.setViewName("jsonView");
 		
 		return mav;
 	}
   
 	
 	//댓글 목록
 	@GetMapping("/comment/list")
 	public String viewComment(Comment commentParam, Model model) {
 		logger.info("commentParam: {}", commentParam);
 		
 		List<Map<String, Object>> commentList = menuPleaseService.viewComment(commentParam);
 		
 		model.addAttribute("commentList", commentList);
 		
 		return "jsonView";
 	}
 	
 	
   //댓글 작성
 	@PostMapping("/comment")
 	public String insert(Comment commentParam, Board board) {
 		
 		menuPleaseService.commentInsert(commentParam);
 		
 		return "redirect:/please/view?boardNo=" + commentParam.getBoardNo();
 	}
   
 	
 	//댓글 삭제
 	@GetMapping("/comment/delete")
 	public String delete(Comment commnetDelete) {
 		logger.info("commentDelete", commnetDelete);
 		
 		menuPleaseService.delete(commnetDelete);
 		
 		return "jsonView";
 	}
   
   
 	@GetMapping("/book")
	public String book() {
		
		return "menu/please/book";
		
	}

 	
 	@RequestMapping("/basket")
	public String basket(
			Basket basket, Model model
			, HttpSession session) {
		logger.info("바스켓이다옹{}",basket);
		
		basket.setBasketId((String)session.getAttribute("id"));
		
		boolean bas = menuPleaseService.checkBasket(basket);
		logger.info("찜여부{}",bas);
		model.addAttribute("check", bas);
		
		return "jsonView";
	}
   
   
   
}