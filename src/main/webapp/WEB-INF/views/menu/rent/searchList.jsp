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
	
	
	$(".star").click(function(){
		console.log("찜 클릭됨!");
        var starImg = $("#star" + boardNo + "+" + menu + "+" + cate);
        console.log(starImg);
         var id = this.id;
         var boardNoMenuCate = id.replace('star', '');
         var parts = boardNoMenuCate.split('+');
         var boardNo = parts[0];
         console.log(boardNo)
         var menu = parts[1];
         console.log(menu)
         var cate = parts[2];
         console.log(cate)
         
         $.ajax({
              type: "post"
              , url: "/rent/basket"
              , data: {
					boardNo : boardNo
					, menu : menu
					, cate : cate
              }
              , dataType: "json"
              , success: function( res ) {
                 console.log("AJAX 성공")
                 console.log(res)
                 console.log(res.check)
              if( res.check == 'true' ) {
                 $(".a").css("display", "block")
                 $(".b").css("display", "none")
                 location.reload()
                 
              } else {
                 $(".b").css("display", "block")
                 $(".a").css("display", "none")
                 location.reload()
              }
              }
              , error: function() {
                 console.log("AJAX 실패")

              }
              
              
           })
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
.row {
    text-align: center;
}

.write-container {
    height: 507px;
    width: 380px;
    margin: 1em auto; 
    text-align: center; 
    border-radius: 15px;
    overflow: hidden;
    border: 1px solid #343a4070;
}

.write-container:hover {
    box-shadow: 5px 5px 5px gray;
    transform: scale( 1.03 );
    transition: all 0.15s ease-in;
}
 
.col-md-4 {
    margin-right: 30px;
}

.preview {
	margin: 15px auto 15px auto;
 	width: 350px;
 	height: 300px;
	display: flex;
	object-fit: cover;
    justify-content: center;
	align-items: center;
    background-size: cover; 
    background-repeat: no-repeat;
	background-position: center center;
}

.write-container-head {
	width: 380px;
	margin: 0 auto;
}

.no {
    font-size: 15px;
    display: inline-block;
    float: left;
    position: absolute;
    margin-left: -70px;
    margin-top: 14px;
}

.title {
	font-size: 18px;
 	width: 245px; 
	color: rgb(255,83,63);
 	font-weight: bold; 
 	overflow: hidden; 
 	text-overflow: ellipsis; 
 	white-space: nowrap; 
	display: inline-block;
    margin-top: 10px;
    margin-bottom: -12px;
    margin-left: -15px;
}
#write-conatiner-hit
,#write-conatiner-like {
	display: inline-block;
	float: right;
	position: absolute;
	font-size: 14px;
}
#write-conatiner-hit {
    margin-top: 23px;
}
#write-conatiner-like {
	margin-top: 4px;
}
#write-conatiner-nick {
    float: left;
    position: relative;
    font-size: 18px;
    margin-top: -8px;
    margin-left: 4px;
}
#write-conatiner-time {
    float: left;
    position: absolute;
    font-size: 18px;
    margin-top: 20px;
    margin-left: 4px;
}
#write-conatiner-price {
	float: right;
    margin-top: -5px;
    margin-bottom: 19px;
    margin-right: 6px;
    font-size: 30px;
    text-align: center;
}
#write-conatiner-loc {
	width: 353px;
    font-size: 19px;
   	overflow: hidden; 
 	text-overflow: ellipsis; 
 	white-space: nowrap;
}
#nickIcon{
	float: none;
	display: inline-block;
}
#rentListHr:hover {
	color: rgb(255,83,63);
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
	vertical-align:top;
	font-style: italic;
	font-size: 13px;
	margin: 2px;
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

#searchForm {
    width: 450px;
    padding: 20px;
    margin-left: -20px;
    margin-top: 4px;
}

.heart {
   float: right;
    position: absolute;
    display: inline-block;
    margin-top: 333px;
    margin-left: 135px;
   
}
.star {
   width: 30px;
   height: 30px;
   margin-left: 106px;
   margin-bottom: 8px;
   cursor: pointer;
}
</style>

<div class="container">

<%-- 검색전 메뉴표시 --%>
<c:forEach  var="list" items="${list }" begin="0" end="0">
	<c:if test="${list.MENU eq '1' && list.CATE eq '1' }">
		<div id="rentText1"> 대여해요 
			<div id="rentText2">[물품]</div>
		</div>
	</c:if>
	<c:if test="${list.MENU eq '1' && list.CATE eq '2' }">
		<div id="rentText1"> 대여해요
			<div id="rentText2">[인력]</div>
		</div>
	</c:if>
	<c:if test="${list.MENU eq '1' && list.CATE eq '3' }">
		<div id="rentText1"> 대여해요
			<div id="rentText2">[공간]</div>
		</div>
	</c:if>
</c:forEach>

