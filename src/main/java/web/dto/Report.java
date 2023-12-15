package web.dto;

import java.util.Date;

import lombok.Data;

@Data
public class Report {
	
	private int reportNo;
	private int boardNo;
	private String reportId;
	private String reportType;
	private String reportChk;
	private Date reportDate;
	private int cmtNo;

}
