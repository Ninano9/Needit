<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    

<c:import url="/WEB-INF/views/layout/header.jsp" />

<script type="text/javascript">
function toggleSection(sectionId) {
    var section = document.getElementById(sectionId);
    section.classList.toggle('hidden');
}
</script>
<style type="text/css">

/* 썸네일 미리보기 */
#thumbnail_container{
   width: 350px;
    height: 350px;
    float: left;
    position: absolute;
    margin-top: 67px;
    border-radius: 300px;
    background-size: cover;
    overflow: hidden;
}
/* 프로필 사진 */
#profileImg{
   width: 350px;
    height: 350px;
    background-size: cover;
    object-fit: cover;
}
/* 프로필사진, 닉네임, 사진등록 삭제 */
#profileImgContainer{ 
   width: 400px; 
    float: left; 
    margin-top: 37px;
/*     display: inline-block; */
}
/* 프로필 등록 삭제 버튼 배치 */
#profileImgUpdate{
   margin-left: 100px;
   margin-top: 6px;
}
/* 프로필 사진 크기 */
#profileImage{
   width: 350px;
   border-radius: 310px;
}
/* 유저 정보 */
#userContent{
	width: 775px;
    height: 332px;
    float: left;
    position: absolute;
    margin-top: -347px;
    margin-left: 415px;
}
.userInfo thead{
	width: 200px;
    background-color: rgb(255 83 63 / 6%);
    border-radius: 8px;
}
.userInfo tbody td{
   width: 575px;
   vertical-align: middle;
   display: table-cell;
}
.userInfo th{
   height: 48px;
}
.userInfo td{
   height: 48px;
}
/* 유저 정보 테이블 둥글게 */
#userContent table{
   border-radius: 10px;
}
/* 회원등급 사진 */
#userGrade{
   display: inline-block;
}
#userGrade img{
   width: 20px;
   height: 30px;
   display: inline-block;
   vertical-align: top;
}
/* 자기소개 너비 */
#introduce{
   width: 1134px;
    clear: both;
    margin: 0 auto;
}
/* 자기소개 id */
#introId{
   margin-bottom: 10px;
   border: 1px solid #ccc;
}
/* 자기소개칸 둥글게 */
#introId, #introText{
    border-radius: 10px;
}
/* 목록들 제목 h1 */
.listH1{
    margin-left: 16px;
}
/* 테이블 th 색상 */
.rentTable th{
   background-color: rgb(255,83,63);
   color: white;
}
/* 목록 테이블 둥글게 */
.rentTable{
   border-radius: 5px;
   width: 99%;
}
.userInfo td{
   border-bottom: 1px solid #cccccc40;
}
/* 목록들 스크롤 */
.tableScroll{
   overflow-x: hidden;
    overflow-y: scroll;
    height: 200px;
    width: 1139px;
    margin-left: 20px;
    display: inline-block;
}
/* 사진 수정 버튼 */
#fileEdit{
    border: 1px solid rgb(255,83,63);
    border-radius: 5px;
    background-color: rgb(255,83,63);
    color: white;
    width: 46px;
    height: 31px;
    text-align: center;
    font-size: 15px;
    font-weight: normal;
    padding: 3px;
    float: left;
    margin-top: -36px;
    margin-left: 162px;
}

/* 유저 정보 */
/* .userInfo th{ */
/*    background-color: rgb(255,83,63); */
/* } */

/* 유저 정보 테이블 모양 세로 정렬 */
#userContent thead{
   float: left;
}
#userContent thead tr, thead tr th{
   display: block;
}
#userContent tbody{
   display: block;
   overflow-x: hidden;
   white-space: nowrap; 
}
#userContent tbody tr{
   display: inline-block;
}
#userContent tbody tr td{
   display: block;
}
/* 등급 크기 */
#userContent tbody tr td img{
   width: 25px;
   height: 28px;
   vertical-align: top;
}
.userInfo th div, .userInfo td div{
   margin-top: 7px;
}
/* 취소 승인 버튼 */
.agrBtn{
   font-size: 16px;
   font-weight: bold;
    width: 99%;
    height: 34px;
    margin-left: 1px;
    border-radius: 5px;
}
.rentDate{
   width: 287px;
}
.rentTable tr th:first-child {
   border-top-left-radius: 5px;
}
.rentTable tr th:last-child {
   border-top-right-radius: 5px;
   border: none;
}
.rentTable th{
   border-right: 1px solid #ccc;
}
.rentTable td{
   border-bottom: 1px solid #ccc;
   font-weight: normal;
}

