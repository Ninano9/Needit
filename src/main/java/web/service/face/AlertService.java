package web.service.face;

import java.util.List;

import web.dto.Alert;

public interface AlertService {
	
	/**
	 * Alert객체에 저장된 id로 조회해
	 * 해당 유저가 안 읽은 알림의 갯수를 불러온다
	 * 
	 * @param alert Alert 객체 
	 * @return 안읽은 알람의 수
	 */
	public int hasNew(Alert alert);

	/**
	 * 유저에게 온 모든 알림을 Alert 객체에 저장된
	 * 유저의 id를 이용해  list로 불러온다
	 * 
	 * @param alert Alert 객체
	 * @return Alert List 
	 */
	public List<Alert> getList(Alert alert);
	
	/**
	 * 알림의 읽음 여부를 받아와
	 * 알림의 읽음 여부를 변경한다
	 * 0 : 읽지 않음, 1 : 읽음
	 * 
	 * @param alert
	 */
	public void readAlert(Alert alert);
	
	/**
	 * 새로 받아온 알림을 DB에 저장한다
	 * 
	 * @param alert Alert 객체
	 */
	public void sendAlert(Alert alert);

	public void delete(Alert alert);

	public void delAll(Alert alert);
	
	
}
