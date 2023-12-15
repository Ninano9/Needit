<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- HEADER -->
<c:import url="/WEB-INF/views/layout/header.jsp" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<%-- 검색버튼 동적CSS --%>
<script type="text/javascript">
$(()=>{
	$("#searchBtn").mouseover(function(){
		$("#searchBtn")	
			.css("color", "white")
			.css("background-color", "rgb(255,83,63)")
			.text("Needit")
	}).mouseout(function () {
        $(this)
        .css("color", "")  // 원래 색으로 돌아가기 위해 빈 문자열로 설정
        .css("background-color", "")
        .text("Search");
	});
});
</script>

<%-- CSS --%>
<style type="text/css">
.link {
   cursor: pointer; /* 커서 모양 변경 */
}
.link:hover {
   color: orange; /* 마우스 오버 시 텍스트 색상 변경 */
}
.write {
	float: right;
    padding-top: 18px;
}

.preview {
	float: left;
	position: absolute;
 	width: 70px;
 	height: 70px;
	margin-top: 14px;
    margin-left: 5px;
    
    display: flex;
    justify-content: center;
    align-items: center;
    background-size: contain;
    background-repeat: no-repeat;
    background-position: center center;
}

.title {
 	width: 150px; 
 	color: black; 
 	font-weight: bold; 
	display: inline-block;
    margin-top: 10px;
    margin-bottom: -12px;
    margin-left: -6px;
}
.titlebox {
	width:420px; 
	height:99px; 
	margin-left:65px;
}
#title {
	width: 100%;
	margin-left: -18px;
    padding: 36px;
  	overflow: hidden;
 	text-overflow: ellipsis; 
 	white-space: nowrap; 
}

#locationBox {
	width: 116px;
  	overflow: hidden;
 	text-overflow: ellipsis; 
 	white-space: nowrap; 
}
#rentText1 {
    font-size: 30px;
    color: #343a40;
}
#rentText2 {
    vertical-align: text-top;
	font-size: 25px;
	text-align: center;
	display: inline-block;
    color: #343a40;
}
#viewType {
	margin-top: -1px;
    margin-bottom: -2px;
    margin-right: 17px;
    display: inline-block;
}

th {
	background-color: rgb(255,83,64);
}

.listType tr td,
.listType tr th {
	font-weight: normal;
	font-size: 16px;
	text-align: center;
	border-bottom: 1px solid #ccc;
}

.listType tr th {
	color: white;
	font-weight: bold;
	height: 40px;
}

.thumbnail {
	display:inline-block;
	float: left;

}

.table-container {
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
}
#rentText1 {
    font-size: 30px;
    color: #343a40;
}
#rentText2 {
    vertical-align: text-top;
	font-size: 25px;
	text-align: center;
	display: inline-block;
    color: #343a40;
}
#viewType {
	margin-top: -1px;
    margin-bottom: -2px;
    margin-right: 17px;
    display: inline-block;
}
.btn { 
    --bs-btn-line-height: 1.3;
	--bs-btn-color: #fff;
    --bs-btn-bg: #343a40;
    --bs-btn-hover-border-color: unset;    
} 

