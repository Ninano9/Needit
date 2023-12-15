package web.service.face;

import web.dto.Report;

public interface ReportService {
	
	/**
	 * 신고 정보 insert
	 * 
	 * @param report 신고 정보
	 * @return true false
	 */
	public boolean insertReport(Report report);

	
	/**
	 * 댓글 신고 정보 insert
	 * @param report
	 * @return
	 */
	public void insertCmtReport(Report report);
	

}
