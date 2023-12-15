<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/views/admin/admin.jsp" />

<style>
#adminNotice{
	background-color: #ff8108;
	width: 302px;
}

#tableWrapper{
	overflow-x: hidden;
	overflow-y: scroll;
	height: 300px;
}
#tableWrapper th{
	position: sticky;
    top: 0px;
}
#adminContent{
	width: 80%;
}
#deleteNoticeTBtn{
    width: 50px;
    height: 26px;
    vertical-align: middle;
    background-color: inherit;
    border: 1px solid rgb(255,83,63);
    border-radius: 5px;
    font-weight: bold;
}

/* Webkit 브라우저를 위한 스타일 */
#tableWrapper::-webkit-scrollbar { width: 12px; }
#tableWrapper::-webkit-scrollbar-track { background: #f1f1f1; border-radius: 10px; }
#tableWrapper::-webkit-scrollbar-thumb { background-color: transparent; border-radius: 10px;background: #ff533f; }

</style>

<script type="text/javascript">
$(() => {
    $("#title").focus();

    //삭제용
    window.deleteBoard = function(boardNo) {
        if (confirm('삭제하시겠습니까?')) {
            $.ajax({
                type: "POST",
                url: "/admin/reportList",
                data: { boardNo: boardNo },
                success: function(response) {
                    location.reload();
                },
                error: function(e) {
                    console.log("에러: ", e);
                }
            });
        }
    }
});

document.getElementById('content').addEventListener('keydown', function(event) {
    if (event.key === 'Enter') {
        event.preventDefault();

        const textarea = document.getElementById('content');

        const cursorPosition = textarea.selectionStart;

        const value = textarea.value;
        const textBeforeCursor = value.substring(0, cursorPosition);
        const textAfterCursor = value.substring(cursorPosition);

        textarea.value = textBeforeCursor + '\n' + textAfterCursor;

        textarea.setSelectionRange(cursorPosition + 1, cursorPosition + 1);
    }
});

</script>

<!-- 안쪽 내용 -->
<div id="adminContent">

<div class="col-10 ms-3">
<form action="./noticeUpdate" method="post" enctype="multipart/form-data">

<div class="form-group mb-3">
	<label class="form-label" for="title">제목</label>
	<input type="text" class="form-control" name="title" id="title">
</div>

<div class="form-group mb-3">
	<label class="form-label" for="content">본문</label>
	<textarea class="form-control" name="content" id="content"></textarea>
</div>

<!-- <div class="form-group mb-3"> -->
<!-- 	<label class="form-label" for="file">첨부파일</label> -->
<!-- 	<input type="file" class="form-control" name="file" id="file" multiple="multiple"> -->
<!-- </div> -->

<!-- <div class="text-center"> -->
<div id="submitBtn">
	<button class="btn btn-primary" id="btnWrite">작성</button>
	<button type="reset" class="btn btn-danger" id="btnCancel">취소</button>
</div><!-- #submitBtn -->

</form>
</div><!-- .col-10 mx-auto -->

<hr>

<!-- 작성한 공지 목록 -->
<div id="tableWrapper">

<table id="noticeTable" class="table table-striped table-sm">

<colgroup>
	<col style="width: 10%;">
	<col style="width: 20%;">
	<col style="width: 50%;">
	
	<col style="width: 15%;">
	<col style="width: 15%;">
</colgroup>

<thead>
	<tr class="table-danger">
		<th>게시글번호</th>
		<th>제목</th>
		<th>내용</th>

		<th>작성날짜</th>
		<th>삭제</th>
	</tr>
</thead>

<tbody>
<c:forEach var="list" items="${noticeList }">
	<tr>
		<td>${list.BOARD_NO }</td>
		<td id="longText">${list.TITLE }</td>
		<td id="longText">${list.CONTENT }</td>
		<td>${list.WRITE_DATE}</td>
        <td><button id="deleteNoticeTBtn" class="delete_btn" onclick="deleteBoard(${list.BOARD_NO})">삭제</button></td>
	</tr>
</c:forEach>
</tbody>
</table>


</div><!-- #tableWrapper -->






</div><!-- #adminContent -->


</body>
</html>