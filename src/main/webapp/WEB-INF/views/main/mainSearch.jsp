<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<style>
/* 검색 */
#mainSearchDiv{
    position: relative;
    vertical-align: top;
/*     margin-top: -46px; */
    margin-left: 781px;
}
/* 검색input */
#mainSearch{
    position: inherit;
    vertical-align: top;
    width: 355px;
    height: 35px;
    border: 1px solid #ccc;
    border-top-left-radius: 5px;
    border-bottom-left-radius: 5px;
}
/* 검색버튼 */
#mainBtnSearch{
    position: absolute;
    vertical-align: top;
    height: 35px;
    width: 52px;
    margin-left: -7px;
    border: 1px solid #ccc;
    border-top-right-radius: 5px;
    border-bottom-right-radius: 5px;
}
/* 검색버튼 focus 없애기 */
#mainSearch:focus, #mainBtnSearch:focus{
	outline: none;
}

.write{
	float: right;
    padding-top: 18px;
}

.preview{
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

.title{
 	width: 150px; 
 	color: black; 
 	font-weight: bold; 
	display: inline-block;
    margin-top: 10px;
    margin-bottom: -12px;
    margin-left: -6px;
}
.titlebox{
	width:420px; 
	height:99px; 
	margin-left:65px;
}
#title{
	width: 100%;
	margin-left: -18px;
    padding: 36px;
  	overflow: hidden;
 	text-overflow: ellipsis; 
 	white-space: nowrap; 
}

#locationBox{
	width: 116px;
  	overflow: hidden;
 	text-overflow: ellipsis; 
 	white-space: nowrap; 
}
#rentText1{
    font-size: 30px;
    color: #343a40;
}
#rentText2{
    vertical-align: text-top;
	font-size: 25px;
	text-align: center;
	display: inline-block;
    color: #343a40;
}
#viewType{
	margin-top: -1px;
    margin-bottom: -2px;
    margin-right: 17px;
    display: inline-block;
}

th{
	background-color: rgb(255,83,64);
}

.listType tr td,
.listType tr th{
	font-weight: normal;
	font-size: 16px;
	text-align: center;
	border-bottom: 1px solid #ccc;
}

.listType tr th{
	color: white;
	font-weight: bold;
	height: 40px;
}

.thumbnail{
	display:inline-block;
	float: left;

}

.table-container{
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
}
.btn{ 
    --bs-btn-line-height: 1.3;
	--bs-btn-color: #fff;
    --bs-btn-bg: #343a40;
    --bs-btn-hover-border-color: unset;    
} 

.pagination{
	margin-bottom: 50px;
    --bs-pagination-active-bg: #ff533f;
    --bs-pagination-color: #373b3e;
	--bs-pagination-active-border-color: #ff533f;  
    --bs-pagination-hover-color: #ff533f;	  
}
#rentText1
,.search-container
,.write{
	display: inline-block;
	vertical-align: middle;
	margin-top: 30px;
	margin-bottom: -25px;
	margin-right: 2px;
}
.listContainer{
	margin-top: 20px;
}
.listContainerEmpty{
	margin-top: 20px;
}
#searchForm{
    width: 450px;
    padding: 20px;
    margin-left: -20px;
    margin-top: 4px;
}
</style>
<script type="text/javascript">
//main.js (또는 원하는 JavaScript 파일)
$(document).ready(function() {
    $(window).scroll(function() {
        if ($(window).scrollTop() + $(window).height() >= $(document).height() - 100) {
            // 페이지 하단에 도달했을 때

            // AJAX 요청을 통해 추가 데이터를 가져오기
            $.ajax({
                url: '/loadMoreData', // 추가 데이터를 제공하는 엔드포인트
                type: 'GET',
                data: {
                    // 페이지 번호나 오프셋과 같은 필요한 파라미터 전달
                },
                success: function(response) {
                    // 응답 데이터를 처리하고 기존 결과에 추가
                    // 받은 데이터를 원하는 방식으로 화면에 추가합니다.
                },
                error: function(xhr) {
                    // 에러 처리
                }
            });
        }
    });
});


</script>


<div id="container" style="margin-left: 12px; margin-top: 20px">

