package web.controller;

import java.util.List;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import web.dto.User;
import web.service.face.UserProfileService;
import web.service.face.UserService;


@Controller
@RequestMapping("/user")
public class LoginController {

	private final Logger logger = LoggerFactory.getLogger( this.getClass() );

	@Autowired UserService userService;
	@Autowired JavaMailSender mailSender;
	@Autowired UserProfileService userProfileService;

	@GetMapping("/signup")
	public void signUp() {}
	
	@PostMapping("/signup")
	public String signUpProc( User user) {
		
		userService.join(user);
		
		return "redirect:/main";
	}
	
	@RequestMapping("/idCheck")
	public @ResponseBody boolean idCheck(User user) {
		boolean result = userService.idCheck(user);
		
		logger.info("{}",result);
		
		return result;
		
	}
	
	@RequestMapping("/nickCheck")
	public @ResponseBody boolean ncikCheck(User user) {
		boolean result = userService.ncikCheck(user);
		
		logger.info("{}",result);
		
		return result;
		
	}

	
	@GetMapping("/login")
	public void login(Model model,HttpSession session) {
		logger.info("[get]");
	}
	
	@PostMapping("/login")
	public ResponseEntity<String> loginProc( User user, HttpSession session, HttpServletResponse response, Model model) {
		
		boolean islogin = userService.login(user);
		user = userService.infoNick(user);
		session.setAttribute("isLogin", islogin);
		
		if(islogin) {
			session.setAttribute("id", user.getId());
			session.setAttribute("nick", user.getNick());
			session.setAttribute("addr1", user.getAddr1());
			session.setAttribute("email", user.getEmail());
			session.setAttribute("name", user.getName());
			session.setAttribute("phone", user.getPhone());
			session.setAttribute("business", user.getBusinessStatus());
			
			return ResponseEntity.ok("success");
		} else {
			
			return ResponseEntity.ok("fail"); // 로그인 페이지로 리다이렉트
		}
	
		
	}

	@GetMapping("/findid")
	public void findid() {}
	
	@PostMapping("/findid")
	public String findidProc(User user, HttpSession session) {
		
		List<User> ids = userService.findid(user);
		session.setAttribute("ids", ids);
		
		return "redirect:/user/findIdInfo";
	}
	
	@GetMapping("/findIdInfo")
	public void findIdInfo() {}
	
	@GetMapping("/findpw")
	public void findpw() {}
	
	@PostMapping("/findpw")
	public String findpwProc(User user, HttpSession session) {
		
		user = userService.findpw(user);
		
		session.setAttribute("id", user.getId());
		
		return "redirect:/user/findPwInfo";
	}
	
	@GetMapping("/findPwInfo")
	public void findPwInfo() {}
	
	@PostMapping("/findPwInfo")
	public String findPwInfoProc(User user) {
		
		userService.pwChange(user);
		
		return "redirect:/main";
	}
	
	@GetMapping("/naver")
	public void naver() {}
	
	@PostMapping("/naver")
	public ResponseEntity<String> naverProc( User user, HttpSession session) {
		
		boolean socialId = userService.social(user);
		user = userService.socialinfo(user);
		session.setAttribute("isLogin", socialId);
		
		
		if(socialId) {
			session.setAttribute("id", user.getId());
			session.setAttribute("nick", user.getNick());
			session.setAttribute("addr1", user.getAddr1());
			session.setAttribute("email", user.getEmail());
			session.setAttribute("name", user.getName());
			session.setAttribute("business", user.getBusinessStatus());
		
			return ResponseEntity.ok("success");
		} else {
			return ResponseEntity.ok("signup"); // 로그인 페이지로 리다이렉트
		}
	
		
	}
	@GetMapping("/kakao")
	public void kakao() {}
	
	@PostMapping("/kakao")
	public ResponseEntity<String> kakaoProc( User user, HttpSession session) {
		
		boolean socialId = userService.social(user);
		user = userService.socialinfo(user);
		session.setAttribute("isLogin", socialId);
		
		if(socialId) {
			session.setAttribute("id", user.getId());
			session.setAttribute("nick", user.getNick());
			session.setAttribute("addr1", user.getAddr1());
			session.setAttribute("email", user.getEmail());
			session.setAttribute("name", user.getName());
			session.setAttribute("business", user.getBusinessStatus());
			
			return ResponseEntity.ok("success");
		} else {
			return ResponseEntity.ok("signup"); // 로그인 페이지로 리다이렉트
		}
		
		
	}
	@PostMapping("/logout")
	@ResponseBody
    public void logoutPOST(HttpServletRequest request, HttpServletResponse response) throws Exception{
        
        logger.info("비동기 로그아웃 메서드 진입");
        
        HttpSession session = request.getSession();
        
        session.invalidate();
        // 쿠키 삭제
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                cookie.setMaxAge(0);
                cookie.setPath("/");
                response.addCookie(cookie);
            }
        }
    }
	
	// mailSending 코드
	@RequestMapping(value = "mailSender.do", method = RequestMethod.GET)
	@ResponseBody
	public String mailSending(String m_email) {

		
		//난수 생성(인증번호)
		Random r = new Random();
		int num = r.nextInt(888888) + 111111;  //111111 ~ 999999
		
		/* 이메일 보내기 */
        String setFrom = "Needit@gmail.com"; //보내는 이메일
        String toMail = m_email; //받는 사람 이메일
        String title = "회원가입 인증 이메일 입니다.";
        String content = 
                "Needit 홈페이지를 방문해주셔서 감사합니다." +
                "<br><br>" + 
                "인증 번호는 " + num + "입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
        
        try {
            
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
            
        }catch(Exception e) {
            e.printStackTrace();
        }
        
        String rnum = Integer.toString(num);  //view로 다시 반환할 때 String만 가능
        
        return rnum;
		
	}
}
