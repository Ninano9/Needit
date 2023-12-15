<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(function(){
	$("input[name=reportType]").click(function(){
		var reportType = $(this).val()
		   $.ajax({
		         type: "post"
		         , url: "/report"
		         , data: {
		        	 reportType: reportType
		        	 , boardNo : '${param.boardNo}'
		   			 
		   			
		         }
		         , dataType: "json"
		         , success: function( res  ) {
		            console.log("AJAX 성공")

		         }
		         , error: function() {
		            console.log("AJAX 실패")

		         }
		      })
		
	})
	
})



</script>
<style type="text/css">
/* 버튼 크기 */
:root {
  --button-width: 400px;
  --button-height:50px;
}
/* 바깥 div */
#report{
	margin: 0 auto;
	width: calc(var(--button-width) + 13px);
	height: calc(var(--button-height)*5 + 55px);
	border-radius: 5px; 
}
/* 안쪽 div */
#reportIn{
	margin: 0 3px;
	margin-top: 8px;
}

/* 버튼 스타일 */
#reportBtn1, #reportBtn2{
	border-radius: 5px;
	width: var(--button-width);
	height: var(--button-height);
	border: 0;
	font-size: 25px;
	margin-bottom: 8px;
}
/* 버튼 2번 색깔 */
#reportBtn2{
	background-color: rgb(255,83,63);
	color: white;
}


</style>

<script type="text/javascript">
$(document).ready(function() {
	$('.reportBtn').click(function() {
	$('.reportBtn').css('outline', 'none');
	  
	$(this).css('outline', '2px solid #E8133D');
	});
});


</script>

</head>
<body>

<div id="report">
	<div id="reportIn">
		<div>
		<input class="reportBtn" id="reportBtn1" type="button" value="광고성" name="reportType" data-bs-target="#reportOkModal" data-bs-toggle="modal">
		</div>
		
		<div>
		<input class="reportBtn" id="reportBtn2" type="button" value="음란물" name="reportType" data-bs-target="#reportOkModal" data-bs-toggle="modal">
		</div>
		
		<div>
		<input class="reportBtn" id="reportBtn1" type="button" value="욕설" name="reportType" data-bs-target="#reportOkModal" data-bs-toggle="modal">
		</div>
		
		<div>
		<input class="reportBtn" id="reportBtn2" type="button" value="불법 정보" name="reportType" data-bs-target="#reportOkModal" data-bs-toggle="modal">
		</div>
		
		<div>
		<input class="reportBtn" id="reportBtn1" type="button" value="개인정보 노출" name="reportType" data-bs-target="#reportOkModal" data-bs-toggle="modal">
		</div>
		
	</div><!-- .reportIn -->
</div><!-- .report -->

</body>
</html>