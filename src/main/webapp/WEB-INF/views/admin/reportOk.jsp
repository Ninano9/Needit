<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
/* 신고접수 완료 바깥 div */
#reportOkDiv{
	margin: 0 auto;
	border: 3px solid rgb(255,83,63);
	width: 413px;
	height: 305px;
	border-radius: 5px; 
}
/* 신고접수 아이콘 */
#reportkOkImg{
	width: 160px;
    height: 160px;
    display: inline-block;
    margin-left: 116px;
    margin-top: 36px;
    margin-bottom: 43px;
}
/* 신고접수 텍스트 */
#reportOkContent{
	text-align: center;
	font-weight: bold;
	font-size: 18px;
}
</style>

</head>
<body>

<div id="reportOkDiv">
	<img id="reportkOkImg" alt="신고접수" src="/resources/img/reportOk.png"><br>
	<div id="reportOkContent">신고가 정상적으로 처리되었습니다.</div>
</div>

</body>
</html>