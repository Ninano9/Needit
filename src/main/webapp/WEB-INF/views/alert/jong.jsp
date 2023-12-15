<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Inse</title>
<style type="text/css">
#newIcon {
	color: white;
	font-size: 10px;
	border: 1px solid rgb(255,83,63);
	background-color: rgb(255,83,63);
	border-radius: 5px;
	width: 32px;
	height: 20px;
	display: inline-block;
	z-index: 2;
	vertical-align: middle;
	text-align: center;
}
#newIcon1 {
	margin-top: 1px;
	text-align: center;
	vertical-align: middle;
}
#new-icon-text{
	display: none;
}
#alertData li:first-child{
	font-weight: bold;
}
#alertData{
	margin-bottom: 0px;
	margin-left: 10px;
}
.btn-close {
    display: none;
  }
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
$(function() {
	
    $(".alertData").click(function() {
		$.ajax({
			type: "post"
			, url: "/alert/read"
			, data: { alertNo: $(this).data("alert") }
			, dataType: "json"
			, success: function( res ) {
				loadAlert() // 알람을 읽었을 때 안읽은 알람들을 불러옴
				hasNew() // 알람을 읽었을 때 새로 생긴 알람이 있는지 확인해서 불러옴
			}
			, error: function() {
			}
		})
	})
	
    $(".delAlert").click(function() {
    	event.preventDefault();
		$.ajax({
			type: "post"
			, url: "/alert/delete"
			, data: { alertNo: $(this).data("alert") }
			, success: function( res ) {
				loadAlert() // 알람을 읽었을 때 안읽은 알람들을 불러옴
				hasNew() // 알람을 읽었을 때 새로 생긴 알람이 있는지 확인해서 불러옴
			}
			, error: function() {
			}
		})
	})
	
    $("#allDel").click(function() {
    	var $id = "${id}"
		$.ajax({
			type: "post"
			, url: "/alert/delAll"
			, data: { id : $id }
			, success: function( res ) {
				loadAlert() // 알람을 읽었을 때 안읽은 알람들을 불러옴
				hasNew() // 알람을 읽었을 때 새로 생긴 알람이 있는지 확인해서 불러옴
			}
			, error: function() {
			}
		})
	})
	 $(".alertData").hover(
		      function() {
		        // Mouse enter
		        $(this).find(".btn-close").show();
		      },
		      function() {
		        // Mouse leave
		        $(this).find(".btn-close").hide();
		      }
		    );
})

</script>
</head>
<body>

<div class="wrap-content ">
	<c:forEach var="list" items="${list }">	
	<ul class="alertData " id="alertData" data-alert="${list.alertNo }">
		<li style="float: right" class="delAlert " id="delAlert" data-alert="${list.alertNo }"><button type="button" class="btn-close"></button></li>
		<li>
			<c:if test="${list.menu eq 1 }">[대여]</c:if>
			<c:if test="${list.menu eq 2 }">[나눔]</c:if>
			<c:if test="${list.menu eq 3 }">[해주세요]</c:if>
			<c:if test="${list.menu eq 4 }">[커뮤니티]</c:if>
			<c:if test="${list.menu eq 5 }">[동네업체]</c:if>
			<c:if test="${list.menu eq 6 }">[채팅]</c:if>
			<c:if test="${list.alertStatus eq 0 }"> <div id="newIcon"><div id="newIcon1">NEW</div></div> </c:if>
		</li>
		<li>
			<c:if test="${list.content eq 1 }">"${list.title }"에서 <br> 승인 완료 됐습니다.</c:if>
			<c:if test="${list.content eq 2 }">"${list.title }"에서 <br> 승인 요청 중입니다.</c:if>
			<c:if test="${list.content eq 3 }">"${list.title }"에서 <br> 승인 취소 됐습니다.</c:if>
			<c:if test="${list.content eq 4 }">${list.sender } 님이 <br> 댓글을 남겼습니다.</c:if>
			<c:if test="${list.content eq 5 }">${list.sender } 님에게 <br> 새로운 메세지가 왔습니다.</c:if>
			<c:if test="${list.content eq 6 }">${list.sender } 님이 <br> 추천 하였습니다.</c:if>
		</li>
	</ul>
	</c:forEach>
</div><!-- .wrap-content  -->

</body>
</html>