<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- 결제CDN --%>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>

<%-- 결제요청 처리 --%>
<script type="text/javascript">

function generateRandomMerchantUid() {
    // 형식: "yyyyMMddHHmmss" + 임의의 6자리 숫자
    var currentDate = new Date();
    var formattedDate = currentDate.getFullYear().toString() +
        pad(currentDate.getMonth() + 1) +
        pad(currentDate.getDate()) +
        pad(currentDate.getHours()) +
        pad(currentDate.getMinutes()) +
        pad(currentDate.getSeconds());

    var randomSixDigit = pad(Math.floor(Math.random() * 1000000));

    return formattedDate + randomSixDigit;
}

function pad(number) {
    // 한 자리 숫자인 경우 앞에 0을 추가하여 두 자리로 만듭니다.
    return (number < 10 ? '0' : '') + number;
}

var randomMerchantUid;
console.log('주문번호 생성 : ', randomMerchantUid)



<%-- 결제창 호출 --%>

// 결제 방법이 변경될 때 호출될 함수
function onPaymentTypeChange() {
    var selectedPaymentType = $("#paymentType").val();

    // 온라인 결제인 경우 추가 처리
    if (selectedPaymentType === "1") {
        // 날짜와 시간이 선택되었는지 확인
        var selectedDate = $("#selectedDate").val();
        var startTime = fromTime;
        var endTime = toTime;

        if (!selectedDate || startTime === 0 || endTime === 0 || startTime >= endTime) {
            // 날짜 또는 시간이 선택되지 않았을 경우 알림창 띄우기
            alert("날짜와 시간을 먼저 선택해주세요.");
            $("#paymentType").val(""); // 선택된 결제 방법 초기화
            return;
        }

        // 선택된 결제 방법이 "1" (온라인 결제)이고, 날짜와 시간이 모두 선택되었을 때 requestPay 함수 호출
        requestPay();
    }
}

// 이벤트 핸들러 등록
$(document).ready(function () {
	$("#paymentType").change(onPaymentTypeChange);
	randomMerchantUid = generateRandomMerchantUid()*1;
});

var IMP = window.IMP;
IMP.init("imp47417351");


function requestPay() {
	
	console.log("온라인결제 버튼 눌린 후 주문번호 : ", randomMerchantUid )
	
  IMP.request_pay(
    {
      pg: "html5_inicis",
      pay_method: "card",
      merchant_uid: randomMerchantUid,
      name: "${board.title}",
      amount: totalPrice - ${board.price},
      buyer_email: "xl7923@naver.com",
      buyer_name: "${nick}",
      buyer_tel: "010-2698-7923",
      buyer_addr: "서울특별시 강남구 삼성동",
      buyer_postcode: "123-456"
    },
    function (rsp) {
      // callback
      //rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.

    	if(rsp.success){
    		alert("결제성공\n대여신청 버튼을 눌러야 신청이 접수됩니다.");
    		
    	} else {
    		alert("결제실패");
    	
    	}
    }
  );
}

</script>

<%-- Style --%>
<style>
@import url('https://fonts.googleapis.com/css?family=Questrial&display=swap');

#rentModal {
   --bs-modal-width: 560px;
}

.Calendar {
    text-align: center;
    width: 100%;
}

.Calendar>thead>tr:first-child>td {
    font-family: 'Questrial', sans-serif;
    font-size: 1.1em;
    font-weight: bold;
}

.Calendar>thead>tr:last-child>td {
    font-family: 'Questrial', sans-serif;
    font-weight: 600;     
}

.Calendar>tbody>tr>td>p {
    font-family: 'Montserrat', sans-serif;
    height: 45px;
    width: 45px;
    border-radius: 45px;
    transition-duration: .2s;
    line-height: 45px;
    margin: 2.5px;
    display: block;
    text-align: center;
}        

.pastDay {
    color: lightgray;
}

.today {
    background-color: #F5D042;            
    color: #fff;
    font-weight: 600;
    cursor: pointer;
}

.futureDay {
    background-color: #FFFFFF;
    cursor: pointer;
}
.futureDay:hover{
    background:#eee;
}

.futureDay.choiceDay,
.today.choiceDay {
    background: rgb(255,83,63);
    color: #fff;
    font-weight: 600;
    cursor: pointer;
}

