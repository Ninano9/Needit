<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:import url="../layout/header.jsp" />
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

<style>
.msgContainer { width: 1200px; }
.msgMain {
	height: 900px;
	width: 1200px;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
	border-left: 1px solid #ccc;
}

#pageTitle {
    height: 100px;
    vertical-align: middle;
    color: #ff533f;
    font-size: 2.5em;
    text-align: center;
    line-height: 100px;
    font-weight: bold;
    border-radius: 20px 20px 0px 0px;
    border-top: 3px solid #ff533f;
    border-left: 3px solid #ff533f;
    border-right: 3px solid #ff533f;
    border-bottom: 1px solid #ccc;
}

.msgMain ::after {
	content:'';
	display:block;
	clear:both;
}

.msgList {
	float: left;
	width: 35%;
	height: 900px;
	padding-bottom: 10px;
	border-right: 1px solid #ccc;
	overflow-y: auto;
	overflow-x: hidden;
}

.msgWrap {
	float: left;
    width: 65%;
}

.msgProfile {
	width: 100%;
	height: 150px;
	background: #ff533f;
}

.msgContent {
	width: 100%;
	height: 750px; 
	overflow: hidden;
	justify-content: space-between;
}

.messages-container {
	width: 100%;
	height: 600px;
	overflow-x: hidden;
    overflow-y: scroll;
}