<!-- 검색버튼 -->
<div id="mainSearchDiv">
  <form action="/mainSearch" method="get" id="searchForm">
<!--     <select name="selectSub" id="selectSub" required="required"> -->
<!--     	<option value="rent">대여해요</option> -->
<!--     	<option value="share">나눔해요</option> -->
<!--     	<option value="please">해주세요</option> -->
<!--     </select> -->
	<input type="text" name="searchText" id="mainSearch" placeholder=" 필요한 것을 검색해보세요."
		required oninvalid="this.setCustomValidity('제목을 입력해주세요')" oninput="this.setCustomValidity('')"/>
	<button id="mainBtnSearch">검색</button>
  </form>
</div><!-- #mainSearchDiv -->
<div style="margin-bottom: -29px;"></div>

<!-- 검색결과 -->

<c:if test="${not empty list }">
<div class="listContainer">
	
	<div class="table-container">
		<table class="listType">
		
		<colgroup>
			<col style="width:6%;">
			<col style="width:12%;">
			<col style="width:13%;">
			<col style="width:13%;">
			<col style="width:10%;">
			
			<col style="width:10%;">
			<col style="width:16%;">
			<col style="width:12%;">
			<col style="width:8%;">
		</colgroup>
		
		<thead>
			<tr>
				<th style="border-top-left-radius: 8px;">No.</th>
				<th>제목</th>
				<th>메뉴</th>
				<th>카테고리</th>
				<th>가격(30분)</th>
				
				<th>위치</th>
				<th>작성자</th>
				<th>작성일</th>
				<th style="border-top-right-radius: 8px;">조회수</th>
				
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
					        	<a href="/rent/view?boardNo=${list.BOARD_NO }&menu=${list.MENU}&cate=${list.CATE}"><img class="preview" src="/upload/${list.THUMBNAIL_NAME}"/></a>
					        </div>
				        </c:if>
				        <c:if test="${ empty list.THUMBNAIL_NAME  }">
					        <div class="thumbnail">
					        	<a href="/rent/view?boardNo=${list.BOARD_NO }&menu=${list.MENU}&cate=${list.CATE}"><img class="preview" src="/resources/img/noimg.png"/></a>
					        </div>
				        </c:if>
				        <div class="titlebox">					
							<a href="/rent/view?boardNo=${list.BOARD_NO }&menu=${list.MENU}&cate=${list.CATE}"><div style="text-align: left;" id="title">${list.TITLE }</div></a>
						</div>
					</div>
				</td>
				<td>
				<c:choose>
		            <c:when test="${list.MENU eq 1}">
		                대여해요
		            </c:when>
		            <c:when test="${list.MENU eq 2}">
		                나눔해요
		            </c:when>
		            <c:when test="${list.MENU eq 3}">
		                해주세요
		            </c:when>
		        </c:choose>
		        </td>
				<td>
				<c:choose>
		            <c:when test="${list.CATE eq 1}">
		                물품
		            </c:when>
		            <c:when test="${list.CATE eq 2}">
		                인력
		            </c:when>
		            <c:when test="${list.CATE eq 3}">
		                공간
		            </c:when>
		        </c:choose>
				</td>
				<c:if test="${list.PRICE != 0 }">
					<td><fmt:formatNumber value="${list.PRICE}" pattern="#,###" />원</td>
				</c:if>
				<c:if test="${list.PRICE eq 0 }">
					<td>나눔♥️</td>
				</c:if>
				<td><div id="locationBox">${list.LOCATION }</div></td>
				<td>${list.WRITER_NICK }</td>
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


<br>

<small class="float-end" style="margin-right: 8px; margin-top: -30px;">total : ${paging.totalCount }</small>
</div><!-- .listContainer -->
<c:import url="/WEB-INF/views/layout/paginationMainSearch.jsp" />

</c:if>

<c:if test="${empty list}">
<div class="listContainerEmpty">
<div style="text-align: center; font-size: 20px; font-weight: bold; margin: 125px 0px;">검색결과가 없습니다.</div>
</div><!-- .listContainerEmpty -->
</c:if>

</div><!-- #container -->

<!-- <div style="clear: both; margin-bottom: 50px;"></div> -->

<c:import url="/WEB-INF/views/layout/footer.jsp" />