package web.util;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.messaging.SessionConnectedEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;

import com.fasterxml.jackson.databind.ObjectMapper;

import web.dto.Msg;
import web.service.face.MsgService;

@Controller
public class ChatController {
	@Autowired MsgService msgService;
	private final Map<String, String> userConnections = new ConcurrentHashMap<>();

	@MessageMapping("/chat/{roomNo}/sendMessage")
	@SendTo("/sub/{roomNo}/public")
	public Msg sendMessage(@DestinationVariable String roomNo, @Payload Msg msg, SimpMessageHeaderAccessor headerAccessor) {
		
		if(msg.getMsgStatus() != 3) { // 새로 생성한 방의 메시지가 아닐 때 ( 0 : 안읽음, 1 : 읽음 )
			msg = msgService.sendmessage(msg); // 보낸 메시지 보내기			
		} else { // 새로 생성한 방의 메시지 일때
			msg.setMsgStatus(0); // 메시지 상태 0(안읽음)으로 초기화
		} // if(msg.getMsgStatus() != 3) 끝
		
		String receiverStatus = userConnections.get(msg.getReceiverId()); // 메시지를 받는 유저의 상태 체크
		
		String receiverId = null; // 받는 유저 초기화
		if(receiverStatus != null) { // 받는 유저가 현재 채팅방에 있을때
			String[] parts = receiverStatus.split("#"); // #을 기준으로 유저ID/방번호 구분
			receiverId = parts[0]; // # 이전 -> 유저 id
			roomNo = parts[1]; // # 이후 -> 방 번호
		} // if(receiverStatus != null) 끝
		
	    if (receiverStatus != null  // 현재 메시지의 받는 id
	    	&& msg.getReceiverId().equals(receiverId) //현재 메세지의 receiverId와 접속중인 유저의 ID가 같을때
	    	&& msg.getRoomNo() == Integer.parseInt(roomNo) //현재 메세지의 roomNo와 접속중인 roomNo가 같을때
	    		) {
	        // 읽음 상태로 업데이트
	    	Map<String,Object> map = new HashMap<String, Object>(); // 맵 생성
	        map.put("userId", receiverId); // 받는 아이디 삽입
		    map.put("roomNo", msg.getRoomNo()); // roomNo 삽입
		    msgService.updateStatus(map); // 읽음상태 처리
	    }
		return msg;
	}
	
	@MessageMapping("/chat/{Id}/sendStatus")
	@SendTo("/sub/{Id}/public/g")
	public Msg sendStatus(@DestinationVariable String Id, @Payload Msg msg) {

		if(msg.getMsgStatus() == 3) { // 새로 생성된 채팅방에 메시지 입력
			msg = msgService.getNewRoom(msg); // 새로운 방을 생성해서 가져옴
			msg.setMsgStatus(3); // 새로운 메시지임을 알려주는 플래그
		}else {
			msg = msgService.getMessage(msg); //msg객체의 msgStatus가 3이 아니라면 정상적으로 받아온 메세지를 db에 저장한다.
		}
		
		return msg; // msg는 몸에 안좋음
	}
	
	@MessageMapping("/chat.addUser")
	@SendTo("/sub/public")
	public void addUser(@Payload Map<String,Object> userInfo, SimpMessageHeaderAccessor headerAccessor) {
		String id = (String) userInfo.get("id"); //전달 받은 유저 아이디
		String roomNo = (String) userInfo.get("roomNo"); //전달받은 roomNo
		String status = id + "#" +roomNo; //유저아이디와 룸넘버를 #을 기준으로 합쳐줌
		userConnections.put(id, status); // concurrentmap에 id를 키값으로, ststus를 value로 넣어준다.
		headerAccessor.getSessionAttributes().put("currentUserId", status); // 현재 접속한 웹소켓 세션에
		//currentUserId라는 키로 status를 넣어준다.
	}
	
	@EventListener
	public void handleWebSocketDisconnectListener(
			SessionDisconnectEvent event) { //DisconnectedEventListenr 이벤트를 감지하는 메소드
		StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage()); //웹소켓 세션에 접근할 수 있는 객체 생성
		String username = (String)headerAccessor.getSessionAttributes().get("currentUserId");	// 웹소켓 세션에 currentUserId라는 키의 값을 username이라는 변수로 할당함
		if (username != null) { //username 이 null 아 아나리면
			userConnections.remove(username); //현재 관리중인 councurrentMap에서 username을 지워준다(ex user3#6 값을 지워준다.)
		}
	}
	
}
