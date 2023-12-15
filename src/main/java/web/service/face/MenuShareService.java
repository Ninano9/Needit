package web.service.face;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import web.dto.Basket;
import web.dto.Board;
import web.dto.Booking;
import web.dto.Comment;
import web.dto.FileTb;
import web.dto.Like;
import web.dto.Rent;
import web.dto.User;
import web.util.Paging;

public interface MenuShareService {

	/**
	 * 페이징 계산
	 * 
	 * @param param 페이지 수
	 * @return 페이지
	 */
	public Paging getPaging(Paging param);
	
	/**
	 * 나눔 게시판 조회
	 * 
	 * @param paging 페이지수로 리스트 조회
	 * @return 나눔게시판 조회
	 */
	public List<Map<String, Object>> selectBoardStatus(Paging paging,Board board);
	
	/**
	 * 나눔 게시판 상세조회
	 * 
	 * @param board 게시글 번호
	 * @return boardno 에 해당 하는 게시글 상세조회
	 */
	public Board view(Board board);
	
	/**
	 * 게시글 작성
	 * 
	 * @param writerContent DB에 insert할 데이터
	 * @param upFile 
	 */
	public void write(Board writerContent, List<MultipartFile> upFile);
	
	/**
	 * 있던 파일 정보 조회
	 * 
	 * @param updateParam 파일 정보
	 * @return 파일 정보
	 */
	public List<FileTb> getAttachFile(Board updateParam);
	
	/**
	 * 메뉴 번호 가져오기 
	 * 
	 * @param writerContent 메뉴 번호
	 * @return 메뉴 번호
	 */
	public List<Board> menu(Board writerContent);
	

	
	
	/**
	 * 사용자가 새로 작성한 정보
	 * 
	 * @param updateParam 파일을 제외한 정보
	 * @param file 파일
	 * @param delFileno 
	 */
	public void updateBoard(Board updateParam, List<MultipartFile> file, int[] delFileno);
	
	/**
	 * 사용자가 작성 한 글 삭제
	 * 
	 * @param deleteParam 삭제
	 */
	public void delete(Board deleteParam);
	
	/**
	 * 추천 상태확인
	 * 
	 * @param like - 추천 상태를 확인할 게시글과 정보 
	 * @return true - 추천한 상태, false - 추천하지 않은 상태
	 */
	public boolean isLike(Like like);
	
	/**
	 * 추천 상태를 확인하고 추천을 토글(넣고빼기) 작업
	 * 
	 * @param like - 추천 대상 정보
	 * @return true - 추천함, false - 추천 취소함
	 */
	public boolean like(Like like);
	
	/**
	 * 총 추천 수를 구한다
	 * 
	 * @param like - 추천수를 파악할 게시글 정보
	 * @return 총 추천 수
	 */
	public int getTotalCntLike(Like like);

	/**
	 * 댓글 작성
	 * 
	 * @param comment 사용자가 입력한 댓글
	 */
	public void commentinsert(Comment comment);

	/**
	 * 댓글 리스트 
	 * 
	 * @param comment 모든 댓글 보여줌
	 * @return 댓글 리스트
	 */
	public List<Map<String, Object>> list(Comment comment);
	
	/**
	 * 댓글 삭제
	 * 
	 * @param commentDelete
	 */
	public void commentdelete(Comment commentDelete);
	
	/**
	 * 대여신청 하기
	 * 
	 * @param rentParam
	 */
	public void rent(Rent rentParam);
	
	/**
	 * 예약 정보 확인
	 * 
	 * @param book 예약 정보
	 * @return false 예약 가능 true 예약 불가
	 */
	public boolean checkBook(Booking book);

	public boolean checkBooking(Booking book);

	public void bookStatus();
	
	/**
	 * 찜이 된상태인지 안된상태인지 확인
	 * 
	 * @param basket 찜 정보
	 * @return true 찜 가능 false 찜 불가능
	 */
	public boolean checkBasket(Basket basket);
	
	/**
	 * 검색한 리스트
	 * @param paging
	 * @return
	 */
	public List<Map<String, Object>> searchList(Paging paging);

	/**
    * 게시글마다 댓글수카운트
    * @param boardNo
    * @return
    */
	public int getCmtCnt(String boardNo);
	
	/**
	 * 글쓰기할때 회원정보수정전 주소가져오는거때문에 주소가져오는거 추가함
	 * @param user
	 * @return
	 */
	public User writeAddrSelect(User user);
	
	
	
	


}
