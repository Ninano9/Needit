<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Needit</title>
<link rel="icon" href="/resources/img/favicon.ico">
<script type="text/javascript" src="http://code.jquery.com/jquery-3.7.1.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>

<script type="text/javascript">
$(document).ready(function() {
    // 쿠키에서 사용자 정보를 가져옴
    var userInfo = getCookie("userInfo");
    
    console.log(userInfo);
    // 만약 쿠키에 사용자 정보가 있다면 자동으로 로그인 처리
  	var isLogin = <%= session.getAttribute("isLogin") %>;

    // isLogin 변수를 사용하여 로그인 상태 확인
    if (!isLogin) {
    	var userInfo = getCookie("userInfo");
        if (userInfo) {
             var user = JSON.parse(userInfo);
             performLogin(user.userId, user.userPw);
    	} 
    }

	// 쿠키에서 특정 이름의 쿠키값을 가져오는 함수
	function getCookie(name) {
	    var value = "; " + document.cookie;
	    var parts = value.split("; " + name + "=");
	    
	    if (parts.length === 2) {
	        return parts.pop().split(";").shift();
	    }
	}

	// userInfo 쿠키 가져오기
	var userInfoCookie = getCookie("userInfo");


	// 여기에 실제로 로그인 처리하는 함수를 추가
	function performLogin(userId, userPw) {
	    // 로그인 처리 로직
	    sessionStorage.setItem('previousUrl', window.location.href);
	    var previousUrl = sessionStorage.getItem('previousUrl');
		$.ajax({
	        type: "POST",
	        url: "/user/login",
	        data: {
	            id: userId,
	            pw: userPw
	        },
	        success: function (response) {
	        	if (response === "success") {
	                var autoLoginChecked = $("#autoLoginCheckbox").prop("checked");
				    
	                if (previousUrl) {
	                // 이전 페이지로 이동
	                window.location.href = previousUrl
	                
	           	 	} else {
	                // 이전 페이지가 없으면 기본적으로 홈 페이지로 이동
	                window.location.href = '/main'
	           		}
	                
	            } else if(response === "singup"){
	            	
	            	 window.location.href = '/user/singup'
	            	 
	            } else{
	            	console.log("로그인 실패")
	
	                $("#label1")
	                	.text("ID/PW 가 올바르지 않습니다.")
	
	            }
	        },
	        error: function () {
	            console.log("로그인 실패")
	            // AJAX 요청 자체가 실패한 경우에 대한 처리
	            alert("로그인 요청에 실패했습니다.")
	        }
	    });
	}
});

$(function() {
	 var sessionId = "${id}";
	 if (sessionId) {
		
		hasNew();
		loadAlert();
		var urlEndPoint = "/alert/get?id=" + sessionId //Sse세션 생성 시 접속한 세션의 id를 보내준다
		var eventSource = new EventSource(urlEndPoint) //SSE를 위한 'EventSource'를 생성
		
		eventSource.onmessage = function (event) { // sendNotification 발생시 생기는 메소드
		var data = JSON.parse(event.data) // sendNotification에서 보내준 data { hasNew : hasNew, alert : alert }
		
		var hasNew = data.hasNew
		var alert = data.alert
		
		 if (hasNew > 0) {
                $("#new-icon").show();
                $("#new-alert").text(hasNew).show();
                $("#badge").text(hasNew).show(); // Update the badge in real-time
            } else {
                $("#new-alert").hide();
                $("#new-icon").hide();
                $("#badge").hide();
            }
		$("#new-icon").show() // new 알림표시 표시
		$("#new-alert").html(hasNew).show() // 새로온 알림 갯수 표시
		
		loadAlert() //알림을 로드하는 함수를 호출
	   	}
	 }
})// 제이쿼리 펑션 끝
	
