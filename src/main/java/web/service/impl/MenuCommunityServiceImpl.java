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
import org.springframework.web.multipart.MultipartFile;

import web.dao.face.MenuCommunityDao;
import web.dto.Board;
import web.dto.Comment;
import web.dto.FileTb;
import web.dto.Like;
import web.service.face.MenuCommunityService;
import web.util.Paging;

@Service
public class MenuCommunityServiceImpl implements MenuCommunityService {
	private final Logger logger = LoggerFactory.getLogger( this.getClass() );
	
	@Autowired private MenuCommunityDao menuCommunityDao;
	@Autowired private ServletContext context;
	
	@Override
	public Paging getPaging(Paging param ) {
		
		//총 게시글 수 조회
		int totalCount = menuCommunityDao.selectCntAll(param);
		
		//페이징 객체 생성(페이징 계산)
		Paging paging = new Paging( param.getMenu(), param.getCate(), param.getSelectSub(), param.getSearchText(),totalCount, param.getCurPage(), 12, 10 );

		return paging;
	}

	@Override
	public List<Map<String, Object>> list(Paging paging) {
		return menuCommunityDao.selectAll(paging);
	}

	@Override
	public List<Map<String, Object>> searchList(Paging paging) {
		return menuCommunityDao.selectSearch(paging);
	}
	
	@Override
	public Board view(Board board) {
		
		//update 일 때에는 조회수가 증가되지 않는다
		if( board.getHit() != -1 ) {
			//조회수 증가
			menuCommunityDao.updateHit(board);
		}
		
		return menuCommunityDao.selectByBoardNo(board);
	}

	@Override
	public void write(Board writeParam, List<MultipartFile> file) {
		
		//글작성 
		menuCommunityDao.insertBoard(writeParam);
		
		//첨부파일이 없을 경우 처리
		if( file.size() == 0 ) {
			return;
		}

		for(MultipartFile f : file) {
			this.fileinsert( f, writeParam.getBoardNo() );
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
		
		menuCommunityDao.insertFile( fileTb );

	}

	@Override
	public List<FileTb> getAttachFile(Board board) {
		return menuCommunityDao.selectFileByBoardNo( board );
	}

	@Override
	public FileTb getFile(FileTb fileTb) {
		return menuCommunityDao.selectFileByFileNo(fileTb);
	}

	@Override
	public boolean isLike(Like like) {
		int cnt = menuCommunityDao.selectCntLike(like);
		
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
			menuCommunityDao.deleteLike(like);
			
			return false;
			
		} else { //추천하지 않은 상태
			menuCommunityDao.insertLike(like);
			
			return true;
		}
	}

	@Override
	public int getTotalCntLike(Like like) {
		return menuCommunityDao.selectTotalCntLike(like);
	}

	@Override
	public void commentInsert(Comment commentParam) {
		menuCommunityDao.insertComment(commentParam);
	}

	@Override
	public List<Map<String,Object>> viewComment(Comment commentParam) {
		return menuCommunityDao.selectAllComment(commentParam);
	}

	@Override
	public void delete(Comment commentDelete) {
		menuCommunityDao.deleteComment(commentDelete);
	}

	@Override
	public void delete(Board board) {
		menuCommunityDao.deleteBoard(board);
	}

	@Override
	public void updateBoard(Board updateParam, List<MultipartFile> file, int[] delFileno) {
	
		if( updateParam.getTitle() == null || "".equals(updateParam.getTitle()) ) {
			updateParam.setTitle("(제목없음)");
		}
		
		menuCommunityDao.updateBoard( updateParam );

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
			menuCommunityDao.deleteFiles( delFileno );
		}
	
	}

	@Override
	public int getCmtCnt(String boardNo) {
		return menuCommunityDao.getCntCmt(boardNo);
	}


}
