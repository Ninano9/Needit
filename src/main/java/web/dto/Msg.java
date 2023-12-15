package web.dto;

import java.util.Date;

import lombok.Data;

@Data
public class Msg {
	private int roomNo;
	private int msgNo;
	private String writerId;
	private String receiverId;
	private Date postDate;
	private String content;
	private int msgStatus;
	private int menu;
	private int cate;
	private int boardNo;
}
