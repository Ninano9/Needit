<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<link rel="icon" href="/resources/img/favicon.ico">
<style type="text/css">

/* 로고 크기 */
#adminImg{
	float: left;
 	position: fixed;
	z-index: 1;
	width: 300px;
	height: 105px;
	margin-top: 5px;
}

/* 로그아웃 버튼 */
#adminBtn{
	float: right;
	position: relative;
	z-index:2;
	margin-right:17px;
	margin-top:16px;
	border: 0px solid;
	border-radius: 5px;
	width: 82px;
	height: 37px;
}

/* 목록 글씨체 */
#adminUl li{
	list-style: none;
	color: white;
	font-size: 35px;
	font-weight: bold;
	margin-bottom: 15px;
	margin-left: -6px;
}
/* 목록 클릭시 */
li:hover{
	background-color: #ff8200;
	cursor: pointer;
	width: 302px;
}

/* 위쪽 배경 */
#adminTop{
	border: 0px solid rgb(255,83,63);
	width: 100%;
	height: 100px;
	background: rgb(255,83,63);
	position: fixed;
	margin-left: 300px;
	z-index: 3;
}

/* 메인, 로그아웃 버튼 */
#mainButton{
	position: relative;
    width: 85%;
    right: 145px;
}
/* 왼쪽 배경 */
#adminLeft{
	float: left;
	position: fixed;
	border: 0px solid rgb(255,83,63);
	width: 300px;
	height: 100%;
	background: rgb(255,83,63);
}
/* 목록 전체 div */
#adminList{
	float: left;
	position: fixed;
	z-index:1;
	margin-top: 110px;
	margin-left: -28px;
}

/* 안쪽 내용 중간 배치 */
#adminContent {
    float: left;
    position: fixed;
    width: 80%;
    margin-left: 300px;
    margin-top: 128px;
}

/* 목록 링크 링크색 제거 */
#adminList li a{
	text-decoration: none;
	color: white;
}

/* 로고와 목록 띄우기 */
#adminDayVisit{
	margin-top: 8px;
}
/* 로그인중일때 */
#ifLogin{
 	float: right;
    position: relative;
    margin-right: -88px;
    margin-top: 10px;
    z-index: 5;
    width: 12px;
    height: 12px;
    background-color: red;
    border-radius: 20px;
}

</style>

</head>
<body>

<div id="adminAll" style="width: 1200px;">
<!-- 니딧 로고 -->
<img alt="니딧로고" src="/resources/img/needitAdmin_white.png" id="adminImg">


<!-- 위쪽 배경 -->
<div id="adminTop">
<!-- 로그아웃 버튼 -->
	<div id="mainButton">
	<form action="/main" method="post">
	<button id="adminBtn">로그아웃</button>
	<c:if test="${not empty isLogin}">
		<div id="ifLogin"></div>
	</c:if>
	</form>
	<a href="/main"><button id="adminBtn">메인으로</button></a>
	</div><!-- #mainButton -->
</div><!-- #adminTop -->


<!-- 왼쪽 배경 -->
<div id="adminLeft"></div>


<!-- 목록 -->
<div id="adminList">
<ul id="adminUl">
<!-- <li id="adminDayVisit"><a href="/admin/dayVisit">방문자수 조회</a></li> -->
<li id="adminChat"><a href="/admin/chat">1:1 채팅문의 목록</a></li>
<li id="adminReport"><a href="/admin/reportList">신고접수 목록</a></li>
<li id="adminBusiness"><a href="/admin/businessReq">업체요청 목록</a></li>

<li id="adminBanner"><a href="/admin/bannerUpdate">메인배너 수정</a></li>
<li id="adminNotice"><a href="/admin/noticeUpdate">공지등록</a></li>
<li id="adminEmail"><a href="/admin/emailSend">회원 이메일 발송</a></li>
</ul>
</div>

</div><!-- #adminAll -->

</body>
</html>