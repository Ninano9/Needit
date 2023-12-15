package web.service.impl;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import web.dao.face.MenuShareDao;
import web.dto.Basket;
import web.dto.Board;
import web.dto.Booking;
import web.dto.Comment;
import web.dto.FileTb;
import web.dto.Like;
import web.dto.Rent;
import web.dto.User;
import web.service.face.MenuShareService;
import web.util.Paging;

@Service
public class MenuShareServiceImpl implements MenuShareService{
	
	//로그 객체 
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired MenuShareDao menuShareDao;
	@Autowired ServletContext context;
	
	@Override
	public Paging getPaging(Paging param) {
		
		int totalCount = menuShareDao.selectCntAll(param);
		
		Paging paging = new Paging( param.getMenu(), param.getCate(), param.getSelectSub(), param.getSearchText(),totalCount, param.getCurPage(), 12, 10 );
		return paging;
	}
	
	@Override
	public List<Map<String, Object>> selectBoardStatus(Paging paging, Board board) {
		return menuShareDao.selectAll(paging);
	}
	
	@Override
	public List<Map<String, Object>> searchList(Paging paging) {
		return menuShareDao.selectSearch(paging);
	}

	@Override
	public Board view(Board board) {
		
		
		if(board.getHit() != -1 ) {
			menuShareDao.updateHit(board);
			
		}
		return menuShareDao.selectByBoardNo(board);
	}
	

	@Override
	public void write(Board writerContent, List<MultipartFile> file) {
		
		if( writerContent.getTitle() == null || "".equals(writerContent.getTitle())) {
			writerContent.setTitle("(제목없음)");
		}
		//글작성 
		menuShareDao.insertBoard(writerContent);
		
		//첨부파일이 없을 경우 처리
		if( file.size() == 0 ) {
			return;
		}

		for(MultipartFile f : file) {
			this.fileinsert( f, writerContent.getBoardNo() );
		}
		
	}
	
