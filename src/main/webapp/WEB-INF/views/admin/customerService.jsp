<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<style type="text/css">

/* customerServie div */
#customerServie-button-div{
	text-align: center;
 	margin: 60px auto 5% auto; 
}
/* customerServie div button */
#customerServie-button{
	margin-bottom: 3px;
	width: 32%;
	height: 80px;
	padding: 12px;
	font-size: 30px;
	border-radius: 10px;
	border: 4px solid rgb(255,83,63);
	background-color: white;
	color: rgb(255,83,63);
}

.floating{
	display: none;
}

</style>


<div id="customerServie-button-div">
<a href="/admin/noticeList"><button id="customerServie-button">⭐NOTICE.공지사항</button></a><br><br>
<!-- <a href="/admin/faq"><button id="customerServie-button">❔FAQ.자주 묻는 질문</button></a><br><br> -->
<a href="/admin/chat"><button id="customerServie-button">🎧1대1 채팅문의</button></a>
</div>


<c:import url="/WEB-INF/views/layout/footer.jsp" />