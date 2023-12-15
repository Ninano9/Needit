<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지도</title>

<style type="text/css">

/* 전체 박스를 감싸는 DIV 오버레이 설정 */
.wrapMap {
	position: absolute;
	left: -5px;bottom: 40px;
	width: 300px;
	height: 132px;
	margin-left: -144px;
	text-align: left;
	overflow: hidden;
	font-size: 12px;
	font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
	line-height: 1.5;
}

/* 전체 박스를 감싸는 DIV의 전체 설정 */
.wrapMap * {
	padding: 0;
	margin: 0;
}

/* 전체 박스 DIV 오버레이 설정 */
.wrapMap .info {
	width: 300px;
	height: 121px;
	border-radius: 5px;
	border-bottom: 2px solid #ccc;
	border-right: 1px solid #ccc;
	overflow-x: hidden;
    overflow-y: scroll;
	background: #fff;
    scrollbar-width: thin;
    scrollbar-color: transparent transparent;
}


/* Webkit 브라우저를 위한 스타일 */
.wrapMap .info::-webkit-scrollbar { width: 12px; }
.wrapMap .info::-webkit-scrollbar-track { 
     background: #f1f1f1;  /*스크롤바 뒷 배경 색상*/
     border-radius: 10px;
}
.wrapMap .info::-webkit-scrollbar-thumb { 
	background-color: transparent; 
    border-radius: 10px; /* 스크롤바 둥근 테두리 */
	background: #ff533f;
}

/* 박스의 그림자 설정 */
.wrapMap .info:nth-child(1) {
	border: 0;
	box-shadow: 0px 1px 2px #888;
}

/* 주소 부분 오버레이 설정 */
.info .address {
	padding: 2px 0 0 5px;
	height: 30px;
	color: white;
    background: rgb(255 83 63);
	border-bottom: 1px solid #ddd;
	font-size: 18px;
	font-weight: bold;
	overflow: hidden;
  	white-space: nowrap;
  	text-overflow: ellipsis;
  	word-break: break-all;
}

/* 'X'표시 오버레이 설정 */
.info .close {
	position: absolute; 
	z-index: 1; 
	top: 5px;
	right: 15px;
	width: 17px;
	height: 17px;
	background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');
}

/* 'X'표시에 마우스를 올렸을 때 설정 */
.info .close:hover { cursor: pointer; }

/* 이미지, desc 를 포함하는 DIV 오버레이 설정 */
.info .body {
	position: relative;
	overflow: hidden;
}

/* 제목, 가격, 링크 부분을 감싸는 desc DIV 스타일 설정 */
.info .desc {
	position: relative; 
	margin: -55px 0 0 90px; 
	height: 75px;
}

/* 제목 스타일 설정 */
.desc .title {
	height: 40px;
    width: 190px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: initial;
}

/* 가격 스타일 설정 */
.desc .price {
	font-size: 12px;
	color: #888;
	margin-top: 0px;
}

/* 썸네일 부분 오버레이 설정 */
.info .img {
	position: relative; 
	top: 6px; 
	left: 5px;
	width: 73px; 
	height: 71px; 
	border: 1px solid #ddd; 
	color: #888; 
	overflow: hidden;
}

/* 썸네일 부분 오버레이 설정 */
.info .img img {
	position: relative; 
	width: 73px;
	height: 71px;
	border: 1px solid #ddd;
	color: #888;
	overflow: hidden;
}

/* 제목, 가격, 링크 부분 오버레이 설정 */
.info:after {
	content: '';
	position: absolute;
	margin-left: -12px;
	left: 50%;
	bottom: 0;
	width: 22px;
	height: 12px;
	background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
}

