package web.dao.face;

import web.dto.Report;

public interface ReportDao {
	
	/**
	 * 예약정보 삽입
	 * 
	 * @param report 예약 정보
	 * @return 1 삽입 성공 2 실패
	 */
	public int insert(Report report);

	
	/**
	 * 
	 * @param report
	 * @return
	 */
	public void cmtReportInsert(Report report);
	
}
