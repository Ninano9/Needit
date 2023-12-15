package web.service.face;

import java.util.List;
import java.util.Map;

import web.dto.Banner;
import web.dto.Board;
import web.dto.FileTb;
import web.util.Paging;

public interface MainService {

	/**
	 * bannerNo를 통해 storedName을 받아와 썸네일의 띄운다 
	 * 
	 * @return 사진 저장 배열
	 */
	public List<Banner> getBannerNo();

	/**
	 * 메인화면 최신 대여해요 게시글 
	 * 
	 * @return 사진, 글 제목
	 */
	public List<Map<String, Object>> getBoardRentInfo();

	/**
	 * 메인화면 최신 나눔해요 게시글
	 *  
	 * @return 사진, 글 제목
	 */
	public List<Map<String, Object>> getBoardShareInfo();

	/**
	 * 게시글 목록을 위한 페이징 객체를 생성한다
	 * 
	 * 	전달파라미터 객체의 curPage - 현재 페이지
	 *  DB에서 조회한 totalCount - 총 게시글 수
	 *  
	 *  두 가지 데이터를 활용하여 페이징 객체를 생성하고 반환한다
	 * 
	 * @param param - curPage정보를 담고 있는 객체
	 * @return 페이징 계산이 완료된 객체
	 */
	public Paging getPaging(Paging param);

	/**
	 * 메인화면 최신 업체 게시글 
	 * 
	 * @return 사진, 글 제목
	 */
	public List<Map<String, Object>> getBusinessInfo();

	/**
	 * 메인화면 커뮤니티 인기 게시글
	 * + 추천수 많은 순으로 2개 출력
	 *  
	 * @return 글 제목, 글 내용
	 */
	public List<Map<String, Object>> getCommuByLike();

	/**
	 * 검색용
	 * @param param - 페이징
	 * @param query - 검색값
	 * @return 페이징 계산
	 */
//	public List<Map<String, Object>> list(Paging paging);

	/**
	 * 게시글 검색
	 * 
	 * @param paging
	 * @return
	 */
	public List<Map<String, Object>> searchList(Paging paging);




}
