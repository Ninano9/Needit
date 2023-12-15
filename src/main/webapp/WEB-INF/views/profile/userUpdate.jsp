<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
	<title>Needit</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.7.1.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
//주소입력
	var pwCheck = false;
	
function addr1_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.address; // 최종 주소 변수

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("addr1").value = addr;
                // 주소로 상세 정보를 검색

            	// 주소창에 포커스 이동
		    	document.getElementById("addr1").focus();
        	  	addrCheck = true;
            }
        }).open();
    }

// //이메일 작성
// let code = "";     //이메일 인증 저장위한 코드
// function sendEmail() {
// 	let emailCheck = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
	
// 	if (!emailCheck.test($("#email").val())) {
// 		alert("이메일 형식에 맞추어 작성하세요");
// 	} else {
// 		let email = $("#email").val();  //입력한 이메일
		
// 		$.ajax({
// 			url: "mailSender.do",
// 			type: "get",
// 			data: {'m_email':email},
// 			success: function(rnum) {
// 				//alert("s");
// 				alert("기입하신 이메일로 인증번호를 전송했습니다.");
				
// 				$("#codeInput").attr("disabled", false); //입력칸 활성화
// 				code = rnum;
// 			},
// 			error: function () {
// 				alert("f");
// 			}
// 		});
// 	}
// }


