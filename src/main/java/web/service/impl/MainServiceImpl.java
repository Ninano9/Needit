package web.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import web.dao.face.MainDao;
import web.dto.Banner;
import web.dto.Board;
import web.dto.FileTb;
import web.service.face.MainService;
import web.util.Paging;

@Service
public class MainServiceImpl implements MainService {
	private final Logger logger = LoggerFactory.getLogger( this.getClass() );

	@Autowired MainDao mainDao;

	//베너 사진 업로드
	@Override
	public List<Banner> getBannerNo() {
		
		List<Banner> banner = new ArrayList<Banner>();
		banner = mainDao.getStoredName();
		return banner;
	}

	//최신 대여해요 게시글
	@Override
	public List<Map<String, Object>> getBoardShareInfo() {
		
		return mainDao.selectRecentShareBoard();
	}
	
	//최신 나눔해요 게시글
	@Override
	public List<Map<String, Object>> getBoardRentInfo() {
		
		return mainDao.selectRecentRentBoard();
	}
	

	//니딧 인증 업체
	@Override
	public List<Map<String, Object>> getBusinessInfo() {

		return mainDao.selectRecentBusinessBoard();
	}

	//오늘의 인기 게시글
	@Override
	public List<Map<String, Object>> getCommuByLike() {

		return mainDao.selectLikeCommuBoard();
	}

	//메인 검색
	@Override
	public Paging getPaging(Paging param) {
		
		//총 게시글 수 조회
		int totalCount = mainDao.selectCntAll(param);
		
		//페이징 객체 생성(페이징 계산)
		Paging paging = new Paging( param.getMenu(), param.getCate(), param.getSelectSub(), param.getSearchText(),totalCount, param.getCurPage(), 12, 10 );

		return paging;
	}
	
	//검색리스트 뽑기
	@Override
	public List<Map<String, Object>> searchList(Paging paging) {

		return mainDao.selectSearch(paging);
	}
	
}
