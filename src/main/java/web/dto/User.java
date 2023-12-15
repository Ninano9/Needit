package web.dto;

import java.util.Date;

import lombok.Data;

@Data
public class User {
	
	private String id;
	private String pw;
	private String name;
	private String nick;
	private String birth;
	private String email;
	private String gender;
	private String phone;
	private String addr1;
	private String addr2;
	private Date joinDate;
	private String grade;
	private String intro;
	private int businessStatus;
	private int emailAgr;
	private String socialId;

}
