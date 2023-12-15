<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    

<c:import url="/WEB-INF/views/layout/header.jsp" />
<script type="text/javascript">
//예약 승인
$(function(){
   $("#confirmBtn").click(function(){
      var confirmBtn = $(this);
        $.ajax({
            type: "post"
            , url: "/profile/confirm"
            , data: {
               rentNo: confirmBtn.data("rent_no")
                , boardNo: confirmBtn.data("board_no")
            }
            , dataType: "json"
            , success: function( res ) {
               location.reload()
            }
            , error: function() {
               console.log("AJAX 실패")
   
            }
         })
      
   });
})


$(function(){

   $(".cancelBtn").click(function() {
      var cancelBtn = $(this);

         $.ajax({
            type: "post"
            , url: "/cancel"
            , data: {
               merchantUid: cancelBtn.data("uid")
               , rentNo: cancelBtn.data("no")
               , boardNo: cancelBtn.data("board_no")
            }
            , dataType: "json"
            , success: function( data ) {
               console.log("결제취소, 대여 요청상태 변경 성공")
               
               alert("취소가 완료되었습니다.\n온라인결제를 하셨다면 환불처리 됩니다.")
               
               if(data.status === "success"){
                  location.reload();
               }
               
            }
            , error: function(xhr, status, error) {
               console.log("AJAX 실패", status, error)
               alert("취소 실패하였습니다.\n관리자에게 문의주세요.")
            }
         })
         
      })
})
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
	margin-top: 67px;
