<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/views/admin/admin.jsp" />

<style>
#adminBanner{
	background-color: #ff8108;
	width: 302px;
}
#bannerImgPre{
	width: auto;
	height: 250px;
    white-space: nowrap;
    overflow-x: auto;
    margin-left: 10px;
}

#bannerImg{
	border: 1px solid #ccc;
    width: 400px;
    height: 210px;
	display: inline-block;
	vertical-align: top;
	margin-right: 10px;
    justify-content: center;
    align-items: center;
    background-size: contain;
    background-repeat: no-repeat;
    background-position: center center;
}

</style>

<script type="text/javascript">



</script>


<!-- 안쪽 내용 -->
<div id="adminContent">

<form action="./bannerUpdate" method="post" enctype="multipart/form-data">

<div class="form-group mb-3 ms-3">
	<label class="form-label" for="file">첨부파일</label>
	<input type="file" class="form-control" name="file" id="file" multiple="multiple">
</div>

<!-- <div class="text-center"> -->
<div class="ms-3">
	<button class="btn btn-primary" id="btnWrite">작성</button>
	<button type="reset" class="btn btn-danger" id="btnCancel">취소</button>
</div>
</form>
<br>

<!-- 이미지 미리보기 -->
<div id="bannerImgPre">
	<c:forEach items="${file }" var="bannerNames">
		<img id="BannerImg" alt="썸네일" src="/resources/banner/${bannerNames.storedName }">
	</c:forEach>
</div><!-- .bannerImgPre -->


</div><!-- #adminContent -->


</body>
</html>