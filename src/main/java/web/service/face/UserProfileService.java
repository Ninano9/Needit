package web.service.face;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import web.dto.Basket;
import web.dto.Board;
import web.dto.Business;
import web.dto.Comment;
import web.dto.Like;
import web.dto.Rent;
import web.dto.User;
import web.dto.UserFile;
import web.util.Paging;

public interface UserProfileService {

	
	/**
	 * 회원정보 업데이트
	 * 
	 * @param user
	 */
	public void updateInfo(User user);

	/**
	 * 회원탈퇴
	 * 
	 * @param userId
	 */
	public void userDelete(User user);
	
	/**
	 * 페이징 계산
	 * 
	 * @param param 페이징 계산
	 * @return 페이징
	 */
	public Paging getPaging(Paging param);

	
	/**
	 * 
	 * 내가쓴글보드페이징 계싼
	 * @param param
	 * @return 페이징
	 */
	public Paging getBoardPaging(Paging param);
	
	
	/**
	 * 예약 목록
	 * @param paging 
	 * 
	 * @param book 예약 정보
	 * @return 
	 */
	public List<Map<String,Object>> myRentList(Board board);
	
	/**
	 * 내가 예약한 리스트
	 * 
	 * @param user 정보
	 * @return 리스트
	 */
	public List<Map<String, Object>> rentList(User user);

	/*
	 * 회원프로필사진
	 * 
	 */
	public void imgUpdate(MultipartFile file, String userId);


	
	
	/**
	 * 뷰에 보여줄 회원프로필사진
	 * 
	 * @param userId
	 * @return
	 */
	public UserFile imgSelect(String userId);

	
	/**
	 * 자기소개 수정
	 * 
	 * @param userPage
	 */
	public void introduceUpdate(User user);
	
	/**
	 * 회원등급을 위한 추천수 조회
	 * 
	 * @param board
	 * @return
	 */
	public int cntLike(User user);
	
	/**
	 * 추천수에 따른 회원등급
	 * 
	 * @param likeCount 추천수
	 * @param grade 
	 * @return 
	 */
	public void updateGrade(int likeCount, User userGrade);
	
	/**
	 * 유저 등급 조회
	 * 
	 * @param userPage 유저 정보
	 * @return
	 */
	public User selectUserGrade(User user);
	
	/**
	 * 업데이트된 유저 등급 조회
	 * 
	 * @param user
	 * @return 등급
	 */
	public User gradeResult(User user);
	
	/**
	 * 프로필사진 삭제
	 * 
	 * @param userPage
	 */
	public void imgDelete(UserFile userFile);
	
	/**
	 * rentStatus 상태 변경 
	 * 
	 * @param rent rent_no, board_no
	 * @return 
	 */
	public boolean updateRentStatus(Rent rent);
	
	/**
	 * 승인 취소 시 예약상태 0 으로 변경
	 * 
	 * @param rent rent_no , board_no
	 * @return true false
	 */
	public boolean updateRentCancel(Rent rent);
	
	/**
	 * 유저테이블 정보 다 가져오는거 주현이가 뭐쓰는지 보고나서 *지움 
	 * @param user 
	 * @return
	 */
	public User userAllSelect(User user);
	
	/**
	 * 예약 상태 확인 confirm
	 * @param rent rent_status
	 * @return true false
	 */
	public boolean checkConfirm(Rent rent);
	
	/**
	 * 예약 상태 확인 cancel
	 * 
	 * @param rent rent_status
	 * @return true false
	 */
	public boolean checkCancel(Rent rent);
	
	/**
	 * 로그인세션아이디로 글찾기
	 * @param paging 
	 * 
	 * @param board
	 * @return
	 */
	public List<Board> boardSelectById(Board board);

	/**
	 * 로그인세션아이디로 댓글찾기 
	 * 
	 * @param comment
	 * @return
	 */
	public List<Map<String, Object>> commentSelectById(Comment comment);
	
	/**
	 * 내 찜 목록 보여주기
	 * 
	 * @param basket 찜 정보
	 * @return 찜 목록
	 */
	public List<Map<Board, Object>> selectBasketList(Board board);


	/**
	 * 이메일수신 동의누르면1 미동의누르면0으로 업데이트
	 * 
	 * @param user
	 * @return
	 */
	public int emailSubUpdate(User user);

	/**
	 * 회원정보수정할때 현재로그인된거 불러옴
	 * @param user
	 * @return
	 */
	public User loginUserSelect(User user);
	
	/**
	 * 업체등록
	 * 
	 * @param busi 업체등록정보
	 * @param user 유저테이블 업데이트
	 */
	public void insertBusiness(Business busi, User user);


	
	/**
	 * 페이징 내가쓴글 목록 조회
	 * 
	 * @param paging - 페이징 정보 객체
	 * @return 게시글 목록
	 */
	public List<Map<String, Object>> myBoardList(Paging myBoardPaging);
  
	/**
	 * 이메일 수신 동의 업데이트
	 * 
	 * @param emailAgr
	 */
	public void updateEmail(User user);
	
	/**
	 * 이메일 수신 동의 확인
	 * 
	 * @param user 
	 * @return true 수신 동의 상태 false 수신 미동의 상태
	 */
	public boolean checkAgree(User user);
	
	/**
	 * 업체 링크 가져오기
	 * 
	 * @param busi 아이디
	 * @return 해당 아이디에 업체링크 가져오기
	 */
	public Map<String, Object> selectBusiness(User user);
	
	/**
	 * 닉네임 클릭시 해당
	 * 유저 아이디 가져오기
	 * 
	 * @param boardNo 보드넘버
	 */
	public String selectyourId(String boardNo);
	
	/**
	 * 다른사람 정보
	 * 
	 * @param id 클릭한 아이디
	 */
	public User yourProfile(String id);
	
	/**
	 * 다른사람 업체 정보
	 * 
	 * @param user
	 * @return
	 */
	public Map<String, Object> selectYourUrl(User user);
	
	/**
	 * 뷰에 보여줄 회원프로필사진
	 * 
	 * @param userId
	 * @return
	 */
	public UserFile yourImg(String id);
	
	/**
	 * 
	 * 
	 * @param board
	 * @return
	 */
	public List<Map<String, Object>> yourBoard(Board board);

	//-----------------------------------------------------------
	
	/**
	 * 댓글에서 불러온 다른사람 프로필아이디
	 * 
	 * @param cmtNo
	 * @return
	 */
	public String yourCmtIdSelect(String cmtNo);

	/**
	 * 댓글에서 불러온 다른사람 프로필정보
	 * 
	 * @param id
	 * @return
	 */
	public User yourCmtProfileSelect(String id);
	
	
	/**
	 * 댓글에서 불러온 업체링크
	 * 
	 * @param user
	 * @return
	 */
	public Map<String, Object> yourCmtUrlSelect(User user);

	/**
	 * 댓글에서 불러온 프로필이미지
	 * 
	 * @param id
	 * @return
	 */
	public UserFile yourCmtImgSelect(String id);

	/**
	 * 댓글에서 불러온 내가쓴글목록
	 * 
	 * @param comment
	 * @return
	 */
	public List<Map<String, Object>> yourCmtBoardSelect(Board board);





	

}
