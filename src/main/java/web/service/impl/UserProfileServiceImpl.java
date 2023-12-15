package web.service.impl;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Arrays;
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

import web.dao.face.UserProfileDao;
import web.dto.Basket;
import web.dto.Board;
import web.dto.Business;
import web.dto.Comment;
import web.dto.Rent;
import web.dto.User;
import web.dto.UserFile;
import web.service.face.UserProfileService;
import web.util.Paging;

@Service
public class UserProfileServiceImpl implements UserProfileService {

	private final Logger logger = LoggerFactory.getLogger( this.getClass() );
	
	@Autowired UserProfileDao userProfileDao;
	@Autowired private ServletContext context;
	
	@Override
	public void updateInfo(User user) {
		
		userProfileDao.infoUpdate(user);
	}


	@Override
	public void userDelete(User user) {
		
		userProfileDao.deleteUser(user);
	}


	@Override
	public void imgUpdate(MultipartFile file, String userId) {
		
		//빈 파일 처리
		if( file.getSize() <= 0 ) {
			return;
		}
        
        
        
        // 허용된 확장자들
        List<String> allowedExtensions = Arrays.asList("jpg", "jpeg", "png", "gif");

        // 원본 파일 이름에서 확장자 추출
        String originalFilename = file.getOriginalFilename();
        String fileExtension = originalFilename.substring(originalFilename.lastIndexOf(".") + 1).toLowerCase();

        // 허용된 확장자인지 검사
        if (!allowedExtensions.contains(fileExtension)) {
            // 허용되지 않은 확장자인 경우 처리 (예: 오류 메시지 반환 또는 예외 처리)
            return;
        }
        
        
        
        // 파일이 저장될 경로
        String storedPath = context.getRealPath("upload");

        // upload 폴더 생성
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

		
		// 이미지 정보를 user_page 테이블에 저장
	    UserFile userFile = new UserFile();
	    userFile.setId(userId);
	    userFile.setOriginName(originalFilename);
	    userFile.setStoredName(storedName);
	    userFile.setThumbnailName(thumbnailName);  // 썸네일 이름은 필요에 따라 변경
	    userFile.setFileType(fileType);

	 // 이미지 정보 업데이트 또는 삽입
	    updateImg(userFile);
		
		
	}	
	
	
	// 이미지 정보 업데이트 또는 삽입 메서드
    private void updateImg(UserFile userFile) {
        // 이미지 정보가 존재하는지 확인
        int count = userProfileDao.checkIfImageExists(userFile.getId());

        if (count > 0) {
            // 이미지 정보가 이미 존재하면 UPDATE
            userProfileDao.updateImage(userFile);
        } else {
            // 이미지 정보가 존재하지 않으면 INSERT
            userProfileDao.insertImage(userFile);
        }
    }
	
	@Override
	public Paging getPaging(Paging param) {
		int totalCount = userProfileDao.selectCntAll(param);
		logger.info("총 조회수우우우야랴{}",totalCount);
		
		
		Paging paging = new Paging(  param.getMenu(), param.getCate(),totalCount, param.getCurPage(), 9, 10 );
		
		return paging;
	}
	
	@Override
	public List<Map<String,Object>> myRentList(Board board) {
		
		return userProfileDao.selectMyRentList(board);
	}
	
	@Override
	public List<Map<String, Object>> rentList(User user) {
		return userProfileDao.selectRentList(user);
	}

	//내가쓴글보드페이징
	@Override
	public Paging getBoardPaging(Paging param) {
		int boardTotalCount = userProfileDao.selectMyBoardCntAll(param);
		logger.info("내가쓴게시글 몇개? : {}",boardTotalCount);
		
		Paging myBoardCnt = new Paging(param.getMenu(), param.getCate(),boardTotalCount, param.getCurPage(), 5, 10);
		
		return myBoardCnt;
	}
	
	@Override
	public List<Map<String, Object>> myBoardList(Paging myBoardPaging) {
		logger.info("서비스 임플에서 myBoardPaging :{}", myBoardPaging);
		
		return userProfileDao.selectAll(myBoardPaging);
	}

	@Override
	public UserFile imgSelect(String userId) {
		
		
		return userProfileDao.selectImg(userId);
	}


	@Override
	public void introduceUpdate(User user) {

		userProfileDao.updateIntroduce(user);
	}

	
	@Override
	public void imgDelete(UserFile userFile) {
	
		userProfileDao.deleteImg(userFile);
		
	}

	@Override
	public int cntLike(User user) {
		return userProfileDao.selectLikeByBoardNo(user);
	}
	
	@Override
	public User selectUserGrade(User user) {
		return userProfileDao.selectGrade(user);
	}


