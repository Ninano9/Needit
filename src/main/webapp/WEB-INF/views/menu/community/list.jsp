<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- HEADER -->
<c:import url="/WEB-INF/views/layout/header.jsp" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<script type="text/javascript">
$(()=>{
	
    <%-- 검색버튼 CSS적용 --%>
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
	
     var $menu = ${param.menu};
     var $cate = ${param.cate};
     
     // "location" 옵션의 DOM 요소를 가져옴
     var locationOption = $('option[value="location"]');
     
     if ($menu == 4 && $cate == 2) {
         // Enable the "location" option
         locationOption.css('display', 'block');
     } else {
         // Disable the "location" option
         locationOption.css('display', 'none');
     }
        
});
</script>

<style type="text/css">

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
	margin-left:65px;
}
#title {
	width: 100%;
	margin-left: -18px;
  	overflow: hidden;
 	text-overflow: ellipsis; 
 	white-space: nowrap; 
}
#locationBox {
	width: 240px;
  	overflow: hidden;
 	text-overflow: ellipsis; 
 	white-space: nowrap; 
}
#communityText1 {
    font-size: 30px;
    color: #343a40;
}
#communityText2 {
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

th { background-color: rgb(255,83,64); }

tr { height: 40px; }

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
#communityText1 {
    font-size: 30px;
    color: #343a40;
}
#communityText2 {
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
#communityText1
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

.link {
   cursor: pointer; /* 커서 모양 변경 */
}
.link:hover {
   color: orange; /* 마우스 오버 시 텍스트 색상 변경 */
}
</style>

<div class="container">

<c:forEach  var="list" items="${list }" begin="0" end="0">
	<c:if test="${list.MENU eq 4 && list.CATE eq 1 }">
		<div id="communityText1"> 커뮤니티 
			<div id="communityText2">[공지사항]</div>
		</div>
	</c:if>
	<c:if test="${list.MENU eq 4 && list.CATE eq 2 }">
		<div id="communityText1"> 커뮤니티
			<div id="communityText2">[우리동네 소식]</div>
		</div>
	</c:if>
	<c:if test="${list.MENU eq 4 && list.CATE eq 3 }">
		<div id="communityText1"> 커뮤니티
			<div id="communityText2">[자유 게시판]</div>
		</div>
	</c:if>
	<c:if test="${list.MENU eq 4 && list.CATE eq 4 }">
		<div id="communityText1"> 커뮤니티
			<div id="communityText2">[팁 게시판]</div>
		</div>
	</c:if>
</c:forEach>

<!--게시글 검색-->
<div class="search-container">
	<form id="searchForm"  action="/community/search" method="get">
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

	<c:if test="${not empty isLogin and isLogin }">
		<a class="btn" href="/community/write?menu=${param.menu }&cate=${param.cate }">✍️글쓰기</a>
	</c:if>
	<c:if test="${empty isLogin and not isLogin }">
		<a class="btn" href=""  data-bs-toggle="modal" data-bs-target="#exampleModal">✍️글쓰기</a>
	</c:if>

</div>

<div class="listContainer">
	<c:choose>
	
	<c:when test="${param.menu == 4 && param.cate == 2 }">
	<div class="table-container">
		<table class="listType" style="width: 100%;}">
		
		<colgroup>
			<col style="width:5%;">
			<col style="width:37%;">
			<col style="width:25%;">
			<col style="width:20%;">
			<col style="width:8%;">
			<col style="width:5%;">
		</colgroup>
		
		<thead>
			<tr>
				<th style="border-top-left-radius: 8px;">No.</th><th>제목</th><th>위치</th><th>작성자</th><th>작성일</th><th style="border-top-right-radius: 8px;">조회</th>
			</tr>
		</thead>
		
		<tbody>
		<c:forEach var="list" items="${list }">
			<tr>
				<td>${list.BOARD_NO }</td>
				<td>
			        <div class="titlebox">					
						<a href="/community/view?boardNo=${list.BOARD_NO }&menu=${list.MENU}&cate=${list.CATE}"><div style="text-align: left;" id="title">${list.TITLE } <span style="color: #ff533f ; font-size: 0.8em;">[${list.cmtCnt }]</span></div></a>
					</div>
				</td>
				<td><div id="locationBox" style="width: 100%;">${list.LOCATION }</div></td>
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
	</c:when>
	
		<c:otherwise>
	<div class="table-container">
		<table class="listType">
		<colgroup width="100px">
			<col style="width:5%;">
			<col style="width:45%;">
			<col style="width:20%;">
			<col style="width:25%;">
			<col style="width:5%;">
		</colgroup>
		
		<thead>
			<tr>
				<th style="border-top-left-radius: 8px;">No.</th><th>제목</th><th>작성자</th><th>작성일</th><th style="border-top-right-radius: 8px;">조회</th>
			</tr>
		</thead>
		
		<tbody>
		<c:forEach var="list" items="${list }">
			<tr>
				<td>${list.BOARD_NO }</td>
				<td>
					<div>
				        <div class="titlebox">					
							<a href="/community/view?boardNo=${list.BOARD_NO }&menu=${list.MENU}&cate=${list.CATE}"><div style="text-align: left;" id="title">${list.TITLE } <span style="color: #ff533f ; font-size: 0.8em;">[${list.cmtCnt }]</span></div></a>
						</div>
					</div>
				</td>
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
	</div><br><!-- .tableContainer  -->
	</c:otherwise>
	
	</c:choose>

<small class="float-end" style="margin-right: 8px; margin-top: -10px;">total : ${paging.totalCount }</small>

<br>
</div><!-- .listContainer -->

</div> <!-- .container -->


<c:import url="/WEB-INF/views/layout/paginationComu.jsp" />

<!-- FOOTER -->
<c:import url="/WEB-INF/views/layout/footer.jsp" />
