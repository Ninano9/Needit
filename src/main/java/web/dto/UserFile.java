package web.dto;

import lombok.Data;

@Data
public class UserFile {
	
	private String id;
	private int profileImgno;
	private String originName;
	private String storedName;
	private String thumbnailName;
	private String fileType;
	
	
}