	private void fileinsert( MultipartFile file, int boardNo ) {
		
		//빈 파일 처리
		if( file.getSize() <= 0 ) {
			return;
		}
		
		//파일이 저장될 경로
		String storedPath = context.getRealPath("upload");
		
		//upload 폴더 생성
		File storedFolder = new File(storedPath);
		storedFolder.mkdir();
		
		//저장될 파일 이름
		String originName = file.getOriginalFilename();
		String storedName = originName + UUID.randomUUID().toString().split("-")[4];
		String fileType = originName.substring(originName.lastIndexOf(".")+ 1);

		//압축 이미지용 저장될 파일 이름
		String thumbnailName = "t_" + storedName;
		logger.info("thumbnailName  : " + thumbnailName );

		//저장할 파일 객체
		File dest = new File(storedFolder, storedName);
		
		try {
			
			file.transferTo(dest);
			
	         //--- 이미지 파일 압축하여 저장하기 ---
			
			 //썸네일 파일생성 객체
			 File thumbnailFile = new File(storedPath, "t_" + storedName);
	         
	         //원본 파일을 압축할 파일명 변수에 대입
	         BufferedImage bufOriginImage = ImageIO.read(dest);
	         //압축될 파일의 ('넓이', '높이', '생성될 이미지의 타입') 지정->원하는 크기로 지정가능
	         BufferedImage bufPressImage = new BufferedImage(500, 500, BufferedImage.TYPE_3BYTE_BGR);
	         
	         //BufferedImage 객체에 Grahpic2D객체를 이용해 그리기
	         Graphics2D graphic = bufPressImage.createGraphics();
	         
	         // drawImage 메서드를 호출하여 원본 이미지(원본 BuffedImage)를 
	         //썸네일 BufferedImage에 지정한 크기로 변경하여 왼쪽 상단 "0, 0" 좌표부터 그리기
	         graphic.drawImage(bufOriginImage, 0, 0, 500, 500, null);
	         
	         // ImageIO의 write 메서드를 호출하여 그려진 객체를 파일로 저장
	         //write() -> 매개변수( 파일로 저장할 이미지, (String)이미지 형식, 저장될 경로 )
	         ImageIO.write(bufPressImage, "jpg", thumbnailFile);
			
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		//---------------------------------------------------------------------------

		FileTb fileTb = new FileTb();

		fileTb.setBoardNo( boardNo );
		fileTb.setOriginName( originName );
		fileTb.setStoredName( storedName );
		fileTb.setThumbnailName( thumbnailName );
		fileTb.setFileType( fileType );
		
		logger.info("fileTb : {}", fileTb);
		
		menuShareDao.insertFile( fileTb );

	}
	
	@Override
	public List<Board> menu(Board writerContent) {
		
		return menuShareDao.selectByMenu(writerContent);
		
	}
	
	
	@Override
	public List<FileTb> getAttachFile(Board updateParam) {
		return menuShareDao.selectBoardfileByBoardNo( updateParam );
	}
	

	@Override
	public void updateBoard(Board updateParam, List<MultipartFile> file, int[] delFileno) {
	
		if( updateParam.getTitle() == null || "".equals(updateParam.getTitle()) ) {
			updateParam.setTitle("(제목없음)");
		}
		
		menuShareDao.updateBoard( updateParam );

		//---------------------------------------------------------------------------
		
		//첨부파일이 없을 경우 처리
		if( file.size() == 0 ) {
			return;
		}

		for(MultipartFile f : file) {
			this.fileinsert( f, updateParam.getBoardNo() );
		}

		//---------------------------------------------------------------------------

		//삭제할 첨부 파일 처리
		if( delFileno != null ) {
			menuShareDao.deleteFiles( delFileno );
		}
	
	}

	@Override
	public void delete(Board deleteParam) {
		menuShareDao.deleteFileByBoardNo( deleteParam );	//첨부파일 삭제
		menuShareDao.deleteByBoardNo( deleteParam );	//게시글 삭제
	}
	
	@Override
	public boolean isLike(Like like) {
		int cnt = menuShareDao.selectCntLike(like);
		
		if(cnt > 0) { //추천했음
			logger.info("추천함!");
			return true;
			
		} else { //추천하지 않았음
			logger.info("추천안함!");
			return false;
			
		}
	}

	@Override
	public boolean like(Like like) {
		logger.info("추천 넘어옴");
		
		if( isLike(like) ) { //추천한 상태
			menuShareDao.deleteLike(like);
			
			return false;
			
		} else { //추천하지 않은 상태
			menuShareDao.insertLike(like);
			
			return true;
		}
	}

	@Override
	public int getTotalCntLike(Like like) {
		return menuShareDao.selectTotalCntLike(like);
	}
	
	
	@Override
	public void commentinsert(Comment comment) {
		menuShareDao.cmtWrite(comment);
	}

	@Override
	public List<Map<String, Object>> list(Comment comment) {
		return menuShareDao.cmtList(comment);
	}

	@Override
	public void commentdelete(Comment commentDelete) {
		menuShareDao.deleteComment(commentDelete);

	}


	@Override
	public boolean checkBook(Booking book) {
		
		int res = menuShareDao.checkBook(book);
		
		if( res > 0) {
			logger.info("예약 불가");
			return true;
		}
		menuShareDao.makeBook(book);
		logger.info("예약 가능");
		return false;
	}

	@Override
	public boolean checkBooking(Booking book) {
		
		if( menuShareDao.checkBook(book) > 0) {
			return true;
		}
		return false;
	}

	@Override
	public void bookStatus() {
		
	}

	@Override
	public boolean checkBasket(Basket basket) {
		int res = menuShareDao.basketInfo(basket);
		logger.info("res{}",res);
		if(  res > 0) {
			menuShareDao.deleteBasket(basket);
			return true;
		} else {
		menuShareDao.insertBasket(basket);
		return false; 
		}
	}
	@Override
	   public int getCmtCnt(String boardNo) {
	      return menuShareDao.getCntCmt(boardNo);
	}

	@Override
	public User writeAddrSelect(User user) {
		return menuShareDao.selectWriteAddr(user);
	}
	
	@Override
	public void rent(Rent rentParam) {
		menuShareDao.makeRent(rentParam);
	}
	



	

		

	
	
	
}