/* 하이퍼링크 스타일 설정 */
.info .link {color: #5085BB;}

.floating{
	display: none;
}
</style>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1b5f231240cb73d46a6f0aa5b0d4c5e1&libraries=services"></script>
<script>

var map; // 지도
var geocoder = new kakao.maps.services.Geocoder();
var center; // 중심 좌표
var latlng // 얻은 좌표 
var markers = []; // 마커 배열

$(function () {
		
	var mapContainer = $('#map')[0]; // 지도를 표시할 div
	
	// 기본 맵 세팅 --------------------------------------------------------------------------
	if (navigator.geolocation) { // HTML5의 geolocation으로 사용할 수 있는지 확인합니다
		
		navigator.geolocation.getCurrentPosition(function(position) {	// GeoLocation을 이용해서 접속 위치를 얻어옵니다
			
			var lat = position.coords.latitude; // 위도
			var lon = position.coords.longitude; // 아래도 는 아니고 경도
			var content = '<div style="padding:5px;">현재 내 위치</div>'; // 인포윈도우에 표시될 내용입니다
			center = new kakao.maps.LatLng(lat, lon);
			
			// 현재 내 위치로 설정
			var mapOption = { center: center, level: 3 }; // 맵 기본 옵션 설정 [center : 중심 좌표 설정, level : 확대 레벨 ]
			
			initMap( $('#map')[0], mapOption )
			initCircle( center )
			
// 			console.log( 'map은 존재하는가?', map)
			
			kakao.maps.event.addListener(map, 'dragend', function() {   // 지도를 이동했을 때 발생하는 이벤트      
			    latlng = map.getCenter(); // 지도 중심좌표를 얻어옵니다   
			    center = new kakao.maps.LatLng( latlng.getLat(), latlng.getLng() )
			    clearMarkers(); // 이전 마커를 모두 제거
			    initCircle( center )
			});
			
			kakao.maps.event.addListener(map, 'zoom_changed', function() { // 지도를 확대, 축소 했을 때 발생하는 이벤트
			    latlng = map.getCenter(); 
			    center = new kakao.maps.LatLng( latlng.getLat(), latlng.getLng() )
			    clearMarkers(); // 이전 마커를 모두 제거
			    initCircle( center )			    
			});
			
		}); // function(position) 끝
		
	} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
		
		// 기본 주소 => 학원 좌표
		var mapOption = { center: new kakao.maps.LatLng(37.499181, 127.032789), level: 3 };
		alert('현재 위치가 아닙니다!!!')
		
		initMap( $('#map')[0], mapOption )
		initCircle( center )

// 		console.log( 'map은 존재하는가?', map)
		
		kakao.maps.event.addListener(map, 'dragend', function() {   // 지도를 이동했을 때 발생하는 이벤트      
		    latlng = map.getCenter(); // 지도 중심좌표를 얻어옵니다   
		    center = new kakao.maps.LatLng( latlng.getLat(), latlng.getLng() )
		    clearMarkers(); // 이전 마커를 모두 제거
		    initCircle( center )
		});
		
		kakao.maps.event.addListener(map, 'zoom_changed', function() { // 지도를 확대, 축소 했을 때 발생하는 이벤트
		    latlng = map.getCenter(); 
		    center = new kakao.maps.LatLng( latlng.getLat(), latlng.getLng() )
		    clearMarkers(); // 이전 마커를 모두 제거
		    initCircle( center )			    
		});
		
	}// if (navigator.geolocation) 끝
	
	$("#myLoc").on( 'click', function() { moveCenter() }); // #mtLoc 클릭 이벤트 - 내 위치로 이동 펑션
	
	
	
}); // jQuery펑션 끝

