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

.viewWrap {
	width: 1200px;
	text-align: center;
	font-weight: normal;
	font-size: medium;
}
#submitCmt {
	margin: 3px 3px 3px 3px;
    width: 95%;
    font-size: 13px;
    border-radius: 5px;
    border: none;
} 
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
#map {
	width: 397px;
    height: 238px;
}

#del {
	border: none;
	border-radius: 10px;
}
#cmtReportBtn {
	border: none;
    background-color: inherit;
    font-size: 13px;
    float: right;
    margin-top: 15px;
    color: red;
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

button:hover { scale: 1.1;}
#upAndDel {
    float: right;
    margin-right: 151px;
    margin-bottom: 13px;
}
#upAndDel button {     
	color: white;
    border: none;
    width: 50px;
    border-radius: 5px;
    background: #ff533f;
    font-weight: bold;
}

a:hover { text-decoration: none; }
#borderContainer {
	width: 900px;
    height: auto;
    margin: 0 auto;
    outline: 3px solid #ccc;
    border-radius: 10px;
    margin-top: 55px;
}
.viewHeader { width: 900px; }
.viewheader > div { float: left;}
.thumb {
	width: 500px; /* 원하는 너비로 설정 */
	height: 500px; /* 원하는 높이로 설정 */
	overflow: hidden; /* 내용이 넘칠 경우 숨김 처리 */
	
}

