<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- HEADER -->
<c:import url="/WEB-INF/views/layout/header.jsp" />

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<style type="text/css">
.file {
	color: blue;
	font-size: 14px;
}
.del { 
    vertical-align: middle;
    font-size: 18px;
    color: red;
    margin-left: 3px;
    margin-bottom: 3px;
}
.del:hover {
	cursor: pointer;
}
#originFile {
    margin-top: -10px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
}
#originFile div{
	margin-left: 5px;
}
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

#btnWrite {
	border: none;
	border-radius: 5px;
	background-color: #ccc;
	font-size: 16px;
}
#rollBack  {
    text-align: center;
    vertical-align: middle;
	color:black;
	font-weight: normal;
	width: 113.63px;
	height: 26px;
	border: none;
	border-radius: 5px;
	background-color: #ccc;
	font-size: 16px;
}
#rollBackBtn {
    margin-bottom: 40px;
}
.text-center {
	margin-top: 40px;
    margin-bottom: 40px;
    text-align: center;
}
</style>

<script type="text/javascript">
$(() => {
   $("#title").focus()
   
   	$(".del").click(e => {
		$(e.target).prev().toggleClass("text-decoration-line-through")
		
		$(e.target).next().prop("checked", ()=>{return !$(e.target).next().prop("checked");})
	})
   
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

<div class="container">
<br><br>

<div class="col-10 mx-auto">
<form action="/community/update" method="post" enctype="multipart/form-data">

<div class="form-group mb-3">
   <label class="form-label">작성자(수정불가)</label>
   <input type="text" class="form-control" readonly="readonly" name="writerNick" value="${nick }">
</div>

<div class="form-group mb-3">
   <label class="form-label" for="title">제목 수정</label>
   <input type="text" class="form-control" name="title" id="title" value="${updateBoard.title }">
</div>

<div id="newFile">
	<div class="form-group mb-3">
	   <label class="form-label" for="file">첨부파일(추가,삭제)</label>
	   <input type="file" class="form-control" name="file" id="file" multiple="multiple">
	</div>
</div>

<div id="originFile">
	<c:forEach var="boardfile" items="${boardfile }">
		<div>
			<a class="file bi bi-paperclip" href="./download?fileNo=${boardfile.fileNo }">${boardfile.originName }</a>
			<span class="del">X</span>
			
			<input type="checkbox" class="d-none" name="delFileno" value="${boardfile.fileNo }">
		</div>
	</c:forEach>
</div>

<div style="font-weight: normal;" class="form-group mb-3">
   <label style="font-weight: bold;" class="form-label" for="content">본문</label>
   <textarea style="font-weight: normal;" class="form-control" name="content" id="content">${updateBoard.content }</textarea>
</div>

<input type="hidden" id="boardNo" name="boardNo" value="${updateBoard.boardNo }" />
<input type="hidden" id="menu" name="menu" value="${updateBoard.menu }" />
<input type="hidden" id="cate" name="cate" value="${updateBoard.cate }" />

<div class="text-center">
	<button id="btnWrite">수정내용 저장</button>
	<a id="rollBack" type="button" href="/community/view?boardNo=${updateBoard.boardNo }&menu=${updateBoard.menu }&cate=${updateBoard.cate}">돌아가기</a>
</div>

</form>

</div>
</div> <!-- .container -->

<!-- FOOTER -->
<c:import url="/WEB-INF/views/layout/footer.jsp" />