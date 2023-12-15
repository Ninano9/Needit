package web.service.face;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import web.dto.Banner;
import web.dto.Board;
import web.dto.Business;
import web.dto.Comment;
import web.dto.Report;
import web.dto.User;

public interface AdminService {

	/**
	 * 배너사진 파일을 업로드한다
	 * 
	 * @param bannerParam - 파일 테이블 정보 객체
	 * @param file - 첨부 파일 리스트
	 */
	public void bannerUpdate(Banner bannerParam, List<MultipartFile> file);

	/**
	 * 관리자에서 썸네일 미리보기를 위한 메소드
	 * @return 사진 저장 배열
	 */
	public List<Banner> getBannerNo();

	/**
	 * 메인에서 공지 목록 조회
	 * 
	 * @return 공지 목록
	 */
	public List<Board> noticeList();

	/**
	 * 관리자에서 공지 조회
	 * 
	 * @return 공지 목록
	 */
	public List<Map<String, Object>> adminNoticeList();
	
	/**
	 * 게시글 작성 처리
	 *  + 첨부 파일을 처리한다
	 *  (첨부 파일은 여러 개 가능)
	 * 
	 * @param board - 게시글 정보 객체
	 * @param file - 첨부 파일 리스트
	 */
	public void writeNotice(Board board);
	
	/**
	 * 공지 삭제
	 * 
	 * @param board - 게시글 정보 객체
	 */
	public void deleteNotice(Board board);


	/**
	 * 메일 전송을 위해 DB에서 이메일을 불러온다
	 * 
	 * @return 이메일 목록
	 */
	public List<Map<String, Object>> emailList();

	/**
	 * 게시글 신고 목록 조회
	 * 
	 * @return 게시글 신고 목록
	 */
	public List<Map<String, Object>> getBoardReportInfo();

	/**
	 * 댓글 신고 목록 조회
	 * 
	 * @return 댓글 신고 목록
	 */
	public List<Map<String, Object>> getCmtReportInfo();

	/**
	 * 게시글을 삭제한다
	 * 
	 * @param board - 게시글 정보 객체
	 */
	public void deleteBoard(Board board);

	/**
	 * 댓글을 삭제한다
	 * 
	 * @param board - 게시글 정보 객체
	 */
	public void deleteComment(Comment cmt);
	
	/**
	 * 업체 요청 목록을 불러온다
	 *  
	 * @return - 업체 요청 목록
	 */
	public List<Map<String, Object>> businessList();

	/**
	 * 업체 승인 한다
	 * 
	 * @param business - 업체
	 */
	public void approveBusiness(Business business);

	/**
	 * 업체 취소 한다
	 * 
	 * @param business - 업체
	 */
	public void cancelBusiness(Business business);
	
	



}
