package needit.project.opening;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import web.dto.UserFile;
import web.service.face.UserProfileService;

@Controller
public class NeeditOpeningController {
	private static final Logger logger = LoggerFactory.getLogger(NeeditOpeningController.class);

	@Autowired UserProfileService userProfileService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "opening";
	}
	
	@GetMapping("/layout/header")
	@ResponseBody
	public UserFile header(Model model, HttpSession session) {
		String userId = (String) session.getAttribute("id");
		UserFile  pimg = userProfileService.imgSelect(userId);
        //모델에 이미지 정보 추가
        model.addAttribute("pimg", pimg);
        
        return pimg;
	}
	
}