.thumb {
 	display: flex;
    justify-content: center;
    align-items: center;
    background-size: contain;
    background-repeat: no-repeat;
    background-position: center center;
}
#thumbImg img {
    width: 100%; /* 부모 요소의 100% 너비로 이미지 크기 조절 */
    height: auto; /* 가로 비율에 맞게 높이 자동 조절 */
    background-size: cover;
   
}
.viewInfo { width: 400px; height: 500px; }
.viewInfo > div { border: 1px solid #ccc; font-weight: bold;  }
.infoMenu { height: 50px; text-align: center; color:#ff533f; font-size: 2em }
.infoTitle { height: 150px }
.infoTitle > div { margin-left: 40px; }
#infoTitle { 
	width: 300px; 
	height: 40px; 
	margin-top: 20px; 
	text-align: left; 
	font-size: 1.5em;
	overflow: hidden;  		
	text-overflow: ellipsis;  
	white-space: nowrap; 		
	word-break:break-all
}
.titleWrap { margin: 0 auto; text-align: left; }
.likeAndHit { float: left; width: 140px; margin-right: 20px}

#infoLike  div { padding: 0; margin-right: 15px; }
.bi-suit-heart-fill::before { font-size: 1.3em; margin-right: 15px; } /*  좋아요 하트  */
.bi-suit-heart::before { font-size: 1.3em; margin-right: 15px; } /*  좋아요 하트  */
#likeNo { font-size: 1.3em; color: black; font-weight: bold; }
.infoPrice { height: 60px; }
#infoPrice { width: 235px; margin: 10px 0px 10px 40px; text-align: left; float: left; }
#btnChat { height: 40px; margin: 10px 0px 10px 10px; text-align: center; float: left;}
#btnChat button { width: 100%; height: 100%; border: 1px solid #ff533f; background: white; color: #ff533f; font-weight: bold; border-radius: 10px 10px 10px 10px;}
#btnPrice { height: 40px; margin: 10px 0px 10px 10px; text-align: center; float: left;}
#btnPrice button { width: 100%; height: 100%; border: none; background: #ff533f; color: white; font-weight: bold; border-radius: 10px 10px 10px 10px;}
#btnList button { width: 60px; height: 40px; margin-top: 10px; border: none; background: #ff533f; color: white; font-weight: bold; border-radius: 10px 10px 10px 10px;}
.infoMap { height: 239px }
.viewFile { width: 900px; margin: 0 auto;border: 1px solid #ccc; border-radius: 0px 0px 10px 10px;}
.viewContent { width: 900px; min-height: 400px; margin: 0 auto; border: 1px solid #ccc;}
#viewContent { margin: 20px 50px;  text-align: left;}
#viewContent p img { max-width: 750px; }

.comment-nickname {
    cursor: pointer; /* 커서 모양 변경 */
}
.comment-nickname:hover {
    color: orange; /* 마우스 오버 시 텍스트 색상 변경 */
}

.card {
    width: 450px;
    margin-left: 110px;
    padding: 20px;
}

#download{
	float: left;
	margin-left: 8px;
	position: absolute;
}
#reportBoard {
	font-weight: bold;
    width: 87px;
    height: 30px;
    float: left;
    margin-left: 170px;
    background-color: rgb(255,83,63);
    color: white;
}
</style>

<%-- 추천, 댓글, 대여상태 --%>
<script type="text/javascript">

function cmtReport(cmtNo) {
    var reportOptions = document.getElementById('reportSelect_' + cmtNo);
    if (reportOptions.style.display === 'none') {
        reportOptions.style.display = 'block';
    } else {
        reportOptions.style.display = 'none';
    }
}

//클릭 이벤트 바인딩을 loadComments 함수 밖으로 이동
$(document).on("click", ".comment-nickname", function () {
    // 현재 클릭된 댓글의 번호를 가져옴
    var cmtNo = $(this).closest('.media').find('.cmt-no').text();

    console.log("작동");
 	// 새 창에서 댓글 프로필 페이지로 이동
    window.open('/profile/yourProfileCmt?cmtNo=' + cmtNo, '_blank');
});

// 댓글목록 불러오기
function loadComments() {
	$.ajax({
	    type: "GET",
	    url: "/rent/comment/list",
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
		            commentListHtml += '  <span class="cmt-no" style="display: none;">' + res.commentList[i].CMT_NO + '</span>';
		            //프로필사진 유무 처리
		            if( res.commentList[i].THUMBNAIL_NAME != null || res.commentList[i].THUMBNAIL_NAME > 0 ){
		            commentListHtml += '  <img style="border: 0.5px solid #ccc; width: 70px; height: 70px;" class="d-flex mr-3 rounded-circle" src="/upload/' + encodeURIComponent(res.commentList[i].THUMBNAIL_NAME) + '">';
		            } else {
			            commentListHtml += '  <img style="border: 0.5px solid #ccc; width: 70px; height: 70px;" class="d-flex mr-3 rounded-circle" src="/resources/img/defaultProfile.png">';
		            }
		            commentListHtml += '  <div class="media-body" style="margin-bottom: -30px;">';
		            //댓글 작성자 구분 처리                                                                                    
		            if (commentWriter === boardMaster && commentWriter === nick) { 
		                commentListHtml += '    <h6 class="comment-nickname">' + res.commentList[i].WRITER_NICK + '<div class="cmtWriter" style="color: white; background-color: #52C728;">내댓글</div>' + '</h6>';
		            } else if (commentWriter === nick) {
		                commentListHtml += '    <h6 class="comment-nickname">' + res.commentList[i].WRITER_NICK + '<div class="cmtWriter" style="color: white; background-color: #52C728;">내댓글</div>' + '</h6>';
		            } else if (commentWriter === boardMaster) {
		                commentListHtml += '    <h6 class="comment-nickname">' + res.commentList[i].WRITER_NICK + '<div class="cmtWriter">작성자</div>' + '</h6>';
		            } else {
		                commentListHtml += '    <h6 class="comment-nickname">' + res.commentList[i].WRITER_NICK + '</h6>';
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
		            commentListHtml += '댓글신고';
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
	     	, url: "/rent/comment/delete"
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
         	, url: "/rent/comment"
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
		
		console.log("글작성자", writer)
		console.log("댓글작성자", sender)
		console.log( writer != sender)
		
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
			, url: "/rent/like"
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

<%-- Kakao Map API --%>
<script type="text/javascript">
$(()=>{
	
	// 지도 객체 설정
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };
	
	// 지도 객체 생성
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
	var zoomControl = new kakao.maps.ZoomControl();
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
	
	//주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	var location = '${board.location}';
	console.log("게시글 위치", location);
	
	//주소로 좌표를 검색합니다
	geocoder.addressSearch( location, function(result, status) {
	
	 // 정상적으로 검색이 완료됐으면 
	  if (status === kakao.maps.services.Status.OK) {
	
	// 주소를 담을 변수
	     var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
	     var imageSrc = '/resources/img/marker.png', // 마커이미지의 주소입니다    
         imageSize = new kakao.maps.Size(45, 45), // 마커이미지의 크기입니다
         imageOption = {offset: new kakao.maps.Point(22, 40)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
        // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
		
	
	//이건 마커 따로 만들어둬서 돼서 핵심 XXXX
	     // 결과값으로 받은 위치를 마커로 표시합니다
	     var marker = new kakao.maps.Marker({
	         map: map,
	         position: coords,
	         image: markerImage
	     });
	
	//이건 인포윈도우로 따로 만들어둬서 돼서 핵심 XXXX
	     // 인포윈도우로 장소에 대한 설명을 표시합니다
	     var infowindow = new kakao.maps.InfoWindow({
	         content: '<div style="width:150px;text-align:center;padding:6px 0;">대여가능 위치<br><div style="font-size: 10px;">${board.location}<div></div>'
	     });
	     infowindow.open(map, marker);
	
	// map객체의 setCenter 메소드가 좌표로 이동 시켜주는 메소드 *** 
	     // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	     map.setCenter(coords);
	 } 
	});    	
}); //Kakao Map API End.
</script>

<%-- Body --%>
<div id="upAndDel">
	<c:if test="${id eq board.writerId }">
		<a href="/rent/update?boardNo=${board.boardNo }&menu=${param.menu }&cate=${param.cate }"><button>수정</button></a>
		<button data-bs-toggle="modal" data-bs-target="#deleteOBoardModal">삭제</button>
	</c:if>
</div>	

<!-- view페이지에서 신고버튼 -->
<c:if test="${not empty isLogin && isLogin}">
	<button type="button" id="reportBoard" class="btn" data-bs-toggle="modal" data-bs-target="#reportModal">
		<div style="width: 25px; height: 25px; margin: -13px -10px;">게시글신고</div>
	</button>	
</c:if>
<c:if test="${empty isLogin}">
</c:if>

<div class="container">
<div class="viewWrap">
<div id="borderContainer">
	
	<div class="viewHeader">
		<div style="clear: both;"></div>
		<div class="thumb">
		    <div id="thumbImg" >
		        <c:if test="${not empty fileTb and not empty fileTb[0]}">
		            <img src="/upload/${fileTb[0].thumbnailName}"/>
		        </c:if>
		        <c:if test="${empty fileTb[0]}">
		            <img src="/resources/img/noimg.png"/>
		        </c:if>
		    </div><!-- .thumbImg -->
		</div><!-- .thumb-->
		
		<div class="viewInfo">
			<div class="infoMenu" style="border-radius: 0px 10px 0px 0px">
				<c:if test="${board.menu eq 1 and board.cate eq 1}">
					<span id="infoMenu">대여해요 [물품]</span>
				</c:if>		
				<c:if test="${board.menu eq 1 and board.cate eq 2}">
					<span id="infoMenu">대여해요 [인력]</span>
				</c:if>
				<c:if test="${board.menu eq 1 and board.cate eq 3}">
					<span id="infoMenu">대여해요 [공간]</span>
				</c:if>
			</div><!-- .infoMenu -->
			
			<div class="infoTitle">
				<div class="titleWrap">
					<div id="infoTitle">${board.title }</div>
					<div style="margin-bottom: 5px"><a href="/profile/yourProfile?boardNo=${board.boardNo }">${board.writerNick }</a></div>
					<div>
						<p style="margin: 0; font-size: 0.8em; color: #ccc; ">
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
						</p>
					</div>
					<div class="likeAndHit" id="infoLike" style="float: left;"> <!-- 추천 -->
						<c:if test="${isLogin }">
						<div class="btn" id="btnLike"><span id="likeNo">${cntLike }</span></div>
						</c:if>		
						<c:if test="${not isLogin }">
						<a href=""  data-bs-toggle="modal" data-bs-target="#exampleModal" >
							<div class="bi bi-suit-heart" id="btnLike"><span id="likeNo">${cntLike }</span></div>
						</a>
						</c:if>		
					</div><!-- #infoLike --> 
					<div class="likeAndHit" id="infoHit" style="float: left;">
						<div id="iconHit"><span style="font-size: 1.3em;">👀 ${board.hit }</span></div>
					</div><!-- #infoHit -->
					<div style="clear: both;"></div>
				</div><!-- .titleWrap -->
			</div><!-- .infoTitle -->
			<div class="infoPrice">
				<div id="infoPrice">
					<span style="font-size: 1.4em;">💸<fmt:formatNumber value="${board.price }" pattern="#,###" />원 [30분]</span>
				</div>
				<div class="chat-container" id="btnChat">
					<c:if test="${isLogin && (id ne board.writerId)}">
						<a href="/message/list?boardNo=${param.boardNo }&menu=${board.menu}&cate=${board.cate}&receiverId=${board.writerId}"><button>채팅</button></a>
					</c:if>
					<c:if test="${id eq board.writerId}">
						<button id="rejectChat">채팅</button>
					</c:if>
					<c:if test="${not isLogin }">
						<a href=""  data-bs-toggle="modal" data-bs-target="#exampleModal"><button>채팅</button></a>
					</c:if>
				</div><!-- .chat-container End -->
				<div id="btnPrice">
					<c:if test="${isLogin and (id ne board.writerId) }">
						<button data-bs-toggle="modal" data-bs-target="#rentModal">대여</button>
					</c:if>
					<c:if test="${not isLogin }">
						<a href=""  data-bs-toggle="modal" data-bs-target="#exampleModal"><button>대여</button></a>
					</c:if>
					<c:if test="${id eq board.writerId }">
					<button id="selfRent">대여</button>
					</c:if>
				</div>
				<div><%-- Modal.대여 --%>
					<c:import url="./rent.jsp"/>
				</div>
			</div><!-- .infoPrice -->
			<div class="infoMap">
				<div id="map"></div>
			</div><!-- .infoMap -->
			<div class="infoBtn">
			</div><!-- .infoBtn -->
		</div><!-- .viewInfo -->
	
	</div><!-- .viewHeader -->
	<div style="clear: both;"></div>
	
	<div class="viewContent">
		<div id="viewContent">${board.content }</div>
	</div>

	<div class="viewFile">
		<div id="Download"> Downloads :</div>
		<p style="margin: 0">
			<c:if test="${not empty fileTb }">
			<c:forEach var="file" items="${fileTb }">
				<a class="file bi bi-paperclip" href="./download?fileNo=${file.fileNo }">${file.originName }</a><br>
			</c:forEach>
			</c:if>
			<c:if test="${empty fileTb }">
				<p>첨부된 파일이 없습니다.</p>
			</c:if>
		</p>
	</div>
	
	</div><!-- #borderContainer -->
	
	<div id="btnList">
		<a href="/rent/list?menu=${param.menu }&cate=${param.cate }"><button>목록</button></a>
	</div>
		
</div> <!-- .viewWrap -->
</div> <!-- .container -->

<hr>

<%-- 댓글 영역 --%>
<div class="comment-container">
	
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
	
</div><!-- .comment-container End. -->
	
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
        <a href="/rent/delete?boardNo=${board.boardNo }&menu=${param.menu }&cate=${param.cate }"><button class="btn">예</button></a>
        <button class="btn" data-bs-dismiss="modal">아니오</button>
      </div>
    </div>
  </div>
</div>