// ajax로 DB에서 객체(Json) 불러오기
function loadInfo( circle ) {		
	$.ajax({
		type: "get" // 보내는 데이터가 없기 때문에 get으로 불러오기만 해도됨
		, url: "/map/list" // 맵에 띄울 정보 받아올 mapping
		, data: {}  // 한번에 다 받아 오는거라 데이터 필요없음
		, dataType: "json"
		, async: "false" // 비동기식 호출 => 응답이 모두 완료 된 후 로직 실행
		, success: function( res ){
// 			console.log("AJAX 성공")
// 			console.log(res)
			//제이쿼리 배열 관리 메소드 - each()
			// each() 메서드는 매개 변수로 받은 것을 사용해 for in 반복문과 같이 배열이나 객체의 요소를 검사할 수 있는 메서드
				// $.each(object, function(index, item){});
			$.each(res.board, (idx, val) => {
// 				console.log(idx, val)

				geocoder.addressSearch( val[0].location, ( result, status ) => { // 주소-좌표 변환 객체
					
					// 정상적으로 검색이 완료됐으면
					if (status === kakao.maps.services.Status.OK) {
						
						var imageSrc = '/resources/img/marker.png', // 마커이미지의 주소입니다    
					    imageSize = new kakao.maps.Size(45, 45), // 마커이미지의 크기입니다
					    imageOption = {offset: new kakao.maps.Point(22, 40)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
						// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
						var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
						
						var markerPosition = new kakao.maps.LatLng(result[0].y, result[0].x) // 마커 생성 위치
							
						var circleCenter = circle.getPosition();
                        // 중심 좌표와 마커 좌표 간의 거리 계산
                        var distance = haversineDistance(
                       		circleCenter.getLat(),
                       		circleCenter.getLng(),
                            markerPosition.getLat(),
                            markerPosition.getLng()
                        );
						
						if ( distance <= circle.getRadius()/1000 ) {
// 							console.log( '거리', distance )
// 							console.log( '반지름', circle.getRadius() )
							
							var marker = new kakao.maps.Marker({ // KAKAO 마커 생성 객체
								map: map,
								position: markerPosition,
								image: markerImage
							}) // 마커 생성 끝
							
					        // 마커 배열에 추가
					        markers.push(marker);
							
							// 오버레이 DIV 설정
							var $wrap = $('<div class="wrapMap">')
							
							// 모든 정보를 감싸는 DIV
							var $info = $('<div class="info">')
							
							var addrLink = 'https://map.kakao.com/link/map/' + val[0].location + ',' + result[0].y  + ',' + result[0].x;
							// 마커의 위치가 들어갈 부분
							var $address = $('<div class="address">').text(val[0].location);							
							// 'X' 닫기 버튼 들어갈 부분 + click fucntion 들어감
							var $close = $('<div class="close" title="닫기" />').click(closeOverlay)
							
							// content에 클릭 이벤트를 추가
							$address.on('click', function() {
							    // 링크 이동
							    window.open(addrLink, '_blank');
							});
							
							// .img와 .desc를 감싸는 DIV
							var $body = $('<div class="body">')
						
							$wrap.append($info);
							$info.append($address).append($body);
							$address.append($close);
							
						    $info.on('mouseover', function() { // 오버레이에 마우스를 올렸을 때
						    	map.setZoomable(false); // 맵 확대-축소 기능 끄기
								$(this).on('wheel', function (e) {  // 오버레이에서 스크롤 할 때
					                e.preventDefault(); // 기본 스크롤 이벤트 제거
					                var delta = e.originalEvent.deltaY || e.originalEvent.wheelDelta;
					                var direction = delta > 0 ? 1 : -1;
					                var scrollTop = $(this).scrollTop(); // 스크롤 이벤트에 따라 스크롤 위치 변경
					                $(this).scrollTop(scrollTop + direction * 30); // 몰라잉
					            }); // 'wheel' 끝
						    }); // 'mouseover' 끝
						    
					        // info 클래스를 가진 div에 마우스 아웃 이벤트 추가
					        $info.on('mouseout', function () {
					        	map.setZoomable(true);
					            $(this).off('wheel');
					        });
						
							
					$.each(val, (i, v) => { // 같은 주소를 가지는 데이터들의 반복문
							
							var number = Number(v.price); // 가격 저장 변수
							var formattedNumber = number.toLocaleString(); // 가격 format 변수
							
							if( v.menu == '1' ) {
								var link = 'http://localhost:8088/rent/view?boardNo=' + v.boardNo + '&menu=' + v.menu + '&cate=' + v.cate;
							} else if( v.menu == '2' ) {
								var link = 'http://localhost:8088/share/view?boardNo=' + v.boardNo + '&menu=' + v.menu + '&cate=' + v.cate;
							} else if( v.menu == '3' ) {
								var link = 'http://localhost:8088/please/view?boardNo=' + v.boardNo + '&menu=' + v.menu + '&cate=' + v.cate;
							} else {
								var link = 'http://localhost:8088/'; 
							}
						
							var $content = $('<div class="content"><hr>'); // 제목을 제외한 컨텐츠 들어가는 부분
							var $img = $('<div class="img">'); // 썸네일 들어가는 DIV 부분
							
							// content에 클릭 이벤트를 추가
							$content.on('click', function() {
							    // 링크 이동
							    window.open(link, '_blank');
							});
							
						      $.ajax({
						         type: "POST"
						         , url: "/map/thumb"
						         , data: { boardNo : v.boardNo }
						         , dataType: ""
						         , success: function( res ){
						            var $thumbNail = res.thumbNail;
						            if( $thumbNail != null ){
										// 이미지 넣는 부분
										var $imgContent = $('<img src="/upload/' + $thumbNail + '" width="73" height="70">');
						            } else {
										var $imgContent = $('<img src="/resources/img/noimg.png" width="73" height="70">');
						            }
									var $desc = $('<div class="desc">'); // 글제목, 가격, 링크 들어가는 부분을 감싸는 DIV 
									var $title = $('<div class="title">').text(v.title); // 글 제목이 들어갈 부분
									var $price = $('<div class="price">').text(formattedNumber); // 가격이 들어갈 부분
									
									// 글 링크 추가 부분
		// 							var $homelink = $('<div><a href="https://www.kakaocorp.com/main" target="_blank" class="link">바로가기</a></div>')
									
									$body.append($content)
									$content.append($img).append($desc)
									$img.append($imgContent)
									$desc.append($title).append($price)
		// 							$desc.append($title).append($price).append($homelink)
		
						         }
						         , error: function(){
						        	alert('오류가 발생했습니다')
// 						            console.log("AJAX 실패")
						         }
						      })
	
					});// veach펑션 끝
					
							var overlay = new kakao.maps.CustomOverlay({ // KAKAO 커스텀 오버레이 생성 객체
								content: $wrap[0], 
								map: map,
								position: marker.getPosition()
							}); // overlay 생성 끝
							overlay.setMap(null) // 지도에 오버레이 안뜨게 설정
							
							function closeOverlay(content) { // 오버레이를 닫는 함수
								event.stopPropagation(); // 이벤트 버블링 막기
// 								console.log('Closing overlay for content:', content);
								overlay.setMap(null); 
					        	map.setZoomable(true);
							} // closeOverlay 끝
							
							kakao.maps.event.addListener(marker, 'click', function(e) { // 마커를 눌렀을 때 지도가 뜨는 펑션
								overlay.setMap(map) 
							}) // click 이벤트 끝
							
						} //if ( distance <= circle.getRadius()/1000 )
					} // 검색 if문 끝
				}) // geocoder 끝
			})// $.each() 끝

		}// success 끝
		, error: function(){
			alert('오류가 발생했습니다')
// 			console.log("AJAX 실패")
		}
	})// ajax끝
	
    // Add mousewheel event handler for the overlay content
    $('.info').on('mousewheel', function (event) {
        // Calculate the new scroll position
        var scrollTop = $(this).scrollTop() - (event.deltaY * 30);

        // Set the new scroll position
        $(this).scrollTop(scrollTop);

        // Prevent the default scrolling behavior
        event.preventDefault();
    });
	
	
}// loadInfo 끝

function initMap( mapContainer, mapOption ) { // map 생성 함수
	map = new kakao.maps.Map( mapContainer, mapOption ); // 지도 생성
	
	var zoomControl = new kakao.maps.ZoomControl(); // 줌컨트롤 객체 생성
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT); // 줌컨트롤 추가 및 배치 위치 설정
	map.setMaxLevel(7); // 맵 최대 축소 설정
} // initMap() 끝