function hasNew() { // 새로운 알림 확인 함수
   $.ajax({
      type: "get"
      , url: "/alert/new"
      , data: {
      }
      , dataType: "json" // int타입인 hasNew를 받아옴
      , success: function( res ) {
         
         if( res.hasNew == 0 ) { //hasNew 값이 0이면 알람을 숨긴다
            $("#new-alert").hide()
            $("#new-icon").hide()
            $("#badge").hide()
         } else { // 0이 아니면 알림을 보여준다
            $("#new-alert").text(res.hasNew).show()
            $("#badge").text(res.hasNew).show()
            $("#new-icon").show()
         }
    
      }
      , error: function() {
      }
   })
} // hasNew 함수 끝

function loadAlert() { // 알림을 로드하는 함수
    $.ajax({
        type: "get"
        , url: "/alert/jong"
        , data: {}
        , dataType: "html"
        , success: function( res ) { // Alert객체를 받아넣어준 list JSP를 HTML 타입으로 불러온다
           
         $("#alert").html(res)
        }
        , error: function() {
        }
     })
} // loadAlert 함수 끝



$(document).ready(function(){
	$('.menu_btn').click(function(){
	$('.menu_btn').toggleClass('lijo');
	$('.gnb').toggleClass('surya');

	});    
	var max_h=0;
	$(".sub").each(function () {
		var h = parseInt($(this).css("height"));
		if (max_h < h) {
			max_h = h;
		}
	});

	// 마우스 over 시
	$('.gnb').mouseenter(function () {
	// menu bg
	
		var menuHeight = $('#header').outerHeight();
	
		$('.hd_bg').css({
		'top': menuHeight + 'px',
		height: max_h + 30 + 'px',
		});
		
		$('#header').addClass('open');
	});
		     
	$('.gnb').mouseleave(function () {
		$('.hd_bg').css('height', '0');
	    $('#header').removeClass('open');
	});
	 
	$('.gnb > li').mouseenter(function () {
		
	    $(this).addClass('active');
	    $(this).siblings().removeClass('active')
	});
	
	$('.gnb > li').mouseleave(function () {
	    $(this).removeClass('active');
	});
	
	$('#dropdownBtn1').click(function () {
		// Toggle the visibility of the dropdown content
		$('.dropdown-content1').toggle();
		$('.dropdown-content2').hide();
		event.stopPropagation();
	});
	
	$('.dropdown-content1').click(function (event) {
		// Prevent the click event inside the dropdown content from reaching the document click handler
		event.stopPropagation();
	});
	
	$(document).click(function(event) {
		var dropdownContent = $('.dropdown-content1');
		if (!dropdownContent.is(event.target) && dropdownContent.has(event.target).length === 0) {
		    dropdownContent.hide();
		}
	});	
	
	$('#dropdownBtn2').click(function () {
	    // Toggle the visibility of the dropdown content
	    $('.dropdown-content2').toggle();
	    $('.dropdown-content1').hide();
	    event.stopPropagation();
	});
	
	$(document).click(function(event) {
	    var dropdownContent = $('.dropdown-content2');
	    if (!dropdownContent.is(event.target) && dropdownContent.has(event.target).length === 0) {
	        dropdownContent.hide();
	        $('.dropdown-content1').hide();
	    }
	});	
	
	// 쿠키 삭제 함수
	function deleteCookie(name) {
	    document.cookie = name + "=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
	 }
	$("#logout_button").click(function(){
	    // 쿠키 삭제 함수 호출
		deleteCookie("userInfo");
	    //alert("버튼 작동");
		$.ajax({
		    type: "POST",
		    url: "/user/logout",
		    success: function(data){
		   
		    	window.location.href = "/main";
		       
		    } 
		}); // ajax 
	});
	
	$("#allDel").click(function() {
	   	var $id = "${id}"
		$.ajax({
			type: "post"
			, url: "/alert/delAll"
			, data: { id : $id }
			, success: function( res ) {
				loadAlert() // 알람을 읽었을 때 안읽은 알람들을 불러옴
				hasNew() // 알람을 읽었을 때 새로 생긴 알람이 있는지 확인해서 불러옴
			}
			, error: function() {
				console.log("AJAX 실패")
			}
		})
	})
	
	$.ajax({
	    url: '/layout/header',
	    method: 'GET',
	    dataType: 'json',
	    success: function(data) {
	        if (data != null) {
	            // UserFile 객체가 'thumbnailName' 속성을 가지고 있는지 확인
	            // 'thumbnailName'이 존재하는지 확인
	          
	            if (data.thumbnailName !== 'defaultProfile.png') {
	                // 이미지의 URL 생성
	                var imageUrl = '/upload/' + data.thumbnailName;
	                // 이미지 소스 설정
	                $('.profileImage').attr('src', imageUrl);
	                
	            } else {
	                $('.profileImage').attr('src', '/resources/img/defaultProfile.png');
	            }
	            
	        } else {
	        	$('.profileImage').attr('src', '/resources/img/defaultProfile.png');
	        }
	    },
	    error: function() {
	    	$('.profileImage').attr('src', '/resources/img/defaultProfile.png');
	        console.error('프로필 이미지 로드에 실패했습니다.');
	    }
	});
});


