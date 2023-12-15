<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style type="text/css">
/* footer 이용약관들 밑줄제거 글씨 까만색 */
#footer-text{
	text-decoration: none;
	color: black;
	font-size: 13px;
	text-align: center;
}
/* footer 1:1문의 버튼 */
#footer-report-button{
    float: left;
    font-size: 15px;
    vertical-align: middle;
    text-align: center;
    display: inline-block;
    position: absolute;
	margin-top: -103px;
    margin-left: 89px;
	width: 80px;
	height: 30px;
	border-radius: 5px;
	background-color: rgb(255,83,63);
	border: 0;
	color: white;
}
#footer-report-button1{
    float: left;
    font-size: 15px;
    vertical-align: middle;
    text-align: center;
    display: inline-block;
    position: absolute;
    margin-top: 2px;
    margin-left: -3px;
    width: 240px;
    height: 30px;
    border-radius: 5px;
    background-color: rgb(255,83,63);
    border: 0;
    color: white;
}

/* 플로팅 버튼 */
.policy-floating-button{
    background-color:white;
    color: black;
    border: 0;
    margin: 0;
    width: 45px;
    height: 45px;
    border-radius: 20px;
    cursor: pointer;
    border: 1px solid #ccc;
    box-shadow: 2px 2px 2px #ccc;
}

#FloatMain{
	margin: 5px 0px;
	font-size: 13px;
}

.footerFloating {
    position: fixed;
    bottom: 20px;
    right: 12px;
}

/* 신고 확인 버튼 */
#footerReportOkBtn{
	background-color: rgb(255,83,63);
    color: white;
    margin-top: 3px;
    margin-right: 202px;
}
</style>

<script type="text/javascript">
function topFunction() {
    window.scrollTo({
        top: 0,
        behavior: "smooth"
    });
}

function downFunction() {
    window.scrollTo({
        top: 20000,
        behavior: "smooth"
    });
}
</script>

<!-- 플로팅 버튼 -->
<div class="footerFloating">
<button onclick="topFunction()" class="policy-floating-button" id="scrollTop">
<!-- svg 사진 url -->
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-up" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M7.646 4.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1-.708.708L8 5.707l-5.646 5.647a.5.5 0 0 1-.708-.708l6-6z"/>
</svg>
</button><br>
<c:if test="${isLogin and (id eq admin)  }">
	<a href="/admin"><button class="policy-floating-button" id="FloatMain">FAQ</button></a><br>
</c:if>
<c:if test="${not isLogin }">
	<button class="policy-floating-button" id="FloatMain" data-bs-toggle="modal" data-bs-target="#exampleModal">FAQ</button><br>
</c:if>
<c:if test="${isLogin and (id ne admin) }">
	<a href="/message/list?boardNo=-1&menu=0&cate=0&receiverId=admin"><button class="policy-floating-button" id="FloatMain">FAQ</button></a><br>
</c:if>
<button onclick="downFunction()" class="policy-floating-button" id="scrollDown">
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-down" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z"/>
</svg>
</button>
</div><!-- .floating -->


<div style="margin-top: 20px;"></div>
<!-- <div style="margin-left: 15%; margin-right: 15%;"> -->

<div id="fooeterStart">
<hr style="margin-bottom: 1em;">

<span style="font-size: 20px; margin-left: 40px; font-size: 24px;"><strong>고객센터 1200-1342</strong></span>

<span style="margin-left: 73px;">
<span style=" margin-right: 90px;"><a href="/opening" id="footer-text">소개 페이지</a></span>
<span style=" margin-right: 90px;"><a href="/terms/term" id="footer-text">이용 약관</a></span>
<span style=" margin-right: 90px;"><a href="/terms/privacyPolicy" id="footer-text">개인정보처리방침</a></span>
<span style=" margin-right: 90px;"><a href="/terms/locationPolicy" id="footer-text">위치기반서비스 이용약관</a></span>

<span><a href="/admin/noticeList" id="footer-text">공지사항</a></span><br>
</span>
<div style="margin-bottom: 7px;"></div>

<div style="margin-left: 40px; display: inline-block;">
<div style="font-size: 20px; margin-bottom: 5px; font-size: 25px;">상담 시간</div>
<c:if test="${isLogin and (id eq admin)  }">
	<div style="clear: both;"><form action="/admin" method="get"><button id="footer-report-button1">1:1 문의</button></form></div>
</c:if>
<c:if test="${not isLogin }">
	<div style="clear: both;"><button id="footer-report-button1" data-bs-toggle="modal" data-bs-target="#exampleModal">1:1 문의</button></div>
</c:if>
<c:if test="${isLogin and (id ne admin) }">
	<div style="clear: both;"><form action="/admin/chat" method="get"><button id="footer-report-button1">1:1 문의</button></form></div>
</c:if>
</div>
<div style="display: inline-block; font-size: 12px; margin-left: 12px;">
	<div>평일 09:00 - 18:00</div>
	<div>주말, 공휴일 휴무</div>
</div>
<%-- <c:if test="${not empty isLogin }"> --%>
	<span style="float: right; font-size: 10px; color: #575757; margin-top: 61px; margin-right: 40px;">Copyright ⓒNeedit</span>
<%-- </c:if> --%>
<%-- <c:if test="${empty isLogin }"> --%>
<!-- 	<span style="float: right; font-size: 10px; color: #ccc; margin-top: -75px; margin-right: 42px;">Copyright ⓒNeedit</span> -->
<%-- </c:if> --%>
</div><!-- #fooeterStart -->
<div style="margin-bottom: 110px;"></div>

</div><!-- .wrap -->

<!-- 모달 -->
<div class="modal fade" id="reportModal" aria-hidden="true" aria-labelledby="reportModalLabel" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="reportModalLabel">신고하기</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
		<%@ include file="/WEB-INF/views/admin/report.jsp" %>
	  </div>
    </div>
  </div>
</div>
<div class="modal fade" id=reportOkModal aria-hidden="true" aria-labelledby="reportOkModalLabel" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
		<%@ include file="/WEB-INF/views/admin/reportOk.jsp" %>
		<button id="footerReportOkBtn" type="button" class="btn float-end" data-bs-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>

<!-- 다른사람 마이페이지 모달 -->
<div class="modal fade" id="profileModal" tabindex="-1" aria-labelledby="profileModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="profileModalLabel">${nick}의마이페이지</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">그만보기</button>
      </div>
    </div>
  </div>
</div>

</body>
</html>