$(document).ready(function() {
	
	// 페이지 로드 시 비밀번호, 닉네임 및 주소 필드에 대한 유효성 검사 트리거
    validatePassword();
    validateNickname();
    validateAddress();
    
    function validatePassword() {
        var password1 = $("#pw1").val();
        var password2 = $("#pw2").val();

        // 비밀번호 유효성 검사 로직 추가
        var pwRegex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()_+])[a-zA-Z0-9!@#$%^&*()_+]{8,15}$/;

        if (!pwRegex.test(password1)) {
            $("#label2").css("color", "red").css("display", "block").text("사용 불가능한 비밀번호 입니다.");
            $("#pwLimit").css("color", "red").css("display", "block").text("영문, 숫자, 특수문자를 조합한 8~15 글자 사용");
            pwCheck = false;
            return false;
        } else {
            $("#label2").css("color", "green").css("display", "block").text("사용 가능한 비밀번호 입니다.");
            $("#pwLimit").css("display", "none");
            pwCheck = true;
        }

        if (password1 !== password2 || password1 === '') {
            $("#label4").css("display", "block").css("color", "red").text("비밀번호가 일치하지 않습니다.");
            pwCheck = false;
            return false;
        } else {
            $("#label4").css("display", "block").css("color", "green").text("비밀번호가 일치합니다!");
            pwCheck = true;
            return true;
        }
    }

    function validateNickname() {
        var nick = $("#nick").val();
        var currentNick = "${nick}"; // 현재 사용자의 닉네임
        var nickRegex = /^(?!.*[ㄱ-ㅎㅏ-ㅣ])[a-zA-Z0-9가-힣]{2,13}$/;

        
        if (nick === currentNick) {
            $("#label3").css("display", "block").css("color", "green").text("현재 사용 중인 닉네임입니다.");
            $("#nickLimit").css("display", "none");
            nickCheck = true;
            return true;
        }
        
        // 닉네임 유효성 검사 로직 추가
        if (nick == '' || nick.length == 0 || !nickRegex.test(nick)) {
            $("#label3").css("color", "red").css("display", "block").text("사용할 수 없습니다.");
            $("#nickLimit").css("color", "red").css("display", "block").text("2~13글자 특수문자 사용 불가");
            nickCheck = false;
            return false;
        } else {
            // Ajax로 중복 검사 수행
            $.ajax({
                url: '/user/nickCheck',
                data: {
                    nick: nick
                },
                type: 'POST',
                dataType: 'json',
                success: function (result) {
                    if (result != true) {
                        $("#label3").css("display", "block")
                        $("#label3").css("color", "green").text("사용 가능한 닉네임 입니다.");
                        $("#nickLimit").css("display", "none");
                        nickCheck = true;
                    } else {
                        $("#label3").css("display", "block")
                        $("#label3").css("color", "red").text("사용 불가능한 닉네임 입니다.");
                        nickCheck = false;
                    }
                    nickCheck = !result;
                }
            });
            
            return nickCheck;
        }
    }

    function validateAddress() {
        var addr = $("#addr1").val();

        // 주소 유효성 검사 로직 추가
        if (addr == '' || addr.length == 0) {
            // 주소가 비어있을 경우
            addrCheck = false;
        } else {
            // 주소가 비어있지 않을 경우
            addrCheck = true;
        }

        return addrCheck;
    }

// 	//ID 중복 확인
// 	//id를 입력할 수 있는 input text 영역을 벗어나면 동작한다.
// 	$("#id").on("input focusin focusout", function() {
		
// 	 	var id = $("#id").val();
//         var idRegex = id.replace(/[^a-zA-Z0-9]/g, ''); // Remove characters that are not English letters or numbers

//         // Ensure the length is between 4 and 15 characters
//         idRegex = idRegex.substring(0, 15);

//         // Update the input value with the cleaned id
//         $(this).val(idRegex);

//         if (idRegex.length < 4 || idRegex.length > 15 || !(/[a-zA-Z]/.test(idRegex) && /[0-9]/.test(idRegex))) {
//             $("#label1").css("color", "red").css("display", "block").text("ID로 사용할 수 없습니다.");
//             $("#idLimit").css("color", "red").css("display", "block").text("영문자와 숫자를 포함한 4~15글자 대문자 미포함, 특수문자 사용 불가");
//             idCheck = false;
//             return false;
//         }
//     	//Ajax로 전송
//     	$.ajax({
//     		url : '/user/idCheck',
//     		data : {
//     			id : id
//     		},
//     		type : 'POST',
//     		dataType : 'json',
//     		success : function(result) {
//     			if (result != true) {
//     				$("#label1").css("display", "block")
//     				$("#label1").css("color", "green").text("사용 가능한 ID 입니다.");
//     				$("#idLimit").css("display", "none");
//     				idCheck = true;
//     			} else{
//     				$("#label1").css("display", "block")
//     				$("#label1").css("color", "red").text("사용 불가능한 ID 입니다.");
//     				idCheck = false;
//     			}
//     		}
//     	}); //End Ajax
// 	});
	//닉네임 중복확인
	$("#nick").on("input focusin focusout", function() {
		
		var nick = $("#nick").val();
		var nickRegex = /^(?!.*[ㄱ-ㅎㅏ-ㅣ])[a-zA-Z0-9가-힣]{2,13}$/;
		
		if(nick == '' || nick.length == 0 || !nickRegex.test(nick)) {
			
			$("#label3").css("color", "red").css("display", "block").text("사용할 수 없습니다.");
			$("#nickLimit").css("color", "red").css("display", "block").text("2~13글자 특수문자 사용 불가");
			return false;
		}

		
		// 닉네임이 변경된 경우에만 중복 검사 수행
        if (nick !== "${nick}") {
        	
        
    	//Ajax로 전송
    	$.ajax({
    		url : '/user/nickCheck',
    		data : {
    			nick : nick
    		},
    		type : 'POST',
    		dataType : 'json',
    		success : function(result) {
    			if (result != true ) {
    				$("#label3").css("display", "block")
    				$("#label3").css("color", "green").text("사용 가능한 닉네임 입니다.");
    				$("#nickLimit").css("display", "none");

    			} else{
    				$("#label3").css("display", "block")
    				$("#label3").css("color", "red").text("사용 불가능한 닉네임 입니다.");
    			}
    				nickCheck = !result;
    		}
    	}); //End Ajax
        } else {
        	// 닉네임이 변경되지 않은 경우에도 "사용 가능한 닉네임 입니다." 메시지 표시
            $("#label3").css("display", "block").css("color", "green").text("사용 가능한 닉네임 입니다.");
            $("#nickLimit").css("display", "none");
        }
	});
    // 비밀번호 일치 여부 확인
    $("#pw1").on("input focusin focusout",function(){
    	var password1 = $("#pw1").val();
    	var pwRegex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()_+])[a-zA-Z0-9!@#$%^&*()_+]{8,15}$/;
  		if(!pwRegex.test(password1)){
  			$("#label2").css("color", "red").css("display", "block").text("사용 불가능한 비밀번호 입니다.");
  			$("#pwLimit").css("color", "red").css("display", "block").text("영문, 숫자, 특수문자 를 조합한 8~15 글자 사용");
  			return false;
  			
  		}else{
  			$("#label2").css("color", "green").css("display", "block").text("사용 가능한 비밀번호 입니다.");
			$("#pwLimit").css("display", "none");
  		}
    })
    $("#pw2").on("input", function() {
	    password1 = $("#pw1").val();
	    var password2 = $(this).val();
	
		    console.log(pwCheck);
		    if (password1 === password2 && password1 !== '') {
		        $("#label4").css("display", "block").css("color", "green").text("비밀번호가 일치합니다!");
		        return true;
		    } else {
		        $("#label4").css("display", "block").css("color", "red").text("비밀번호가 일치하지 않습니다.");
		        return false;
		    }
});
//     //이메일 전송
//     $("#codeInput").on("input focusout focusin", function() {
    	
