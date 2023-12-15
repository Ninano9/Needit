<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1b5f231240cb73d46a6f0aa5b0d4c5e1&libraries=services"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

<%-- Header --%>
<c:import url="/WEB-INF/views/layout/header.jsp" />

<%-- Style --%>
<style type="text/css">
.report-options {
    font-size: 13px;
    background-color: white;
    position: absolute;
    border-radius: 5px;
    width: 100px;
    border: 1px solid #ccc;
    display: block;
    margin-left: 1110px;
    margin-top: -19px;
    z-index: 2;
}
.report-options input {
	margin-left: 5px;
    margin-top: 5px;
}
#cmtReportBtn {
	border: none;
    background-color: inherit;
    font-size: 13px;
    float: right;
    margin-top: 15px;
    color: red;
}
#submitCmt {
	margin: 3px 3px 3px 3px;
    width: 95%;
    font-size: 13px;
    border-radius: 5px;
    border: none;
} 
#map-container {
    overflow: hidden;
    height: 0;
    transition: height 0.3s ease;
}

#map-container.expanded {
    height: 350px;
}

#map {
	margin: 0 auto;
}

#del {
	border: none;
	border-radius: 10px;
}
.file {
    color: blue;
}
.cmtWriter {
	display: inline-block;
    text-align: center;
    width: 42px;
    border-radius: 10px;
    color: white; 
    background-color: rgb(255,83,63);
    font-size: 11px;
    margin-left: 4px;
}
h5 {
	font-size: 15px;

}
h6 {
    font-weight: bolder;
}
.bi-suit-heart-fill::before {
    color: red;
    content: "\f59d";
}
.bi-suit-heart::before {
    color: red;
    content: "\f59e";
}
#likeNo {
	display:inline;
	color: blue;
}

.table td {
	vertical-align: middle;
}


.viewWrap { 
	margin: 10px auto;
}
#viewTitle {
	font-size: 2em;
}
#viewHit {
	color:  #ff533f;
}
.viewNick {
    padding: 5px 0;
    border-bottom: 3px solid #ff533f;
    border-top: 3px solid #ff533f;
    color: #ff533f;
}
#viewNick {
	margin-left: 10px
}
#viewDate {
	font-size: 0.8em;
    color: #6f6f6f;
}
.viewContent {
    width: 1100px;
    margin: 10px auto;
    min-height: 300px;
}
.viewLike {
	margin: 0 auto;
    text-align: center;
    border-radius: 20px;
    color: #ff533f;
    background: black;
    width: 110px;
}
.text-left a {
    background: #ff533f;
    color: white;
    font-weight: bold;
}
#upAndDel button {     
	color: white;
    border: none;
    width: 60px;
    border-radius: 5px;
    background: #ff533f;
    font-weight: bold;
}

#viewLocation {
    float: right;
    font-size: 0.9em;
    margin-right: 14px;
    color: black;
}

a:hover {
	text-decoration: none;
	color: #ff533f;
}

