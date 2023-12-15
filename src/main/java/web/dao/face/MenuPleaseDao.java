package web.dao.face;

import java.util.List;
import java.util.Map;

import web.dto.Basket;
import web.dto.Board;
import web.dto.Comment;
import web.dto.FileTb;
import web.dto.Like;
import web.dto.User;
import web.util.Paging;

public interface MenuPleaseDao {

	
	/**
	 * 게시글 목록 조회
	 * 
	 * @param paging - 페이징 정보 객체
	 * @return 게시글 목록
	 */
	public List<Map<String, Object>> selectAll(Paging paging);

	
	/**
	 * 전체 게시글 수를 조회한다
	 * @param param 
	 * 
	 * @return 총 게시글 수
	 */
	public int selectCntAll(Paging param);

	
	/**
	 * 검색요청 목록 조회
	 * 
	 * @param paging
	 * @return
	 */
	public List<Map<String, Object>> selectSearch(Paging paging);
	
	/**
	 * 
	 * @param paging
	 * @return
	 */
	public int getCntLikeByBoardNo(Paging paging);
	
	
	
	
	/**
	 * 조회하려는 게시글의 조회수를 1증가 시킨다
	 * 
	 * @param board - 게시글 번호 객체
	 */
	public void updateHit(Board board);

	
	/**
	 * 게시글 번호를 이용하여 게시글을 조회한다 
	 * 
	 * @param board - 조회하려는 게시글 번호 객체
	 * @return 조회된 게시글 정보
	 */
	public Board selectByBoardNo(Board board);


	/**
	 * 
	 * @param writeParam
	 */
	public void insertBoard(Board writeParam);


	/**
	 * 파일 업로드
	 * 
	 * @param fileTb
	 */
	public void insertFile(FileTb fileTb);

	
	/**
	 * 
	 * @param board
	 * @return
	 */
	public List<FileTb> selectFileByBoardNo(Board board);


	/**
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
	 * @param like - 추천 정보 객체
	 */
	public void insertLike(Like like);
	
	/**
	 * 추천상태 지우기
	 * 
	 * @param like - 추천 정보 객체
	 */
	public void deleteLike(Like like);
	
	
	/**
	 * 게시글의 전체 추천 수 조회
	 * 
	 * @param like - 추천 수를 조회할 게시글 정보
	 * @return 전체 추천 수
	 */
	public int selectTotalCntLike(Like like);
	
	
	
	/**
	 * 게시글 내용을 수정한다
	 * 제목, 본문을 주어진 게시글 번호를 이용하여 수정한다
	 * 
	 * @param updateParam - 수정할 내용이 담긴 객체
	 */
	public void update(Board updateParam);
	

	/**
	 * 기존의 첨부파일을 삭제한다
	 * 
	 * @param delFileno - 삭제하려는 파일 번호들
	 */
	public void deleteFiles(int[] delFileno);
	
	
	
	/**
	 * 게시글 번호를 이용하여 첨부파일 삭제
	 * 
	 * @param deleteParam - 삭제하려는 게시글 번호
	 */
	public void deleteFileByBoardNo(Board deleteParam);


	/**
	 * 리스트에서 게시글의 게시글 삭제
	 * 
	 * @param deleteParam - 삭제하려는 게시글 번호
	 */
	public void deleteByBoardNo(Board deleteParam);

	
	
	
	/**
	 * 댓글 작성
	 * 
	 * @param commentParam
	 */
	public void insertComment(Comment commentParam);


	/**
	 * 댓글 목록 조회
	 * 
	 * @param commentParam
	 * @return
	 */
	public List<Map<String, Object>> selectAllComment(Comment commentParam);


	/**
	 * 댓글 삭제
	 * 
	 * @param commnetDelete
	 */
	public void deleteComment(Comment commnetDelete);


	/**
	 * 
	 * @param commentReply
	 */
	public void insertCommentReply(Comment commentReply);

	

	/**
	 * 찜 여부 조회
	 * 
	 * @param basket 찜 여부
	 * @return 1 찜 불가능 0 찜 가능
	 */
	public int basketInfo(Basket basket);

	/**
	 * 찜 가능하면 insert
	 * @param basket
	 */
	public void deleteBasket(Basket basket);

	/**
	 * 한번 더 클릭시 delete
	 * 
	 * @param basket
	 */
	public void insertBasket(Basket basket);


	/**
	 * 세션이 회원정보수정전 주소 가져오는것 때문에 추가함
	 * @param user
	 * @return
	 */
	public User selectWriteAddr(User user);




	/**
	 * 게시글별 댓글수 카운트
	 * @param boardNo
	 * @return
	 */
	public int getCntCmt(String boardNo);


	


	


	

}
