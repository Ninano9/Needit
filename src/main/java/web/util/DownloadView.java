package web.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

import web.dto.FileTb;

public class DownloadView extends AbstractView {
	   private final Logger logger = LoggerFactory.getLogger( this.getClass() );
	   
	@Autowired private ServletContext context;

	@Override
	protected void renderMergedOutputModel(
			Map<String, Object> model, 
			HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		logger.info("파일 다운로드 응답 테스트");
		//------------------------------------------------------------------------
		
//		response.setContentType("text/html;charset=utf-8");
//		response.getWriter().append("<h1>스프링 빈 응답 테스트</h1>");
		//------------------------------------------------------------------------
		
		//모델값 가져오기
		FileTb file = (FileTb) model.get("downFile");
		
		//저장된 파일의 폴더 (upload)
		String path = context.getRealPath("upload");
		
		//실제 업로드된 파일의 이름
		String filename = file.getStoredName();
		
		//실제 파일 객체
		File src = new File(path, filename);
		
		logger.info("서버에 업로드된 파일 {}", src);
		logger.info("존재 여부{}", src.exists() );
		//------------------------------------------------------------------------

		//** HTTP응답을 직접 구성하여 처리해야 한다
		
		//** 필수 HTTP Response HEADER 정보를 작성한다
		//	Content-Type
		//	Content-Length
		//	CharacterEncoding
		//	Content-Disposition
		
		//** 응답 데이터를 HTTP Response BODY 로 채워야 한다
		//------------------------------------------------------------------------
		
		//** 응답 메시지의 HEADER영역 설정하기
		
		//응답 데이터의 콘텐트타입(데이터 유형) 설정하기
		//	-> application/octet-stream : 모든 파일의 형식을 대표하는 MIME타입
		//	-> 브라우저는 해당 형식의 데이터를 파일로 다운받오록 되어있다
		response.setContentType("application/octet-stream");
		
		//응답 데이터의 크기 설정
//		response.setContentLength( (int)src.length() );
		response.setContentLengthLong( src.length() );
		
		//응답 데이터의 인코딩 설정
		response.setCharacterEncoding("UTF-8");
		
		//브라우저가 다운로드할 파일의 이름 설정
		// -> 한글 인코딩(UTF-8)이 톰캣 서버를 통과할 때 깨지므로
		//	URL Encoding을 이용하여 UTF-8을 유지하도록 변환한다
		String outputName = URLEncoder.encode(file.getOriginName(), "UTF-8");
		outputName = outputName.replace("+", "%20"); //띄어쓰기 복원
		response.setHeader("Content-Disposition", "attachment; filename=\"" + outputName + "\"");
		//------------------------------------------------------------------------

		//** 응답 메시지의 BODY영역 설정하기
		
		//	서버File객체 -> FileInputStream 입력 -> HTTP Response OutputStream 출력
		
		//서버의 파일 입력 스트림
		FileInputStream in = new FileInputStream(src);
		
		//클라이언트의 응답 출력 스트림
		OutputStream out = response.getOutputStream();
		
		//서버->클라이언트의 파일 복사
		FileCopyUtils.copy(in, out);
		
	}
	
}





