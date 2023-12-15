<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
.pagination {
    --bs-pagination-active-bg: #ff533f;
    --bs-pagination-color: #373b3e;
	--bs-pagination-active-border-color: #ff533f;  
    --bs-pagination-hover-color: #ff533f;	  
}
</style>

<script>
// 페이지 로드 시 첫 번째 페이지 데이터 로드
$(document).ready(function() {
	// 페이지 로드 시 첫 번째 페이지 데이터 로드
	goToPage(1);
});

function loadPage(pageNumber) {
    $.ajax({
        type: "GET",
        url: "./view?curPage=" + pageNumber, // 실제로 사용하는 URL로 변경
        data: { 
        	
        	curPage: pageNumber 
        	
        },
        dataType: "html",
        success: function(data) {
        	console.log("내가쓴글 AJAX 성공")
            $("#myBoardList").html(data); // 서버에서 받은 HTML을 테이블 컨테이너에 삽입
        },
        error: function() {
             console.log("내가쓴글 AJAX 실패")
        }
    });
}

// 페이지 이동 함수
function goToPage(pageNumber) {
	// 페이지 이동 함수
    loadPage(pageNumber);
}
</script>



<div>
	<ul class="pagination pagination-sm justify-content-center">
	
		<%-- 첫 페이지로 이동 --%>
		<c:if test="${paging.curPage ne 1 }">
		<li class="page-item">
			  <a class="page-link" href="./view">&larr; 처음</a>
		</li>
		</c:if>
		
		<%-- 이전 페이지 리스트로 이동 --%>
		<c:choose>
			<c:when test="${paging.startPage ne 1 }">
			<li class="page-item">
				<a class="page-link" href="./view?curPage=${paging.startPage - paging.pageCount }">&laquo;</a>
			</li>
			</c:when>
			<c:when test="${paging.startPage ne 1 }">
			<li class="page-item">
				<a class="page-link disabled" >&laquo;</a>
			</li>
			</c:when>
		</c:choose>
		
		<%-- 이전 페이지로 이동 --%> 
		<c:if test="${paging.curPage > 1 }">
			<li class="page-item">
				<a class="page-link" href="./view?curPage=${paging.curPage -1 }">&lt;</a>
			</li>
		</c:if>
		
		
		<%-- 페이징 번호 목록 --%>
		<c:forEach var="i" begin="${paging.startPage }" end="${paging.endPage }">
			<c:if test="${paging.curPage eq i }">
			<li class="page-item">
				<a class="page-link active" href="./view?curPage=${i }">${i }</a>
			</li>
			</c:if>

			<c:if test="${paging.curPage ne i }">
			<li class="page-item">
				<a class="page-link" href="./view?curPage=${i }">${i }</a>
			</li>
			</c:if>
		</c:forEach>
		
		<%-- 다음 페이지로 이동 --%>
		<c:if test="${paging.curPage < paging.totalPage }">
		   <li class="page-item">
		      <a class="page-link" href="./view?curPage=${paging.curPage + 1 }">&gt;</a>
		   </li>
		</c:if>
      
		<%-- 다음 페이지 리스트로 이동 --%>
		<c:choose>
		   <c:when test="${paging.endPage ne paging.totalPage }">
		   <li class="page-item">
		      <a class="page-link" href="./view?curPage=${paging.endPage + paging.pageCount }">&raquo;</a>
		   </li>
		   </c:when>
		   <c:when test="${paging.endPage eq paging.totalPage }">
		   <li class="page-item">
		      <a class="page-link disabled">&raquo;</a>
		   </li>
		   </c:when>
		</c:choose>
		
		<%-- 끝 페이지로 이동 --%>
		<c:if test="${paging.curPage ne paging.totalPage }">
		<li class="page-item">
			<a class="page-link" href="./view?curPage=${paging.totalPage }">&rarr; 끝으로</a>
		</li>
		</c:if>
	</ul>
	
</div>