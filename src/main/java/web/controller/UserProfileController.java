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
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import web.dto.Basket;
import web.dto.Board;
import web.dto.Business;
import web.dto.Comment;
import web.dto.Like;
import web.dto.Rent;
import web.dto.User;
import web.dto.UserFile;
import web.service.face.UserProfileService;
import web.util.Paging;

@Controller
@RequestMapping("/profile")
public class UserProfileController {
	
	private final Logger logger = LoggerFactory.getLogger( this.getClass() );
	
	@Autowired UserProfileService userProfileService;
	
	
	//아무것도없이 /profile했을때 view로연결
	@GetMapping("")
	public String profile( ) {
		
		return "redirect:/profile/view";
	}
	
	
	@RequestMapping("/view")
	public String profileView(
			
			Rent rent
			, Model model
			, HttpSession session
			, User user
			, Like like
			, Board board
			, Comment comment
			, Paging param
			, Basket basket
			) {
		board.setWriterId((String)session.getAttribute("id"));
		user.setId((String)session.getAttribute("id"));
		like.setLikeId((String)session.getAttribute("id"));
		param.setUserId((String)session.getAttribute("id"));
		if((boolean)session.getAttribute("isLogin") == false) {
			return "redirect:/user/login";
		}
		
		Paging paging = userProfileService.getPaging(param);
		paging.setUserId((String)session.getAttribute("id"));

		
		//----------------------------------
		// 세션에서 사용자 ID 가져오기
        String userId = (String) session.getAttribute("id");
        
        
        //추천수 조회
        int likeCount = userProfileService.cntLike(user);
        logger.info("likeCount두두{}",likeCount);
        //회원등급 조회
        User userGrade = userProfileService.selectUserGrade(user);
        logger.info("등급나와라잇{}",userGrade.getGrade());
        //회원등업
        if( (boolean)session.getAttribute("isLogin") == true) {
        	
		userProfileService.updateGrade(likeCount, userGrade);
        }
        User userGradeResult = userProfileService.gradeResult(userGrade);
        logger.info("reudd{}",userGradeResult);
        model.addAttribute("userGrade",userGradeResult.getGrade());
        
        // 사용자의 프로필 이미지 정보 가져오기
        UserFile  img = userProfileService.imgSelect(userId);
        logger.info("이미지 {} : ", img);
        //모델에 이미지 정보 추가
        model.addAttribute("img", img);

        //--------------------------------------------------------------
        //이걸로 user테이블 정보 다가져옴 내가쓰는거 grade, join_date, addr1, addr2, intro
        User profile = userProfileService.userAllSelect(user);
		model.addAttribute("user", profile);
        
		//--------------------------------------------------------------
		
		
		//업체 링크
		Map<String, Object> busy = userProfileService.selectBusiness(user);
		logger.info("업체링크{}",busy);
		model.addAttribute("busy",busy);
		
		
		return "profile/view";
		
		
	}
	

	//회원정보수정
	@GetMapping("/infoupdate")
	public String infoUpdate(User user, Model model, HttpSession session) {
		
		user.setId((String) session.getAttribute("id"));
		
		User loginUser = userProfileService.loginUserSelect(user);
		logger.info("loginUser: {}", loginUser);
		model.addAttribute("user", loginUser);
		
		return "profile/userUpdate";
	}

	@PostMapping("/infoupdate")
	public String infoUpdateProc(User user, HttpSession session, Model model) {
		
		logger.info("회원정보업데이트 : {}", user);
		
		User loginUser = userProfileService.loginUserSelect(user);
		logger.info("loginUser: {}", loginUser);
		
		model.addAttribute("user", loginUser);
		
		userProfileService.updateInfo(user);
		
		session.setAttribute("nick", user.getNick());
		
		return "redirect:/profile/view";
		
	}
	
	
	//회원탈퇴
	@GetMapping("/delete")
	public String delete(User user, HttpSession session, RedirectAttributes rttr) {
	    // 세션에서 로그인된 사용자의 ID 가져오기
		user.setId((String)session.getAttribute("id"));
	    // 현재 로그인된 사용자와 탈퇴하려는 사용자의 ID가 일치하는지 확인
	    if (user.getId().equals(session.getAttribute("id"))) {
	        // 사용자 정보 삭제 로직 수행
	        userProfileService.userDelete(user);

	        // 세션 무효화 (로그아웃)
	        session.invalidate();

	        return "redirect:/main";
	    } else {
	        // 권한이 없는 사용자가 탈퇴를 시도한 경우
	        return "redirect:/main";
	    
	    } 
	}
	
	
	//프로필사진등록
	@GetMapping("/imgupdate")
	public String imgUpdate() {
		
		return "/profile/view";
	}
	
