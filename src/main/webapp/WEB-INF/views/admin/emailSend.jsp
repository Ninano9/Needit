<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/views/admin/admin.jsp" />

<style>
/* 왼쪽 목록 선택시 색상 */
#adminEmail{
	background-color: #ff8108;
	width: 302px;
}
#adminContent{
	width: 80%;
}

/* 이메일 목록 */
#emailList{
	width: 1200px;
    height: 153px;
	border: 1px solid black;
	margin-left: 10px;
}

.emailGroup {
    display: inline-block;
    vertical-align: top;
    margin-right: 20px;
}
#emailSendList {
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    gap: 30px;
    height: 140px;
    overflow-x: hidden;
    overflow-y: scroll; 
}

/* Webkit 브라우저를 위한 스타일 */
#emailSendList::-webkit-scrollbar { width: 12px; }
#emailSendList::-webkit-scrollbar-track { background: #f1f1f1; border-radius: 10px; }
#emailSendList::-webkit-scrollbar-thumb { background-color: transparent; border-radius: 10px;background: #ff533f; }

</style>

<script type="text/javascript">


function sendEmail(event) {
    event.preventDefault();

    let selectedEmails = [];
    $('input[name="email"]:checked').each(function() {
        selectedEmails.push($(this).val());
    });

    let title = $("#emailTitle").val();
    let content = $("#emailContent").val();
    
    if (!selectedEmails || selectedEmails.length === 0) {
        alert("이메일을 선택해주세요.");
        return; 
    }
    if (title.trim() === '') {
        alert("제목을 입력해주세요.");
        return; 
    }

    $.ajax({
        url: "/admin/emailSend",
        type: "post",
        traditional: true,
        data: {
            'm_email': selectedEmails,
            'title': title,
            'content': content
        },
        success: function(response) {
            alert("이메일이 정상적으로 발송되었습니다.");
            $("#emailTitle").val('');
            $("#emailContent").val('');
            $('input[name="email"]').prop('checked', false);
            
            $('#emailSendList input[type="checkbox"]').prop('checked', false);
        },
        error: function () {
            alert("전송실패");
        }
    });
}

$(document).ready(function() {
    $('#emailForm').submit(sendEmail);
    
    $('#selectAll').click(function() {
        $('input[name="email"]').prop('checked', $(this).prop('checked'));
    });
    
    
    $('input[name^="selectSend"]').click(function() {
        var container = $(this).parent('.verticalContent, .horizontalContent');
        var checkboxes = container.siblings('.verticalContent, .horizontalContent').find('input[type="checkbox"]');
        
        if ($(this).is(":checked")) {
            checkboxes.prop('checked', false);
            var title = $(this).data('title');
            var content = $(this).data('content');
            content = content.replace(/\\n/g, '\n');
            content = content.replace(/\n/g, '<br>');
            
            $('#emailTitle').val(title);
            $('#emailContent').val(content);
        }
    });
});

var expanded = false;

function showCheckboxes() {
  var checkboxes = document.getElementById("checkboxes");
  if (!expanded) {
    checkboxes.style.display = "block";
    expanded = true;
  } else {
    checkboxes.style.display = "none";
    expanded = false;
  }
}



</script>

<!-- 안쪽 내용 -->
<div id="adminContent">

<!-- <label>이메일 목록</label><br> -->
<!-- <div id="emailList"> -->
<!-- <select name="email" id="email" > -->
<!-- 	<option value="all">전체</option> -->
<%-- 		<c:forEach var="list" items="${emailList}"  > --%>
<%-- 			<option value="${list.EMAIL}"<c:if test="${(email) == (list.EMAIL)}">selected</c:if>>${list.EMAIL}</option> --%>
<%-- 		</c:forEach> --%>
<!-- </select> -->
<!-- </div> -->

<label style="margin-left: 10px;">이메일 목록</label><br>
<div id="emailList" onclick="showCheckboxes()">
    <div style="margin-left: 20px; margin-top: 4px;">
	    <input type="checkbox" id="selectAll" name="selectAll">
	    <label for="selectAll" >전체 선택</label><br>
    </div>

    <div class="emailGroup">
        <c:forEach var="list" items="${emailList}" varStatus="loop">
            <c:if test="${loop.index % 5 == 0}">
                </div><div class="emailGroup">
            </c:if>
            <input type="checkbox" id="${list.EMAIL}" name="email" value="${list.EMAIL}">
            <label for="${list.EMAIL}">${list.EMAIL}(${list.NICK})</label><br>
        </c:forEach>
    </div>
</div><br>

<div id="emailDiv" class="ms-2">
<form id="emailForm" action="/admin/emailSend" method="post">
  
<!-- 제목 -->
<div align="center">
	<input type="text" name="title" id="emailTitle" size="120" style="width: 100%" placeholder="제목을 입력해주세요" class="form-control">
</div><br>

<!-- 내용 -->
<div align="center">
	<textarea name="content" id="emailContent" cols="120" rows="12" style="width: 100%; height: 100px; resize: none;" placeholder="내용" class="form-control"></textarea>
</div>

<div>
	<input type="submit" value="메일 보내기" class="btn btn-warning mt-1" onclick="sendEmail()">
</div>
</form>
</div><!-- #emailDiv -->

<div id="emailSendList" class="ms-2">
<div class="verticalContent">
    <input type="checkbox" id="selectSend1" name="selectSend" data-title="Needit 서버점검 공지"
           data-content="<strong>서버점검이 있을 예정입니다.</strong>
                            금일 오전 10시 ~ 오후 1시 까지 서버가 작동하지 않을 수 있습니다.
                            양해 부탁드립니다.
                            
                            감사합니다.">
    <label for="selectSend1">Needit 서버점검 공지</label><br>
    <label for="selectSend1">
        <strong>서버점검이 있을 예정입니다.</strong><br>
        금일 오전 10시 ~ 오후 1시 까지 서버가 작동하지 않을 수 있습니다.<br>
        양해 부탁드립니다.<br><br>
        감사합니다.<br>
    </label><br>
</div>

<div class="verticalContent">
    <input type="checkbox" id="selectSend2" name="selectSend" data-title="Needit에 오신것을 환영합니다." data-content="홈페이지 방문해주셔서 감사합니다.">
    <label for="selectSend2">Needit에 오신것을 환영합니다.</label><br>
    <label for="selectSend2">홈페이지 방문해주셔서 감사합니다.</label><br>
</div>

<div class="verticalContent">
    <input type="checkbox" id="selectSend3" name="selectSend" data-title="Needit" data-content="신고로 인해 게시물이 삭제되었습니다.">
    <label for="selectSend3">Needit</label><br>
    <label for="selectSend3">신고로 인해 게시물이 삭제되었습니다.</label><br>
</div>

    
</div><!-- #emailSendList -->

</div><!-- #adminContent -->


</body>
</html>