function moveCenter(){ // 현재 내 위치로 이동합니다
	if (navigator.geolocation) { // HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
		navigator.geolocation.getCurrentPosition(function(position) {	// GeoLocation을 이용해서 접속 위치를 얻어옵니다
			
		lat = position.coords.latitude; 
		lon = position.coords.longitude; 
							
		center = new kakao.maps.LatLng(lat, lon)
		map.setCenter( center )
		initCircle( center )
		
		}); // function(position) 끝
		
	} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
		// 기본 주소 => 학원 좌표
		center = new kakao.maps.LatLng(37.499181, 127.032789)
		map.setCenter( center )
	
	}// if (navigator.geolocation) 끝
} // moveCenter() 끝

//하버사인 공식을 사용한 거리 계산 함수
function haversineDistance(lat1, lon1, lat2, lon2) {
    function toRad(value) {
        return (value * Math.PI) / 180;
    }
    var R = 6371; // 지구의 반지름 (단위: km)
    var dLat = toRad(lat2 - lat1);
    var dLon = toRad(lon2 - lon1);
    var a =
        Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) * Math.sin(dLon / 2) * Math.sin(dLon / 2);
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    var distance = R * c;

    return distance;
} // haversineDistance() 끝

function initCircle( center ) {
// 	console.log( '현재 지도 레벨은요??' , map.getLevel() )
	var mapLv = map.getLevel();
	if( mapLv <= 3 ){ // 현재 지도 레벨에 따른 마커 생성 범위
		var mapRadius = 2000 // 2km
	} else if( mapLv == 4 ) {
		var mapRadius = 3000 // 3km
	} else if( mapLv == 5 ) {
		var mapRadius = 4000 // 4km
	} else if( mapLv == 6) {
		var mapRadius = 5000 // 5km
	} else { // mapLv이 7일 때
		var mapRadius = 6000 // 5km
	}
	
    var circle = new kakao.maps.Circle({
        center: center,
        radius: mapRadius, // 반경 2km
        strokeWeight: 1, // 선 두께
        strokeColor: '#75B8FA', // 선 색상
        strokeOpacity: 0,
        fillColor: '#CFE7FF', // 채우기 색상
        fillOpacity: 0
    });
    
    circle.setMap(map); // 지도에 원 표시
    loadInfo( circle ) 
} // initCircle( center ) 끝

function clearMarkers() {
    for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(null);
    }
    markers = [];
} // clearMarkers() 끝

</script>	

</head>
<body>

<!-- 지도를 담을 DIV  -->
<div id="mapArea" style="position: relative;">
	<div id="map" style="width:100%;height:235px; z-index: 3; border-radius: 10px;"></div>
	<img id="myLoc" src="/resources/img/myLocation.png" alt="내위치" style="width: 25px; height:25px; z-index: 5; position: absolute; right: 5px; bottom: 10px">
</div>


</body>
</html>