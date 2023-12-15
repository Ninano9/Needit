<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
.rentTable td{
	text-align: center;
}
/* Webkit 브라우저를 위한 스타일 */
.tableScroll::-webkit-scrollbar { width: 12px; }
.tableScroll::-webkit-scrollbar-track { background: #f1f1f1; border-radius: 10px; }
.tableScroll::-webkit-scrollbar-thumb { background-color: transparent; border-radius: 10px;background: #ff533f; }
</style>

<table class="listType rentTable">
      <tr>
         <th>No.</th>
         <th class="title">제목</th>
         <th>게시판</th>
         <th>작성일</th>
         <th>조회수</th>
      </tr>
      <c:forEach items="${board }" var="board">
         <tr>
            <td>${board.boardNo }</td>
            <td style="text-align: left;">
	    <c:choose>
	        <c:when test="${board.menu eq 1}">
	            <a href="/rent/view?boardNo=${board.boardNo}" class="board-link">${board.title}</a>
	        </c:when>
	        <c:when test="${board.menu eq 2}">
	            <a href="/share/view?boardNo=${board.boardNo}" class="board-link">${board.title}</a>
	        </c:when>
	        <c:when test="${board.menu eq 3}">
	            <a href="/please/view?boardNo=${board.boardNo}" class="board-link">${board.title}</a>
	        </c:when>
	        <c:when test="${board.menu eq 4}">
	            <a href="/community/view?boardNo=${board.boardNo}" class="board-link">${board.title}</a>
	        </c:when>
	        <c:when test="${board.menu eq 5}">
	            <a href="/business/view?boardNo=${board.boardNo}" class="board-link">${board.title}</a>
	        </c:when>
	    </c:choose>
	</td>
            <td>
            		<c:choose>
	        <c:when test="${board.menu eq 1}">
	            대여해요
	        </c:when>
	        <c:when test="${board.menu eq 2}">
	            나눔해요
	        </c:when>
	        <c:when test="${board.menu eq 3}">
	            해주세요
	        </c:when>
	        <c:when test="${board.menu eq 4}">
	            커뮤니티
	        </c:when>
	        <c:when test="${board.menu eq 5}">
	            동네업체
	        </c:when>
	    </c:choose>
            </td>
            <td>
               <fmt:formatDate var="curDate" value="<%=new Date() %>" pattern="yyyyMMdd" />
               <fmt:formatDate var="writeDate" value="${board.writeDate }" pattern="yyyyMMdd" />
               <c:choose>
                  <c:when test="${writeDate lt curDate }">
                     <fmt:formatDate value="${board.writeDate }" pattern="yyyy-MM-dd" />
                  </c:when>
                  <c:otherwise>
                     <fmt:formatDate value="${board.writeDate }" pattern="HH:mm" />
                  </c:otherwise>
               </c:choose>
            </td>
            <td>${board.hit}</td>
         </tr>
      </c:forEach>
</table><!-- .listType -->

