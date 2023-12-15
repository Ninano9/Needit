package web.service.face;

import java.util.List;
import java.util.Map;

import web.dto.Board;
import web.dto.Msg;
import web.dto.User;

public interface MsgService {

	public List<Map<String, Object>> getmsglist(User user);

	public List<Msg> getMsgLoad(Msg roomNo, String currentUserId);

	public Msg sendmessage(Msg msg);

	public Msg getMessage(Msg msg);
	
	public void updateStatus(Map<String,Object> map);

	public Msg getNewRoom(Msg msg);

	public Integer checkNewRoom(Map<String, Object> map);

	public Board getBoardLoad(int boardNo);

	public List<Map<String, Object>> getThumnail(int boardNo);

	public Map<String, Object> getInfo(int boardNo);

	public Map<String, Object> getNewChatInfo(String id);

}