	@PostMapping("/imgupdate")
	
	public String imgUpdateProc(@RequestPart("file") MultipartFile file, HttpSession session, Model model) {
		
		
		// 사용자 ID 가져오기
        String userId = (String) session.getAttribute("id");
        
        // 프로필 사진 업로드 및 데이터베이스에 저장
        userProfileService.imgUpdate(file, userId);
        
        // 사용자의 프로필 이미지 정보 가져오기
        UserFile img = userProfileService.imgSelect(userId);
        logger.info("프로필이미지ajax {} : ", img);
        model.addAttribute("img", img);
        //모델에 이미지 정보 추가
        
        

        return "jsonView";
	}
	
	

	//프로필사진 삭제
	@GetMapping("/imgdelete")
	public String imgDelete(UserFile userFile, HttpSession session) {
		
		logger.info("userFile 프로필삭제:{}", userFile);
		userFile.setId((String) session.getAttribute("id"));
		userProfileService.imgDelete(userFile);
		
		
		return "jsonView";
	}
	
	
	
	//자기소개
	@GetMapping("/introduce")
	public String intoduce(User user, Model model) {
		
		User intro = userProfileService.userAllSelect(user);
		
		logger.info("인트로{}",intro.getIntro());
		
		model.addAttribute("user", intro);
		
		return "/profile/introduce";
	}


	@PostMapping("/introduce")
	public String introduceProc(User user, Model model) {

		logger.info("자기소개 업데이트 : {}",user);
		//자기소개 업데이트
		userProfileService.introduceUpdate(user);
		
		User intro = userProfileService.userAllSelect(user);
		
		
		model.addAttribute("user", intro);
		
		return "jsonView";
	}
	
	
	
	@RequestMapping("/confirm")
	public String confirm(Rent rent, Model model,HttpSession session) {
		logger.info("렌트 번호{}",rent);
		
		rent.setRenterId((String)session.getAttribute("id"));
		
		//업데이트 여부 확인 confirm
        boolean confirmStatus = userProfileService.updateRentStatus(rent);
        logger.info("성공{}",confirmStatus);
        model.addAttribute("confirm",confirmStatus);
        
        boolean checkCon = userProfileService.checkConfirm(rent);
		logger.info("컨트롤러 컨펌{}",checkCon);
		session.setAttribute("checkCon", checkCon);
		model.addAttribute("checkCon", checkCon);
        
      
		return "jsonView";
		
	}
	
	@GetMapping("/business")
	public void business( User user
			, HttpSession session, Model model
			) {
		user.setId((String) session.getAttribute("id"));
		
	}
	
	@PostMapping("/business")
	public String businessProc(
			Business busi, User user
			, HttpSession session, Model model
			) {
		logger.info("업체{}",busi);
		
		busi.setId((String) session.getAttribute("id"));
		user.setId((String) session.getAttribute("id"));
		
		Map<String, Object> busy = userProfileService.selectBusiness(user);
		logger.info("업체링크{}",busy);
		model.addAttribute("busy",busy);
		userProfileService.insertBusiness(busi, user);
		return "redirect:/profile/view";
	}
	
	@PostMapping("/email")
	public String email(
			User user, HttpSession session
			) {
		logger.info("이메일{}",user.getEmailAgr());
		
		user.setId((String)session.getAttribute("id"));
		
		userProfileService.updateEmail(user);
		
		
		
		return "/profile/view";
	}
	
	@GetMapping("/checkEmail")
	public String checkEmail(
			User user, Model model
			, HttpSession session
			) {
		user.setId((String)session.getAttribute("id"));
		
		boolean email = userProfileService.checkAgree(user);
		model.addAttribute("email",email);
		
		return "jsonView";
		
	}
	