.viewFile { width: 100%; height: 35px; margin: 0 auto;border: 1px solid #ccc; border-radius: 10px;}
</style>

<%-- 추천, 댓글 --%>
<script type="text/javascript">

function cmtReport(cmtNo) {
    var reportOptions = document.getElementById('reportSelect_' + cmtNo);
    if (reportOptions.style.display === 'none') {
        reportOptions.style.display = 'block';
    } else {
        reportOptions.style.display = 'none';
    }
}

// 댓글목록 불러오기
function loadComments() {
	$.ajax({
	    type: "GET",
	    url: "/community/comment/list",
	    data: {
	        boardNo: ${board.boardNo}
	    },
	    success: function (res) {
	        console.log("댓글창 반응 성공 : ", res);
	        
	        // 댓글 목록을 가져와서 HTML로 렌더링
	        var commentListHtml = "";
	
	        const id = '${id}' //세션 아이디
	        const nick = '${nick}' //세션 닉네임
	        
	        if( res.commentList != null && res.commentList.length > 0 ){
	        	console.log("댓글 있음")
		        for (var i = 0; i < res.commentList.length; i++) {
	
		            var boardMaster = "${board.writerNick }" //게시글 작성자
		            var commentWriter = res.commentList[i].WRITER_NICK//댓글 작성자
		            
		            commentListHtml += '<hr>'; 
		            commentListHtml += '<div class="media mb-4">';
		            //프로필사진 유무 처리
		            if( res.commentList[i].THUMBNAIL_NAME != null || res.commentList[i].THUMBNAIL_NAME > 0 ){
		            commentListHtml += '  <img style="border: 0.5px solid #ccc; width: 70px; height: 70px;" class="d-flex mr-3 rounded-circle" src="/upload/' + encodeURIComponent(res.commentList[i].THUMBNAIL_NAME) + '">';
		            } else {
			            commentListHtml += '  <img style="border: 0.5px solid #ccc; width: 70px; height: 70px;" class="d-flex mr-3 rounded-circle" src="/resources/img/defaultProfile.png">';
		            }
		            commentListHtml += '  <div class="media-body" style="margin-bottom: -30px;">';
		            //댓글 작성자 구분 처리                                                                                    
		            if (commentWriter === boardMaster && commentWriter === nick) { 
		                commentListHtml += '    <h6>' + res.commentList[i].WRITER_NICK + '<div class="cmtWriter" style="color: white; background-color: #52C728;">내댓글</div>' + '</h6>';
		            } else if (commentWriter === nick) {
		                commentListHtml += '    <h6>' + res.commentList[i].WRITER_NICK + '<div class="cmtWriter" style="color: white; background-color: #52C728;">내댓글</div>' + '</h6>';
		            } else if (commentWriter === boardMaster) {
		                commentListHtml += '    <h6>' + res.commentList[i].WRITER_NICK + '<div class="cmtWriter">작성자</div>' + '</h6>';
		            } else {
		                commentListHtml += '    <h6>' + res.commentList[i].WRITER_NICK + '</h6>';
		            }
		            //댓글내용
		            commentListHtml += '    <h5 class="text-start">' + res.commentList[i].CONTENT + '</h5>';
		            //댓글작성 일자
		            commentListHtml += '    <p style="font-size: 13px; display: inline-block;">' + formatDate(new Date(res.commentList[i].writeDate)) + '</p>';
		            //본인 댓글 삭제가능 처리
		            if (id && id == res.commentList[i].WRITER_ID) {
		                commentListHtml += '    <button id="del" onclick="deleteComment(' + res.commentList[i].CMT_NO + ');">';
		                commentListHtml += '	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash3" viewBox="0 0 16 16">';
		                commentListHtml += '	<path d="M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5ZM11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H2.506a.58.58 0 0 0-.01 0H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1h-.995a.59.59 0 0 0-.01 0H11Zm1.958 1-.846 10.58a1 1 0 0 1-.997.92h-6.23a1 1 0 0 1-.997-.92L3.042 3.5h9.916Zm-7.487 1a.5.5 0 0 1 .528.47l.5 8.5a.5.5 0 0 1-.998.06L5 5.03a.5.5 0 0 1 .47-.53Zm5.058 0a.5.5 0 0 1 .47.53l-.5 8.5a.5.5 0 1 1-.998-.06l.5-8.5a.5.5 0 0 1 .528-.47ZM8 4.5a.5.5 0 0 1 .5.5v8.5a.5.5 0 0 1-1 0V5a.5.5 0 0 1 .5-.5Z"/>';
		                commentListHtml += '	</svg>'
		                commentListHtml += '    </button>';
		            }
		            //댓글신고 버튼
		            if (id != null) {
		            commentListHtml += '	<button id="cmtReportBtn" onclick="cmtReport(' + res.commentList[i].CMT_NO + ');">'; 
		            commentListHtml += '신고하기';
		            commentListHtml += '	</button>';
		            commentListHtml += '<div id="reportSelect_' + res.commentList[i].CMT_NO + '" class="report-options" style="display:none;">';
		            commentListHtml += '  <input type="radio" name="reportType" value="광고">광고</input>';
		            commentListHtml += '  <input type="radio" name="reportType" value="욕설">욕설</input><br>';
		            commentListHtml += '  <input type="radio" name="reportType" value="비방">비방</input>';
		            commentListHtml += '  <input type="radio" name="reportType" value="음란">음란</input><br>';
		            commentListHtml += '  <input type="radio" name="reportType" value="불법">불법</input><br>';
		            commentListHtml += '  <button id="submitCmt" onclick="submitReport(' + res.commentList[i].CMT_NO + ');">제출</button>';
		            commentListHtml += '</div>';
		            }
		            commentListHtml += '</div>';
		            commentListHtml += '  </div>';
		            commentListHtml += '</div>';
		        }
		        // 렌더링된 HTML을 추가
		        $("#commentList").html(commentListHtml);

	        } else {
	        	console.log("댓글 없음")
	            commentListHtml += '<hr>'; 
	            commentListHtml += '<div class="media mb-4">';
	            commentListHtml += '  <div class="media-body" style="margin-bottom: -30px;">';
	            commentListHtml += '    <p style="text-align: center; color: rgb(255,83,63); margin-bottom: 100px;">작성된 댓글이 없습니다.</p>';
	            commentListHtml += '  </div>';
	            commentListHtml += '</div>';
	        }
	        // 렌더링된 HTML을 추가
	        $("#commentList").html(commentListHtml);
	        
	    },
	    error: function () {
	        console.log("댓글창 반응 실패");
	    }
	
	});
	
	function formatDate(date) {
	    var curDate = new Date();
	    var writeDate = new Date(date);
	
	    var isSameDay = curDate.toDateString() === writeDate.toDateString();
	
	    var year = writeDate.getFullYear().toString().slice(-2); // 년도의 뒤 2자리를 가져옴
	    var month = ('0' + (writeDate.getMonth() + 1)).slice(-2);
	    var day = ('0' + writeDate.getDate()).slice(-2);
	    var hours = ('0' + writeDate.getHours()).slice(-2);
	    var minutes = ('0' + writeDate.getMinutes()).slice(-2);
	    var seconds = ('0' + date.getSeconds()).slice(-2);
	
	    if (isSameDay) {
	        return hours + ':' + minutes + ':' + seconds;
	        
	    } else {
	        return year + '.' + month + '.' + day + ' ' + hours + ':' + minutes;
	    }
	}

}// loadComments() End.


function submitReport(cmtNo) {
    // 선택된 라디오 버튼의 값을 가져오기
    var selectedOption = document.querySelector('input[name="reportType"]:checked');
	
    if (!selectedOption) {
        alert("옵션을 선택하세요.");
        return;
    }
    
    // 서버로 Ajax 호출
    $.ajax({
        type: "post",
        url: "/cmtReport",
        data: {
            boardNo: "${param.boardNo}",
            cmtNo: cmtNo,
            reportType: selectedOption.value,
            reportId: "${id}"
        },
        success: function (res) {
            console.log("댓글 신고 성공");
            alert("댓글 신고가 접수되었습니다.");
            
            loadComments()

        },
        error: function () {
            console.log("댓글 신고 실패");
        }
    });
}

function deleteComment( cmtNo ) {
	console.log("댓글 삭제 버튼 동작! : ", cmtNo )
	
		$.ajax({
			type: "GET"
	     	, url: "/community/comment/delete"
	     	, data: { 
	     		boardNo : ${board.boardNo },
	     		cmtNo : cmtNo
	     	}
	     	, success: function() {
	     		console.log("댓글삭제 성공")
	     		
	     		alert("댓글이 삭제되었습니다.")
	     		//댓글창 재 로드
	     		loadComments()
	         }
	         , error: function() {
		        console.log("댓글삭제 실패")
	         }
		})
	
}// deleteComment() End.

$(()=>{
	
	//댓글 리스트 조회
	loadComments()
	
	//댓글 입력 요청
	$("#btnCommInsert").click(function(){
		console.log("댓글 입력 버튼 동작!")
		
        // textarea의 value 가져오기
        var commentContent = $("#commentContent").val().trim();

        // textarea에 값이 없으면 동작하지 않음
        if (commentContent.length === 0) {
            alert("댓글 내용을 입력하세요.");
            return;
        }		

		$.ajax({
			type: "POST"
         	, url: "/community/comment"
         	, data: { 
         		boardNo : ${board.boardNo },
         		writerId : "${id }",
         		writerNick : "${nick }",
         		menu : "${param.menu }",
         		cate : "${param.cate }",
         		content : $("#commentContent").val()
         	}
         	, success: function( res ) {
         		console.log("댓글입력 AJAX성공")
         		
               	// 댓글 입력 성공 시, 댓글 창 비우고 포커스를 주기
               	$("#commentContent").val(""); // 댓글 창 비우기
               	$("#commentContent").focus(); // 댓글 창에 포커스 주기	         		
         		
	         	loadComments() // 페이지 로딩 시 댓글 목록 불러오기
	         }
	         , error: function() {
    	        console.log("댓글입력 AJAX실패")
	         }
	
		})
		
		var writer = "${board.writerId}";
		var sender = "${id}";
		
		<%-- 본인글에 댓글 입력시 알림x --%>
		if( writer != sender ){
			$.post( "/alert/sendnotification", { 
					id: "${board.writerId}"
			        , sender: "${id }"
			        , content: 4
			        , menu: "${param.menu}"
					, boardNo: "${board.boardNo}"
			}); // $.post 끝
		}
		
	})
	
	//추천 버튼 변경
	if(${isLike}) {
		console.log('추천 이미 함')
		$("#btnLike")
			.addClass("bi bi-suit-heart-fill")
	} else {
		console.log('추천 아직 안함')
		$("#btnLike")
			.addClass("bi bi-suit-heart")
	}// 추천 버튼 End.
	
	//추천, 취소 요청Ajax
	$("#btnLike").click(()=>{
		
		
		$.ajax({
			type: "GET"
			, url: "/community/like"
			, data: {  
				boardNo : ${board.boardNo }
			}
			, dataType: "JSON"
			, success: function( data ) {
					console.log("추천 성공");
	
				if( data.result ) { //추천 성공
					$("#btnLike")
					.removeClass("bi bi-suit-heart")
					.addClass("bi bi-suit-heart-fill")
					sendNofiLike()
				
				} else { //추천 취소 성공
					$("#btnLike")
					.removeClass("bi bi-suit-heart-fill")
					.addClass("bi bi-suit-heart")
				
				}
				//추천수 적용
				$("#likeNo").text(data.cnt)
				
			}
			, error: function() {
				console.log("실패");
			}
		}); //ajax end
	}); //$("#btnLike").click() End.
	
	$("#selfRent").click(function () {
		alert("작성자 본인은 대여신청이 불가합니다.");
	});
	
	$("#rejectChat").click(function(){
		alert("본인에게 대화신청은 불가합니다.");
	})
	
}); //jQuery Function End.

function sendNofiLike() {
	$.post( "/alert/sendnotification", { 
		id: "${board.writerId}"
        , sender: "${id }"
        , content: 6
        , menu: "${param.menu}" 
		, boardNo: "${board.boardNo}"
	}); // $.post 끝
}
</script>

<%-- Body --%>
<div class="container">
	<div class="viewWrap">
		<div id="upAndDel" style="float: right; margin: 15px;">
			<c:if test="${id eq board.writerId }">
				<a href="/community/update?boardNo=${board.boardNo }&menu=${param.menu }&cate=${param.cate }"><button>수정</button></a>
				<button data-bs-toggle="modal" data-bs-target="#deleteOBoardModal">삭제</button>
			</c:if>
		</div>	
		<div style="clear: both;"></div>
		<div class="viewTitle">
			<span id="viewTitle">${board.title }</span>
			<span id="viewHit">👀[${board.hit }]</span>
		</div><!-- .viewTitle -->
		<div class="viewNick">
			<a href="/profile/yourProfile?boardNo=${board.boardNo }"><span id="viewNick">${board.writerNick}</span></a> 		
			<span id="viewDate">🕑
			<fmt:formatDate var="curDate" value="<%=new Date() %>" pattern="yyyyMMdd" />
			<fmt:formatDate var="writeDate" value="${board.writeDate }" pattern="yyyyMMdd" />
			<c:choose>
				<c:when test="${writeDate lt curDate }">
					<fmt:formatDate value="${board.writeDate }" pattern="yyyy-MM-dd HH:mm:ss" />
				</c:when>
				<c:otherwise>
					<fmt:formatDate value="${board.writeDate }" pattern="HH:mm" />
				</c:otherwise>
			</c:choose>
			</span>	
			<c:if test="${param.menu == 4 && param.cate == 2 }">
				<span id="viewLocation" style="float: right;"><i style="color: rgb(255,83,63)" class="bi bi-geo-alt-fill"></i> ${board.location }</span>
			</c:if>
		</div><!-- .viewNick -->
		<div class="viewContent">${board.content }</div><!-- .viewContent  -->
		   <div class="viewFile">
       <div id="Download" style="float: left; margin: 1px 0 1px 10px;"> Downloads :</div>
	       <span style="margin: 0; float: left;">
	          <c:if test="${not empty fileTb }">
	          <c:forEach var="file" items="${fileTb }">
	             <a class="file bi bi-paperclip" href="./download?fileNo=${file.fileNo }">${file.originName }</a><br>
	          </c:forEach>
	          </c:if>
	          <c:if test="${empty fileTb }">
	             <span>첨부된 파일이 없습니다.</span>
	          </c:if>
	       </span>
	    </div><!-- #Download -->
	    <div style="clear: both; margin-bottom: 20px;"></div>
		<div class="viewLike">
			<c:if test="${isLogin }">
				<div class="btn" id="btnLike">
					<span style="color: white">좋아요</span>
					<span id="likeNo" style="color: #ff533f;">${cntLike }</span>
				</div>
			</c:if>		
			
			<c:if test="${not isLogin }">
				<a href=""  data-bs-toggle="modal" data-bs-target="#exampleModal" >
					<div class="btn bi bi-suit-heart" id="btnLike">
						<span style="color: white; font-weight: normal;">좋아요</span>
						<span id="likeNo" style="color: #ff533f;">${cntLike }</span>
					</div>
				</a>
			</c:if>		
		</div><!-- .viewLike -->
	</div><!-- .viewWrap -->

	<%-- 목록,수정,삭제 --%>
	<div class="text-left">
		<a class="btn" href="/community/list?menu=${param.menu }&cate=${param.cate}">목록</a>
	</div><br>

</div> <!-- .container -->

<%-- 댓글 영역 --%>
<div class="comment_container">
	
	<%-- 로그인 상태 --%>
	<c:if test="${isLogin }">
		<%-- 댓글작성 --%>
		<div class="row text-center justify-content-around align-items-center">
			<div class="col col-2">
				<input style="background-color: white;" type="text" class="form-control" id="commentWriter" value="${nick }" readonly="readonly"/>
			</div>
			<div class="col col-9">
				<textarea class="form-control" id="commentContent" style="resize: none; height: 15px;"></textarea>
			</div>
			<button id="btnCommInsert" class="btn btn-secondary col-1">작성</button>
		</div>
	</c:if><br>

	<%-- 비로그인 상태 --%>
	<c:if test="${not isLogin }">
		<div class="row text-center justify-content-around align-items-center">
			<div class="col col-2">
				<input type="text" class="form-control" id="commentWriter" value="unknown" readonly="readonly"/>
			</div>
			<div class="col col-9">
				<textarea class="form-control" id="commentContent" style="resize: none; height: 15px;" readonly="readonly" placeholder="로그인 후 댓글 작성 가능"></textarea>
			</div>
				<a class="btn btn-danger col-1" href=""  data-bs-toggle="modal" data-bs-target="#exampleModal">로그인</a>
		</div>
	</c:if><br>

	<%-- 댓글 목록 --%>
	<div id="commentList"></div>
	
</div><!-- .comment_container End. -->
	
<!-- FOOTER -->
<c:import url="/WEB-INF/views/layout/footer.jsp" />

<!-- 게시글 삭제Modal -->
<div class="modal fade" id="deleteOBoardModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="deleteOBoardModalLabel" aria-hidden="true" style="margin-top: 500px;display: none;">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>  
      <div class="modal-body">
        <p>게시글을 삭제하시겠습니까?</p>
      </div>
      <div class="modal-footer">  
        <a href="/community/delete?boardNo=${board.boardNo }&menu=${param.menu }&cate=${param.cate }"><button class="btn">예</button></a>
        <button class="btn" data-bs-dismiss="modal">아니오</button>
      </div>
    </div>
  </div>
</div>