/* 업체 마크 */
#userContent svg{
   display: inline-block;
   margin-left: 5px;
   margin-top: -11px;
   color: rgb(255,83,63);
}
/* 업체 링크 */
#businessUrl{
   position: absolute;
    margin-top: -50px;
    margin-left: 415px;
    margin-bottom: 24px;
    font-size: 18px;
    width: 777px;
    height: 50px;
    background-color: rgb(255 83 63 / 4%);
    color: black;
    border-radius: 5px;
    vertical-align: middle;
    text-align: center;
}

/* 업체 마크 */
#userContent svg{
   display: inline-block;
   margin-left: 5px;
   margin-top: -11px;
   color: rgb(255,83,63);
}

#businessUrl a {
    vertical-align: -webkit-baseline-middle;
    color: blue;
    text-decoration: underline;
}
#introUpdate {
	display: none; /* 초기에는 저장 버튼을 숨김 */
}

/* 목록들 보기 버튼 */
.listWatchBtn{
	width: 260px;
    height: 39px;
    border-radius: 5px;
    margin-bottom: 6px;
    margin-left: 19px;
    font-size: 16px;
    font-weight: bold;
    background-color: darkgrey;
    color: white;
    border: none;
}
#boardSection tr td{
	font-size: 16px;
}

/* hover 시 색상 변경 */
.board-link:hover {
	color: orange; /* hover 시 변경할 색상 */
}

</style>

<div class="container">

<!-- 썸네일 미리보기를 담을 div 추가 -->
<div id="thumbnail_container"></div>

<div style="margin-top: 20px;"></div>

<div id="profileTop">
<div id="profileImgContainer" >
<div id="profileImg">
   <c:if test="${not empty img}">
       <img id="profileImage" src="/upload/${img.thumbnailName}">
   </c:if>
   <c:if test="${empty img}">
       <img id="profileImage" src="/resources/img/defaultProfile.png">
   </c:if>
</div><!-- #profileImg -->



<div class="panel panel-default" id="userContent">
<h3 style="font-size: 23px; font-weight: bold; margin-bottom: 12px; display: inline-block;">${your.nick}님의 프로필</h3>
<c:if test="${your.businessStatus eq 2 }">
   <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-award" viewBox="0 0 16 16">
     <path d="M9.669.864 8 0 6.331.864l-1.858.282-.842 1.68-1.337 1.32L2.6 6l-.306 1.854 1.337 1.32.842 1.68 1.858.282L8 12l1.669-.864 1.858-.282.842-1.68 1.337-1.32L13.4 6l.306-1.854-1.337-1.32-.842-1.68L9.669.864zm1.196 1.193.684 1.365 1.086 1.072L12.387 6l.248 1.506-1.086 1.072-.684 1.365-1.51.229L8 10.874l-1.355-.702-1.51-.229-.684-1.365-1.086-1.072L3.614 6l-.25-1.506 1.087-1.072.684-1.365 1.51-.229L8 1.126l1.356.702 1.509.229z"/>
     <path d="M4 11.794V16l4-1 4 1v-4.206l-2.018.306L8 13.126 6.018 12.1 4 11.794z"/>
   </svg>
</c:if>
   <input type="hidden" name="id" value="${id}"/>
   <table class="userInfo" style="text-align: center;">
     <thead>
      <tr>
         <th style="border-top-left-radius: 5px;"><div>아이디</div></th>
         <th><div>닉네임</div></th>
         <th><div>등급</div></th>
         
         <th><div>가입일</div></th>
         <th style="height: 73px;"><div style="margin-top: 19px;">주소</div></th>
      </tr>
     </thead>
      
      <tbody>
      <tr>
         <td style="border-top-right-radius: 5px;"><div>${your.id }</div></td> 
         <td><div>${your.nick }</div></td>
         <td><div>Lv.${your.grade }
         <!-- 회원등급 -->
         <c:choose>
            <c:when test="${your.grade eq 1}">
               <img src="/resources/img/계란.png"/>
            </c:when>
            <c:when test="${your.grade eq 2}">
               <img src="/resources/img/금간계란.png"/>
            </c:when>
            <c:when test="${your.grade eq 3}">
               <img src="/resources/img/병아리.png"/>
            </c:when>
            <c:when test="${your.grade eq 4}">
               <img src="/resources/img/닭.png"/>
            </c:when>
            <c:when test="${your.grade eq 5}">
               <img src="/resources/img/치킨.png"/>
            </c:when>
         </c:choose></div>
         </td>
          <td><div><fmt:formatDate pattern="yyyy-MM-dd" value="${your.joinDate }"/></div></td>
         <td style="height: 73px;"><div>${your.addr1 }<br>
               ${your.addr2 }</div>
         </td>
      </tr>
     </tbody>
   </table>
