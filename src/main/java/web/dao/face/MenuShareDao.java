package web.dao.face;

import java.util.List;
import java.util.Map;

import web.dto.Basket;
import web.dto.Board;
import web.dto.Booking;
import web.dto.Comment;
import web.dto.FileTb;
import web.dto.Like;
import web.dto.Rent;
import web.dto.User;
import web.util.Paging;

public interface MenuShareDao {
	
	/**
	 * 페이지수 계산
	 * 
	 * @param param 페이지수 
	 * @return 계산된 페이지 수 
	 */
	public int selectCntAll(Paging param);
	
	/**
	 * 나눔 게시판 전체 조회
	 * @param cate 
	 * 
	 * @return 나눔 게시판 전체 조회 결과
	 */
	public List<Map<String, Object>> selectAll(Paging paging);
	
	/**
	 * 상세조회시 필요한 boardno 가져오기
	 * 
	 * @param board boardno
	 * @return 해당 게시글 boardno 
	 */
	public Board selectByBoardNo(Board board);
	
	/**
	 * 조회수 조회
	 * 
	 * @param board 전달 파라미터
	 */
	public void updateHit(Board board);
	
	/**
	 * 사용자가 입력한 글작성 정보를 DB에 insert
	 * 
	 * @param writerContent 사용자가 작성한 데이터
	 */
	public void insertBoard(Board writerContent);
	
	/**
	 * 파일 업로드
	 * 
	 * @param fileTb 사용자가 업로드할 파일
	 */
	public void insertFile(FileTb fileTb);
	
	/**
	 * 메뉴 번호
	 * 
	 * @param writerContent 메뉴번호
	 * @return 메뉴번호
	 */
	public List<Board> selectByMenu(Board writerContent);
	
	/**
	 * 사용자가 업로드한 이미지
	 * 
	 * @param file 이미지
	 * @return file 이미지
	 */
	public List<FileTb> selectFileImg(FileTb file);
	
	/**
	 * 게시판에 새로운 정보 삽입
	 * 
	 * @param updateParam 사용자가 입력한 정보
	 */
	public void updateBoard(Board updateParam);

	public List<FileTb> selectBoardfileByBoardNo(Board updateParam);

	public void deleteFiles(int[] delFileno);
	
	/**
	 * 첨부파일 삭제
	 * 
	 * @param deleteParam 파일 삭제
	 */
	public void deleteFileByBoardNo(Board deleteParam);
	
	/**
	 * 게시글 삭제
	 * 
	 * @param deleteParam 게시글 삭제
	 */
	public void deleteByBoardNo(Board deleteParam);
	
	
	/**
	 * 추천이있으면 삭제
	 * 
	 * @param like 추천
	 */
	public void deleteLike(Like like);
	
	/**
	 * 추천이 있으면 insert
	 * 
	 * @param like 추천
	 */
	public void insertLike(Like like);
	
	/**
	 * 댓글 입력
	 * 
	 * @param comment 사용자가 입력한 댓글
	 */
	public void cmtWrite(Comment comment);

	/**
	 * 댓글 목록
	 * 
	 * @param comment 댓글 리스트
	 * @return 댓글 리스트
	 */
	public List<Map<String, Object>> cmtList(Comment comment);
	
	/**
	 * 댓글 삭제
	 * 
	 * @param commentDelete
	 */
	public void deleteComment(Comment commentDelete);
	
	
	
	/**
	 * 예약 DB에 넣기
	 * 
	 * @param book 예약 정보
	 */
	public void makeBook(Booking book);
	
	/**
	 * 예약 정보 확인
	 * 
	 * @param book 예약 정보
	 * @return false 예약 가능 true 예약 불가능
	 */
	public int checkBook(Booking book);

	/**
	 * 사용자가 해당 게시글을 추천한 적이 있는지 조회	
	 * 
	 * @param like - 사용자와 게시글 정보를 가지고 있는 객체
	 * @return 1 - 추천한 적 있음, 0 - 추천한 적 없음
	 */
	public int selectCntLike(Like like);

	/**
	 * 게시글의 전체 추천 수 조회
	 * 
	 * @param recommend - 추천 수를 조회할 게시글 정보
	 * @return 전체 추천 수
	 */
	public int selectTotalCntLike(Like like);
	
	/**
	 * 찜 여부 조회 
	 * 
	 * @param basket 찜여부
	 * @return 1 찜불가능 0 찜 가능
	 */
	public int basketInfo(Basket basket);
	
	/**
	 * 찜 가능하면 insert
	 * 
	 * @param basket
	 * @return
	 */
	public int insertBasket(Basket basket);
	
	/**
	 * 한번더 클릭시 delete
	 * 
	 * @param basket 
	 * @return 삭제
	 */
	public int deleteBasket(Basket basket);
	
	/**
	 * 검색한 리스트
	 * 
	 * @param paging 페이징
	 * @return 리스트 
	 */
	public List<Map<String, Object>> selectSearch(Paging paging);

	/**
    * 게시글별 댓글수 카운트
    * @param boardNo
    * @return
    */
	public int getCntCmt(String boardNo);

	/**
	 * 세션이 회원정보수정전 주소 가져오는것 때문에 추가함
	 * @param user
	 * @return
	 */
	public User selectWriteAddr(User user);
	
	/**
	 * 대여 신청하기
	 * 
	 * @param rentParam
	 */
	public void makeRent(Rent rentParam);
}