</script>
<style type="text/css">
#needitFont {
	color: #ff533f;
}

a {
	text-decoration: none;
	color: black;
}

li {
	list-style: none;
}

nav {
	list-style: none;
	padding: 0;
	display: flex;
}

nav li {
	width: 170px;
}

.wrap {
	width: 1200px;
	margin: auto;
}

.container {
	max-width: 1200px;
	margin: auto;
	font-size: 20px;
	font-weight: bold;
}

#header {
	background: #fff;
	margin: 0;
	position: relative;
	text-align: center;
}

#header .container {
	justify-content: center;
	align-items: center;
}

#header .gnb {
	text-align: center;
}

#header .nav ul.gnb {
	margin-bottom: 0px;
	padding-left: 0px;
	display: flex;
}

#header .nav ul.gnb li {
	margin-bottom: 0px;
	color: #000;
	text-align: center;
	position: relative;
}

#header .nav ul.gnb li a {
	box-sizing: border-box;
	display: block;
	transition: .8s ease;
	text-transform: uppercase;
}
#header .nav ul.gnb li ul li a:hover {
	color: blue;
}

#header .nav ul.gnb li ul.sub {
	position: absolute;
	padding-left: 0px;
	display: none;
	padding-top: 10px;
	z-index: 4;
	width: 100%
}

#header .nav ul.gnb li ul.sub li {
	position: relative;
}

#header .nav ul.gnb li ul.sub li a {
	padding: 10px;
	margin-top: 8px;
}

#header .nav ul.gnb:hover li ul.sub {
	display: block;
	color: blue;
}

#header .nav ul.gnb li{
	display: inline-block;
	margin-bottom: 0px;

}


#header.open .hd_bg {
	position: absolute;
	width: 100%;
	background: #fff;
	transition: all ;
	border-top: 1px solid #dcdcdc;
	opacity: 95%;
	z-index: 3;
}

#header .nav ul.gnb li ul.sub li a {
	text-align: center
}

#header .nav .active {
	position: relative
}

#header .nav .active:hover:after {
	content: '';
	display: block;
	width: 100%;
	height: 2px;
	background: #000;
	position: absolute;
	left: 0;
	bottom: 0;
	background-color: #ccc
}

.dropbtn {
	border: none;
	cursor: pointer;
}


.dropdown {
	position: relative;
	display: inline-block;
	z-index: 5;
}

#dropdownBtn2{
	width: 40px;
	height: 40px;
	border-radius: 40px;
	cursor: pointer;
}

.dropdown-content1 {
	margin-top: 15px;
	display: none;
	position: absolute;
	background-color: #f1f1f1;
	width: 240px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	text-align: left;
	right: -50px;
	border-radius: 20px;
	z-index: 5;
	height: 350px;
}

.dropdown-content1:after {
	content: "";
	position: absolute;
	top: -10px;
	border-left: 10px solid transparent;
	border-right: 10px solid transparent;
	border-bottom: 10px solid #f1f1f1;
}

