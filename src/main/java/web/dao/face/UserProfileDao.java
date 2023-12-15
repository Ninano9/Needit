package web.dao.face;

import java.util.List;
import java.util.Map;

import web.dto.Basket;
import web.dto.Board;
import web.dto.Business;
import web.dto.Comment;
import web.dto.Like;
import web.dto.Rent;
import web.dto.User;
import web.dto.UserFile;
import web.util.Paging;

public interface UserProfileDao {

	
	/**
	 * 회원정보 업데이트
	 * 
	 * @param user
	 */
	public void infoUpdate(User user);

	
	/**
	 * 회원탈퇴
	 * 
	 * @param userId
	 */
	public void deleteUser(User user);
	
	/**
	 * 페이징
	 * 
	 * @param param 페이징
	 * @return 페이징
	 */
	public int selectCntAll(Paging param);

	/**
	 * 예약 정보 확인
	 * 
	 * @param rent 예약 정보
	 */
	public List<Map<String,Object>> selectMyRentList(Board board);
	
	/**
	 * 내가 예약한 정보 확인
	 * 
	 * @param user 예약 정보
	 * @return 내가 예약한 리스트 
	 */
	public List<Map<String, Object>> selectRentList(User user);

	/**
	 * 회원프로필사진인서트
	 * 
	 * @param userPage
	 */
	public void updateImg(UserFile userFile);



	
	/**
	 * 뷰에 보여줄 회원프로필사진
	 * 
	 * @param userId
	 * @return
	 */
	public UserFile selectImg(String userId);

	/**
	 * 추천수 조회
	 * 
	 * @param like 조회수
	 * @return 추천수
	 */
	public int selectLikeByBoardNo(User user);
	
	/**
	 * 추천수가 5 이상이면 회원등급
	 * CrackEgg로 변경
	 * 
	 * @param grade 추천수
	 * @return 
	 */
	public int updateCrackEgg(User user);

	/**
	 * 추천수가 10이상이면 회원등급
	 * Chick으로 변경
	 * 
	 * @param likeCount 추천수
	 * @return 
	 */
	public int updateChick(User user);

	/**
	 * 추천수가 20이상이면 회원등급
	 * Chicken으로 변경
	 * 
	 * @param likeCount 추천수
	 * @return 
	 */
	public int updateChicken(User user);

	/**
	 * 추천수가 30이상이면 회원등급
	 * FriedChicken으로 변경
	 * 
	 * @param likeCount
	 * @return 
	 */
	public int updateFriedChicken(User user);

	/**
	 * 유저 등급 조회
	 * 
	 * @param userPage 유저 등급
	 * @return
	 */
	public User selectGrade(User user);


	/**
	 * 자기소개 수정
	 * 
	 * @param userPage
	 */
	public void updateIntroduce(User user);


	/**
	 * 회원프로필 삭제
	 * 
	 * @param userPage
	 */
	public void deleteImg(UserFile userFile);

	/**
	 * 예약 상태 변경 승인
	 * 
	 * @param rent rent_no, board_no
	 * @return 
	 */
	public int updateRentStatus(Rent rent);

	/**
	 * 예약 상태 변경 취소 
	 * 
	 * @param rent rent_no , board_no
	 * @return 
	 */
	public int updateCancel(Rent rent);
	
	/**
	 * confirm 예약 상태 조회
	 * 
	 * @param rent 예약 
	 * @return true false
	 */
	public int selectConfirm(Rent rent);

	/**
	 * cancel 예약 상태 조회
	 * 
	 * @param rent rent_status
	 * @return 
	 */
	public int selectCancel(Rent rent);

	/**
	 * 유저테이블 전체 조회 주현이가 뭐쓰는지 보고나서 * 없애기
	 * 
	 * @return
	 */
	public User selectUserAll(User user);

	/**
	 * 로그인한 아이디가 쓴 글 목록 조회
	 * 
	 * @param user
	 * @return
	 */
	public List<Board> selectBoardById(Board board);


	/**
	 * 로그인한 아이디가 쓴 댓글 목록 조회
	 * 
	 * @param comment
	 * @return
	 */
	public List<Map<String, Object>> selectCommentById(Comment comment);

