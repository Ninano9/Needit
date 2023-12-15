package web.service.impl;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import web.dao.face.AdminDao;
import web.dto.Banner;
import web.dto.Board;
import web.dto.Business;
import web.dto.Comment;
import web.dto.FileTb;
import web.dto.Report;
import web.dto.User;
import web.service.face.AdminService;
import web.util.Paging;

@Service
public class AdminServiceImpl implements AdminService {
	private final Logger logger = LoggerFactory.getLogger( this.getClass() );

	@Autowired AdminDao adminDao;
	@Autowired ServletContext context;
	
	//관리자 메인배너 수정 및 업로드
	@Override
	public void bannerUpdate(Banner bannerParam, List<MultipartFile> file) {

//		adminDao.insert(bannerParam);
		
		if( file.size() == 0 ) {
			return;
		}
		
		for(MultipartFile f : file) {
			this.fileinsert( f, bannerParam.getBannerNo() );
		}
	} //bannerUpdate end

	private void fileinsert(MultipartFile file, int bannerNo) {
		//빈 파일 처리
		if( file.getSize() <= 0 ) {
			return;
		}
		
		//파일이 저장될 경로
		String storedPath = context.getRealPath("/resources/banner");
		logger.info(storedPath);
		//upload 폴더 생성
		File storedFolder = new File(storedPath);
		storedFolder.mkdir();
		
		//저장될 파일 이름
		String originName = file.getOriginalFilename();
		String storedName = originName + UUID.randomUUID().toString().split("-")[4];
		String fileType = originName.substring(originName.lastIndexOf(".") + 1);
		
		//확장자명 가져오는 코드
//		file.getContentType();
		
		//저장할 파일 객체
		File dest = new File(storedFolder, storedName);
	
		try {
			file.transferTo(dest);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		Banner banner = new Banner();
		banner.setBannerNo(bannerNo);
		banner.setOriginName(originName);
		banner.setStoredName(storedName);
		banner.setFileType(fileType);
		
		adminDao.insertBanner(banner);
				
	} //fileinsert end

	//썸네일 미리보기
	@Override
	public List<Banner> getBannerNo() {
		
		List<Banner> banner = new ArrayList<Banner>();
		banner = adminDao.getStoredName();
		return banner;
	}

	//------------------------------------------------------
	
	//공지사항 작성
	@Override
	public void writeNotice(Board board) {

		adminDao.insertNotice(board);
	}
	
	
	//메인에서 공지사항 list 조회
	@Override
	public List<Board> noticeList() {

		return adminDao.selectAllNotice();
	}

	//관리자에서 공지사항 list 조회
	@Override
	public List<Map<String, Object>> adminNoticeList() {

		return adminDao.adminSelectAllNotice();
	}
	
	//공지삭제
	@Override
	public void deleteNotice(Board board) {
		
		adminDao.deleteNoticeFile(board);
		adminDao.deleteNotice(board);
	}

	//DB에서 이메일 불러오기
	@Override
	public List<Map<String, Object>> emailList() {
		
		return adminDao.selectAllEmail();
	}

	//게시글 신고 목록
	@Override
	public List<Map<String, Object>> getBoardReportInfo() {

		return adminDao.selectReportBoard();
	}
	
	//댓글 신고 목록
	@Override
	public List<Map<String, Object>> getCmtReportInfo() {

		return adminDao.selectCmtBoard();
	}
	
	//게시글 신고 삭제
	@Override
	public void deleteBoard(Board board) {
		//게시글 삭제를 위해 필요한 것들(FK)
		adminDao.deleteFile(board);
		adminDao.deleteCmt(board);
		adminDao.deleteLike(board);
		adminDao.deleteBasket(board);
		
		//게시글 삭제
		adminDao.deleteBoard(board);
		
	}
	
	@Override
	public void deleteComment(Comment cmt) {

		//댓글 삭제
		adminDao.deleteComment(cmt);
	}
	
	
	//업체 요청 목록
	@Override
	public List<Map<String, Object>> businessList() {

		return adminDao.selectBusinessList();
	}
	
	//업체 승인, 취소
	@Override
	public void approveBusiness(Business business) {
		adminDao.approveBusiness(business);
		
	}
	@Override
	public void cancelBusiness(Business business) {
		int res = adminDao.cancelBusiness(business);
		if ( res > 0 ) {
			adminDao.deleteBusiness(business);
		}
		
	}

}