.dropdown-content1 .alertData {
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

.dropdown-content1 .alertData:hover {
	background-color: #ccc;
	position: relative;
	border-radius: 20px;
}

.dropdown-content2 {
	margin-top: 15px;
	display: none;
	position: absolute;
	background-color: #f1f1f1;
	width: 160px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	text-align: center;
	right: -50px;
	border-radius: 20px;
	z-index: 5;
}

.dropdown-content2:after {
	content: "";
	position: absolute;
	top: -10px;
	border-left: 10px solid transparent;
	border-right: 10px solid transparent;
	border-bottom: 10px solid #f1f1f1;
}

.dropdown-content2 a {
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

.dropdown-content2 a:hover {
	background-color: #ccc;
	position: relative;
	border-radius: 20px;
}

.dropdown-title {
	color: white;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
	border-bottom: solid #f1f1f1;
	background-color: #ff533f;
	border-radius: 20px 20px 0px 0px;
}

.dropdown-title:after {
	z-index: 1;
	content: "";
	position: absolute;
	top: -10px;
	right: 60px;
	border-left: 10px solid transparent;
	border-right: 10px solid transparent;
	border-bottom: 10px solid #ff533f;
}
#allDel {
	font-size: 12px;
	border-radius: 30px;
	border: none;
	background-color: #ff533f;
	color: white;
	margin-top: 3px;
	margin-right: 8px;
	margin-bottom: 8px;
	
}
#alertDel{
	display: flex;
  	justify-content: flex-end;
}
.p-2 {
	margin-top: 30px;
	margin-bottom: 20px;
	padding: 0.5rem !important;
}

.header {
	z-index: 300;
}

.p-4 {
	display: flex;
	flex-wrap: nowrap;
	justify-content: center;
	align-items: center;
}

#new-icon-text {
	display: none;
	
}

.scrollbar { 
  height: 260px;
  overflow-y: scroll;
}

/* 스크롤바의 폭 너비 */
.scrollbar::-webkit-scrollbar {
    width: 10px;  
}

.scrollbar::-webkit-scrollbar-thumb {
    background: #ff533f; /* 스크롤바 색상 */
    border-radius: 10px; /* 스크롤바 둥근 테두리 */
}

.scrollbar::-webkit-scrollbar-track {
    background: #f1f1f1;  /*스크롤바 뒷 배경 색상*/
     border-radius: 10px;
}
#badge{
	width: 30px;
	border-radius: 10px;
	color: white;
	font-size: 12px;
	position: absolute;
	top: -5px;
	right: -10px;
	background-color: red;
	text-align:  center;
	font-weight: bold;
	te
}
</style>

</head>
<body>
<div class="wrap">