/*     display: inline-block; */
}
/* 프로필 등록 삭제 버튼 배치 */
#profileImgUpdate{
	margin-left: 96px;
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
/*     display: inline-block; */
	float: left;
}
.userInfo thead{
	width: 200px;
	background-color: azure;
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
	text-align: center;
}
.rentTable td{
	text-align: center;
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

/* Webkit 브라우저를 위한 스타일 */
.tableScroll::-webkit-scrollbar { width: 12px; }
.tableScroll::-webkit-scrollbar-track { background: #f1f1f1; border-radius: 10px; }
.tableScroll::-webkit-scrollbar-thumb { background-color: transparent; border-radius: 10px;background: #ff533f; }
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
    margin-top: -69px;
    margin-left: 400px;
    margin-bottom: 24px;
    font-size: 18px;
    width: 776px;
    height: 50px;
    background-color: #ccc;
    color: black;
    border-radius: 5px;
    vertical-align: middle;
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
    margin-top: -69px;
    margin-left: 400px;
    margin-bottom: 24px;
    font-size: 18px;
    width: 776px;
    height: 50px;
    background-color: #ccc;
    color: black;
    border-radius: 5px;
    vertical-align: middle;
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
#gotoMainBtn{
	float: right;
    margin-right: 42px;
    border-radius: 5px;
    background-color: rgb(255,83,63);
    color: white;
    border: none;
    width: 87px;
    height: 34px;
    font-weight: bold;
}

.cancelBtn{
	border: none;
	border-radius: 5px;
    margin-left: 4px;

}
#confirmBtn{
    border: none;
    border-radius: 5px;
    font-size: 1em;
    font-weight: normal;
    width: 77px;
    height: 37px;
	margin-left: 6px;
}
</style>

<!-- 마이프로필 버튼 -->
<a href="/profile/view"><button id="gotoMainBtn">BACK &#11148;</button></a>

<h1 class="listH1">빌려준거 목록</h1>
<div class="tableScroll">
<table class="rentTable">
	<colgroup>
		<col style="width: 7%;">
		<col style="width: 9%;">
		<col style="width: 19%;">
		<col style="width: 7%;">
		<!-- 신청일자 -->
		<col style="width: 10%;">
		<!-- 사용날짜 -->		
		<col style="width: 9%;">
		<!-- 사용 시작 시간 -->
		<col style="width: 10%;">
		<col style="width: 9%;">
		<col style="width: 7%;">
		<col style="width: 8%;">

		<col style="width: 5%;">
	</colgroup>
   <tr>
      <th>예약 번호</th>
      <th>게시글 번호</th>
      <th>주문번호</th>
      <th>예약자</th>
      <th>신청 일자</th>
      
      <th>사용 날짜</th>
      <th>사용 시작 시간</th>
      <th>사용 끝 시간</th>
      <th>결제 상태</th>
      <th>승인 여부</th>
      
      <th>취소</th>
      
   </tr>
<c:forEach items="${myList }" var="list" begin="0" end="10">
   <tr>
      <td>${list.RENT_NO }</td>
      <td>${list.BOARD_NO }</td>
      <td>${list.MERCHANT_UID }</td>
      <td>${list.RENTER_ID }</td>
      <td>${list.CURRENT_TIME }</td>
      <td class="rentDate">${list.RENT_DATE }</td>
      <c:choose>
       <c:when test="${list.START_TIME % 2 == 1}">
              <c:set var="hour" value="${(list.START_TIME ) / 2}" />
              <c:set var="minute" value="00" />
          </c:when>
          <c:when test="${list.START_TIME % 2 == 0}">
              <c:set var="hour" value="${list.START_TIME / 2}" />
              <c:set var="minute" value="30" />
          </c:when>
      </c:choose>

      <!-- 시작 시간 출력 -->
      <td>${hour}:${minute}</td>
      
      <c:choose>
          <c:when test="${list.END_TIME % 2 == 1}">
              <c:set var="endHour" value="${(list.END_TIME + 1) / 2 - 1}" />
              <c:set var="endMinute" value="00" />
          </c:when>
          <c:when test="${list.END_TIME % 2 == 0}">
              <c:set var="endHour" value="${list.END_TIME / 2}" />
              <c:set var="endMinute" value="30" />
          </c:when>
      </c:choose>
   
      <!-- 종료 시간 출력 -->
      <td>${endHour}:${endMinute}</td>
      
      <!-- 결제상태 -->
      <c:choose>
	      <c:when test="${list.PAYMENT_TYPE eq 1}">
	          <td><div style="color: blue;">결제됨</div></td>
	      </c:when>
	      <c:when test="${list.PAYMENT_TYPE eq 0}">
	          <td><div style="color: green;">직거래</div></td>
	      </c:when>
      </c:choose>
      
      <!-- 승인 여부 -->  
      <c:if test="${list.RENT_STATUS eq 1 }">
      	<c:if test="${not empty isLogin }">
      	  <c:if test="${list.RENTER_ID ne id }">
   	    	<td><button id="confirmBtn" class="agrBtn" data-rent_no="${list.RENT_NO }" data-board_no="${list.BOARD_NO }">승인하기</button></td>
      	  </c:if>
      	</c:if>
      </c:if>
      <c:if test="${list.RENT_STATUS eq 2 }">
         <td><div style="color: blue;">완료</div></td>
      </c:if>
      <c:if test="${list.RENT_STATUS eq 0 }">
         <td><div style="color: red;">승인불가</div></td>
      </c:if>

      <!-- 취소 여부 -->
      <c:if test="${list.RENT_STATUS eq 0 }">
         <td><div style="color: red;">거절됨</div></td>
      </c:if>
      <c:if test="${list.RENT_STATUS eq 1 }">
         <td><button class="cancelBtn" data-no="${list.RENT_NO }" data-uid="${list.MERCHANT_UID }" data-board_no="${list.BOARD_NO }">거절</button></td>
      </c:if>
      <c:if test="${list.RENT_STATUS eq 2 }">
		<td><div style="color: red;">취소불가</div></td>      
      </c:if>
    
   </tr>
   
</c:forEach>
</table><!-- .rentTable -->
</div><!-- .tableScroll -->

<%-- <small class="float-end" style=" margin-right: 8px; margin-top: -10px; margin-bottom: 20px;">total : ${paging.totalCount }</small> --%>

<%-- <c:import url="/WEB-INF/views/layout/paginationRent.jsp" /> --%>
      
<hr>


<h1 class="listH1">빌린거 목록</h1>
<div class="tableScroll">
<table class="rentTable">

	<colgroup>
		<col style="width: 8%;">
		<col style="width: 10%;">
		<col style="width: 20%;">
		<col style="width: 8%;">
		<!-- 사용날짜 -->		
		<col style="width: 10%;">
		<!-- 사용 시작 시간 -->
		<col style="width: 11%;">
		<col style="width: 10%;">
		<col style="width: 8%;">
		<col style="width: 9%;">

		<col style="width: 6%;">
	</colgroup>


   <tr>
      <th>예약 번호</th>
      <th>게시글 번호</th>
      <th>주문번호</th>
      <th>신청 일자</th>
      <th>사용 날짜</th>
      <th>사용 시작 시간</th>
      <th>사용 끝 시간</th>
      <th>결제 상태</th>
      <th>승인 여부</th>
      <th>취소</th>
   </tr>
<c:forEach items="${list }" var="list" begin="0" end="10">
   <tr>
      <td>${list.RENT_NO }</td>
      <td>${list.BOARD_NO }</td>
      <td>${list.MERCHANT_UID }</td>
      <td>${list.CURRENT_TIME }</td>
      <td>${list.RENT_DATE }</td>

      <c:choose>
       <c:when test="${list.START_TIME % 2 == 1}">
              <c:set var="hour" value="${(list.START_TIME + 1) / 2}" />
              <c:set var="minute" value="00" />
          </c:when>
          <c:when test="${list.START_TIME % 2 == 0}">
              <c:set var="hour" value="${(list.START_TIME / 2) - 1}" />
              <c:set var="minute" value="30" />
          </c:when>
      </c:choose>

      <!-- 시작 시간 출력 -->
      <td>${hour}:${minute}</td>
      
      <c:choose>
          <c:when test="${list.END_TIME % 2 == 1}">
              <c:set var="endHour" value="${(list.END_TIME + 1) / 2 - 1}" />
              <c:set var="endMinute" value="00" />
          </c:when>
          <c:when test="${list.END_TIME % 2 == 0}">
              <c:set var="endHour" value="${list.END_TIME / 2}" />
              <c:set var="endMinute" value="30" />
          </c:when>
      </c:choose>
   
      <!-- 종료 시간 출력 -->
      <td>${endHour}:${endMinute}</td>
      
      <!-- 결제상태 -->
      <c:choose>
            <c:when test="${list.PAYMENT_TYPE eq 1}">
                <td><div>결제됨</div></td>
            </c:when>
            <c:when test="${list.PAYMENT_TYPE eq 0}">
                <td><div>직거래</div></td>
            </c:when>
      </c:choose>
      
      <!-- 승인 여부 -->
      <c:if test="${list.RENT_STATUS eq 0 }">
		 <td><span style="color: red;">거절됨</span></td>      
      </c:if>
      <c:if test="${list.RENT_STATUS eq 1 }">
         <td><span style="color: green;">대기중</span></td>
      </c:if>
      <c:if test="${list.RENT_STATUS eq 2 }">
         <td><span style="color: blue;">승인됨</span></td>
      </c:if>

      <!-- 취소 여부 -->
      <c:if test="${list.RENT_STATUS eq 1 }">
         <td><button class="cancelBtn" data-no="${list.RENT_NO }" data-uid="${list.MERCHANT_UID }" data-board_no="${list.BOARD_NO }">요청</button></td>
      </c:if>
      <c:if test="${list.RENT_STATUS eq 0 }">
         <td><div style="color: red;">불가</div></td>
      </c:if>
      <c:if test="${list.RENT_STATUS eq 2 }">
         <td><div style="color: red;">불가</div></td>
      </c:if>
   </tr>
</c:forEach>
</table>
</div><!-- .tableScroll -->

<c:import url="/WEB-INF/views/layout/footer.jsp" />