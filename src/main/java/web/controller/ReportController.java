package web.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import web.dto.Report;
import web.service.face.ReportService;

@Controller
public class ReportController {
	//로그 객체 
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired ReportService reportService;
	
	@RequestMapping("/report")
	public String reportProc(
			Report report, HttpSession session) {
		logger.info("신고{}", report);
		
		report.setReportId((String)session.getAttribute("id"));
		
		boolean checkReport = reportService.insertReport(report);
		
//		boolean check = reportService.checkReport(report);
		
		return "admin/report";
		
	}
	
	
	@RequestMapping("/cmtReport")
	public String cmtReportProc(Report report, HttpSession session) {
		logger.info("댓글신고내역! Param : {}", report);
		reportService.insertCmtReport(report);
		
		return "jsonView";
	}
	
}
