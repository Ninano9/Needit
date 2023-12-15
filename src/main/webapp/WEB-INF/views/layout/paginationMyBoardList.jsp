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