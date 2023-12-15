package web.service.impl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import web.dao.face.AlertDao;
import web.dto.Alert;
import web.service.face.AlertService;

@Service
public class AlertServiceImpl implements AlertService {
	@Autowired AlertDao alertDao;

	@Override
	public int hasNew(Alert alert) {
		return alertDao.countStatus(alert);
	}

	@Override
	public List<Alert> getList(Alert alert) {
		
	    List<Alert> alerts = alertDao.selectByUser(alert);
	    for (Alert a : alerts) {
	        if (a.getBoard() != null) {	// 가져온 Alert에 대한 Board 정보가 있다면 title을 설정
	            a.setTitle(a.getBoard().getTitle());
	        }
	    }
	    return alerts;
	}

	@Override
	public void readAlert(Alert alert) {
		alertDao.updateAlertStatus(alert);
	}

	@Override
	public void sendAlert(Alert alert) {
		alertDao.insertAlert(alert);
	}

	@Override
	public void delete(Alert alert) {
		alertDao.deleteAlert(alert);
	}

	@Override
	public void delAll(Alert alert) {
		alertDao.deleteAll(alert);
	}

}