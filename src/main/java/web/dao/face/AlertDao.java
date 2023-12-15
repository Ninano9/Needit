package web.dao.face;

import java.util.List;

import web.dto.Alert;

public interface AlertDao {

	/**
	 * id에 맞는 알림들을 List로 불러온다
	 * 
	 * @param alert Alert 객체의 id
	 * @return Alert List
	 */
	public List<Alert> selectByUser(Alert alert);

	/**
	 * 새로 발생한 알림을 DB에 저장한다
	 *  
	 * @param alert Alert 객체
	 */
	public void insertAlert(Alert alert);

	/**
	 * 알림의 읽음 상태를 읽음으로 바꾼다
	 * 
	 * @param alert Alert 객체
	 */
	public void updateAlertStatus(Alert alert);
	
	/**
	 * 안 읽은 알림의 갯수를 반환한다
	 *  
	 * @param alert Alert 객체
	 * @return 안 읽은 알림의 갯수
	 */
	public int countStatus(Alert alert);

	public void deleteAlert(Alert alert);

	public void deleteAll(Alert alert);
}
