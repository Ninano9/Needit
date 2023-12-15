<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>

<html>
<head>
<title>Needit</title>

<style type="text/css">
/* 사진 전체 화면 */
.logo{
	width: 100%;
	height: 100%;
}
.logo1, .logo2, .logo3{
	width: 100%;
	height: 100%;
}

/* 슬라이드시 fade-in, fade-out */
.logo1, .logo2, .logo3{
	opacity: 0;
	transition: 1s ease-out;
}
.logo2:hover, .logo3:hover{
	opacity: 1;
	transition: 1s ease-out;
}
.logo1:not(:hover), .logo2:not(:hover), .logo3:not(:hover) {
    transition: 0.5s ease-out;
}


</style>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	setTimeout(function() {
		$('.logo1').css('opacity', '1');
	}, 1000);
});
</script>
</head>
<body>
<div id="logoStart">
	<div class="logo" id="div1">
	<a href="/main"><img id="one" class="logo1" alt="logo1" src="/resources/img/opening1.png"></a>
	</div>
	<div class="logo" id="div2">
	<a href="/main"><img id="two" class="logo2" alt="logo2" src="/resources/img/opening2.png"></a>
	</div>
	
	<div class="logo" id="div3">
	<a href="/main"><img id="three" class="logo3" alt="logo3" src="/resources/img/opening3.png"></a>
	</div>
</div>

</body>
</html>