/* Webkit 브라우저를 위한 스타일 */
.messages-container::-webkit-scrollbar { width: 12px; }
.messages-container::-webkit-scrollbar-track { background: #f1f1f1; border-radius: 10px; }
.messages-container::-webkit-scrollbar-thumb { background-color: transparent; border-radius: 10px;background: #ff533f; }

.msgInput {
	width: 100%;
	height: 150px;
	border-top: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}

.msgInput input {
	width: 80%;
    height: 125px;
    margin: 10px;
    padding: 10px;
    border-radius: 5px;
    border: 2px solid #ccc;
    vertical-align: middle;
}

.msgInput button {
	margin: 0 15px;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    background-color: #ff533f;
    color: white;
    font-weight: bold;
}

.msgSendContent {
	align-self: flex-end;
	background-color: #ff533f;
	color: white;
	margin: 5px 0;
	padding: 10px;
	border-radius: 10px;
	max-width: 80%;
}

.msgReceiverContent {
	align-self: flex-start;
	background-color: #f1f1f1;
	margin: 5px 0;
	padding: 10px;
	border-radius: 10px;
	max-width: 80%;
}

.message-send-wrapper {
	align-self: flex-end;
	display: flex;
}

.message-receiver-wrapper {
	align-self: flex-start;
	display: flex;
}

.send-time {
	margin-left: auto;
	padding-right: 10px; /* Adjust as needed */
	font-size: 11px;
	margin-top: 33px;
}

.receive-time {
	margin-right: auto;
	padding-left: 10px; /* Adjust as needed */
	font-size: 11px;
	margin-top: 33px;
}

.msgFilter {
	display: flex;
	justify-content: space-between;
	padding: 10px;
	border-bottom: 1px solid #ccc;
}

.msgMain .hidden { display: none; }

.msgObject:hover { background-color: #f38d8d; }

.msgPrompt {
	float: left;
	width: 65%;
	height: 900px;
	text-align: center;
	font-size: 40px;
	line-height: 850px
}

.msgObject-img {
	float: left;
	width: 75px;
	height: 75px;
	border-radius: 50%;
	margin-right: 10px;
}

.msgObject-content { /* 안씀 */
	flex-direction: column; /* 내용을 세로로 쌓음 */
	justify-content: center; /* 세로 방향 중앙 정렬 */
	align-items: flex-start; /* 가로 방향 시작 부분 정렬 */
}

.msgObject-username { font-weight: bold; }

.messagePreview {
	float: left;
	width: 275px;
 	color: #555;
}

.lastMessageTime {
	float: left;
	margin-left: 10px;
	color: #aaa;
}

.msgObject { /* 안쓸듯 */
	align-items: center; /* 세로 중앙 정렬 */
	padding: 10px; /* 패딩 설정 */
}

.msgObject-username, .messagePreview {
	float: left;
	width: 275px;
	white-space: nowrap; /* 텍스트가 넘칠 경우 줄바꿈 없이 처리 */
}

.profileImg {
    position: relative;
    top: 6px;
    left: 10px;
    width: 135px;
    height: 135px;
	background: white;
}

.profileImg img {
    width: 135px;
    height: 135px;
}

.profileDesc {
    position: relative;
    right: 20px;
    margin: -120px 0px 0px 180px;
    width: 630px;
    height: 100px;
}

.profileTitle {
    height: 75px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space:nowrap;
    font-size: 2.5em;
    color: white;
}

.profilePrice {
    position: relative;
    bottom: -15px;
    font-size: 1.3em;
    color: wheat;
}

.redDot {
    float: left;
    width: 15px;
    height: 15px;
}

.redDot-unread {
    float: left;
    width: 15px;
    height: 15px;
    border-radius: 50%;
    background: #ff533f;
    animation: sparkle 1s infinite alternate;
}

@keyframes sparkle {
	from { opacity: 1; }
	to { opacity: 0.7; }
}


</style>
<script >
var roomNo;
var socket;
var currentUserId;
var receiverId;
var userId;
var lastSentRoomNo;
var stompClient = null; 
var currentUserIdSubscription;
var receiverIdSubscription;
var newRoom
var makingRoom = false;
var newChatMsg;
var sendNewFlag = 0;

// $(document).ready(function() {
$(function() {
	
	$('.msgInput form').on('submit', function(event) { // 메시지를 보낼 때
		event.preventDefault(); // 기본 submit 동작 방지
		var message = $(this).find('input[name="message"]').val(); // 입력 필드의 값을 가져옴
	     
		if(makingRoom == false){ // 방이 존재한다면 
			sendMessage() // 메시지 보내기 
			
		} else if(makingRoom ==true){ // 방이 존재안하면
			console.log("makingNewRoom start")
			
			receiverId = newRoom.newReceiverId;
			subscribeToReceiverId(receiverId) // 받는 사람 한테 구독 하는 함수
			console.log('receiverId = ' + receiverId)
			
			var newChatMsg = {	// 새로 생성된 채팅방의 첫 메시지
				writerId: currentUserId,	// 작성자 : 현재 접속 유저
				content: message,	// 메시지
				receiverId: receiverId,	// 받는 사람 
				boardNo: newRoom.newBoardNo,	// 새로운 방의 방 번호
				menu: newRoom.newMenu,	// 새로운 방의 메뉴
				cate: newRoom.newCate,	// 새로운 방의 카테고리
				msgStatus: 3	// 3 : 새로운 방에서 작성한 메시지
			} // var newChatMsg 끝
			console.log('newChatMsg = ' + newChatMsg)
			     	
			if(stompId && newChatMsg && makingRoom){
				stompId.send("/pub/chat/" + receiverId + "/sendStatus",{},JSON.stringify(newChatMsg))
			}
			
			$.post( "/alert/sendnotification", { 
	        	id: receiverId
	        	, sender: currentUserId
	        	, content: 5
	        	, menu: 6
	        }); // $.post 끝
			
		} // if-else 문 끝
	
	$(this).find('input[name="message"]').val(''); // input 필드를 지움
	$('.msgInput input').attr('placeholder', '메시지를 입력해 주세요.'); // 지워진 input 필드에 placeholder 추가
	return;
	// 여기에 메시지 전송 로직을 추가할 수 있습니다.
	}); // 메세지 전송 이벤트 끝
	 
 	currentUserId = '<c:out value="${sessionScope.id}"/>'; // JSP EL to get current user ID
	console.log('현재 접속 아이디 = ' + currentUserId)
	
	$('.msgObjects').on('click', '.msgObject', function() {	
		roomNo = $(this).attr('room_no');
		lastSentRoomNo = $(this).attr('room_no');
		
		// Hide the prompt and show the message content
		$('.msgPrompt').addClass('hidden');
		$('.msgContent, .msgProfile, .msgWrap').removeClass('hidden'); 
		$(this).css('background-color','white');
		$(this).find('.redDot').removeClass('redDot-unread');
		console.log( "지금여기 클릭한거 맞아? ", this );

		// AJAX call to get messages
		$.ajax({
			url: './msgload',
			type: 'GET',
			data: { RoomNo: roomNo, currentUserId: currentUserId }
		, success: function(res){
			$('.messages-container').empty(); // 이전 채팅방 메시지들 비우기
			$(".msgProfile").empty();
			console.log('지금여기로오고있나용??ㅇㅇㅇㅇㅇ')
			
			var messages = res.messages;
			var boardInfo = res.boardInfo;
			var thumbnail = res.thumbnail;
			
			
			var number = Number(boardInfo.price); // 가격 저장 변수
			var formattedNumber = number.toLocaleString(); // 가격 format 변수
			if( formattedNumber == '-1'){
				formattedNumber = '고객지'
			}
			var price = formattedNumber + "원";
			console.log( formattedNumber )
			
			var thumbnailName
			var thumbnailTitle
			
			thumbnail.forEach(function(thumbnail) {
				console.log( thumbnail.THUMBNAIL_NAME )
				thumbnailName = thumbnail.THUMBNAIL_NAME
				return thumbnailName;
			});
			
			thumbnail.forEach(function(thumbnail) {
				console.log( thumbnail.TITLE )
				thumbnailTitle = thumbnail.TITLE
				return thumbnailTitle;
			});
			
			console.log( thumbnailName )
			
			var $body = $('<div class="profileBody">') // .img와 .desc를 감싸는 DIV
			var $img = $('<div class="profileImg">')
			
			var $imgContent;
			
			if( thumbnailName != null ) {
				$imgContent = $('<img  alt="' + thumbnailTitle + '" src="/upload/' + thumbnailName + '">');////
			} else {
				$imgContent = $('<img alt="사진이 없습니다" src="/resources/img/noimg.png">')
			}
			
			if( formattedNumber == '고객지' ) {
				$imgContent = $('<img alt="고객센터" src="/resources/img/gogakcenter.png">')
			}
			
			var $board = res.boardInfo			
			
			if( $board.menu == 1 ){
				var link = '<a href="/rent/view?boardNo=' + $board.boardNo + '&menu=' + $board.menu + '&cate=' + $board.cate + '" style="color: white;">' + $board.title + '</a>';
			} else if( $board.menu == 2 ) {
				var link = '<a href="/share/view?boardNo=' + $board.boardNo + '&menu=' + $board.menu + '&cate=' + $board.cate + '" style="color: white;">' + $board.title + '</a>';
			} else if( $board.menu == 3 ) {
				var link = '<a href="/please/view?boardNo=' + $board.boardNo + '&menu=' + $board.menu + '&cate=' + $board.cate + '" style="color: white;">' + $board.title + '</a>';
			} else if( $board.menu == 5 ) {
				var link = '<a href="/business/view?boardNo=' + $board.boardNo + '&menu=' + $board.menu + '&cate=' + $board.cate + '" style="color: white;">' + $board.title + '</a>';
			} else {
				var link = '<a href="/business/view?boardNo=' + $board.boardNo + '&menu=0&cate=0 style="color: white;">' + $board.title + '</a>';
			}
			
			var $desc = $('<div class="profileDesc">'); // 글제목, 가격, 링크 들어가는 부분을 감싸는 DIV 
			var $title = $('<div class="profileTitle">').html(link); // 글 제목이 들어갈 부분 ////
			var $price = $('<div class="profilePrice">').text(price); // 가격이 들어갈 부분 ////
			
			$('.msgProfile').append($body);
			$body.append($img).append($desc)
			$img.append($imgContent)
			$desc.append($title).append($price)
			
			messages.forEach(function(message) { // 페이지에 메시지 반복 추가
				var msgElement, wrapperElement, timeElement;
				console.log('받는 사람 : ' + message.receiverId)
				
				if(currentUserId === message.writerId){ // 현재 접속 아이디와 보낸 사람이 같을 때
					receiverId = message.receiverId // 받은 메시지의 받는사람 = 상대
				} else{ // 현재 접속 아이디와 보낸 사람이 다를 때
					receiverId = message.writerId // 받은 메시지의 받은 사람 = 작성자 본인
				}
				
				var timestamp = message.postDate;	// TIMESTAMP 타입의 postDate 삽입
				var date = new Date(timestamp);	// JS의 Date 타입으로 형변환	
				
				var dateFormatter = new Intl.DateTimeFormat('ko-KR', {
					year: 'numeric'
					, month: '2-digit'
					, day: '2-digit'
					, hour: '2-digit'
					, minute: '2-digit'
					, hour12: false
				}); // 날짜 포맷 
				
				var formattedDate = dateFormatter.format(date); // 포맷된 시간
				console.log('포맷된 시간 : ' + formattedDate)
	
				timeElement = $('<div>').text(formattedDate); // 시간 요소 생성
				
				if(message.receiverId === currentUserId) { // 받는 메시지가 본인일 때 
					// 받는 메시지
					msgElement = $('<div>').addClass('msgReceiverContent').text(message.content);
					wrapperElement = $('<div>').addClass('message-receiver-wrapper');
					wrapperElement.append(msgElement).append(timeElement.addClass('receive-time'));
				} else {
					// 보낸 메시지
					msgElement = $('<div>').addClass('msgSendContent').text(message.content);
					wrapperElement = $('<div>').addClass('message-send-wrapper');
					wrapperElement.append(timeElement.addClass('send-time')).append(msgElement);
				}
				
				// Append the wrapper element to the correct container
				$('.messages-container').append(wrapperElement);
				
				scrollToBottom()
				
			}); // messages.forEach(function(message) 끝      
			console.log('받는 아이디 =' + receiverId)
			subscribeToReceiverId(receiverId) // 받는 사람에게 구독
			}, error: function(error){ console.log("AJAX request failed"); }
		}); // ajax 끝
				console.log('여기옴4444444444444444444444??');
		
		connectToRoom(roomNo); // 방 연결 함수
		var userId = '<c:out value="${sessionScope.id}"/>' // 현재 접속 세션 아이디
   
	    // 부모 요소의 모든 자식 요소의 배경 색상 제거
	    $('.msgObject').css('background-color', '');
	    // 클릭된 자식 요소에만 배경 색상 적용
	    $(this).css('background-color', '#ff533f52');
		
	}); // $('.msgObjects').on('click') 펑션 끝
	
	currentUserId = '<c:out value="${sessionScope.id}"/>';
	console.log('현재 유저 아이디' + currentUserId)

	connectWebSocket() // 자기 자신에게 웹소켓 연결
	console.log("현재 아이디로 구독 완료")
    var newMaking = '<c:out value="${newMaking}" escapeXml="false"/>'; // newMaking(모델값)을 변수에 대입

    if(newMaking) { // newMaking이 null이 아니라면 -> 새로운 방을 만든 상태라면
        newRoom = JSON.parse(newMaking); // newMaking 파싱
        console.log( "newRoom은 ?", newRoom )
        console.log(newRoom.newMenu);
        console.log(newRoom.newCate);
        console.log(newRoom.newBoardNo);
        console.log(newRoom.newReceiverId);
        
        makingRoom = true; // 새로운 방을 만든 상태를 알려주는 플래그
        $('.msgInput input').attr('placeholder', '메시지를 입력하면 새로운 채팅이 시작됩니다.'); // 새로 생성한 채팅방의 인풋에 들어가는 placeholder
        $('.msgPrompt').addClass('hidden'); // msgPrompt 숨김
        $('.msgContent, .msgProfile, .msgWrap').removeClass('hidden'); // 숨겨놓은 msgContent, msgProfile 활성화
       
        var $boardNo = newRoom.newBoardNo;
        console.log( "$boardNo = ", $boardNo )
        console.log(typeof $boardNo);
        
        console.log('ajax 실행 시작')
        $.ajax({
           type: "GET"
           , url: "./info"
           , data: { boardNo : $boardNo }
           , success: function( res ){
				console.log("AJAX 성공")
				console.log(res)
				var $info = res.info
				
				var number = Number( $info.PRICE ); // 가격 저장 변수
				var formattedNumber = number.toLocaleString(); // 가격 format 변수
				if( formattedNumber == '-1'){
					formattedNumber = '고객지'
				}
				var price = formattedNumber + "원";
				console.log( formattedNumber )
				
				var $thumbnailTitle = $info.TITLE
				var $thumbnailName = $info.THUMBNAIL_NAME
				              
				var $body = $('<div class="profileBody">') // .img와 .desc를 감싸는 DIV
				var $img = $('<div class="profileImg">')
				
				var $imgContent;
				
				if( $thumbnailName != null ) {
					$imgContent = $('<img  alt="' + $thumbnailTitle + '" src="/upload/' + $thumbnailName + '">');
				} else {
					$imgContent = $('<img alt="사진이 없습니다" src="/resources/img/noimg.png">')
				}
				
				if( formattedNumber == '고객지' ) {
					$imgContent = $('<img alt="고객센터" src="/resources/img/gogakcenter.png">')
				}
				
				console.log( $imgContent )
				
				var $desc = $('<div class="profileDesc">'); // 글제목, 가격, 링크 들어가는 부분을 감싸는 DIV 
				var $title = $('<div class="profileTitle">').text($info.TITLE); // 글 제목이 들어갈 부분
				var $price = $('<div class="profilePrice">').text(price); // 가격이 들어갈 부분
				
				$('.msgProfile').append($body);
				$body.append($img).append($desc)
				$img.append($imgContent)
				$desc.append($title).append($price)
			
           }
           , error: function(){
              console.log("AJAX 실패")
           }
        })
        console.log('ajax 실행 끝')
        
    }

    var targetRoomNo = '<c:out value="${targetRoomNo}" escapeXml="false"/>'
    if(targetRoomNo){ // 이미 생성된 방일 경우
	    console.log( '이미 생성된 방의 번호 = ' + targetRoomNo )
    	 $(".msgObject[room_no='" + targetRoomNo + "']").click(); // 해당 방 번호를 클릭해 방에 입장
    }	 
}); //ready 함수 끝

function connectWebSocket() { // 웹소켓 연결 시작 함수
	console.log('connectWebSocket 함수 시작')
	
    var socketId = new SockJS('/ws');
    stompId = Stomp.over(socketId);
    stompId.connect({}, function() {
        console.log("WebSocket connected");
        subscribeToCurrentUserId();   // 최초 접속 시, currentUserId로 구독
    }, onErrorId);
} // connectWebSocket() 끝

function scrollToBottom() { // 채팅방 스크롤 내려주는 함수
    var messagesContainer = $('.messages-container');
    messagesContainer.scrollTop(messagesContainer.prop("scrollHeight"));
} // scrollToBottom() 끝
  
function connectToRoom(roomNumber) { // 채팅방 접속 함수
	console.log('connectToRoom 함수 실행')
	console.log('connectToRoom의 파라미터 = ' + roomNumber )
	
    disconnectWebSocket(); // 기존 연결 해제
    roomNo = roomNumber; // 방번호
    
    socket = new SockJS('/ws'); // 웹소켓 객체 생성
    stompClient = Stomp.over(socket); // stomp 객체 생성

    stompClient.connect({}, function(frame) {
        console.log('frame : ' + frame);
        stompClient.subscribe('/sub/' + roomNo + '/public', onMessageReceived); // 구독

        if(makingRoom && currentUserId == newChatMsg.writerId){ // 방이 존재하고 현재 접속한 유저가 작성자 일 때
            // 여기서 메시지 전송 로직을 수행
            sendNewFlag = 1;
    		stompClient.send("/pub/chat/" + roomNo + "/sendMessage",{},JSON.stringify(newChatMsg))
    		
    		makingRoom=false; // 방 생성이 이미 완료 됐으니 false
    		sendNewFlag = 0;
    		lastSentRoomNo = roomNo; // 마지막으로 메시지를 보낸 방 번호
        }// if(makingRoom &&currentUserId == newChatMsg.writerId) 끝
        
        // 사용자 추가 메시지 보내기
        // .send( destination, headers = {}, body = '' )
        // body는 JSON으로 헤더없이 보내기
        stompClient.send( "/pub/chat.addUser", {}
        , JSON.stringify({ 'currentUserId' : currentUserId // 현재 접속 유저
				        	, 'userId' : currentUserId // 현재 접속 유저(ID)
				        	, 'roomNo': roomNo })); // 방 번호
    }, onError); // stompClient.connect({}, function(frame) 끝 
} // connectToRoom(roomNumber) 끝

function onError(){ console.log("에러뜸!") }

function sendMessage(event){ // 메시지 전송 함수
	console.log("sendMessage 함수 시작")
	lastSentRoomNo = roomNo;  // 마지막으로 보낸 방 번호
	
	var messageContent = $('.msgInput form').find('input[name="message"]').val() // 메세지 입력 창 value
	
	if( messageContent && stompClient ){ // 보내는 메세지가 존재하고, 통신이 연결되어 있을 때
		console.log("데이터 전송 시작")
		
		var chatMessage = { // 메시지 Object로 보낸다
			roomNo: roomNo,
			writerId: currentUserId,
			content: messageContent
		}
	
		console.log( '현재 메세지를 받는사람은 누구일까요?!!?!!', receiverId)
		
		stompClient.send("/pub/chat/" + roomNo + "/sendMessage",{},JSON.stringify(chatMessage)) // object Json으로 파싱
		
		console.log( '알림 sender 누구?', currentUserId)
		
		$.post( "/alert/sendnotification", { 
        	id: receiverId
        	, sender: currentUserId
        	, content: 5
        	, menu: 6
        }); // $.post 끝
		
	}
} // sendMessage(event) 끝

function onMessageReceived(payload) { // 메시지 수신 함수
    console.log("onMessageReceived 함수 시작")
    console.log("onMessageReceived 페이로드 = " + payload)
    
    var newMessage = JSON.parse(payload.body);
    console.log(newMessage)
    
    var msgElement, wrapperElement, timeElement; // 지역변수 생성
    var timestamp1 = newMessage.postDate; // TIMESTAMP 타입 메세지의 전송 시간
    
    var date1 = new Date(timestamp1); // Date타입으로 형변환
    var dateFormatter1 = new Intl.DateTimeFormat('ko-KR', { // 시간 지역 설정
        year: 'numeric' // 연도를 숫자로 표시
        , month: '2-digit' // 월을 두 자리 숫자로 표시
        , day: '2-digit' // 일을 두 자리 숫자로 표시
        , hour: '2-digit' // 시간을 두 자리 숫자로 표시
        , minute: '2-digit' // 분을 두 자리 숫자로 표시
        , hour12: false // 시간을 24시간 형식으로 표시
    });
    
    var formattedDate1 = dateFormatter1.format(date1); // 설정해놓은 포맷 방식에 따라 변환
    console.log('formattedDate1 = ' + formattedDate1)
    
    timeElement = $('<div>').text(formattedDate1);
    
    if(newMessage.receiverId === currentUserId) { // 새로운 메세지의 수신자 == 현재 유저 일 때 
    	// => 본인이 보낸 메시지를 보고 있을 때 
        // 받은 메시지
        msgElement = $('<div>').addClass('msgReceiverContent').text(newMessage.content); 
        wrapperElement = $('<div>').addClass('message-receiver-wrapper');
        wrapperElement.append(msgElement).append(timeElement.addClass('receive-time'));
        
    } else {
        // 보낸 메시지
        msgElement = $('<div>').addClass('msgSendContent').text(newMessage.content);
        wrapperElement = $('<div>').addClass('message-send-wrapper');
        wrapperElement.append(timeElement.addClass('send-time')).append(msgElement);
    } // if(newMessage.receiverId === currentUserId) 끝

    // Append the wrapper element to the correct container
    $('.messages-container').append(wrapperElement);
      scrollToBottom()
      
	if(stompId && newMessage && sendNewFlag == 0){
		stompId.send("/pub/chat/" + receiverId + "/sendStatus",{},JSON.stringify(newMessage))
	}
} // onMessageReceived(payload) 끝


function disconnectWebSocket() { // 웹소켓 연결 해제 함수
    if (stompClient !== null) { stompClient.disconnect(); } // 연결이 되어있을 때 연결 해제
    console.log("Disconnected");
} // disconnectWebSocket() 끝


function subscribeToCurrentUserId() { // 현재 접속 유저 구독 함수
	console.log('subscribeToCurrentUserId 시작')
    if (stompId && !currentUserIdSubscription) { // 최초 접속 구독과 현재 접속 구독을 안했다면
        currentUserIdSubscription = stompId.subscribe('/sub/' + currentUserId + '/public/g', onReceivedId);
    }
} // subscribeToCurrentUserId() 끝

function subscribeToReceiverId() { // 받는 사람 한테 구독 하는 함수
	console.log('subscribeToReceiverId 시작')
    // 기존 receiverId 구독이 있다면 해제
    if (receiverIdSubscription) {
        receiverIdSubscription.unsubscribe();
    }
    receiverIdSubscription = stompId.subscribe('/sub/' + receiverId + '/public/g', onReceivedId);
} // subscribeToReceiverId() 끝

function onErrorId(){ console.log("에러에용") }

function onReceivedId(payload){
	console.log("onReceivedId 함수 시작")
	newChatMsg = JSON.parse(payload.body);
	var testMsg = JSON.parse(payload.body)
	console.log("testMsg = ", testMsg)
	if(testMsg.msgStatus === 3){
		if(testMsg.writerId == currentUserId){
		roomNo = testMsg.roomNo;
		console.log("새로운 채팅방으로 구독 시작")
		connectToRoom(roomNo);
		lastSentRoomNo = roomNo;
		}
		var messagePreview = testMsg.content.length > 10 ? testMsg.content.substring(0, 10) + '...' : testMsg.content;
		var date = new Date(testMsg.postDate);
	    var dateFormatter = new Intl.DateTimeFormat('ko-KR', { 
	        hour: '2-digit', minute: '2-digit', hour12: false
	    });
	    roomNo = testMsg.roomNo;
	    
	    if(currentUserId === testMsg.writerId){
	    	var ID = testMsg.receiverId
	    }else{
	    	var ID = testMsg.writerId
	    }
	    
	    var $boardNo = testMsg.boardNo;
	    var formattedDate = dateFormatter.format(date);

	    $.ajax({
		    type: "GET"
		    , url: "./getNick"
		    , data: { id : ID }
		    , success: function( res ){
				console.log("AJAX 성공")
				console.log("res : ", res)
				var $newInfo = res.newInfo;
				var $nick = $newInfo.NICK;  
				var $thumbnailName = $newInfo.THUMBNAIL_NAME
				
				console.log("ajax안", ID )
				console.log("ajax안", messagePreview )
				console.log("ajax안", formattedDate )
				
				var $body = $('<div class="profileBody">') // .img와 .desc를 감싸는 DIV
				var $img = $('<div class="profileImg">')
				
				var $src;
				var $alt;
				
				$alt = $nick
				if( $thumbnailName != null ) {
					$src = '/upload/' + $thumbnailName
				} else {
					$src = '/resources/img/defaultProfile.png';
				}
				
				if( $nick == '관리자' ) {
					$src = '/resources/img/gogakcenter.png';
					$alt = '고객센터'
				}
				
			    var chatRoomDiv = $('<div>')
		        .addClass('msgObject')
		        .attr('room_no',  testMsg.roomNo.toString())
		        .append(
		            $('<img>').attr({
		                'src': $src,
		                'alt': $alt
		            }).addClass('msgObject-img'),
		            $('<div>').addClass('msgObject-content')
		                .append(
		                    $('<div>').addClass('msgObject-username').text($nick),
		                    $('<div>').addClass('messagePreview').text(messagePreview),
		                    $('<div>').addClass('lastMessageTime').text(formattedDate)
		                )
		        );
			    $('.msgObjects').prepend(chatRoomDiv);
		    }
		    , error: function(){
		       console.log("AJAX 실패")
		    }
		 })
		 
	    if(currentUserId == testMsg.receiverId){
// 	    	chatRoomDiv.css('background-color', '#F3F781');
	        chatRoomDiv.find('.redDot').addClass('redDot-unread');

	    }
	    
	    return;
	}
	console.log(testMsg)
    var chatRoomDiv = $('.msgObject[room_no="' + testMsg.roomNo + '"]');
    var updatedContent = testMsg.content;

    if(updatedContent.length > 10) {
        updatedContent = updatedContent.substring(0, 10) + '...';
    }

    // 업데이트된 내용으로 각 요소의 텍스트를 설정합니다.
    chatRoomDiv.find('.messagePreview').text(updatedContent);

    // 날짜 포매팅 로직
    var timestamp = testMsg.postDate;
    var date = new Date(timestamp);
    var dateFormatter = new Intl.DateTimeFormat('ko-KR', { 
        hour: '2-digit', minute: '2-digit', hour12: false
    });
    var formattedDate = dateFormatter.format(date);
    chatRoomDiv.find('.lastMessageTime').text(formattedDate);

    // 채팅방 위치 이동
    $('.msgObjects').prepend(chatRoomDiv);

    // 배경색 변경
    if(testMsg.roomNo != lastSentRoomNo) {
//         chatRoomDiv.css('background-color', '#F3F781');
        chatRoomDiv.find('.redDot').addClass('redDot-unread');
    }
} // onReceivedId(payload) 끝

function formatDate(timestamp) {
	console.log('formatDate 함수 시작')
    // Create a new Date object from the timestamp
    var date = new Date(timestamp * 1000); // The timestamp is in seconds, Date() requires milliseconds
    // Format the date and time
    return date.toLocaleString('ko-KR'); // This will use the Korean locale
} // formatDate(timestamp) 끝 

</script>

<div class="msgContainer">
	<div id="pageTitle" style="text-align: center;">${nick }님의 채팅</h3>
	</div><!-- .pageTitle -->
	<div class="msgMain">
		<div class="msgList">
			<div class="msgObjects">
				<c:forEach var="list" items="${list}">
					<div class="msgObject" room_no="${list.roomNo}">
						<c:choose>
							<c:when test="${not empty list.otherUserThumbnail}">
								<img src="/upload/${list.otherUserThumbnail}" alt="${list.otherUserNick}" class="msgObject-img">
							</c:when>
							<c:otherwise>
								<img src="/resources/img/defaultProfile.png" alt="기본 이미지" class="msgObject-img">
							</c:otherwise>
						</c:choose>
						<div class="msgObject-content">
							<c:choose>
							<c:when test="${list.otherUserNick eq '관리자닉'}">
								<div class="msgObject-username">관리자 1:1 문의</div>
							</c:when>
							<c:otherwise>
								<div class="msgObject-username">${list.otherUserNick}</div>
							</c:otherwise>
							</c:choose>
							<div class="messagePreview">
								<c:choose>
								<c:when test="${fn:length(list.messagePreview) > 10}">
								${fn:substring(list.messagePreview, 0, 10)}...
								</c:when>
								<c:otherwise>
								${list.messagePreview}
								</c:otherwise>
								</c:choose>
							</div><!-- ."messagePreview" -->
							<div class="redDot ${list.msgStatus == 1 ? 'redDot-unread' : ''}"></div>
							<div class="lastMessageTime">${list.lastMessageTime}</div>
						</div><!-- .msgObject-content  -->
					</div><!-- .msgObject -->
				</c:forEach>
			</div><!-- .msgObjects -->
		</div><!-- .msgList  -->
		
		<div class="msgPrompt" >
		<sapn>메시지 리스트를 선택해주세요.</sapn>
		</div><!-- .msgPrompt -->
		<div class="msgWrap hidden">
			<div class="msgProfile hidden"></div>
			<div class="msgContent hidden">
				<div class="messages-container"></div>
				<!-- 보내는 사람 메시지 -->
				<div class="msgInput">
					<form method="post"> <!-- 나중에 action 속성 추가 예정 -->
						<input type="text" placeholder="메세지를 입력해주세요" name="message"  autocomplete="off">
						<button type="submit" style="padding: 10px 20px; border-radius: 5px; border: none; background-color: #ff533f; color: white;">보내기</button>
					</form>
				</div><!-- .msgInput -->
			</div><!-- .msgContent-hidden -->
		</div><!-- .msgWrap -->
		<div style="clear: both;"></div>
	</div><!-- .msgMain  -->
</div><!-- .msgContainer -->
<div style="clear: both;"></div>


<c:import url="../layout/footer.jsp" />