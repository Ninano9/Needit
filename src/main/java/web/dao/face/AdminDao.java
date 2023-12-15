package web.dao.face;

import java.util.List;
import java.util.Map;

import web.dto.Banner;
import web.dto.Board;
import web.dto.Business;
import web.dto.Comment;
import web.dto.FileTb;
import web.dto.Report;
import web.dto.User;
import web.util.Paging;

public interface AdminDao {

	/**
	 * 게시글 정보를 삽입한다
	 * 
	 * @param bannerParam - 삽입하 게시글 정보
	 */
	public void insert(Banner bannerParam);

	/**
	 * 첨부파일 정보를 삽입한다
	 * 
	 * @param banner - 삽입할 첨부파일 정보
	 */
	public void insertBanner(Banner banner);

	/**
	 * DB에서 storedName을 받아와 main.jsp에 썸네일로 띄운다
	 * @return 사진 저장 배열
	 */
	public List<Banner> getStoredName();

	/**
	 * 공지사항 작성
	 * 
	 * @param board - 삽입할 게시글 정보
	 */
	public void insertNotice(Board board);

	/**
	 * 메인에서 공지 게시글 목록 조회
	 * 
	 * @return 공지 목록
	 */
	public List<Board> selectAllNotice();
	
	/**
	 * 관지자에서 공지 게시글 목록 조회
	 * 
	 * @return 공지 목록
	 */
	public List<Map<String, Object>> adminSelectAllNotice();
	
	/**
	 * 공지 삭제를 위한 파일 삭제
	 * 
	 * @param writeNotice - 공지
	 */
	public void deleteNoticeFile(Board board);

	/**
	 * 공지 삭제
	 * 
	 * @param writeNotice - 공지
	 */
	public void deleteNotice(Board board);

	/**
	 * 전체 게시글 수를 조회한다
	 *  + 검색어 추가
	 * 
	 * @return 총 게시글 수
	 */
	public int selectCntAll();

	/**
	 * DB에 저장된 이메일 목록을 불러온다
	 * 
	 * @return 이메일 목록
	 */
	public List<Map<String, Object>> selectAllEmail();

	/**
	 * 신고된 게시글 목록을 불러온다
	 * 
	 * @return 신고된 게시글 목록
	 */
	public List<Map<String, Object>> selectReportBoard();

	/**
	 * 신고된 댓글 목록을 불러온다
	 * 
	 * @return 신고된 댓글 목록
	 */
	public List<Map<String, Object>> selectCmtBoard();

	/**
	 * 사진 삭제
	 * @param board - 사진 삭제
	 */
	public void deleteFile(Board board);
	
	/**
	 * 댓글 삭제
	 * 
	 * @param board - 댓글 삭제
	 */
	public void deleteCmt(Board board);

	/**
	 * 장바구니 삭제
	 * 
	 * @param board - 장바구니 삭제
	 */
	public void deleteBasket(Board board);
	
	/**
	 * 추천 삭제
	 * 
	 * @param board - 추천 삭제
	 */
	public void deleteLike(Board board);

	/**
	 * 게시글 삭제
	 * 
	 * @param board - 추천 삭제
	 */
	public void deleteBoard(Board board);

	/**
	 * 해당 댓글 삭제
	 * 
	 * @param cmt - 댓글만 삭제
	 */
	public void deleteComment(Comment cmt);

	/**
	 * 업체 요청 목록 전체 불러오기
	 * 
	 * @return - 업체 요청 목록
	 */
	public List<Map<String, Object>> selectBusinessList();

	/**
	 * 업체요청을 승인한다
	 * 
	 * @param business - 업체
	 */
	public void approveBusiness(Business business);

	/**
	 * 업체요청을 취소한다
	 * 
	 * @param business - 업체
	 * @return 
	 */
	public int cancelBusiness(Business business);
	
	/**
	 * 업체 승인 취소 요청시 삭제
	 * 
	 * @param business 삭제
	 */
	public void deleteBusiness(Business business);






	

	
}
