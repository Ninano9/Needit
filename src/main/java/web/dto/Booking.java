package web.dto;

import java.util.Date;

import lombok.Data;

@Data
public class Booking {
	
	private int bookNo;
	private int boardNo;
	private String bookerId;
	private int bookStatus;
	private Date bookDate;
	private int startTime;
  	private int endTime;

}
