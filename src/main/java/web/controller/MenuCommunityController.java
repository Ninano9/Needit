package web.controller;

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

import web.dto.Board;
import web.dto.Comment;
import web.dto.FileTb;
import web.dto.Like;
import web.service.face.MenuCommunityService;
import web.util.Paging;

@Controller
@RequestMapping("/community")
public class MenuCommunityController {
	private final Logger logger = LoggerFactory.getLogger( this.getClass() );
	
	@Autowired private MenuCommunityService menuCommunityService;
	
	@GetMapping("/list")
	public String list( Paging param, Model model ) {
		//페이징 계산
		Paging paging = menuCommunityService.getPaging(param);
		
		//게시글 목록 조회
		List<Map<String, Object>> list = menuCommunityService.list(paging); 
		model.addAttribute("paging", paging);
		
 		//게시글마다 댓글 몇개 달렸는지 카운트
 		for (Map<String, Object> postMap : list) {
 			String boardNo = postMap.get("BOARD_NO").toString(); 
 			int cmtCnt = menuCommunityService.getCmtCnt(boardNo);
 			postMap.put("cmtCnt", cmtCnt);
		}
		
		model.addAttribute("list", list);
		
		return "menu/community/list";
	}
	
	//검색한 게시판 목록 그리드타입 띄우기
	@GetMapping("/search")
	public String search( Board board, Model model, Paging param, HttpSession session ) {
		//페이징 계산
		Paging paging = menuCommunityService.getPaging(param);
		
		//게시글 목록 조회
		List<Map<String, Object>> list = menuCommunityService.searchList(paging);
		model.addAttribute("paging", paging);
		
 		//게시글마다 댓글 몇개 달렸는지 카운트
 		for (Map<String, Object> postMap : list) {
 			String boardNo = postMap.get("BOARD_NO").toString(); 
 			int cmtCnt = menuCommunityService.getCmtCnt(boardNo);
 			postMap.put("cmtCnt", cmtCnt);
		}
 		
		model.addAttribute("list", list);
		
		return "menu/community/searchList";
	}
	
	//게시글 상세 조회
	@GetMapping("/view")
	public String view( Board board, Model model, HttpSession session ) {

		//게시글 번호를 전달받지 못하면 목록으로 이동
		if( board.getBoardNo() < 1 ) {
			return "redirect:/community/list";
		}
		
		//게시글 상세 조회
		board = menuCommunityService.view(board);
		model.addAttribute("board", board);
		
		//첨부파일 정보 전달
		List<FileTb> fileTb = menuCommunityService.getAttachFile( board );
		model.addAttribute("fileTb", fileTb);
		
		//추천 상태 조회
		Like like = new Like();
		like.setBoardNo(board.getBoardNo()); //게시글 번호
		like.setLikeId((String)session.getAttribute("id")); //로그인한 아이디

		//추천 상태 전달
		boolean isLike = menuCommunityService.isLike(like);
		model.addAttribute("isLike", isLike);
		model.addAttribute("cntLike", menuCommunityService.getTotalCntLike(like));
		
		return "menu/community/view";
	}

	//파일 다운로드
	@GetMapping("/download")
	public String down( FileTb fileTb, Model model ) {
		
		//첨부파일 정보 조회
		fileTb = menuCommunityService.getFile( fileTb );
		model.addAttribute("downFile", fileTb);
		
		return "down";
	}
	
	//게시글 작성 폼
	@GetMapping("/write")
	public String write() {
		return "menu/community/write";
	}
	
	//게시글 작성 처리
	@PostMapping("/write")
	public String writeProc( Board writeParam, List<MultipartFile> file, HttpSession session ) {
		//작성자 id, nick 세팅
		writeParam.setWriterId((String) session.getAttribute("id"));
		writeParam.setWriterNick((String) session.getAttribute("nick"));
		
		//게시글 저장
		menuCommunityService.write( writeParam, file );
		
		return "redirect:/community/view?boardNo=" + writeParam.getBoardNo() + "&menu=" + writeParam.getMenu() + "&cate=" + writeParam.getCate();
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
		updateParam = menuCommunityService.view(updateParam);
		model.addAttribute("updateBoard", updateParam);
		
		//첨부파일 정보 전달
		List<FileTb> boardfile = menuCommunityService.getAttachFile( updateParam );
		model.addAttribute("boardfile", boardfile);
		
		return "menu/community/update";
	} 
	
	//게시글 수정 처리
	@PostMapping("/update")
	public String updateProc(
			Board updateParam
			, List<MultipartFile> file
			, int[] delFileno
			, HttpSession session
			, Model model) {
		updateParam.setWriterId((String) session.getAttribute("id"));
		updateParam.setWriterNick((String) session.getAttribute("nick"));
		
		menuCommunityService.updateBoard(updateParam, file, delFileno);
		
		return "redirect:/community/view?boardNo=" + updateParam.getBoardNo() + "&menu=" + updateParam.getMenu() + "&cate=" + updateParam.getCate();
		 
	} 

	//게시글 삭제
	@RequestMapping("/delete")
	public String delete(Board board, HttpSession session) {
		board.setWriterId((String) session.getAttribute("id"));
		menuCommunityService.delete(board);
		return "redirect:/community/list?menu=" + board.getMenu() + "&cate=" + board.getCate();
	}


	//추천 적용
	@GetMapping("/like")
	public ModelAndView like( Like like, ModelAndView mav, HttpSession session  ) {
		
		//추천 정보 토글
		like.setLikeId((String) session.getAttribute("id"));
		boolean result = menuCommunityService.like(like);
		mav.addObject("result", result);
		
		//추천 수 조회
		int cnt = menuCommunityService.getTotalCntLike(like);
		mav.addObject("cnt", cnt);

		mav.setViewName("jsonView");
		
		return mav;
	}
	
	//댓글 입력하기
	@PostMapping("/comment")
	public String insert(Comment commentParam, Board board) {
		menuCommunityService.commentInsert(commentParam);
		
		return "redirect: /community/view?boardNo=" + board.getBoardNo();
	}
	
	//댓글 불러오기
	@GetMapping("/comment/list")
	public String viewComment(Comment commentParam, Model model) {
		//댓글 목록 조회
		List<Map<String,Object>> commentList = menuCommunityService.viewComment(commentParam);
		model.addAttribute("commentList", commentList);
		
		return "jsonView";
	}
	
	//댓글 삭제
	@GetMapping("/comment/delete")
	public String delete(Comment commentDelete) {
		menuCommunityService.delete(commentDelete);
		
		return "jsonView";
	}
	
	//게시글 신고
	@PostMapping("/report")
	public void report() {}
	
}