//     	console.log(code);
//     	if(code == $("#codeInput").val()) { //인증번호 같다면
//     		$("#codecheck_blank").css("color", "green");
//     		$("#codecheck_blank").text("인증되었습니다.");
//     		email = true;
//     	}else {
//     		$("#codecheck_blank").css("color", "red");
//     		$("#codecheck_blank").text("인증번호를 다시 입력해주세요.");
//     		email = false;
//     	}
//     });
    
//     $("#name").on("input", function() {
//         var name = $(this).val();

//         // 한글과 영어만 허용하도록 정규표현식 적용
//         var cleanedName = name.replace(/[^ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z]/g, '');

//         // 입력란에 정제된 이름 설정
//         $(this).val(cleanedName);

//         // 유효성 검사
//         if (cleanedName.length > 0) {
//             // 유효한 경우
//             nameCheck = true;
//         } else {
//             // 유효하지 않은 경우
//             nameCheck = false;
//         }
//     });
    
//     $("#phone").on("input focusout focusin", function(event) {
//         // 현재 입력된 전화번호
//         var phone = $(this).val();

//         // 숫자 이외의 문자 제거
//         var numericPhone = phone.replace(/[^0-9]/g, '');

//         // 입력된 숫자가 11자리를 초과하면 맨 앞에서부터 11자리까지만 남기기
//         numericPhone = numericPhone.slice(0, 11);

//         // 입력란에 숫자만 설정
//         $(this).val(numericPhone);

//         // 유효성 검사
//         if (numericPhone.length === 11) {
//             // 유효한 경우
//             phoneCheck = true;
//         } else {
//             // 유효하지 않은 경우
//             phoneCheck = false;
//         }
//     });

    
//     $("#birth").on("input focusout focusin", function() {
//     	var birth = $("#birth").val();
    	
//     	if(birth == '' || birth.length == 0 ){
//     		return false;
//     	} else {
//     		birthCheck = true;
//     	}
//     });   
    
     
    
    // 최종 확인
    $("#needit1").click(function() {
    	
    	console.log(pwCheck,nickCheck, addrCheck);
        if (pwCheck && nickCheck && addrCheck) { // 이메일이 인증되었는지 확인
       
            alert("회원정보 수정이 완료되었습니다!");

        } else {
        	alert("필수사항을 입력하지 않았습니다. 다시 확인해주세요.");
        	return false;
        }

    });
});




</script>
<style type="text/css">

html {
 	background-size : cover; 
	background-image: url('../resources/img/3.jpg') ;  
}
form {
     width: 900px; 
     padding: 20px;
     
}
#needit{
	color: white; 
	background-color: #ff533f;
	border-color: #ff533f;
}
#label1{
	display: none;
}

</style>
</head>
<body>


<div class="container position-relativ ">

<div class="col-7 mx-auto my-5 ">

<form action="./infoupdate"  method="post"  class="card shadow-lg position-absolute top-50 start-50 translate-middle form-signin" >
<a href="/main"><img class="mb-3 mx-auto d-block" src="../resources/img/needit..png" width="300" height="70" ></a>
<span class="float-start" style="font-size: 15px">* : 필수입력사항</span>
<div class="clearfix"></div>