.pagination {
	margin-bottom: 50px;
    --bs-pagination-active-bg: #ff533f;
    --bs-pagination-color: #373b3e;
	--bs-pagination-active-border-color: #ff533f;  
    --bs-pagination-hover-color: #ff533f;	  
}
.search-container {
	margin-left: 10px;
}
#searchText {
	vertical-align:top;
    height: 30px;
    font-size: 15px; 
    border: 1px solid #ccc;
    border-top-right-radius: 10px;
    border-bottom-right-radius: 10px;
}
#searchText::placeholder {
	font-style: italic;
	font-size: 13px;
}
#searchBtn:hover {
	color: white;
	background-color: rgb(255,83,63);
}
#searchBtn {
	float: right;
    height: 20px;
    font-size: 12px;
    margin-left: -53px;
    margin-top: 5px;
    position: absolute;
    border: 0;
    border-radius: 15px;
    background-color: #ccc;
    color: white;
}
#selectSub {
    width: 50px;
	text-align: center;
	vertical-align:top;
    height: 30px;
    font-size: 14px;
    border: 1px solid #ccc;
    border-top-left-radius: 10px;
    border-bottom-left-radius: 10px;
    position: relative;
    margin-right: -8.5px;
    appearance: none;
	-webkit-appearance: none;
 	-moz-appearance: none;
}
#selectSub:focus
,#searchText:focus {
	outline: none;
}
#rentText1
,.search-container
,.write {
	display: inline-block;
	vertical-align: middle;
	margin-top: 30px;
	margin-bottom: -25px;
	margin-right: 2px;
}
.listContainer {
	margin-top: 20px;
}
#searchForm {
    width: 450px;
    padding: 20px;
    margin-left: -20px;
    margin-top: 4px;
}
</style>

<div class="container">

<%-- 검색전 메뉴표시 --%>
<c:forEach  var="list" items="${list }" begin="0" end="0">
	<c:if test="${list.MENU eq '5' && list.CATE eq '1' }">
		<div id="rentText1"> 동네업체 
			<div id="rentText2">[물품]</div>
		</div>
	</c:if>
	<c:if test="${list.MENU eq '5' && list.CATE eq '2' }">
		<div id="rentText1"> 동네업체
			<div id="rentText2">[인력]</div>
		</div>
	</c:if>
	<c:if test="${list.MENU eq '5' && list.CATE eq '3' }">
		<div id="rentText1"> 동네업체
			<div id="rentText2">[공간]</div>
		</div>
	</c:if>
</c:forEach>

<%-- 검색후 메뉴표시 --%>
<c:if test="${empty list }">
	<c:if test="${param.menu eq '5' && param.cate eq '1' }">
		<div id="rentText1"> 동네업체 
			<div id="rentText2">[물품]</div>
		</div>
	</c:if>
	<c:if test="${param.menu eq '5' && param.cate eq '2' }">
		<div id="rentText1"> 동네업체
			<div id="rentText2">[인력]</div>
		</div>
	</c:if>
	<c:if test="${param.menu eq '5' && param.cate eq '3' }">
		<div id="rentText1"> 동네업체
			<div id="rentText2">[공간]</div>
		</div>
	</c:if>
</c:if>

<%-- 게시글 검색 --%>
<div class="search-container">
	<form id="searchForm" action="/business/search" method="get">
    <select name="selectSub" id="selectSub" required="required">
    	<option value="" selected disabled hidden>선택&#9660;</option>
    	<option value="title">제목</option>
    	<option value="content">내용</option>
    	<option value="writerNick">작성자</option>
    	<option value="location">지역</option>
    </select>
    
    <input type="text" name="searchText" id="searchText" placeholder=" Need it Now!" 
    	required required oninvalid="this.setCustomValidity('검색어를 입력해주세요')" 
    	oninput="this.setCustomValidity('')">
    <input type="hidden" name="menu" value="${param.menu }">
    <input type="hidden" name="cate" value="${param.cate }">
    <button id="searchBtn">Search</button>
    </form>
</div>

<div class="write">

	<%-- 그리드타입,리스트타입 선택 --%>
	<div id="viewType">
		<a type="button" href="/business/search?selectSub=${param.selectSub}&searchText=${param.searchText}&menu=${param.menu}&cate=${param.cate}"><img src="/resources/img/girdtype.png" style="width: 40px; height: 40px;"></a>
		<a type="button" href="/business/searchType?selectSub=${param.selectSub}&searchText=${param.searchText}&menu=${param.menu}&cate=${param.cate}"><img src="/resources/img/listtype2.png" style="width: 32px; height: 40px;"></a>
	</div>
	
	<c:if test="${not empty isLogin and isLogin }">
		<a class="btn" href="/business/write?menu=${param.menu }&cate=${param.cate }">✍️글쓰기</a>
	</c:if>
	<c:if test="${empty isLogin and not isLogin }">
		<a class="btn" href=""  data-bs-toggle="modal" data-bs-target="#exampleModal">✍️글쓰기</a>
	</c:if>