#makeRent {
   color: white;
   background-color: rgb(255,83,63);
}

#startTmSelected td {
   padding: 0;
}
#startTmSelected td div {
   padding: 0.75em;
   text-align: center;
}

.reserved {
   background-color: #ccc;
   text-decoration-line:line-through;
}

.reserving {
   background-color: rgb(255,83,63);
   color: white;
}
#paymentType {
   border-radius: 5px;
    text-align: center;
    height: 40px;
    margin-bottom: 10px;
    margin-right: 10px;
    width: 420px;
    appearance: none;
   -webkit-appearance: none;
    -moz-appearance: none;
}
.rentBtn-container {
   text-align: right;
}
.paymentContainer, .rentBtn-container {
   display: inline-block;
   vertical-align: top;
}
</style>

<%-- 전역변수 Script --%>
<script>
var now = new Date(); //renderTable() 함수에서 시간표시 해주는 for문에 targetnow변수와 비교에 사용할 변수
var clickedDate; //renderTable() 함수에서 시간표시 해주는 for문에서 targetnow변수에 현재일자로 넣어줄 매개변수
var selectedCount; //
var totalPrice;
</script>

<%-- 캘린더 생성 --%>
<script>
    window.onload = function () { buildCalendar(); }    // 웹 페이지가 로드되면 buildCalendar 실행

    let nowMonth = new Date();  // 현재 달을 페이지를 로드한 날의 달로 초기화
    let today = new Date();     // 페이지를 로드한 날짜를 저장
    today.setHours(0, 0, 0, 0);    // 비교 편의를 위해 today의 시간을 초기화

    // 달력 생성 : 해당 달에 맞춰 테이블을 만들고, 날짜를 채워 넣는다.
    function buildCalendar() {

        let firstDate = new Date(nowMonth.getFullYear(), nowMonth.getMonth(), 1);
        let lastDate = new Date(nowMonth.getFullYear(), nowMonth.getMonth() + 1, 0);
        let tbody_Calendar = document.querySelector(".Calendar > tbody");
        document.getElementById("calYear").innerText = nowMonth.getFullYear();
        document.getElementById("calMonth").innerText = leftPad(nowMonth.getMonth() + 1);

        while (tbody_Calendar.rows.length > 0) {
            tbody_Calendar.deleteRow(tbody_Calendar.rows.length - 1);
        }

        let nowRow = tbody_Calendar.insertRow();

        for (let j = 0; j < firstDate.getDay(); j++) {
            let nowColumn = nowRow.insertCell();
        }

        for (let nowDay = firstDate; nowDay <= lastDate; nowDay.setDate(nowDay.getDate() + 1)) {

            let nowColumn = nowRow.insertCell();

            let newDIV = document.createElement("p");
            newDIV.innerHTML = leftPad(nowDay.getDate());
            nowColumn.appendChild(newDIV);

            if (nowDay.getDay() == 6) {
                nowRow = tbody_Calendar.insertRow();
            }

            if (nowDay < today) {
                newDIV.className = "pastDay";
            }
            else if (nowDay.getFullYear() == today.getFullYear() && nowDay.getMonth() == today.getMonth() && nowDay.getDate() == today.getDate()) {
                newDIV.className = "today";
                newDIV.onclick = function () { choiceDate(this); }
            }
            else if (nowDay.getMonth() == today.getMonth() + 1 || nowDay.getMonth() == today.getMonth() + 2) {
                newDIV.className = "futureDay futureMonth";
                newDIV.onclick = function () { choiceDate(this); }
            }
            else {
                newDIV.className = "futureDay";
                newDIV.onclick = function () { choiceDate(this); }
            }       
        }
    }

    // 날짜 선택
    function choiceDate(newDIV) {
        if (document.getElementsByClassName("choiceDay")[0]) {
            document.getElementsByClassName("choiceDay")[0].classList.remove("choiceDay");
        }
        newDIV.classList.add("choiceDay", "futureMonth");
    }

    // 이전달 버튼 클릭
    function prevCalendar() {
        nowMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() - 1, nowMonth.getDate());
        buildCalendar();
    }

    // 다음달 버튼 클릭
    function nextCalendar() {
        nowMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() + 1, nowMonth.getDate());
        buildCalendar();
    }

    // input값이 한자리 숫자인 경우 앞에 '0' 붙혀주는 함수
    function leftPad(value) {
        if (value < 10) {
            value = "0" + value;
            return value;
        }
        return value;
    }
