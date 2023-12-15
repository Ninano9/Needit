<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
	<title>Login</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.7.1.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>

<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>

<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	
	$("#id").mousedown(function () {
		 $("#label1")
     	.text("")
	});
	
    // 세션 스토리지에 현재 페이지의 URL 저장
    sessionStorage.setItem('previousUrl', window.location.href);
    var previousUrl = sessionStorage.getItem('previousUrl');
    function loginUser() {
        $.ajax({
            type: "POST",
            url: "/user/login",
            data: {
                id: $("#id").val(),
                pw: $("#pw").val()
            },
            success: function (response) {
            	if (response === "success") {
                    console.log("로그인 성공")
                     var autoLoginChecked = $("#autoLoginCheckbox").prop("checked");
					 var userId = $("#id").val()
					 var userPw = $("#pw").val();
				     // 만약 체크되어 있다면 쿠키에 저장
				     if (autoLoginChecked) {
				    	 var userInfo = {
				                 userId: userId,
				                 userPw: userPw
				             };
				    	 var expirationDate = new Date();
				    	    expirationDate.setDate(expirationDate.getDate() + 30);

				    	    document.cookie = "userInfo=" + JSON.stringify(userInfo) + "; expires=" + expirationDate.toUTCString() + "; path=/;";
				     } else {
				         // 체크가 되어 있지 않으면 쿠키 삭제
				         document.cookie = "userInfo=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
				     }
	                if (previousUrl) {
	                // 이전 페이지로 이동
	                window.location.href = previousUrl
	                
	           	 	} else {
	                // 이전 페이지가 없으면 기본적으로 홈 페이지로 이동
	                window.location.href = '/main'
	           		}
                    
                } else if(response === "singup"){
                	
                	 window.location.href = '/user/singup'
                	 
                } else{
                	console.log("로그인 실패")

                    $("#label1")
                    	.text("ID/PW 가 올바르지 않습니다.")

                }
            },
            error: function () {
                console.log("로그인 실패")
                // AJAX 요청 자체가 실패한 경우에 대한 처리
                alert("로그인 요청에 실패했습니다.")
            }
        });
    };
    
 // 엔터키 이벤트 처리
	$("#pw").keypress(function (e) {
		if (e.which === 13) {
			loginUser();
		}
	});

	$("#login").click(function () {
		loginUser();
	});
	
});




</script>
<style type="text/css">

a {text-decoration: none; color: #343a40;}


.card {
     width: 450px; 
     padding: 20px;
     
}
#login {
	height: 5.8em;
	padding: 0;
	width: 130px; 
	color: white; 
	background-color: #ff533f;
	border-color: #ff533f;
}
#needit{
	color: white; 
	background-color: #ff533f;
	border-color: #ff533f;
}

#label1{
	margin-top: 5px;
    margin-left: 8px;
    text-align: left;
    font-size: 15px;
    color: red;
    display: block;
}

#social{margin-bottom: 5px;}
#naver{float: left;}
#kakao{float: right;}
</style>
</head>
<body>

<div class="form col-7 mx-auto my-5 ">
	<div class="card shadow-lg position-absolute top-50 start-50 translate-middle form-signin" >
		<a href="/main"><img class="mb-3 float-start" src="/resources/img/needit..png" width="250" height="45" ></a>
		<div class="clearfix"></div>
		<div class="row mb-2">
			<div class="col-8">
				<input type="text" class="form-control mb-3" name="id" id="id" placeholder="아이디를 입력해주세요" required="required">
				<input type="password" class="form-control" name="pw" id="pw" placeholder="비밀번호를 입력해주세요" required="required">
				<span id="label1"></span>
			</div>
			<button class="col-3 mr-2 btn btn-danger float-end" id="login" >로그인</button>
		</div>
		
		<div class="mb-3">
			<label class="float-start"><input id="autoLoginCheckbox" type="checkbox" > 로그인 상태 유지</label>	
			<div class="float-end">
				<a href="/user/findid" style="margin-right: 10px;">아이디찾기</a>
				<a href="/user/findpw">비밀번호찾기</a>
			</div>
		</div>
		<div id="social">
			<a id="naverIdLogin_loginButton" href="javascript:void(0)"><img id="naver" src="/resources/img/naver.png"></a>
		    <a href="javascript:void(0)" onclick="kakaoLogin();"><img id="kakao" src="/resources/img/kakao.png"></a>
		</div>
		<a id="needit"class=" col-12 btn btn-danger"href = "/user/signup">회원가입</a>
		
	</div>
</div>
<div class="col-6 mx-auto">

</div>
<script type="text/javascript">

//네이버
var naverLogin = new naver.LoginWithNaverId(
		{
			clientId: "If3wwgFKrS1NdGdbpSB4", //내 애플리케이션 정보에 cliendId를 입력해줍니다.
			callbackUrl: "http://localhost:8088/user/naver", // 내 애플리케이션 API설정의 Callback URL 을 입력해줍니다.
			isPopup: false,
			callbackHandle: true
		}
	);	
naverLogin.init();

var testPopUp;
function openPopUp() {
    testPopUp= window.open("https://nid.naver.com/nidlogin.logout", "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,width=1,height=1");
}
function closePopUp(){
    testPopUp.close();
}

function naverLogout() {
	openPopUp();
	setTimeout(function() {
		closePopUp();
		}, 1000);
	
	
}
//---------------------------------------------------

Kakao.init('a52e48853ec86f2933366f08010630db'); //발급받은 키 중 javascript키를 사용해준다.
console.log(Kakao.isInitialized()); // sdk초기화여부판단
//카카오로그인
function kakaoLogin() {
    Kakao.Auth.login({
      success: function (response) {
        Kakao.API.request({
          url: '/v2/user/me',
          success: function (response) {
        	  console.log(response)
        	  window.location.href = '/user/kakao'
          },
          fail: function (error) {
            console.log(error)
          },
        })
      },
      fail: function (error) {
        console.log(error)
      },
    })
  }
//카카오로그아웃  
function kakaoLogout() {
    if (Kakao.Auth.getAccessToken()) {
      Kakao.API.request({
        url: '/v1/user/unlink',
        success: function (response) {
        	console.log(response)
        	
        },
        fail: function (error) {
          console.log(error)
        },
      })
      Kakao.Auth.setAccessToken(undefined)
    }
  }  

</script>

</body>
</html>