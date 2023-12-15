package web.dto;

import java.util.Date;

import lombok.Data;

@Data
public class Board {
	
	private int boardNo;
	private String menu;
	private String cate;
	private String writerId;
	private String writerNick;
	private Date writeDate;
	private int hit;
	private String title;
	private int price;
	private String content;
	private String location;
	private String businessUrl;

}
