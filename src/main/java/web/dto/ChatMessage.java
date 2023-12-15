package web.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ChatMessage {
	
	private String roomId;
	private String 	sender;
	private String message;
	private Date sendWrite;

}
