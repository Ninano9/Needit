<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/views/admin/admin.jsp" />

<style>
#adminBusiness{
	background-color: #ff8108;
	width: 302px;
}

#tableWrapper th{
	position: sticky;
    top: 0px;
}
#tableWrapper{
	overflow-x: hidden;
	overflow-y: scroll;
	height: 315px;
}

#adminContent{
	width: 80%;
}
.approveButton{
    width: 82px;
    height: 26px;
    vertical-align: middle;
    background-color: inherit;
    border: 2px solid blue;
    border-radius: 5px;
    font-weight: bold;
}
.cancelButton{
    width: 106px;
    height: 26px;
    vertical-align: middle;
    background-color: inherit;
    border: 2px solid red;
    border-radius: 5px;
    font-weight: bold;
}

/* Webkit 브라우저를 위한 스타일 */
#tableWrapper::-webkit-scrollbar { width: 12px; }
#tableWrapper::-webkit-scrollbar-track { background: #f1f1f1; border-radius: 10px; }
#tableWrapper::-webkit-scrollbar-thumb { background-color: transparent; border-radius: 10px;background: #ff533f; }

</style>

<script type="text/javascript">
$(document).ready(function() {
    $(".approveButton").click(function() {
        var id = $(this).data('id');
        console.log("id : ", id);
        $.ajax({
            type: "POST",
            url: "/admin/approveBusiness",
            data: {
                id: id
            },
            success: function(response) {
            	console.log("AJAX성공")
            	console.log("response : ",response)

                var target = $(".approveButton[data-id='" + id + "']");
            	console.log(target[0])
                if(response === "done"){
                	console.log("함수 실행")
                	target.removeClass("req").addClass("done");
                	console.log(target[0])
                	target.text("승인됨")
                }
                
            },
            error: function(xhr, status, error) {
            }
        });
    });

    $(".cancelButton").click(function() {
        var id = $(this).data('id');
        cancelBusiness(id);
    });
});


function cancelBusiness(id) {
    $.ajax({
        type: "POST",
        url: "/admin/cancelBusiness",
        data: {
            id: id
        },
        success: function(response) {
        },
        error: function(xhr, status, error) {
        }
    });
}
    
    
</script>


<!-- 안쪽 내용 -->
<div id="adminContent">

<div id="tableWrapper">
<table class="table table-striped table-sm">

<colgroup>
	<col style="width: 10%;">
	<col style="width: 10%;">
	<col style="width: 20%;">
	<col style="width: 20%;">
	<col style="width: 20%;">
	
	<col style="width: 10%;">
	<col style="width: 10%;">
</colgroup>

<thead>
	<tr class="table-danger">
		<th>아이디</th>
		<th>업체 이름</th>
		<th>업체 주소</th>
		<th>업체 전화번호</th>
		<th>업체 URL</th>

		<th>승인</th>
		<th>거절</th>
	</tr>
</thead>

<tbody>
<c:forEach var="list" items="${businessList }">
	<tr>
		<td>${list.ID }</td>
		<td>${list.BUSINESS_NAME }</td>
		<td>${list.BUSINESS_ADDR }</td>
		<td>${list.BUSINESS_PHONE }</td>
		<td>${list.BUSINESS_URL }</td>
		<c:if test="${list.BUSINESS_STATUS eq 1 }">
			<td><button class="approveButton req" data-id="${list.ID}">승인</button></td>
		</c:if>
		<c:if test="${list.BUSINESS_STATUS eq 2 }">
			<td><button class="approveButton done" data-id="${list.ID}" disabled="disabled">승인됨</button></td>
		</c:if>
		<c:if test="${list.BUSINESS_STATUS eq 1 }">
        	<td><button class="cancelButton" data-id="${list.ID}">거절</button></td>
        </c:if>
		<c:if test="${list.BUSINESS_STATUS eq 2 }">
        	<td><button class="cancelButton" data-id="${list.ID}">등록해제</button></td>
        </c:if>
	</tr>
</c:forEach>
</tbody>
</table>

</div><!-- #tableWrapper -->
</div><!-- #adminContent -->

</body>
</html>