<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.7.1.min.js"></script>

<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

</head>
<body>
<script type="text/javascript">
Kakao.init('a52e48853ec86f2933366f08010630db'); //발급받은 키 중 javascript키를 사용해준다.
console.log(Kakao.isInitialized()); // sdk초기화여부판단
//카카오로그인
window.addEventListener('load', function () {
    Kakao.Auth.login({
      success: function (response) {
        Kakao.API.request({
          url: '/v2/user/me',
          success: function (response) {
        	  console.log(response)
        	  var socialId = response.id
        	  
        	  var data = {socialId : socialId}
        	  var queryString = Object.keys(data).map(function(key) {
				  return encodeURIComponent(key) + '=' + encodeURIComponent(data[key]);
				}).join('&');
			  var previousUrl = sessionStorage.getItem('previousUrl');
        	  $.ajax({
     	         type: "POST",
     	         url: "/user/kakao",
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
  });

</script>
</body>
</html>