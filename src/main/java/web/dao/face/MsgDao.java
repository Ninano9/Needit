package web.dao.face;

import java.util.List;
import java.util.Map;

import web.dto.Board;
import web.dto.Msg;
import web.dto.User;

public interface MsgDao {
	
	/**
	 * 현재 user의 id를 통해 보유하고 있는
	 * 채팅방 리스트를 불러온다
	 * 
	 * @param user dto의 id
	 * @return 현재 user의 보유 채팅방 목록
	 */
	public List<Map<String, Object>> selectRoomNo(User user);
	
	/**
	 * 방 번호(roomNo)에 해당하는
	 * 모든 메시지들을 보낸 시간의 역순(최신순) 으로 불러온다
	 * 
	 * @param roomNo 방 번호
	 * @return 메세지 List
	 */
	public List<Msg> selectByRoomNo(Msg roomNo);
	
	/**
	 * 메시지 저장
	 * 
	 * @param msg
	 * @return 방금 보낸 메세지의 msg_no 가 담긴 msg객체
	 */
	public int insertmessage(Msg msg);
	
	/**
	 * 가장 최근 메세지의 정보를 불러온다
	 * 
	 * @param msg
	 * @return
	 */
	public Msg getColunmInfo(Msg msg);

	public Msg selectByMsgNo(Msg msg);

	public Msg selectByRoomNoLast(Msg msg);
	
	/**
	 * 메시지의 읽음 처리
	 * 읽음 : 1 / 안읽음 : 0
	 * 
	 * @param map map의 id(CurrentUser)와 roomNo
	 */
	public void updateStatus(Map<String, Object> map);
	
	/**
	 * 새로운 방 생성
	 * 
	 * @param msg 생성한 방의 room_no가 저장된 msg객체가 담긴다.
	 */
	public void makeNewRoom(Msg msg);

	public Integer selectNewRoomByMap(Map<String, Object> map);

	public Board selectByBoardNo(int boardNo);
	
	public List<Map<String, Object>> selectThumbnail(int boardNo);

	public Map<String, Object> selectByBoardNoInfo(int boardNo);

	public Map<String, Object> selectNewInfo(String id);

}