	@Override
	public void updateGrade(int likeCount, User userGrade) {
		logger.info("추천수 나오나?{}",likeCount);
		logger.info("추천수 나오나?{}",userGrade);
		
		
		if (likeCount >= 5 && likeCount < 10) {
		    userProfileDao.updateCrackEgg(userGrade);
		} else if (likeCount >= 10 && likeCount < 20) {
			 userProfileDao.updateChick(userGrade);
		} else if (likeCount >= 20 && likeCount <= 30) {
			 userProfileDao.updateChicken(userGrade);
		} else if (likeCount > 30) {
			 userProfileDao.updateFriedChicken(userGrade);
		}
		
	}
	
	@Override
	public User gradeResult(User user) {
		return userProfileDao.selectGrade(user);
	}


	@Override
	public boolean updateRentStatus(Rent rent) {
		int res = userProfileDao.updateRentStatus(rent);
		if (res != 0 ) {
			logger.info("22222{}",res);
			return true;
		} else {
			logger.info("33333{}",res);
			return false; 
		}
		
	}


	@Override
	public boolean updateRentCancel(Rent rent) {
		int res = userProfileDao.updateCancel(rent);
		
		if (res > 0 ) {
			logger.info("123{}",res);
			return true;
		} else {
			logger.info("12344{}",res);
			return false; 
		} 
	}
	
	@Override
	public boolean checkConfirm(Rent rent) {
		
		int confirm = userProfileDao.selectConfirm(rent);
		logger.info("컨펌{}",confirm);
		
		if ( confirm == 2) {
			return true;
		}
		return false;
	}
	
	@Override
	public boolean checkCancel(Rent rent) {
		
		int cancel = userProfileDao.selectCancel(rent);
		logger.info("캔슬{}",cancel);
		if( cancel == 0) {
			return true;
		}
		return false;
	}

	public User userAllSelect(User user) {
		return userProfileDao.selectUserAll(user);
	}

//	@Override
//	public List<Board> boardSelectById(Board board) {
//		return userProfileDao.selectBoardById(board);
//	}
	
	@Override
	public List<Board> boardSelectById(Board board) {
		return userProfileDao.selectBoardById(board);
	}


	@Override
	public List<Map<String, Object>> commentSelectById(Comment comment) {
		return userProfileDao.selectCommentById(comment);
	}


	@Override
	public List<Map<Board, Object>> selectBasketList(Board board) {
		return userProfileDao.basketList(board);
	}


	public int emailSubUpdate(User user) {
		return userProfileDao.updateEmailSub(user);
	}


	@Override
	public User loginUserSelect(User user) {
		return userProfileDao.selectLoginUser(user);
	}

	@Override
	public void insertBusiness(Business busi, User user) {
		int res = userProfileDao.insertBusi(busi);
		
		if( res > 0 ) {
			userProfileDao.updateBusiStatus(user);
		}
	}

	@Override
	public boolean checkAgree(User user) {
		
		User res =  userProfileDao.selectEmail(user);
		logger.info("이거 나와야합니다아아{}",res);
		if( res.getEmailAgr() > 0) {
			return true;
		}
		return false;
	}
	
	
	@Override
	public void updateEmail(User user) {
		
		if(user.getEmailAgr() > 0 ) {
			userProfileDao.updateAgree(user);
		} else {
			userProfileDao.updateDisagree(user);

		}
		
	}


	@Override
	public Map<String, Object> selectBusiness(User user) {
		return userProfileDao.selectBusy(user);
	}
	
	@Override
	public String selectyourId(String boardNo) {
		return userProfileDao.selectId(boardNo);
	}


	@Override
	public User yourProfile(String id) {
		return userProfileDao.selectYourInfo(id);
	}


	@Override
	public Map<String, Object> selectYourUrl(User user) {
		return userProfileDao.selectYourLink(user);
	}


	@Override
	public UserFile yourImg(String userId) {
		return userProfileDao.yourThumb(userId);
	}


	@Override
	public List<Map<String, Object>> yourBoard(Board board) {
		return userProfileDao.yourBoardList(board);
	}

	//-------------------------------------------------------------
	
	@Override
	public String yourCmtIdSelect(String cmtNo) {
		
		return userProfileDao.selectYourCmtId(cmtNo);
	}


	@Override
	public User yourCmtProfileSelect(String id) {
		
		return userProfileDao.selectYourCmtProfile(id);
	}


	@Override
	public Map<String, Object> yourCmtUrlSelect(User user) {
		return userProfileDao.selectYourCmtUrl(user);
	}


	@Override
	public UserFile yourCmtImgSelect(String id) {
		return userProfileDao.selectYourCmtImg(id);
	}


	@Override
	public List<Map<String, Object>> yourCmtBoardSelect(Board board) {
		return userProfileDao.selectYourCmtBoard(board);
	}




	


	


	



}
