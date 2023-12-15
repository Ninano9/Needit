package web.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import web.dto.Banner;
import web.dto.Board;
import web.dto.Business;
import web.dto.Comment;
import web.dto.Like;
import web.dto.Report;
import web.dto.User;
import web.service.face.AdminService;

@Controller
public class AdminController {
	private final Logger logger = LoggerFactory.getLogger( this.getClass() );

	@Autowired AdminService adminService;
	@Autowired JavaMailSender mailSender;
	
	//소개 페이지(오프닝 페이지)
	@GetMapping("/opening")
	public void opening() {}
	
	//푸터
	@GetMapping("/layout/footer")
	public void main() {}
	
	//이용약관
	@GetMapping("/terms/term")
	public void term() {}
	
	//개인정보처리방침
	@GetMapping("/terms/privacyPolicy")
	public void privacyPolicy() {}

	//위치기반서비스 이용약관
	@GetMapping("/terms/locationPolicy")
	public void locationPolicy() {}

	//고객센터
	@GetMapping("/admin/customerService")
	public String customerService() {
		return "admin/customerService";
	}
	
	//고객센터 -> FAQ
	@GetMapping("/admin/faq")
	public String faq() {
		return "admin/faq";
	}
	
	//고객센터 -> 1:1채팅
	@GetMapping("/admin/chat")
	public String chat() {
		return "redirect:../message/list?boardNo=-1&menu=-1&cate=-1&receiverId=admin";
		
	}
	
	//-------------------------------------
	
	//관리자 로그아웃
	@RequestMapping("/main")
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/main";
	}
	
	//관리자 메인페이지
	@GetMapping("/admin")
	public String admin() {
		return "/admin/admin";
	}
	
	//관리자 일일 방문자수 조회
	@GetMapping("/admin/dayVisit")
	public void dayVisit() {}

	//관리자 업체요청 목록 
	@GetMapping("/admin/businessReq")
	public void businessReq(
			Business business,
			User user,
			Model model
			) {
		List<Map<String, Object>> businessList = adminService.businessList();
		model.addAttribute("businessList", businessList);
		
	}
	
	//업체목록 수정(승인, 취소)
	@PostMapping("/admin/approveBusiness")
	@ResponseBody
	public String approveBusiness(Business business) {
		adminService.approveBusiness(business);
		
		return"done";
	}
	@PostMapping("/admin/cancelBusiness")
	@ResponseBody
	public String cancelBusiness(Business business) {
		adminService.cancelBusiness(business);
		
		return"cancle";
	}

	//관리자 메인배너 접속
	@GetMapping("/admin/bannerUpdate")
	public void banner() {}
	
	//관리자 메인배너 수정
	@PostMapping("/admin/bannerUpdate")
	public String bannerUpdate( 
			Banner bannerParam, 
			List<MultipartFile> file,
			HttpSession session,
			Model model
			) {
		logger.info("bannerParam : {}", bannerParam.getBannerNo());
		
		adminService.bannerUpdate(bannerParam, file);
		//--------------------------------------
		
		List<Banner> bannerNames = new ArrayList<Banner>();
		bannerNames = adminService.getBannerNo();
		logger.info(bannerNames.toString());
		
		model.addAttribute("file", bannerNames);
		
		//배너사진 관리자 페이지 세션에 저장
		session.setAttribute("file", bannerNames);
		return "admin/bannerUpdate";
	}
	
	
	//메인에서 공지사항 list 조회
	@GetMapping("/admin/noticeList")
	public void noticeList(Model model, HttpSession session) {
		
		List<Board> noticeList = adminService.noticeList(); 
		model.addAttribute("noticeList", noticeList);
//		session.setAttribute("noticeList", noticeList);
		
//		logger.info("공지사항 목록 : {}", noticeList);
	}
	
	
	//관리자 공지조회
	@GetMapping("/admin/noticeUpdate")
	public void noticeUpdate(Model model, Board board) {
		
		List<Map<String, Object>> noticeList = adminService.adminNoticeList();
		model.addAttribute("noticeList", noticeList);
	}
	
	//관리자 공지등록
	@PostMapping("/admin/noticeUpdate")
	public String noticeUpdateProc(
			Board board,
			HttpSession session
			) {
		
		board.setWriterId((String) session.getAttribute("id"));
		board.setWriterNick((String) session.getAttribute("nick"));
		
		adminService.writeNotice(board);
		adminService.deleteNotice(board);
		
		return "redirect:/admin/noticeUpdate";
	}
	
	
	//관리자 회원이메일 발송 
	@GetMapping("/admin/emailSend")
	public void emailSend(
			User user,
			HttpSession session,
			Model model
			) {
		user.setEmail((String) session.getAttribute("email"));
		
		//이메일 받아오기
		List<Map<String, Object>> emailList = adminService.emailList();
		model.addAttribute("emailList", emailList);
		
	}
	
	
	// mailSending 코드
	@PostMapping(value ="/admin/emailSend")
	@ResponseBody
	public String emailSend(
			@RequestParam List<String> m_email,
		    @RequestParam String title,
		    @RequestParam String content,
			HttpSession session
			) {

		/* 이메일 보내기 */
        String setFrom = "Needit@gmail.com"; //보내는 이메일
//        List<String> toMail = m_email; //받는 사람 이메일
//        String title = "Needit 방문을 환영합니다.";
//        String content = 
//                "Needit 홈페이지를 방문해주셔서 감사합니다." +
//                "<br><br>" + 
//                "저희 서비스를 이용해 주셔서 감사합니다." + 
//                "<br>" + 
//                "많은 이용 부탁드립니다.";
        
        try {
            
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            String[] toMailArray = m_email.toArray(new String[0]);
            helper.setTo(toMailArray);


            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
            
        }catch(Exception e) {
            e.printStackTrace();
        }
        
        return "forward:/admin/emailSend";
	}
	
	//신고목록
	@GetMapping("/admin/reportList")
	public void report(
			Model model,
			HttpSession session,
			Board board,
			Report report,
			Comment comment,
			Like like
			) {
		//게시글 신고 목록
		List<Map<String, Object>> reportBoardList = adminService.getBoardReportInfo();
		model.addAttribute("reportBoardList", reportBoardList);
		
		
		//댓글 신고 목록
		List<Map<String, Object>> reportCmtList = adminService.getCmtReportInfo();
		model.addAttribute("reportCmtList", reportCmtList);
	}
	
	
	//게시글, 댓글 신고목록 삭제
	@PostMapping("/admin/reportList")
	public String deleteBoard(Board board, Comment cmt) {

		adminService.deleteBoard(board);
		adminService.deleteComment(cmt);
		
		return "redirect:/admin/reportList";
	}

	//댓글 신고목록 삭제
//	@PostMapping("/admin/reportList")
//	public String deleteCmt(Comment cmt) {
//
//		
//		return "redirect:/admin/reportList";
//	}
	
	//-------------------------------------

	
	
	
}