</script>

<%-- 대여날짜,시간 선택 --%>
<script type="text/javascript">
$(function(){
   
    // 다음 달의 날짜에 대한 클릭 이벤트 추가
    $(".Calendar").on("click", ".futureMonth", function(){
        clickedDate = parseInt($(this).text()); // 문자열을 숫자로 변환
        console.log(clickedDate)
        let nextMonth = nowMonth.getMonth() + 1; // 현재 월에 1을 더해 다음 달로 설정
        let fullDate = new Date(nowMonth.getFullYear(), nextMonth - 1, clickedDate); // 월의 경우 1을 빼줌
        console.log("클릭한 날짜 선택", fullDate);
        
        // 선택한 날짜를 hidden input에 설정
        $("#selectedDate").val(fullDate.getTime());

        $("#time").show();
        renderTable(fullDate.getTime());
    });
});

//대여테이블 시간표 만들기
function renderTable(selectedDate) {
   
   var startSelect = $("#startTmSelected");
   var tmp = "";
   var reservedTime = [];
   var tempDate = new Date(parseInt(selectedDate));
   
   //예약정보 가져오기
   <c:forEach var="sta" items="${status}">
      var rentDate = new Date('${sta.RENT_DATE}');
      console.log(rentDate + "\r\n " + tempDate)
      
       if (rentDate.toLocaleString() ===  tempDate.toLocaleString()) {
         for (let i=${sta.START_TIME}; i<=${sta.END_TIME}; i++) {   
            reservedTime.push(i);
         }
      }
   </c:forEach>
   
   //대여시간 테이블 랜더링
   for (let i=1; i<=48; i++) {   
      var time = new Date('2023-01-01 00:00:00');
      time.setMinutes((i-1)*30);
      
      //현재 연도,월,날짜,시간 구하기
       var targetnow = new Date();
       targetnow.setYear(nowMonth.getFullYear())
       targetnow.setMonth(nowMonth.getMonth())
       targetnow.setDate(clickedDate)
      targetnow.setHours(Math.floor(((i-1) / 48) * 24))
       if (i % 2 === 0) {
          targetnow.setMinutes(30)
      } else {
         targetnow.setMinutes(0)
      }
       targetnow.setSeconds(0);
      
      //대여가능 시간 테이블 생성
      if ((i-1)%6==0) {tmp += '<tr>';}
      if (reservedTime.indexOf(i) == -1 && now<targetnow) {
         tmp += `<td><div type="button" name='endTime' value='\${i}' onClick="timeSet(event, \${i})">\${time.toString().substring(16,21)}</div></td>`;            
      } else {
         tmp += `<td><div type="button" name='endTime' value='\${i}' class="reserved">\${time.toString().substring(16,21)}</div></td>`;
      }
      if (i%6==0) {tmp += '</tr>';}
   }
   
   //HTML랜더링 처리
   startSelect.html(tmp);
   
}

</script>

<%-- 대여 신청 --%>
<script type="text/javascript">

let fromTime = 0;
let toTime = 0;

//이미 지나간 시간인지 확인하는 함수
function isPastTime(selectedDate, timeValue) {
    let currentTime = new Date();
    let selectedDateTime = new Date(selectedDate);
    selectedDateTime.setMinutes((timeValue - 1) * 30);

    return selectedDateTime < currentTime;
}

