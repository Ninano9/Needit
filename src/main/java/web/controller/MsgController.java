package web.controller;

import java.util.ArrayList;
import java.util.HashMap;
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

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import web.dto.Board;
import web.dto.FileTb;
import web.dto.Msg;
import web.dto.User;
import web.service.face.MsgService;

@Controller
@RequestMapping("/message")
public class MsgController {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired MsgService msgService;
	
	@GetMapping("/list") // 채팅방 목록 가져오기
	public String Msg(HttpSession session, Model model,
			@RequestParam(value = "boardNo", required = false, defaultValue = "0") int boardNo, // 글 번호
			@RequestParam(value = "menu", required = false, defaultValue = "0") int menu, // 메뉴 번호
			@RequestParam(value = "cate", required = false, defaultValue = "0") int cate, // 카테고리 번호
			@RequestParam(value = "receiverId", required = false,defaultValue = "anonymous") String receiverId) throws JsonProcessingException {
		User user = new User(); // 유저 dto 생성
		user.setId(session.getAttribute("id").toString()); // 현재 접속한 유저의 ID
		
		List<Map<String,Object>> list  = new ArrayList<Map<String,Object>>(); // 메시지 리스트 생성
		list = msgService.getmsglist(user); // 채팅방 목록 가져오기
		
		Map<String,Object> map = new HashMap<String, Object>(); // map(List) 생성
		
		if(boardNo != 0) { // 새로운 채팅방 생성
			map.put("newBoardNo", boardNo);
			map.put("newReceiverId", receiverId);
			map.put("newMenu",menu);
			map.put("newCate",cate);
			map.put("newWriterId", user.getId());
			
			Integer checkRoom = 0;
			if(msgService.checkNewRoom(map) != null) {
				checkRoom = msgService.checkNewRoom(map);
				logger.info("새방 : {}", checkRoom);
				model.addAttribute("targetRoomNo",checkRoom);
			}else {
				ObjectMapper objectMapper = new ObjectMapper(); // 객체 간의 매핑을 도와준다
				String newMakingJson = objectMapper.writeValueAsString(map); // map 객체를 JSON으로 변환해준다
				model.addAttribute("newMaking",newMakingJson);
			} // if문 끝
		} // 새로운 채팅방 생성 끝
		model.addAttribute("list",list); // 채팅 목록 보내기
		
		System.err.println("list" + list.toString());
		return "/message/list";
	}

	@GetMapping("/msgload") // 채팅방의 메시지 불러오기
	@ResponseBody
	public Map<String, Object> msgload(Msg roomNo, @RequestParam("currentUserId") String currentUserId) {
		logger.info( "currentUserId : {}", currentUserId ); // 현재 세션의 유저 id
		logger.info( "roomNo.toString() : {}", roomNo.toString() ); // roomNo

		List<Msg> msgload = new ArrayList<Msg>();
		msgload = msgService.getMsgLoad(roomNo, currentUserId);
		
		int boardNo = msgload.get(0).getBoardNo();
		Board boardload = msgService.getBoardLoad( boardNo );
		
		List<Map<String, Object>> thumbnail = msgService.getThumnail( boardNo );
		
		Map<String, Object> response = new HashMap<>();
		
	    response.put("messages", msgload);
	    response.put("boardInfo", boardload);
	    response.put("thumbnail", thumbnail);

		logger.info(msgload.toString()); // log
		return response;
	}
	
	@GetMapping("/info")
	public String info( int boardNo, Model model ) {
		Map<String, Object> info = msgService.getInfo( boardNo );
		model.addAttribute( "info", info );
		return "jsonView";
	}
	@GetMapping("/getNick")
	public String getNick( String id, Model model ) {
		Map<String, Object> newInfo = msgService.getNewChatInfo( id );
		model.addAttribute( "newInfo", newInfo );
		return "jsonView";
	}
	
}
