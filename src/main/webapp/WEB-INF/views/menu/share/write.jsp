<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- HEADER -->
<c:import url="/WEB-INF/views/layout/header.jsp" />

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<script type="text/javascript">
$(() => {
   $("#title").focus()
   $('#content').summernote('fontName', 'Arial');
   $('#content').summernote('fontSize', 16);
   $('#content').summernote('style', 'clear');
   
   $("#content").summernote({
      height: 300,
      toolbar: [
          ['fontname', ['fontname']],
          ['fontsize', ['fontsize']],
          ['style', ['bold', 'italic', 'underline', 'clear']],
          ['color', ['color']],
          ['table', ['table']],
          ['para', ['ul', 'ol', 'paragraph']],
          ['height', ['height']],
          ['insert',['picture','link']],
        ],
      fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
      fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
   })
})
</script>

<script type="text/javascript">
function setThumbnail(event) {
    var reader = new FileReader();

    reader.onload = function (event) {
        var thumbnailContainer = document.querySelector("#thumbnail_container");
        thumbnailContainer.style.backgroundImage = "url('" + event.target.result + "')";
    };

    reader.readAsDataURL(event.target.files[0]);
}
</script>

<style type="text/css">

.note-editor.note-airframe .note-editing-area, .note-editor.note-frame .note-editing-area {
    overflow: hidden;
    height: 700px;
}
.note-editor.note-airframe .note-editing-area .note-editable, .note-editor.note-frame .note-editing-area .note-editable {
    padding: 10px;
    overflow: auto;
    word-wrap: break-word;
    height: 700px;
}
#thumbnail_container{
    border: 1px solid #ccc;
    width: 200px;
    height: 200px;
    display: flex;
    justify-content: center;
    align-items: center;
    background-size: contain;
    background-repeat: no-repeat;
    background-position: center center;
}

</style>

<div class="container">
<br><br>

<div class="col-10 mx-auto">
<form action="/share/write" method="post" enctype="multipart/form-data">
<input type="hidden" name="menu" id="menu" value="${param.menu }" />
<input type="hidden" name="cate" id="cate" value="${param.cate }" />

<div class="form-group mb-3">
	<label class="form-label">작성자</label>
	<input type="text" class="form-control" readonly="readonly" name="writerNick" value="${nick }">
</div>

<div class="form-group mb-3">
	<label class="form-label" for="title">제목</label>
	<input type="text" class="form-control" name="title" id="title">
</div>

<div class="form-group mb-3">
	<label class="form-label" for="location">위치</label>
	<input type="text" class="form-control" readonly="readonly" name="location" value="${addr1 }" id="location">
</div>

<div class="form-group mb-3">
	<label class="form-label" for="price">0원</label>
</div>

<div class="form-group mb-3">
   <label class="form-label" for="thumbnailFile">썸네일</label>
   <input type="file" class="form-control form-control-user" name="upFile" id="thumbnailFile" onchange="setThumbnail(event);"><br>
   <div id="thumbnail_container"></div>
</div>

<div class="form-group mb-3">
	<label class="form-label" for="content">본문</label>
	<textarea class="form-control" name="content" id="content"></textarea>
</div>

<div class="form-group mb-3">
	<label class="form-label" for="file">첨부파일</label>
	<input type="file" class="form-control" name="upFile" id="file" multiple="multiple">
</div>

<div class="text-center">
	<button class="btn btn-primary" id="btnWrite">작성</button>
	<button type="reset" class="btn btn-danger" id="btnCancel">취소</button>
</div>

</form>
</div>

</div> <!-- .container -->

<!-- FOOTER -->
<c:import url="/WEB-INF/views/layout/footer.jsp" />