</div><!-- #userContent -->
</div><!-- #profileTop -->

<!-- 사진, 유저정보와 자기소개 사이 마진 -->
<div style="clear: both; margin-bottom: 85px;"></div>

<!-- 업체 링크 -->
<c:if test="${your.businessStatus eq 2 }">
<div id="businessUrl">
	<span style="vertical-align: -webkit-baseline-middle; color: black;">업체주소 : </span><a href="http://${link.BUSINESS_URL}" target="_blank">${link.BUSINESS_URL}</a>
</div>
</c:if>


<div id="introduce">
    <h2 style="font-size: 26px; font-weight: bold; margin-left: 6px; margin-bottom: 2px;">자기소개</h2>
    
    <!-- 자기소개글을 입력하는 텍스트박스 -->
    <div>
        <textarea class="form-control" id="introText" name="intro" rows="5" maxlength="100" readonly="readonly">${your.intro }</textarea>
    </div>
</div><!-- #introduce -->

<h1 class="listH1" style="font-size: 24px; font-weight: bold; margin-top: 15px; margin-left: 23px; margin-bottom: 3px;">${your.nick}님의 게시글</h1>
<div id="boardSection" class="tableScroll">
   <table class="listType rentTable">
         <tr>
            <th>No.</th>
            <th class="title">제목</th>
            <th>게시판</th>
            <th>상세게시판</th>
            <th>작성일</th>
            <th>조회수</th>
         </tr>
         <c:forEach items="${yourList }" var="yourList">
            <tr>
               <td>${yourList.BOARD_NO }</td>
               <td>
                <c:choose>
                    <c:when test="${yourList.MENU eq 1}">
                        <a href="/rent/view?boardNo=${yourList.BOARD_NO}" class="board-link">${yourList.TITLE}</a>
                    </c:when>
                    <c:when test="${yourList.MENU eq 2}">
                        <a href="/share/view?boardNo=${yourList.BOARD_NO}" class="board-link">${yourList.TITLE}</a>
                    </c:when>
                    <c:when test="${yourList.MENU eq 3}">
                        <a href="/please/view?boardNo=${yourList.BOARD_NO}" class="board-link">${yourList.TITLE}</a>
                    </c:when>
                    <c:when test="${yourList.MENU eq 4}">
                        <a href="/community/view?boardNo=${yourList.BOARD_NO}" class="board-link">${yourList.TITLE}</a>
                    </c:when>
                    <c:when test="${yourList.MENU eq 5}">
                        <a href="/business/view?boardNo=${yourList.BOARD_NO}" class="board-link">${yourList.TITLE}</a>
                    </c:when>
                </c:choose>
            </td>
               <td>
                     <c:choose>
                    <c:when test="${yourList.MENU eq 1}">
                        대여해요
                    </c:when>
                    <c:when test="${yourList.MENU eq 2}">
                        나눔해요
                    </c:when>
                    <c:when test="${yourList.MENU eq 3}">
                        해주세요
                    </c:when>
                    <c:when test="${yourList.MENU eq 4}">
                        커뮤니티
                    </c:when>
                    <c:when test="${yourList.MENU eq 5}">
                        동네업체
                    </c:when>
                </c:choose>
               </td>
               <td>
	               <c:choose>
				       <c:when test="${yourList.CATE eq 1}">
				           물품
				       </c:when>
				       <c:when test="${yourList.CATE eq 2}">
				           인력
				       </c:when>
				       <c:when test="${yourList.CATE eq 3}">
				           공간
				       </c:when>
			       </c:choose>
               </td>
               <td>
                  <fmt:formatDate var="curDate" value="<%=new Date() %>" pattern="yyyyMMdd" />
                  <fmt:formatDate var="writeDate" value="${yourList.write_date }" pattern="yyyyMMdd" />
                  <c:choose>
                     <c:when test="${writeDate lt curDate }">
                        <fmt:formatDate value="${yourList.write_date }" pattern="yyyy-MM-dd" />
                     </c:when>
                     <c:otherwise>
                        <fmt:formatDate value="${yourList.write_date }" pattern="HH:mm" />
                     </c:otherwise>
                  </c:choose>
               </td>
               <td>${yourList.HIT}</td>
            </tr>
         </c:forEach>
   </table><!-- .listType -->
</div><!-- .tableScroll -->

</div>
</div><!-- .container -->

<c:import url="/WEB-INF/views/layout/footer.jsp" />