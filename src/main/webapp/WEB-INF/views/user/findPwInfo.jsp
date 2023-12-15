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
$(document).ready(function() {
	$("#pw1").on("input focusin focusout",function(){
    	var password1 = $("#pw1").val();
    	var pwRegex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()_+])[a-zA-Z0-9!@#$%^&*()_+]{8,15}$/;
  		if(!pwRegex.test(password1)){
  			$("#label2").css("color", "red").css("display", "block").text("사용 불가능한 비밀번호 입니다.");
  			$("#pwLimit").css("color", "red").css("display", "block").text("영문, 숫자, 특수문자 를 조합한 8~15 글자 사용");
  			pwCheck = false;
  			return false;
  			
  		}else{
  			$("#label2").css("color", "green").css("display", "block").text("사용 가능한 비밀번호 입니다.");
			$("#pwLimit").css("display", "none");
  			pwCheck = true;
  		}
    })
    $("#pw2").on("input",function() {
    	password1 = $("#pw1").val();
        var password2 = $(this).val();
      
    	console.log(pwCheck);
	        if (password1 === password2 && !password1 == '') {
	            $("#label4").css("display", "block").css("color", "green").text("비밀번호가 일치합니다!");
	 			pwCheck = true;
	        } else {
	            $("#label4").css("display", "block").css("color", "red").text("비밀번호가 일치하지 않습니다.");
	            pwCheck = false;
	        }

        
    });
	$(".submit").on("click", function() {
	     if (!pwCheck) {
	         alert("비밀번호가 일치하지 않습니다");
	         return false; // Prevent form submission
	     }
	     // Continue with form submission
	});
	
	
});
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

<h2>비밀번호 변경</h2>
	<c:if test="${empty id}">
		<p>일치하는 아이디가 없습니다.</p>
		<a href="/main" id="needit"class="col-4 btn btn-danger" style="margin-right: 10px">메인으로</a>
	</c:if>

<form action="/user/findPwInfo"  method="post" >
    <c:if test="${not empty id}">
    	<input type="hidden" name="id" value="${id}">
   		<div class="position-relative">
		<label class="fs-3 fw-bold">*비밀번호</label>
		<span class="position-absolute top-50 end-0 translate-middle-y" id="label2" style="font-size: 15px;"></span>
 		</div>
   		<input type="password" class="form-control form-control-lg mb-3" id="pw1" name="pw" placeholder="비밀번호를 입력해주세요" required="required">
 		<span  id="pwLimit" style="font-size: 15px;"></span>
   		
   		<div class="position-relative">
 			<label class="fs-3 fw-bold">*비밀번호 확인</label>
   		<span class="position-absolute top-50 end-0 translate-middle-y" id="label4" style="font-size: 15px;"></span>
   		</div>
   		<input type="password" class="form-control form-control-lg mb-3" id="pw2" placeholder="비밀번호를 입력해주세요" required="required">
   		
   		<button id="needit"class="submit col-12 btn btn-danger btn-lg" >비밀번호 변경</button>
   		
    </c:if>
</form>
</div>

</body>
</html>