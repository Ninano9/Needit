package web.service.impl;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.java.Log;
import oracle.sql.TIMESTAMP;
import web.dao.face.MsgDao;
import web.dto.Board;
import web.dto.Msg;
import web.dto.Room;
import web.dto.User;
import web.service.face.MsgService;

@Service
public class MsgServiceImpl implements MsgService {
	@Autowired MsgDao msgDao;

	@Override
	public List<Map<String, Object>> getmsglist(User user) {
	    List<Map<String, Object>> list = msgDao.selectRoomNo(user); // 유저의 채팅방들을 가져옴
	    DateTimeFormatter formatter; // 날짜와 시간을 원하는 형식으로 포맷하거나 파싱하는 데 사용되는 클래스
	    LocalDateTime now = LocalDateTime.now(); // 현재 시간

	    for (Map<String, Object> map : list) {
	        Object tsObject = map.get("lastMessageTime");

	        // Oracle TIMESTAMP 타입 체크 및 변환
	        Timestamp ts = null; // Timestamp 객체 초기화
	        if (tsObject instanceof TIMESTAMP) { // tsObject가 TIMESTAMP 클래스(오라클) 혹은 하위 클래스 인지 구분하는 조건문
	            try { 
					ts = ((TIMESTAMP) tsObject).timestampValue(); // Oracle TIMESTAMP를 JAVA Timestamp로 변환
				} catch (SQLException e) {
					e.printStackTrace();
				}
	        } else {
	            // 이미 java.sql.Timestamp 타입인 경우
	            ts = (Timestamp) tsObject;
	        }

	        LocalDateTime messageTime = ts.toLocalDateTime(); // 하루의 변화를 구분하기 위한 객체

	        // 날짜 포맷 결정 로직은 동일하게 유지
	        if (messageTime.isAfter(now.minusDays(1))) { // 하루가 지나지 않았을 때
	            formatter = DateTimeFormatter.ofPattern("HH:mm"); // 시:분
	        } else { // 하루가 지났을 때
	            formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd "); // 연:월:일
	        }

	        // 포맷된 날짜로 업데이트
	        String formattedDate = messageTime.format(formatter);
	        map.put("lastMessageTime", formattedDate);
	    } // Map 반복문 끝
	    
		System.err.println("list" + list.toString());

	    return list;
	}
	
	@Override
	public List<Msg> getMsgLoad(Msg roomNo, String currentUserId) { // 각 채팅방의 메시지(리스트) 불러오기
		List<Msg> msg = new ArrayList<Msg>();
		msg = msgDao.selectByRoomNo(roomNo); // 특정 채팅방 불러오기
		DateTimeFormatter formatter;
		
	    for (Msg msglist : msg) {  
	        Date tsObject = msglist.getPostDate(); // 저장된 전송시간(날짜)를 Date 객체로 저장
	        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm"); // 연:월:일 시:분 으로 포맷
	        String formattedDate = dateFormat.format(tsObject); // 문자열로 형변환
	        Date target = null; // Date 타입 초기화
			try {
				target = dateFormat.parse(formattedDate); // formattedDate(String)를 target(Date)로 형변환 
			} catch (ParseException e) {
				e.printStackTrace();
			}
	        msglist.setPostDate(target); // 각 메시지에 포맷한 시간 삽입
	    }
	    
	    Map<String,Object> map = new HashMap<String, Object>();
	    map.put("id", currentUserId); // 세션에 저장된 유저id
	    map.put("roomNo", roomNo.getRoomNo()); // 방번호
	    msgDao.updateStatus(map); // 읽음 처리
		
		return msg;
	}

	@Override
	public Msg sendmessage(Msg msg) {
		String content = msg.getContent(); // 현재 보낸 메시지 내용 저장
		String writer = msg.getWriterId(); // 현재 보낸 유저 저장

		msg = msgDao.getColunmInfo(msg); // (최신 제외) 가장 마지막 메시지 불러오기
		String sender = msg.getWriterId(); // sender에 보낸 유저 대입
		msg.setWriterId(writer); // 메시지 작성한 유저 저장(본인)
		if(msg.getReceiverId().equals(writer)) { // 받은 사람 = 본인 일 때
			msg.setReceiverId(sender); // 상대방 아이디 저장 
		}
		
		msg.setContent(content); // getColumInfo에는 content가 없기 때문에 다시 저장 
		msgDao.insertmessage(msg); // 보낸 메시지 DB에 저장
		msg = msgDao.selectByMsgNo(msg); // 보낸 메시지 return
		return msg;
	}

	@Override
	public Msg getMessage(Msg msg) {
		return msgDao.selectByRoomNoLast(msg);
	}

	@Override
	public void updateStatus(Map<String, Object> map) {
		msgDao.updateStatus(map);
	}

	@Override
	public Msg getNewRoom(Msg msg) {
		Room room = new Room();
		msgDao.makeNewRoom(msg); // 새로운 방 생성
		msgDao.insertmessage(msg); // 새로운 메시지 저장
		return msgDao.selectByMsgNo(msg);
	}

	@Override
	public Integer checkNewRoom(Map<String, Object> map) {
		return msgDao.selectNewRoomByMap(map);
	}

	@Override
	public Board getBoardLoad(int boardNo) {
		return msgDao.selectByBoardNo( boardNo );
	}

	@Override
	public List<Map<String, Object>> getThumnail(int boardNo) {
		return msgDao.selectThumbnail(boardNo);
	}

	@Override
	public Map<String, Object> getInfo(int boardNo) {
		return msgDao.selectByBoardNoInfo(boardNo);
	}

	@Override
	public Map<String, Object> getNewChatInfo(String id) {
		return msgDao.selectNewInfo( id );
	}

}
