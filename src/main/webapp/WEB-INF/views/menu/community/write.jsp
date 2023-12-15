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

<style type="text/css">
   
.note-editor .dropdown-toggle::after { 
	all: unset; 
}

.note-editor .note-toolbar .note-dropdown-menu, .note-popover .popover-content .note-dropdown-menu {
    font-size: 16px; 
    text-align: left;
    min-width: 160px;
}
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

</style>

<div class="container">
<br><br>

<div class="col-10 mx-auto">
<form action="/community/write" method="post" enctype="multipart/form-data">

<input type="hidden" id="menu" name="menu" value="${param.menu }" />
<input type="hidden" id="cate" name="cate" value="${param.cate }" />

<div class="form-group mb-3">
   <label class="form-label">작성자</label>
   <input type="text" class="form-control" readonly="readonly" name="writerNick" value="${nick }">
</div>

<div class="form-group mb-3">
   <label class="form-label" for="title">제목</label>
   <input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력해주세요" required>
</div>


<c:if test="${param.menu == 4 && param.cate == 2 }">
<div class="form-group mb-3">
   <label class="form-label" for="location">위치</label>
   <input type="text" class="form-control" readonly="readonly" name="location" value="${addr1 }" id="location">
</div>
</c:if>

<div style="font-weight: normal;" class="form-group mb-3">
   <label style="font-weight: normal;" class="form-label" for="content">본문</label>
   <textarea style="font-weight: normal;" class="form-control" name="content" id="content"></textarea>
</div>

<div class="form-group mb-3">
   <label class="form-label" for="file">첨부파일</label>
   <input type="file" class="form-control" name="file" id="file" multiple="multiple">
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