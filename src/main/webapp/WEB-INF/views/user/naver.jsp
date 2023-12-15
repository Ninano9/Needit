<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.7.1.min.js"></script>

<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>

</head>
<body>
<script type="text/javascript">
var naverLogin = new naver.LoginWithNaverId(
		{
			clientId: "If3wwgFKrS1NdGdbpSB4", //내 애플리케이션 정보에 cliendId를 입력해줍니다.
			callbackUrl: "http://localhost:8088/user/social", // 내 애플리케이션 API설정의 Callback URL 을 입력해줍니다.
			isPopup: false,
			callbackHandle: true
		}
	);	
naverLogin.init();
window.addEventListener('load', function () {
	naverLogin.getLoginStatus(function (status) {
		if (status) {
			var email = naverLogin.user.getEmail(); // 필수로 설정할것을 받아와 아래처럼 조건문을 줍니다.
    		var gender = naverLogin.user.getGender();
			var socialId = naverLogin.user.getId();
			var mobile = naverLogin.user.getMobile();
			var phone = mobile.replace(/-/g, '');
			var name = naverLogin.user.getName();
			var nick = naverLogin.user.getNickName();
    	
			var data = {
					  email: email,
					  gender: gender,
					  socialId: socialId,
					  phone: phone,
					  name: name,
					  nick: nick
					};
    		
			var queryString = Object.keys(data).map(function(key) {
				  return encodeURIComponent(key) + '=' + encodeURIComponent(data[key]);
				}).join('&');
			 var previousUrl = sessionStorage.getItem('previousUrl');
			console.log(naverLogin.user); 
    		 $.ajax({
    	         type: "POST",
    	         url: "/user/naver",
    	         data: {
    	        	 socialId : socialId
    	         },
    	         success: function (response) {
    	        	 console.log(response)
    	         	if (response === "success") {
    	                 console.log("로그인 성공")
    	                 
    		            
    	                  if (previousUrl) {
			                // 이전 페이지로 이동
			                window.location.href = previousUrl
			                
			           	 	} else {
			                // 이전 페이지가 없으면 기본적으로 홈 페이지로 이동
			                window.location.href = '/main'
			           		}
    	                 
    	             } else if(response === "signup"){
    	            	 alert("아이디가 없으므로 회원가입을 진행합니다.")
    	             	 window.location.href = '/user/signup?' + queryString;
    	             	 
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
        
		} else {
			console.log("callback 처리에 실패하였습니다.");
		}
	});
	
});

</script>
</body>
</html>