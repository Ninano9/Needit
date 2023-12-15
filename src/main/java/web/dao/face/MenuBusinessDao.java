package web.dao.face;

import java.util.List;
import java.util.Map;

import web.dto.Basket;
import web.dto.Board;
import web.dto.Comment;
import web.dto.FileTb;
import web.dto.Like;
import web.dto.Rent;
import web.dto.User;
import web.util.Paging;

public interface MenuBusinessDao {

	/**
	 * 
	 * 
	 * @param param
	 * @return
	 */
	public int selectCntAll(Paging param);

	
	/**
	 * 
	 * 
	 * @param paging
	 * @return
	 */
	public List<Map<String, Object>> selectAll(Paging paging);

	/**
	 * 검색요청 목록 조회
	 * 
	 * @param paging
	 * @return
	 */
	public List<Map<String, Object>> selectSearch(Paging paging);
	
	/**
	 * 
	 * 
	 * @param board
	 */
	public void updateHit(Board board);

	/**
	 * 
	 * 
	 * @param board
	 * @return
	 */
	public Board selectByBoardNo(Board board);

	/**
	 * 
	 * 
	 * @param writeParam
	 */
	public void insertBoard(Board writeParam);

	/**
	 * 
	 * 
	 * @param fileTb
	 */
	public void insertFile(FileTb fileTb);

	/**
	 * 
	 * 
	 * @param board
	 * @return
	 */
	public List<FileTb> selectFileByBoardNo(Board board);

	/**
	 * 파일 조회
	 * 
	 * @param fileTb
	 * @return
	 */
	public FileTb selectFileByFileNo(FileTb fileTb);

	/**
	 * 사용자가 해당 게시글을 추천한 적이 있는지 조회	
	 * 
	 * @param like - 사용자와 게시글 정보를 가지고 있는 객체
	 * @return 1 - 추천한 적 있음, 0 - 추천한 적 없음
	 */
	public int selectCntLike(Like like);
	
	/**
	 * 추천상태 넣기
	 * 
	 * @param recommend - 추천 정보 객체
	 */
	public void insertLike(Like like);

	/**
	 * 추천상태 지우기
	 * 
	 * @param recommend - 추천 정보 객체
	 */
	public void deleteLike(Like like);

	/**
	 * 게시글의 전체 추천 수 조회
	 * 
	 * @param recommend - 추천 수를 조회할 게시글 정보
	 * @return 전체 추천 수
	 */
	public int selectTotalCntLike(Like like);

	/**
	 * 댓글 입력 
	 * 
	 * @param commentParam
	 */
	public void insertComment(Comment commentParam);

	/**
	 * 댓글 조회
	 * 
	 * @param commentParam
	 * @return
	 */
	public List<Map<String, Object>> selectAllComment(Comment commentParam);

	/**
	 * 댓글 삭제
	 * 
	 * @param commentDelete
	 */
	public void deleteComment(Comment commentDelete);

	/**
	 * 대여 신청하기
	 * 
	 * @param rentParam
	 */
	public void makeRent(Rent rentParam);

	/**
	 * 대여신청 상태 조회
	 * 
	 * @return
	 */
	public List<Map<String, Object>> chkRentStatus(Board board);

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
	 * 게시글 삭제
	 * 
	 * @param board
	 */
	public void deleteBoard(Board board);

	/**
	 * 게시글 수정
	 * 
	 * @param updateParam
	 */
	public void updateBoard(Board updateParam);

	/**
	 * 게시글 수정, 파일삭제용
	 * 
	 * @param delFileno
	 */
	public void deleteFiles(int[] delFileno);

	/**
	 * 
	 * @param boardNo
	 * @return
	 */
	public int getCntCmt(String boardNo);

	/**
	 * 
	 * @param user
	 * @return
	 */
	public User selectWriteAddr(User user);






}