<%-- 검색후 메뉴표시 --%>
<c:if test="${empty list }">
	<c:if test="${param.menu eq '1' && param.cate eq '1' }">
		<div id="rentText1"> 대여해요 
			<div id="rentText2">[물품]</div>
		</div>
	</c:if>
	<c:if test="${param.menu eq '1' && param.cate eq '2' }">
		<div id="rentText1"> 대여해요
			<div id="rentText2">[인력]</div>
		</div>
	</c:if>
	<c:if test="${param.menu eq '1' && param.cate eq '3' }">
		<div id="rentText1"> 대여해요
			<div id="rentText2">[공간]</div>
		</div>
	</c:if>
</c:if>

<%-- 게시글 검색 --%>
<div class="search-container">
	<form id="searchForm" action="/rent/search" method="get">
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
		<a type="button" href="/rent/search?selectSub=${param.selectSub}&searchText=${param.searchText}&menu=${param.menu}&cate=${param.cate}"><img src="/resources/img/girdtype.png" style="width: 40px; height: 40px;"></a>
		<a type="button" href="/rent/searchType?selectSub=${param.selectSub}&searchText=${param.searchText}&menu=${param.menu}&cate=${param.cate}"><img src="/resources/img/listtype2.png" style="width: 32px; height: 40px;"></a>
	</div>

	<c:if test="${not empty isLogin and isLogin }">
		<a class="btn" href="/rent/write?menu=${param.menu }&cate=${param.cate }">✍️글쓰기</a>
	</c:if>
	<c:if test="${empty isLogin and not isLogin }">
		<a class="btn" href=""  data-bs-toggle="modal" data-bs-target="#exampleModal">✍️글쓰기</a>
	</c:if>

</div>

<%-- 검색 결과 없음표시 --%>
<c:if test="${empty list }">
<div class="gridContainer">
	<div style="text-align: center; font-size: 20px; margin: 125px 0;">
		검색된 내용이 없습니다.
	</div>
</div>
</c:if>

<%-- 검색 결과 --%>
<c:if test="${not empty list }">
<div class="gridContainer">

<c:forEach items="${list}" var="list" varStatus="loop">
  <c:if test="${loop.index % 3 == 0}">
  <div class="row">
  </c:if>
  	
    <div class="write-container">
 		<div class="write-container-head">
<%-- 	        <div class="no">no.${list.BOARD_NO}</div> --%>
	        <c:if test="${list.BASKET_STATUS eq 1}">
                <span class="heart"><img class="star a" id="star${list.BOARD_NO}+${list.MENU}+${list.CATE}"src="/resources/img/star.png"></span>
            </c:if>
            <c:if test="${list.BASKET_STATUS eq 0}">
                <span class="heart"><img class="star b" id="star${list.BOARD_NO}+${list.MENU}+${list.CATE}"src="/resources/img/emptyStar.png"></span>
            </c:if>
	        
	        <div class="no">Title.</div>
	        <a href="/rent/view?boardNo=${list.BOARD_NO }&menu=${list.MENU}&cate=${list.CATE}"><div class="title">${list.TITLE }<span style="color: black; font-size: 0.8em;">[${list.cmtCnt}]</span></div></a>
        <div id="write-conatiner-like">❤️  ${list.LIKE_CNT }</div>
        <div id="write-conatiner-hit">👀  ${list.HIT}</div>
        </div><!-- .write-container-head -->
        <hr id="rentListHr">
        <c:if test="${ not empty list.THUMBNAIL_NAME  }">
	        <div>
	        	<a href="/rent/view?boardNo=${list.BOARD_NO }&menu=${list.MENU}&cate=${list.CATE}"><img class="preview" src="/upload/${list.THUMBNAIL_NAME}"/></a>
	        </div>
        </c:if>
        <c:if test="${ empty list.THUMBNAIL_NAME  }">
	        <div>
	        	<a href="/rent/view?boardNo=${list.BOARD_NO }&menu=${list.MENU}&cate=${list.CATE}"><img class="preview" src="/resources/img/noimg.png"/></a>
	        </div>
        </c:if>
        <hr id="rentListHr">
        <div id="write-conatiner-nick"><div id="nickIcon">✍️</div><a href="/profile/yourProfile?boardNo=${list.BOARD_NO }" class="link">${list.WRITER_NICK }</a></div>
        <div id="write-conatiner-time">🕟
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
        </div><!-- #write-conatiner-time -->
        <div id="write-conatiner-price">💸<fmt:formatNumber value="${list.PRICE}" pattern="#,###" />원</div>
        
        <div id="write-conatiner-loc" ><i style="color: rgb(255,83,63)" class="bi bi-geo-alt-fill"></i>${list.LOCATION } </div>
    </div><!-- .write-container -->
    
  <c:if test="${loop.index % 3 == 2 || loop.index + 1 == yourList.size()}">
  </div>
  </c:if>
</c:forEach>

<small class="float-end" style="margin-right: 8px; margin-top: -10px;">total : ${paging.totalCount }</small>

</div><!-- .gridContainer -->
</c:if>

</div> <!-- .container -->
<br>

<c:import url="/WEB-INF/views/layout/paginationSearch.jsp" />

<!-- FOOTER -->
<c:import url="/WEB-INF/views/layout/footer.jsp" />
