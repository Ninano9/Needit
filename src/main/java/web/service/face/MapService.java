package web.service.face;

import java.util.List;

import web.dto.Board;
import web.util.Paging;

public interface MapService {
	
	
	/**
	 * 주소를 하나의 배열로 하고
	 * 주소 안에 중복된 주소를 가진만큼
	 * 배열의 값을 가진다
	 * 
	 * @return Board의 2차원 배열
	 */
	public List<List<Board>> list();

	public String getThumb(int boardNo);

	public List<List<Board>> search( Paging search );

}
