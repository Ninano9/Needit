<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div>
	<ul class="pagination pagination-sm justify-content-center">
	
		<%-- 첫 페이지로 이동 --%>
		<c:if test="${paging.curPage ne 1 }">
		<li class="page-item">
			<a class="page-link" href="./list?menu=${param.menu }&cate=${param.cate}">&larr; 처음</a>
		</li>
		</c:if>
		
		<%-- 이전 페이지 리스트로 이동 --%>
		<c:choose>
			<c:when test="${paging.startPage ne 1 }">
			<li class="page-item">
				<a class="page-link" href="./list?curPage=${paging.startPage - paging.pageCount }&menu=${param.menu }&cate=${param.cate}">&laquo;</a>
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
				<a class="page-link" href="./list?curPage=${paging.curPage -1 }&menu=${param.menu }&cate=${param.cate}">&lt;</a>
			</li>
		</c:if>
		
		
		<%-- 페이징 번호 목록 --%>
		<c:forEach var="i" begin="${paging.startPage }" end="${paging.endPage }">
			<c:if test="${paging.curPage eq i }">
			<li class="page-item">
				<a class="page-link active" href="./list?curPage=${i }&menu=${param.menu }&cate=${param.cate}">${i }</a>
			</li>
			</c:if>

			<c:if test="${paging.curPage ne i }">
			<li class="page-item">
				<a class="page-link" href="./list?curPage=${i }&menu=${param.menu }&cate=${param.cate}">${i }</a>
			</li>
			</c:if>
		</c:forEach>
		
		<%-- 다음 페이지로 이동 --%>
		<c:if test="${paging.curPage < paging.totalPage }">
		   <li class="page-item">
		      <a class="page-link" href="./list?curPage=${paging.curPage + 1 }&menu=${param.menu }&cate=${param.cate}">&gt;</a>
		   </li>
		</c:if>
      
		<%-- 다음 페이지 리스트로 이동 --%>
		<c:choose>
		   <c:when test="${paging.endPage ne paging.totalPage }">
		   <li class="page-item">
		      <a class="page-link" href="./list?curPage=${paging.endPage + paging.pageCount }&menu=${param.menu }&cate=${param.cate}">&raquo;</a>
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
			<a class="page-link" href="./list?curPage=${paging.totalPage }&menu=${param.menu }&cate=${param.cate}">&rarr; 끝으로</a>
		</li>
		</c:if>
	</ul>
	
</div>