</div>

<%-- 검색 결과 없음표시 --%>
<c:if test="${empty list }">
<div class="listContainer">
	<div style="text-align: center; font-size: 20px; margin: 125px 0;">
		검색된 내용이 없습니다.
	</div>
</div>
</c:if>

<%-- 검색 결과 --%>
<c:if test="${not empty list }">
<div class="listContainer">
	
	<div class="table-container">
		<table class="listType">
		
		<colgroup>
			<col style="width:5%;">
			<col style="width:45%;">
			<col style="width:10%;">
			<col style="width:10%;">
			<col style="width:10%;">
			<col style="width:15%;">
			<col style="width:5%;">
		</colgroup>
		
		<thead>
			<tr>
				<th style="border-top-left-radius: 8px;">No.</th><th>제목</th><th>가격(30분)</th><th>위치</th><th>작성자</th><th>작성일</th><th style="border-top-right-radius: 8px;">조회</th>
			</tr>
		</thead>
		
		<tbody>
		<c:forEach var="list" items="${list }">
			<tr>
				<td>${list.BOARD_NO }</td>
				<td>
					<div>
				        <c:if test="${ not empty list.THUMBNAIL_NAME  }">
					        <div class="thumbnail">
					        	<a href="/business/view?boardNo=${list.BOARD_NO }&menu=${list.MENU}&cate=${list.CATE}"><img class="preview" src="/upload/${list.THUMBNAIL_NAME}"/></a>
					        </div>
				        </c:if>
				        <c:if test="${ empty list.THUMBNAIL_NAME  }">
					        <div class="thumbnail">
					        	<a href="/business/view?boardNo=${list.BOARD_NO }&menu=${list.MENU}&cate=${list.CATE}"><img class="preview" src="/resources/img/noimg.png"/></a>
					        </div>
				        </c:if>
				        <div class="titlebox">					
							<a href="/business/view?boardNo=${list.BOARD_NO }"><div style="text-align: left;" id="title">${list.TITLE }<span style="color: #ff533f ; font-size: 0.8em;">[${list.cmtCnt }]</span></div></a>
						</div>
					</div>
				</td>
				<td><fmt:formatNumber value="${list.PRICE}" pattern="#,###" />원</td>
				<td><div id="locationBox">${list.LOCATION }</div></td>
				<td><a href="/profile/yourProfile?boardNo=${list.BOARD_NO }" class="link">${list.WRITER_NICK }</a></td>
				<td>
					<fmt:formatDate var="curDate" value="<%=new Date() %>" pattern="yyyyMMdd" />
					<fmt:formatDate var="writeDate" value="${list.WRITE_DATE }" pattern="yyyyMMdd" />
					<c:choose>
						<c:when test="${writeDate lt curDate }">
							<fmt:formatDate value="${list.WRITE_DATE }" pattern="yyyy-MM-dd" />
						</c:when>
						<c:otherwise>
							<fmt:formatDate value="${list.WRITE_DATE }" pattern="HH:mm" />
						</c:otherwise>
					</c:choose>				
				</td>
				<td>${list.HIT}</td>
			</tr>
		</c:forEach>
		</tbody>
		
		</table>
	</div><br>

<small class="float-end" style="margin-right: 8px; margin-top: -10px;">total : ${paging.totalCount }</small>

<br>
</div><!-- .listContainer -->
</c:if>

</div> <!-- .container -->


<c:import url="/WEB-INF/views/layout/paginationSearchList.jsp" />

<!-- FOOTER -->
<c:import url="/WEB-INF/views/layout/footer.jsp" />
