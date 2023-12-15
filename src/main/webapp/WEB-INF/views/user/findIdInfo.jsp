<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
	<title>아이디 찾기</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.7.1.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>


<script type="text/javascript">

</script>
<style type="text/css">
html {
 	background-size : cover; 
	background-image: url('../resources/img/3.jpg') ;  
}
.card {
     width: 450px; 
     padding: 20px;
     transform: translate(-50%,-50%)
  
}
#needit{
	color: white; 
	background-color: #ff533f;
	border-color: #ff533f;
}
.login_warn{
    margin-top: 30px;
    text-align: center;
    color : red;
}
.logo{
    position: absolute;
    top: -45px;
    left: 80px;
    transform: translate(-50%,-365%);
    z-index: 6;
}
.find{
	text-align: center;
	font-weight: bold;
}
.code{
	position: absolute;
    right: 0px;
    top: 12px;
}

.slide-out {
  transform: translate(-400%,-50%);
  transition: transform 1s ease-out;
}

</style>
</head>
<body>


<img class="logo top-50 start-50" src="/resources/img/needit01.png" width="300" height="60" >
<div class="card shadow-lg position-absolute top-50 start-50">

 <h2>아이디 찾기 결과</h2>

    <c:if test="${empty ids}">
        <p>일치하는 아이디가 없습니다.</p>
    </c:if>

    <c:if test="${not empty ids}">
        <p>일치하는 아이디가 여러 개 있습니다:</p>
        <ul>
            <c:forEach var="id" items="${ids}">
                <li>${id}</li>
            </c:forEach>
        </ul>
    </c:if>
    <div class="row justify-content-center">
    <a href="/main" id="needit"class="col-4 btn btn-danger" style="margin-right: 10px">메인으로</a>
    <a href="/user/findpw" id="needit"class="col-4 btn btn-danger" >비밀번호 찾기</a>
    </div>
</div>

</body>
</html>