package web.dto;

import java.util.Date;

import lombok.Data;

@Data
public class Comment {
	
	private int cmtNo;
	private int boardNo;
	private String content;
	private String writerId;
	private String writerNick;
	private Date writeDate;
	
}