<div class="form-floating">
	<div class="row">
  		<div class="col">
  		
  			<div class="position-relative">
  			<label class="fs-3 fw-bold">*아이디</label>
   	 		<span class="position-absolute top-50 end-0 translate-middle-y" id="label1" style="font-size: 15px;"></span>
  			</div>
   	 		<input type="text" class="form-control form-control-lg mb-3" name="id" id="id" value="${id }" readonly>
   	 		<span  id="idLimit" style="font-size: 13px;"></span>
   	 		<div class="position-relative">
  			<label class="fs-3 fw-bold">*비밀번호</label>
  			<span class="position-absolute top-50 end-0 translate-middle-y" id="label2" style="font-size: 15px;"></span>
   	 		</div>
    		<input type="password" class="form-control form-control-lg mb-3" id="pw1" name="pw" value="${user.pw }" placeholder="비밀번호를 입력해주세요">
   	 		<span  id="pwLimit" style="font-size: 15px;"></span>
    		
    		<div class="position-relative">
  			<label class="fs-3 fw-bold">*비밀번호 확인</label>
    		<span class="position-absolute top-50 end-0 translate-middle-y" id="label4" style="font-size: 15px;"></span>
    		</div>
    		<input type="password" class="form-control form-control-lg mb-3" id="pw2" value="${user.pw }"  placeholder="비밀번호를 입력해주세요">
    		
     		<div class="position-relative"> 
  			<label class="fs-3 fw-bold">*닉네임</label> 
   			<span class="position-absolute top-50 end-0 translate-middle-y" id="label3" style="font-size: 15px;"></span> 
     		</div> 
    		<input type="text" class="form-control form-control-lg mb-3" id="nick" name="nick" value="${nick }"> 
    	 		<span  id="nickLimit" style="font-size: 15px;"></span> 
    	 		
<!--   			<label class="fs-3 fw-bold">*생년월일</label> -->
<!--     		<input type="date" class="form-control form-control-lg mb-3" id="birth" name="birth" required="required"> -->
    		
   	 		<div class="position-relative">
  			<label class="fs-3 fw-bold">*주소</label> 
  			<input class="btn mb-2 position-absolute top-50 end-0 translate-middle-y" id="needit"type="button" onclick="addr1_execDaumPostcode()" value="우편번호 찾기">
  			</div>

  			<input type="text" class="form-control form-control-lg mb-3" name="addr1" value="${user.addr1 }" id="addr1" required="required">
    		
    		<label class="fs-3 fw-bold">상세주소</label>
    		<input type="text" class="form-control form-control-lg mb-3" name="addr2" value="${user.addr2 }">
   	 		
  		</div>
  		
<!--   		<div class="col"> -->
  		
<!--     		<label class="fs-3 fw-bold">성별</label> -->
<!--     		<select name="gender"  class="form-select form-select-lg mb-3" name="gender"> -->
<!-- 			    <option value="E">기타</option> -->
<!-- 	    		<option value="M">남자</option> -->
<!-- 			   	<option value="F">여자</option> -->
<!-- 			</select> -->
<!--   			<label class="fs-3 fw-bold">*이름</label> -->
<!--     		<input type="text" class="form-control form-control-lg mb-3" id="name" name="name" placeholder="이름을 입력해주세요" required="required"> -->
    		
  			
<!--   			<label class="fs-3 fw-bold">*전화번호</label> -->
<!--     		<input type="text" class="form-control form-control-lg mb-3" id="phone" name="phone" placeholder="전화번호를 입력해주세요" > -->
    		
<!--     		<div class="position-relative"> -->
<!--     		<label class="fs-3 fw-bold">*이메일</label>  -->
<!--     		<input class=" position-absolute top-50 end-0 translate-middle-y btn btn-danger" type="button" value="인증코드 발송" onclick="sendEmail()"> -->
<!--     		</div> -->
<!--    	 		<input type="email" class="form-control form-control-lg mb-3" name="email" id="email" placeholder="이메일을 입력해주세요" required="required"> -->
   	 		
<!--   			<div class="position-relative"> -->
<!--   			<label class="fs-3 fw-bold">*인증번호</label> -->
<!--   			<span class="position-absolute top-50 end-0 translate-middle-y" id="codecheck_blank" style="font-size: 15px;"></span> -->
<!--     		</div> -->
<!-- 			<input type="text" class="form-control form-control-lg mb-3" id="codeInput" placeholder="인증번호 입력"  required="required" disabled="disabled"> -->
<!--   		</div> -->
  		
	</div>
</div>


	<div>
	<button id="needit1"class=" col-12 btn btn-danger btn-lg" >회원정보 수정</button>
	
	</div>
</form>
</div>
<div class="col-6 mx-auto">

</div>
</div><%--컨테이너 --%>




</body>
</html>