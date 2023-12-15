package web.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import web.dto.Alert;
import web.service.face.AlertService;

@Controller
@RequestMapping("/alert")
public class AlertController {
	private final Logger logger = LoggerFactory.getLogger( this.getClass() );
	
	public Map<String, SseEmitter> emitters = new HashMap<>();
	
	@Autowired private AlertService alertService;
	
	@RequestMapping("/test")
	public void test() {}

	@RequestMapping(value = "/get", consumes = MediaType.ALL_VALUE )
	@ResponseBody
    public SseEmitter getNotification( HttpSession session ) { // 유저가 로그인 시 알림을 불러오기 위한 SSE연결
    	
    	String id = (String) session.getAttribute("id"); // 접속한 유저의 저장된 세션을 불러온다
    	logger.info("id : {}", id);
    	
    	// SSE 접속 부분
    	SseEmitter sseEmitter = new SseEmitter(Long.MAX_VALUE); // SSE 객체의 임의로 임아웃을 설정해서 생성해준다
    	sendInitEvent(sseEmitter); // 첫 SSE 생성시 생성이벤트를 만들어서 보내줌
    	emitters.put(id, sseEmitter); // SSE객체를 value로 가지고 있는 Map에 userId를 Key로 보내줌
    	// SSE 접속 부분 끝
    	
		//	비동기 요청이 완료될 때 호출할 코드를 등록한다
		//	비동기 요청이 완료되면 컨테이너 스레드에서 호출된다
		sseEmitter.onCompletion(() -> emitters.remove(sseEmitter));
		
		// 	비동기 요청 시간 초과 시 호출할 코드를 등록한다
		//	비동기 요청 시간이 초과되면 컨테이너 스레드에서 호출된다
		sseEmitter.onTimeout(() -> emitters.remove(sseEmitter));
		
		//	비동기 요청 처리 중 오류 발생 시 호출할 코드를 등록한다
		//	비동기 요청을 처리하는 동안 오류가 발생했을때 컨테이너 스레드에서 호출된다
		sseEmitter.onError((e) -> emitters.remove(sseEmitter));
    	
		return sseEmitter; // 생성한 SSE객체를 반환해준다
	} // getNotification 끝
	
	@RequestMapping("/new") // JSP에서 hasNew함수(ajax)를 호출 했을 때 실행하는 함수
	public String countNewAlert( Model model, Alert alert, @SessionAttribute("id") String id ) {
		alert.setId(id); // Alert 객체에 세션에 저장된 id를 넣어준다
		int hasNew = alertService.hasNew(alert); // 유저가 읽지 않은 알림의 개수를 불러옴
		
		model.addAttribute("hasNew", hasNew); // 불러온 알림의 갯수를 Model 값으로 보내줌
		logger.info("hasNew : {}", hasNew);
		
		return "jsonView";
	} // countNewAlert 끝
	
	@GetMapping("/jong")
	public String jong( Model model, Alert alert, @SessionAttribute("id") String id ) { // JSP에서 loadAlert함수(ajax)를 호출 했을 때 실행하는 함수
		alert.setId(id);
		logger.info("alert : {}", alert);		
		
		List<Alert> list = alertService.getList(alert); // 유저에게 쌓인(기존에 읽지 않은) 알림 목록을 가져온다 - 새로 생긴 알림과 다름
		model.addAttribute("list", list); // 알람 목록을 Model값으로 보내준다
		logger.info("list : {}", list);
		return "/alert/jong"; // list JSP로 리턴
	} // alert 끝
	
	@PostMapping("/read")
	public String readAlert( Alert alert ) {
		logger.info("alert : {}", alert);
		alertService.readAlert(alert); // 알림의 읽음 여부를 처리한다
		
		return "jsonView";
	} // readAlert 끝
	
    @PostMapping("/sendnotification")
    @ResponseBody
    public void sendNotification( Alert alert, HttpServletResponse resp ) { // 댓글 달림, 채팅 옴 등의 이벤트 발생시 ajax로 post해줌
    	logger.info("alert : {}", alert);
    	
    	alertService.sendAlert(alert); // 발생한 알림을 처리하는 메소드
    	
    	int hasNew = alertService.hasNew(alert); // 새로 발생한 알림의 갯수를 가져온다
    	logger.info("hasNew : {}", hasNew);
    	
    	SseEmitter sseEmitter = emitters.get(alert.getId()); // 생성된 유저의 SSE 객체를 가져와 SSE 객체에 저장
    	logger.info("sseEmitter : {}", sseEmitter);	
    	
    	if(sseEmitter != null) { // 생성된 SSE객체가 있을시 (유저가 제대로 접속했을 시) 
    		String formattedData = new JSONObject().put("hasNew", hasNew).put("alert", alert).toString(); // 새로운 알림 갯수와, 알림 내용을 JSON으로 형변환
    		try {
				sseEmitter.send(sseEmitter.event().data(formattedData)); // 알림을 보내줌
			} catch (IOException e) {
				emitters.remove(sseEmitter);
			}
    		
    	} // if 문 끝
        try {
            resp.sendRedirect("/send");
        } catch (IOException e) {
            e.printStackTrace();
        }
	} // sendNotification 끝
    
    @PostMapping("/delete")
    public void delete( Alert alert ) {
    	alertService.delete( alert );
    }
    
    @PostMapping("/delAll")
    public String delAll( Alert alert, Model model ) {
    	alertService.delAll( alert );
    	model.addAttribute("1", 1);
    	return "jsonView";
    }
    
	
	private void sendInitEvent( SseEmitter sseEmitter ) { 	// 처음 구독했을 때 생성되는 이벤트
		try {
			sseEmitter.send(sseEmitter.event().name("INIT")); // 이름이 "INIT"인 이벤트를 보내준다
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
