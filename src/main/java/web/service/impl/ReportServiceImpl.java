package web.service.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import web.dao.face.ReportDao;
import web.dto.Board;
import web.dto.Report;
import web.service.face.ReportService;

@Service
public class ReportServiceImpl implements ReportService{
	
	//로그 객체 
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired ReportDao reportDao;

	@Override
	public boolean insertReport(Report report) {
		
		int res = reportDao.insert(report);
		return false;
	}

	@Override
	public void insertCmtReport(Report report) {
		reportDao.cmtReportInsert(report);
	}

}
