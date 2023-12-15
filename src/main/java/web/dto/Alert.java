package web.dto;

import java.util.Date;

import lombok.Data;

@Data
public class Alert {
    private Board board;
	private int alertNo; // 알람번호
	private String id; // 알람받는 유저
	private String sender; // 알람보낸 유저
	private int content; // 알람 내용
	private Date postDate; // 보낸 날짜
	private int alertStatus; // 읽음 상태 0 : 읽지 않음, 1 : 읽음
	private int boardNo; // 가져온 게시물 번호
	private String menu; // 가져온 게시물 메뉴
	private String title;
}