//대여할 시간 선택 영역 표시, 선택된 값 저장
function timeSet(event, t) {
   
   var selectedDate =  $("#selectedDate").val();
   var reservedTime = [];
   var tempDate = new Date(parseInt(selectedDate));
   
   <c:forEach var="sta" items="${status}">
      var rentDate = new Date('${sta.RENT_DATE}');
      console.log(rentDate + "\r\n " + tempDate)
      
       if (rentDate.toLocaleString() ===  tempDate.toLocaleString()) {
         for (let i=${sta.START_TIME}; i<=${sta.END_TIME}; i++) {   
            reservedTime.push(i);
         }
      }
   </c:forEach>
   
    <%-- 시간 세팅 --%>
   if (fromTime == 0 || toTime !=0 || fromTime >= t) {
      
      $("#startTmSelected td div").removeClass('reserving');
      fromTime = t;
      toTime = 0;
      $(event.target).addClass('reserving');
      
      console.log(event.target);
   
   } else {
      toTime = t;
      
      <%-- 대여시간 잘못 선택시 예외처리 --%>
      for (let i=fromTime; i<=toTime; i++) {         
         if (reservedTime.indexOf(i) != -1) {
            alert('선택불가한 시간입니다.');
            
             <%-- 시작시간이0이 아니고, 끝시간도 0이 아니고 시작시간이 끝시간보다 크다면 
                선택된 시간 초기화하기 --%>
            $("#startTmSelected td div").removeClass('reserving');
            fromTime = 0;
            toTime = 0;

            return false;
         }

         <%-- 선택한 시간에 문제가 없다면 끝시간에 val 넣어주기 --%>
         $(`#startTmSelected td div[value="\${i}"]`).addClass('reserving');
      }
      
       // 선택된 시간 개수 출력
       selectedCount = toTime - fromTime + 1;
       console.log('선택된 시간 개수 : ', selectedCount);
       
       // totalPrice값 설정
       totalPrice = selectedCount * ${board.price};
       console.log('총 금액: ', totalPrice);
        
       // 동적으로 payInfo 업데이트
        updatePayInfo();
       
   }
}

//payInfo 업데이트 함수 추가
function updatePayInfo() {
   
    // 동적으로 payInfo 업데이트
    var payInfo = "";
      var hours;
      var minutes;
      
    if( selectedCount > 2) {
       if( (selectedCount%2) == 1 ){ // 홀수칸 일때 == 시간만 나와야함
          if(selectedCount == 3) {
             hours = 1;
             minutes = 0;

             payInfo = "";
             payInfo += "<p>총 대여시간 : " + hours + "시간</p>";
                 payInfo += "<p>총 금액 : " + formatNumber(totalPrice - ${board.price}) + "원</p>";
                 
             console.log("시간",hours)
             console.log("분",minutes)
          } else {
             hours = Math.floor( (selectedCount-1) / 2 );
             minutes = 0;

             payInfo = "";
             payInfo += "<p>총 대여시간 : " + hours*1 + "시간</p>";
                 payInfo += "<p>총 금액 : " + formatNumber(totalPrice - ${board.price}) + "원</p>";

             console.log("시간",hours)
             console.log("분",minutes)
          }
       } else { // 짝수 일 때 == 시간 분 나와야 함
            hours = Math.floor( (selectedCount / 2) - 1);
            minutes = 30;
           payInfo = "";
          payInfo += "<p>총 대여시간 : " + hours*1 + "시간" + " " + minutes*1 + "분</p>";
              payInfo += "<p>총 금액 : " + formatNumber(totalPrice - ${board.price}) + "원</p>";
          console.log("시간",hours)
            console.log("분",minutes)
       } 
       
    } else if( selectedCount == 2) {
       hours = 0;
       minutes = 30;
       
        payInfo = "";
       payInfo += "<p>총 대여시간 : " + minutes*1 + "분</p>";
        payInfo += "<p>총 금액 : " + formatNumber(${board.price}) + "원</p>";
    
       console.log("시간",hours)
        console.log("분",minutes)
    } else {
       payInfo = "";
    }
    
    $(".payInfo").html(payInfo);
}

//숫자를 패턴에 맞게 형식화하는 함수
function formatNumber(number) {
    const formatter = new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' });
    return formatter.format(number);
}