	/**
	 * 내가 찜한 목록 가져오기
	 * 
	 * @param basket 찜 목록
	 * @return 찜 목록
	 */
	public List<Map<Board, Object>> basketList(Board board);

	/**
	 * 이메일 수신 동의 미동의 업데이트
	 * 
	 * @param user
	 * @return
	 */
	public int updateEmailSub(User user);


	/**
	 * 회원정보수정할때 로그인된아이디 회원정보 가져오기
	 * @param user
	 * @return
	 */
	public User selectLoginUser(User user);

	/**
	 * 업체등록
	 * 
	 * @param busi 업체등록 정보
	 * @return 
	 */
	public int insertBusi(Business busi);

	/**
	 * 업체등록시 유저테이블에 status 변경
	 * 
	 * @param user 유저 아이디
	 */
	public void updateBusiStatus(User user);


	/**
	 * 페이징 내가쓴글 목록 조회
	 * 
	 * @param paging - 페이징 정보 객체
	 * @return 내가쓴글 목록
	 */
	public List<Map<String, Object>> selectAll(Paging myBoardPaging);


	/**
	 * 내가 쓴 글 목록을 만들 게시글 개수
	 * 
	 * @param param - id(로그인한 유저)
	 * @return - 게시글 개수
	 */
	public int selectMyBoardCntAll(Paging myBoardPaging);

	/**
	 * 이메일 수신 동의시
	 * 회원정보 1로 업데이트
	 * 
	 * @param emailAgr 클릭한 정보
	 */
	public void updateAgree(User user);

	/**
	 * 이메일 수신 미동의시
	 * 회원정보 0으로 업데이트
	 * 
	 * @param emailAgr 클릭한 정보
	 */
	public void updateDisagree(User user);

	/**
	 * 이메일 수신 확인
	 * 
	 * @param user
	 * @return 1 수신 동의한 상태 0 수신 미동의한 상태
	 */
	public User selectEmail(User user);


	/**
	 * 프로필사진 업데이트할지 인서트할지 보려고 카운트
	 * 
	 * @param id
	 * @return
	 */
	public int checkIfImageExists(String id);

	/**
	 * 프로필사진 업데이트
	 * 
	 * @param userFile
	 */
	public void updateImage(UserFile userFile);

	/**
	 * 프로필사진 인서트
	 * 
	 * @param userFile
	 */
	public void insertImage(UserFile userFile);

	/**
	 * 업체 링크 가져오기
	 * 
	 * @param busi 아이디
	 * @return 링크
	 */
	public Map<String, Object> selectBusy(User user);

	/**
	 * 유저 아이디찾기
	 * 
	 * @param boardNo 보드번호
	 */
	public String selectId(String boardNo);

	/**
	 * 유저 아이디로 유저정보 찾기
	 * 
	 * @param busi 유저 아이디
	 * @return 유저정보
	 */
	public User selectYourInfo(String id);

	/**
	 * 다른사람 업체 링크
	 * 
	 * @param id 다른사람 아이디
	 * @return 링크
	 */
	public Map<String, Object> selectYourLink(User user);

	/**
	 * 타인 썸네일 가져오기 
	 * 
	 * @param userId 타인 아이디
	 * @return 썸네일
	 */
	public UserFile yourThumb(String userId);

	
	public List<Map<String, Object>> yourBoardList(Board board);

	//----------------------------------------------------------
	
	/**
	 * 댓글로 아이디찾기
	 * @param cmtNo
	 * @return
	 */
	public String selectYourCmtId(String cmtNo);

	/**
	 * 댓글로 프로필찾기
	 * @param id
	 * @return
	 */
	public User selectYourCmtProfile(String id);

	/**
	 * 댓글로 업체링크찾기
	 * @param user
	 * @return
	 */
	public Map<String, Object> selectYourCmtUrl(User user);

	/**
	 * 댓글로 이미지
	 * @param id
	 * @return
	 */
	public UserFile selectYourCmtImg(String id);


	/**
	 * 댓글로 내가쓴글불러오기
	 * @param comment
	 * @return
	 */
	public List<Map<String, Object>> selectYourCmtBoard(Board board);


	



}
