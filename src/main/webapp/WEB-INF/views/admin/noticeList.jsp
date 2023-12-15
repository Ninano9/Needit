<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<style>
#noticeTop{
    background: #ff533f;
    color: white;
    border-radius: 10px 10px 0 0;
    font-size: 2.8em;
    padding: 5px;
    text-align: center;
    margin-bottom: 10px;
}
#noticeDiv {
    margin-top: 18px;
}
.first-notice #noticeFloat {
    margin-top: 4px;
}
#noticeDiv + #noticeDiv {
    border-top: 1px solid black;
}
#noticeFloat{
	float: left;
	position: relative;
	width: 50px;
	height: 22px;
	height: 22px;
	border: 1px solid red;
	font-size: 15px;
	background-color: pink;
	color: red;
	border-radius: 5px;
	text-align: center;
	vertical-align: middle;
	margin-top: 19px;
	margin-right: 4px;
}
#noticeTitleContent{
	width: 1100px;
	margin-top: 15px;
}
#noticeTitle{
	display: block;
	height: 100%;
	font-size: 20px;
	font-weight: bold;
	overflow: hidden;
    margin-bottom: 5px;
}
#noticeContent{
	display: block;
	height: 100%;
	font-size: 16px;
    margin-left: 54px;
}
#noticeDate{
	display: inline-block;
	float: right;
	position: relative;
	margin-top: -24px;
	margin-right: 10px;
}


</style>

<div style="margin-top: 5%;"></div>

<!-- 공지사항 -->
<div id="noticeTop">Notice</div>
<c:forEach var="list" items="${noticeList }" varStatus="loop">
	<div id="noticeDiv" class="${loop.first ? 'first-notice' : ''}">
		<div id="noticeFloat">공지</div>
	<div id="noticeTitleContent">
		<span id="noticeTitle">${list.title }</span>
		<span id="noticeContent">${list.content }</span>
	</div><!-- #noticeTitleContent -->
		<div id="noticeDate"><fmt:formatDate value="${list.writeDate }" pattern="yyyy-MM-dd"/></div>
	</div><!-- #noticeDiv -->
</c:forEach>




<c:import url="/WEB-INF/views/layout/footer.jsp" />