<div class="header">
	<div class="float-end" style="margin-bottom: -70px; margin-top: 30px; width: 90px; height: 40px; text-align: right; ">
		<%-- 비로그인 --%>
		<c:if test="${not isLogin }">
		
			<div class="dropdown">
				<img id="dropdownBtn2" src="/resources/img/mypageicon.png" class="dropbtn" style="height: 40px; width: 40px;">
				<div class="dropdown-content2">
					<a href=""  data-bs-toggle="modal" data-bs-target="#exampleModal"> 로그인 </a>
				</div>
			</div>
			
			<!-- Modal -->
			<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content" style="display:contents;">
						<c:import url="/user/login" />
					</div>
				</div>
			</div>
			
		</c:if>
			
		<c:if test="${not empty isLogin and isLogin }">
			<c:choose>
				<c:when test="${id eq 'admin'}">
					<!-- 사용자가 'admin' 역할을 가지고 있는 경우의 코드 -->
					<div class="dropdown">
						<img id="dropdownBtn2" src="/resources/img/mypageicon.png" class="dropbtn" style="height: 40px; width: 40px;">
					<div class="dropdown-content2">
						<div class="dropdown-title">${nick }</div>
							<a href="/admin">관리자 페이지</a>
					              <a href="/message/list">내 채팅</a>
					              <a href=""id="logout_button">로그아웃</a>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="dropdown">
						<img id="dropdownBtn1" src="/resources/img/jong.png" class="dropbtn" style="height: 40px; width: 40px;">
					<span id="badge"></span>
					<div class="dropdown-content1 ">
						<div class="dropdown-title" style="text-align: center;">알림</div>
							<div id="alertDel"><button id="allDel">전체삭제</button></div>
							<div class="scrollbar">
								<a id="new-icon">
									<label id="new-icon-text">NEW</label>
								</a>
								<a id="alert"></a> 
							</div>
						</div>
					</div>
					
					<div class="dropdown">
					<div id="profileImageContainer">
					<img class="profileImage" id="dropdownBtn2" src="">
					</div>
						<div class="dropdown-content2">
							<div class="dropdown-title">${nick }</div>
							<a href="/profile">마이페이지</a>
							<a href="/message/list">내 채팅</a>
							<a href="/profile/rentList ">빌린거/빌려준거</a>
							<a href="/profile/basket">찜 목록</a>
							<a href=""id="logout_button">로그아웃</a>
						</div>
					</div>
				</c:otherwise>	
	        </c:choose>
		</c:if>
		</div>
	
	<div class="mx-auto p-4" style="width: 1200px;" >
		<div class="mx-auto p-2">
			<a class="logo" href="/main"><img src="/resources/img/needit..png" width="350" height="70"></a>
		</div>
	</div>
	
	<header id="header" >
		<div class="container ">
			<nav class="nav justify-content-center">
	            <ul class="gnb">
	                <li><label id="needitFont" style="font-size: 28px;">대여해요</label>
	                    <ul class="sub">
	                        <li><a href="/rent/list?menu=1&cate=1">물품</a></li>
	                        <li><a href="/rent/list?menu=1&cate=2">인력</a></li>
	                        <li><a href="/rent/list?menu=1&cate=3">공간</a></li>
	                    </ul>
	                </li>
	                
	                <li><label id="needitFont" style="font-size: 28px;">나눔해요</label>
	                     <ul class="sub">
	                        <li><a href="/share/list?menu=2&cate=1">물품</a></li>
	                        <li><a href="/share/list?menu=2&cate=2">인력</a></li>
	                        <li><a href="/share/list?menu=2&cate=3">공간</a></li>
	                    </ul>
	                </li>
	                
	                <li><label id="needitFont" style="font-size: 28px;">해주세요</label>
	                     <ul class="sub">
	                    	<li><a href="/please/list?menu=3&cate=1">물품</a>
							<li><a href="/please/list?menu=3&cate=2">인력</a>
							<li><a href="/please/list?menu=3&cate=3">공간</a>
	                    </ul>
	                </li>
	                
	                <li><label id="needitFont" style="font-size: 28px;">커뮤니티</label>
	                     <ul class="sub">
	               			<li><a href="/admin/noticeList">공지사항</a>
							<li><a href="/community/list?menu=4&cate=2">우리동네 소식</a>
							<li><a href="/community/list?menu=4&cate=3">자유 게시판</a>
							<li><a href="/community/list?menu=4&cate=4">팁 게시판</a>
	                    </ul>
	                </li>
	                
	                <li><label id="needitFont" style="font-size: 28px;">동네업체</label>
	                	<ul class="sub">
	                		<li><a href="/business/list?menu=5&cate=1">물품</a></li>
							<li><a href="/business/list?menu=5&cate=2">인력</a></li>
							<li><a href="/business/list?menu=5&cate=3">공간</a></li>
						</ul>
	                </li>
	                
	                <li><a id="needitFont" href="/map" style="font-size: 28px;">주변지도</a></li>
	            </ul>
			</nav>
		</div>
		<hr>
		
	<div class="hd_bg"></div>
	</header>
</div><!-- header -->

