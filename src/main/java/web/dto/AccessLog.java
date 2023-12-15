package web.dto;

import java.util.Date;

import lombok.Data;

@Data
public class AccessLog {
	
	private String id;
	private Date accessDate;
	
}