	@GetMapping("/rentList")
	public String rentList(
			Board board, User user
			, HttpSession session, Model model) {
		user.setId((String)session.getAttribute("id"));
		board.setWriterId((String)session.getAttribute("id"));
		
		//내 게시물에 예약한 정보
		List<Map<String,Object>> myList = userProfileService.myRentList(board);
		logger.info("예약 정보 나와라아아아아{}",myList);
		model.addAttribute("myList",myList);
		
		//내가 예약한 정보
		List<Map<String,Object>> list = userProfileService.rentList(user);
		model.addAttribute("list",list);
		
		return "/profile/rentList";
		
	}
	
	@GetMapping("/basket")
	public String basket(
			Board board, Model model
			, HttpSession session ) {
		
		board.setWriterId((String)session.getAttribute("id"));

		//내 찜 목록
		List<Map<Board, Object>> basketList = userProfileService.selectBasketList(board);
		logger.info("바스켓또{}",basketList);
		model.addAttribute("basketList",basketList);
		
		return "/profile/basket";
		
	}
	

	
	
	//내가 쓴 글 보기 뷰에서 분리함
	 @RequestMapping("/myBoardList")
	    public String myBoardList(Board board, Model model, HttpSession session) {
		 
		 	board.setWriterId((String) session.getAttribute("id"));
		 	List<Board> boardList = userProfileService.boardSelectById(board);
			logger.info("내가쓴글목록: {}", boardList);
			
			// 모델에 페이징 정보와 글 목록 추가 board_no, menu, title, write_date, hit
			model.addAttribute("board", boardList);
		 
		 
	        return "profile/myBoardList";
	    }
	 
	 //내가 쓴 댓글 보기 뷰에서 분리함
	 @RequestMapping("/myCmtList")
	 	public String myBoardList(Comment comment, Model model, HttpSession session) {
		 
		 	comment.setWriterId((String) session.getAttribute("id"));
			List<Map<String, Object>> commentList = userProfileService.commentSelectById(comment);
			logger.info("내가쓴댓글목록: {}", commentList);
			
			model.addAttribute("comment", commentList);
		 
		 
		 return "profile/myCmtList";
	 }
	 
		@GetMapping("/yourProfile")
		public void yourProfile(
				User user, Model model
				, Business busi, Board board
				, @RequestParam("boardNo") String boardNo
				) {
			String id = userProfileService.selectyourId(boardNo);
			user.setId(id);
			logger.info("다른사람 프로필아이디{}", id);
			
			User your = userProfileService.yourProfile(id);
			logger.info("다른사람 프로필정보{}", your);
			model.addAttribute("your",your);
			
			//업체 링크
			Map<String, Object>  link = userProfileService.selectYourUrl(user);
			logger.info("업체링크{}",link);
			model.addAttribute("link",link);
			
			UserFile img = userProfileService.yourImg(id);
			logger.info("프로필이미지ajax {} : ", img);
			model.addAttribute("img", img);
			
			board.setWriterId(id);
		 	List<Map<String, Object>> yourList = userProfileService.yourBoard(board);
			logger.info("내가쓴글목록: {}", yourList);
			// 모델에 페이징 정보와 글 목록 추가 board_no, menu, title, write_date, hit
			model.addAttribute("yourList", yourList);
			
			
			
		}
		
		
		@GetMapping("/yourProfileCmt")
		public void yourProfileCmt(
				User user
				, Model model
				, Business busi
				, Comment comment
				, Board board
				, @RequestParam("cmtNo") String cmtNo
				) {
			
			String id = userProfileService.yourCmtIdSelect(cmtNo);
			user.setId(id);
			logger.info("댓글에서 불러온 다른사람 프로필아이디{}", id);
			
			User your = userProfileService.yourCmtProfileSelect(id);
			logger.info("댓글에서 불러온 다른사람 프로필정보{}", your);
			model.addAttribute("your",your);
			
			//업체 링크
			Map<String, Object>  link = userProfileService.yourCmtUrlSelect(user);
			logger.info("댓글에서 불러온 업체링크{}",link);
			model.addAttribute("link",link);
			
			UserFile img = userProfileService.yourCmtImgSelect(id);
			logger.info("댓글에서 불러온 프로필이미지ajax {} : ", img);
			model.addAttribute("img", img);
			
			board.setWriterId(id);
		 	List<Map<String, Object>> yourList = userProfileService.yourCmtBoardSelect(board);
			logger.info("댓글에서 불러온 내가쓴 댓글목록: {}", yourList);
			// 모델에 페이징 정보와 글 목록 추가 board_no, menu, title, write_date, hit
			model.addAttribute("yourList", yourList);
		}
		

	
	
	
}
