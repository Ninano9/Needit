package web.dao.face;

import java.util.List;

import web.dto.Board;
import web.util.Paging;

public interface MapDao {

	public List<Board> selectAllBoard();

	public String selectThumb(int boardNo);

	public List<Board> selectBySearch( Paging search  );


}
