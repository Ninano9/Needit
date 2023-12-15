package web.dto;

import lombok.Data;

@Data
public class FileTb {
	
	private int fileNo;
	private int boardNo;
	private String originName;
	private String storedName;
	private String thumbnailName;
	private String fileType;
	
}