// 대여신청 버튼 클릭 시 서버로 전송
$(document).ready(function(){
  $("#makeRent").click(function () {
	  
      var selectedPaymentType = $("#paymentType").val();
      if (!selectedPaymentType) {
        alert('결제 방법을 선택해주세요.');
        return false;
      }     
     
      let selectedDate = $("#selectedDate").val();
      let startTime = fromTime;
      let endTime = toTime;
      
      if (fromTime == 0 || toTime == 0 || fromTime >= toTime) {
      alert('선택불가한 시간입니다.');
      
      $("#startTmSelected td div").prop("style","background-color:transparent;");
      fromTime = 0;
      toTime = 0;
      
      return false;  
      }
   
    // 대여신청 정보를 서버로 전송
	    $.ajax({
	        type: "POST",
	        url: "/share/rent"
	        , data: {
	        	boardNo: "${view.boardNo }",
	        	renterId: "${id }",
	        	rentDate: new Date(parseInt(selectedDate)),
	        	startTime: startTime,
	            endTime: endTime,
	            rentStatus : 1,
	            paymentType : $("#paymentType").val(),
	            merchantUid: randomMerchantUid
	        }
	    	,dataType: "json"
	        // 대여신청 성공 시 추가 작업 수행
	        , success: function (res) {
	            console.log("대여신청 성공:", res);
	            
	           // 대여신청 성공 시 알림창 띄우기
	           alert("대여신청이 성공적으로 완료되었습니다. \n승인을 기다려주세요.");
	           
			   <%-- 알림보내기 --%>	          
	           $.post( "/alert/sendnotification", { 
	        		id: "${view.writerId}"
        	        , sender: "${id}"
        	        , content: 2
        	        , menu: "${param.menu}"
	        		, boardNo: "${view.boardNo}"
	        	});// $.post 끝
	           
	           // 페이지 새로고침
	           location.reload();
	            
	        }
	        , error: function (error) {
	            console.error("대여신청 실패:", error);
	            
	            // 대여신청 실패 시 알림창 띄우기
	            alert("대여신청에 오류가 발생했습니다. \n관리자에게 문의주세요.");
	            
	        }
	    });
  });
});
</script>

<!-- Modal, 대여창 -->
<div class="modal fade" id="rentModal" tabindex="-1" aria-labelledby="rentModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
      
         <!-- Modal Header -->
         <div class="modal-header">
            <h5 class="modal-title" id="rentModalLabel">대여일 선택</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div><!-- .modal-header -->
         
         <!-- Modal Body -->
         <div class="modal-body">
             <div class="calendar-container">
                 <table class="Calendar">
                  
                  <thead>
                      <tr>
                          <td onClick="prevCalendar();" style="cursor:pointer;">&#60;</td>
                          <td colspan="5">
                              <span id="calYear"></span>년
                              <span id="calMonth"></span>월
                          </td>
                          <td onClick="nextCalendar();" style="cursor:pointer;">&#62;</td>
                      </tr>
                      <tr>
                          <td>일</td><td>월</td><td>화</td><td>수</td><td>목</td><td>금</td><td>토</td>
                      </tr>
                  </thead>
                  
                  <tbody>
                  </tbody>
                  
                 </table>
             </div><!-- .calendar-container --><br><br>
             
             <%-- 예약 시간을 선택하는 폼 --%>
               <div class="time-container" style="margin-bottom: -8px; display: grid;">
                  
                 <div style="display:none; margin-top:-30px; margin-bottom:5px;" id="time">
                     <span style="font-size: 14px;">*다음 대여자를 위해 장기 대여는 삼가주세요.</span><br>
                        <span style="font-size: 14px;">*날짜가 넘어가면 여러번 신청해야 합니다.</span><br>
                     <span style="font-size: 14px;">*선택한 시간 전까지 반납필수!</span><br>
                 </div>
                      
                  <%-- 시간목록 테이블 --%>
                  <table>
                    <tbody id="startTmSelected"></tbody>
                  </table><br>
                  
             </div><!-- .time-container -->
              
              <div class="payInfo">
              </div>
              
              <div class="paymentContainer">
                  <select name="paymentType" id="paymentType">
                     <option value="" selected disabled hidden>결제 방법을 선택하세요</option>
                     <option value="0">직접결제</option>
                  </select>
            </div><!-- .paymentContainer -->
            
            <div class="rentBtn-container">   
                 <!-- 선택한 날짜를 저장할 hidden input -->
                 <input type="hidden" name="selectedDate" id="selectedDate" >
                  <button type="button" name="makeRent" id="makeRent" class="btn float-end">대여신청</button>
              </div><!-- .rentBtn-container -->
                 
         </div><!-- .modal-body -->
         
         <!-- Modal Footer -->
         <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
         </div><!-- .modal-footer -->
      
      </div><!-- .modal-content -->
   </div><!-- .modal-dialog -->
</div><!-- .modal fade -->

