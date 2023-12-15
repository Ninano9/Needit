package web.service.face;

import java.util.List;

import org.springframework.stereotype.Service;

import web.dto.User;

@Service
public interface UserService {
	
	//회원가입
	public void join(User user);

	//로그인
	public boolean login(User user);

	//닉네임 정보
	public User infoNick(User user);

	//아이디 체크
	public boolean idCheck(User user);

	//닉네임 체크
	public boolean ncikCheck(User user);

	//소셜 아이디 체크
	public boolean social(User user);

	//소셜 정보
	public User socialinfo(User user);
	
	//아이디 찾기
	public List<User> findid(User user);
	
	//비밀번호 찾기
	public User findpw(User user);
	
	//비밀번호 변경
	public void pwChange(User user);


}
