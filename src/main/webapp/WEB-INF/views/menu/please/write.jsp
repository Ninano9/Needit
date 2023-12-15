<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />
    
<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<script type="text/javascript">
$(() => {
	$("#title").focus()
	$('#content').summernote('fontName', '바탕체');
	$('#content').summernote('fontSize', 16);
	$('#content').summernote('style', 'clear');
	
	$("#content").summernote({
		height: 300,
		toolbar: [
		    // [groupName, [list of button]]
		    // 썸머노트lite로 바꿔야됨~
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
		fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
	})
	
})

//썸네일 미리보기
function setThumbnail(event) {
    var reader = new FileReader();

    reader.onload = function (event) {
        var thumbnailContainer = document.querySelector("#thumbnail_container");
        thumbnailContainer.style.backgroundImage = "url('" + event.target.result + "')";
    };

    reader.readAsDataURL(event.target.files[0]);
}// .setThumbnail() End

//가격란에 문자,높은 금액, 0원 입력 방지
$(document).ready(function() {
    $("#price").on("keyup", function() {
        var checkType = $("#price").val();

        if (isNaN(checkType)) {
            alert("숫자만 입력 가능합니다");
            $("#price").val("");
            $("#price").focus();
        }

        if ( checkType > 999999999) {
            alert("가격은 999,999,999원 보다 높을 수 없습니다.");
            $("#price").val("");
            $("#price").focus();
        }
    
        if ( checkType == 0 ) {
            alert("가격은 0원 보다 높아야 합니다.");
            $("#price").val("");
            $("#price").focus();
        }

    });
});

</script>

<style type="text/css">

#thumbnail_container{
    border: 1px solid #ccc;
    width: 300px;
    height: 300px;
    display: flex;
    justify-content: center;
    align-items: center;
    background-size: contain;
    background-repeat: no-repeat;
    background-position: center center;
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
    height: 500px;
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
<form action="./write" method="post" enctype="multipart/form-data">

<input type="hidden" id="menu" name="menu" value="${param.menu }" />
<input type="hidden" id="cate" name="cate" value="${param.cate }" />


<div class="form-group mb-3">
	<label class="form-label">작성자</label>
	<input type="text" class="form-control" readonly="readonly" value="${nick }">
</div>

<div class="form-group mb-3">
	<label class="form-label" for="title">제목</label>
	<input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력해주세요" required>
</div>

<div class="form-group mb-3">
	<label class="form-label" for="location">위치</label>
	<input type="text" class="form-control" readonly="readonly" name="location" id="location" value="${user.addr1}">
</div>

<div class="form-group mb-3">
	<label class="form-label" for="price">가격</label>
	<input type="text" class="form-control" name="price" id="price" placeholder="30분당 가격을 입력해주세요" required>
</div>

<div class="form-group mb-3">
   <label class="form-label" for="thumbnailFile">썸네일</label>
   <div id="thumbnail_container"></div>
   <input type="file" class="form-control form-control-user" name="file" id="thumbnailFile" onchange="setThumbnail(event);" 
   	style="width:500px; margin-top:-38px; margin-left:310px; width:500px;">
</div>

<div style="font-weight: normal;" class="form-group mb-3">
   <label style="font-weight: normal;" class="form-label" for="content">본문</label>
   <textarea style="font-weight: normal;" class="form-control" name="content" id="content"></textarea>
</div>

<div class="form-group mb-3">
	<label class="form-label" for="file">파일첨부</label>
	<input type="file" class="form-control" name="file" id="file" multiple="multiple">
</div>

<div class="text-center">
	<button class="btn btn-primary" id="btnWrite">작성</button>
	<button type="reset" class="btn btn-danger" id="btnCancel">취소</button>
</div>

</form>
</div>

</div><!-- .container -->


<c:import url="/WEB-INF/views/layout/footer.jsp" />