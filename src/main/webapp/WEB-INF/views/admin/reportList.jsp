<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/views/admin/admin.jsp" />

<style>
#adminReport{
	background-color: #ff8108;
	width: 302px;
}
.table tr td{
	overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}
#reportBoard, #reportComment{
	overflow-x: hidden;
	overflow-y: scroll;
	height: 213px;
}
#adminContent{
	width: 80%;
}
#reportBoard th, #reportComment th{
	position: sticky;
    top: 0px;
}
.delete_btn{
    width: 55px;
    height: 28px;
    vertical-align: middle;
    background-color: inherit;
    border: 2px solid red;
    border-radius: 5px;
    font-weight: bold;
}

/* Webkit 브라우저를 위한 스타일 */
#reportBoard::-webkit-scrollbar { width: 12px; }
#reportBoard::-webkit-scrollbar-track { background: #f1f1f1; border-radius: 10px; }
#reportBoard::-webkit-scrollbar-thumb { background-color: transparent; border-radius: 10px;background: #ff533f; }

#reportComment::-webkit-scrollbar { width: 12px; }
#reportComment::-webkit-scrollbar-track { background: #f1f1f1; border-radius: 10px; }
#reportComment::-webkit-scrollbar-thumb { background-color: transparent; border-radius: 10px;background: #ff533f; }

</style>

<script type="text/javascript">
/* 삭제 버튼 */
function deleteBoard(boardNo) {
    if (confirm('정말로 삭제하시겠습니까?')) {
        $.ajax({
            type: "POST",
            url: "/admin/reportList",
            data: { boardNo: boardNo },
            success: function (response) {
                location.reload();
            },
            error: function (e) {
                console.log("에러 발생: ", e);
            }
        });
    }
}

function deleteComment(cmtNo) {
    if (confirm('정말로 삭제하시겠습니까?')) {
        $.ajax({
            type: "POST",
            url: "/admin/reportList",
            data: { cmtNo: cmtNo },
            success: function (response) {
                location.reload();
            },
            error: function (e) {
                console.log("에러 발생: ", e);
            }
        });
    }
}
</script>

<!-- 안쪽 내용 -->
<div id="adminContent">

<!-- 게시글 신고 목록 -->
<h3>게시글 신고 목록</h3>
<div id="reportBoard">
<table class="table table-striped table-sm">

<colgroup>
	<col style="width: 7%;">
	<col style="width: 16%;">
	<col style="width: 15%;">
	<col style="width: 6%;">
	<col style="width: 8%;">
	
	<col style="width: 13%;">
	<col style="width: 15%;">
	<col style="width: 15%;">
	<col style="width: 5%;">
</colgroup>

<thead>
	<tr class="table-danger">
		<th>신고번호</th>
		<th>게시글번호</th>
		<th>제목</th>
		<th>메뉴</th>
		<th>카테고리</th>
		
		<th>작성자</th>
		<th>신고종류</th>
		<th>신고날짜</th>
		<th>삭제</th>
	</tr>
</thead>

<tbody>
<c:forEach var="list" items="${reportBoardList }">
	<tr>
		<td>${list.REPORT_NO }</td>
		<td>${list.BOARD_NO }</td>
		
		<c:if test="${list.MENU eq 1}">
			<td><a href="/rent/view?boardNo=${list.BOARD_NO }&menu=${list.MENU }&cate=${list.CATE }">${list.TITLE }</a></td>
		</c:if>
		<c:if test="${list.MENU eq 2}">
			<td><a href="/share/view?boardNo=${list.BOARD_NO }&menu=${list.MENU }&cate=${list.CATE }">${list.TITLE }</a></td>
		</c:if>
		<c:if test="${list.MENU eq 3}">
			<td><a href="/please/view?boardNo=${list.BOARD_NO }&menu=${list.MENU }&cate=${list.CATE }">${list.TITLE }</a></td>
		</c:if>		
		<td>${list.MENU }</td>
		<td>${list.CATE }</td>
		
		<td>${list.WRITER_ID }</td>
		<c:if test="${empty list.REPORT_TYPE }">
		<td></td>
		</c:if>
		<td>${list.REPORT_TYPE }</td>
		<td>${list.REPORT_DATE }</td>
        <td><button class="delete_btn" onclick="deleteBoard(${list.BOARD_NO})">삭제</button></td>
	</tr>
</c:forEach>

</tbody>
</table>
</div><!-- #reportBoard -->

<hr>


<!-- 댓글 신고 목록 -->
<h3>댓글 신고 목록</h3>
<div id="reportComment">
<table class="table table-striped table-sm">

<colgroup>
	<col style="width: 7%;">
	<col style="width: 8%;">
	<col style="width: 8%;">
	<col style="width: 15%;">
	<col style="width: 6%;">
	<col style="width: 8%;">


	<col style="width: 13%;">
	<col style="width: 15%;">
	<col style="width: 15%;">
	<col style="width: 5%;">
</colgroup>

<thead>
	<tr class="table-danger">
		<th>신고번호</th>
		<th>게시글번호</th>
		<th>댓글번호</th>
		<th>댓글내용</th>
		<th>메뉴</th>
		
		<th>카테고리</th>
		<th>작성자</th>
		<th>신고종류</th>
		<th>신고날짜</th>
		<th>삭제</th>
	</tr>
</thead>

<tbody>
<c:forEach var="list" items="${reportCmtList }">
	<tr>
		<td>${list.REPORT_NO }</td>
		<td>${list.BOARD_NO }</td>
		<td>${list.CMT_NO }</td>
		<td>${list.CONTENT }</td>
		<td>${list.MENU }</td>
		
		<td>${list.CATE }</td>
		<td>${list.WRITER_ID }</td>
		<td>${list.REPORT_TYPE }</td>
		<td id="">${list.REPORT_DATE }</td>
        <td><button class="delete_btn" onclick="deleteComment(${list.CMT_NO})">삭제</button></td>
	</tr>
</c:forEach>
</tbody>
</table>
</div><!-- #reportComment -->




</div><!-- #adminContent -->



</body>
</html>