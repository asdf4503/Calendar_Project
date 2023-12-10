<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang='en'>
<head>
    <title>DB ProJect~ 초심</title>
    <meta charset='utf-8' />
    <link href="${pageContext.request.contextPath}/FullCalendar/lib/main.css" rel="stylesheet" />
    <link rel="stylesheet" href="css/calendarStyle.css"/>
    <script src="${pageContext.request.contextPath}/FullCalendar/lib/main.js"></script>
    <script src='FullCalendar/lib/locales/ko.js'></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // FullCalendar 인스턴스 생성 및 설정
            var calendarEl = document.getElementById('calendar');

            // 데이터 로딩 함수
            function loadCalendarData() {
                return fetch('calendarData.jsp')
                    .then(response => response.json())
                    .then(data => {
                        console.log("Data loaded: ", data);
                        return data; // 로드된 데이터 반환
                    })
                    .catch(error => {
                        console.error("Error loading data: ", error);
                        // 에러 처리
                    });
            }

            var calendar = new FullCalendar.Calendar(calendarEl, {
                height: 880,
                initialView: 'dayGridMonth',
                locale: 'ko',
                dayMaxEventRows: 2,

                events: function(fetchInfo, successCallback, failureCallback) {
                    loadCalendarData().then(data => {
                        successCallback(data);
                    });
                },

                dateClick: function(info) {
                    var clickedDate = new Date(info.dateStr); // 클릭한 날짜의 Date 객체 생성
                    var formattedDate = clickedDate.getFullYear() + '년 ' +
                        (clickedDate.getMonth() + 1) + '월 ' + // getMonth()는 0부터 11까지입니다.
                        clickedDate.getDate() + '일';

                    var modalContent = `
                    <form action="calendarCheck.jsp" method="post">
                        <div class="modal-content">
                        <div class="modal-top">
                            <p style="font-weight: bold;">일정 추가 - ` + formattedDate + `</p>
                        </div>
                        <div class="modal-body">
                            <div class="body-title">
                                <input type="text" id="eventTitle" name="eventTitle" placeholder="일정 제목" required>
                            </div>
                            <div class="body-sub">
                                <input type="text" id="eventDescription" name="eventDescription" placeholder="일정 내용" required>
                            </div>
                        </div>
                        <input type="hidden" id="eventDate" name="eventDate" value="` + info.dateStr + `" required>
                        <div class="modal-bottom">
                            <button type="submit" id="addEventBtn">추가 하기</button>
                        </div>
                        </div>
                    </form>
                    `;

                    var modal = document.createElement('div');
                    modal.className = 'modal';
                    modal.innerHTML = `
                    <div class="modal-content">
                        <div class="content-header"></div>
                        <div class="content-body">
                            <div class="first"></div>
                            <div class="middle">
                                ` + modalContent + `
                            </div>
                            <div class="end"></div>
                        </div>
                    </div>
                    </form>
                    `;
                    document.body.appendChild(modal);

                    var modalClose = modal.querySelector('.close');
                    modalClose.onclick = function() {
                        document.body.removeChild(modal);
                    };

                    var addEventBtn = modal.querySelector('#addEventBtn');
                    addEventBtn.onclick = function() {
                        var eventTitle = modal.querySelector('#eventTitle').value;
                        var eventDescription = modal.querySelector('#eventDescription').value;
                        var event = {
                            title: eventTitle,
                            start: clickedDate,
                            allDay: true,
                            description: eventDescription // 설명 추가
                        };
                        calendar.addEvent(event);
                        document.body.removeChild(modal);
                    };
                },
                eventClick: function(info) {
                    var clickedEvent = info.event;
                    var eventTitle = clickedEvent.title;
                    var eventDescription = clickedEvent.extendedProps.description || ''; // 기존 설명
                    var modal = document.createElement('div');
                    modal.innerHTML = `
                    <form action="calendarUpdate.jsp" method="post">
                        <div id="myModal" class="modal">
                          <div class="modal-content">
                            <div class="content-header"></div>
                                <div class="content-body">
                                    <div class="first"></div>
                                    <div class="middle">
                                        <div class="modal-top">
                                            <p style="font-weight: bold;">일정 수정</p>
                                        </div>
                                        <div class="modal-body">
                                        <input type="hidden" name="originalTitle" value="` + eventTitle + `" >
                                        <input type="hidden" name="originalDescription" value="` + eventDescription + `">
                                          <div class="body-title">
                                             <input type="text" name="newTitle" id="eventTitle" placeholder="일정 제목" value="` + eventTitle + `" required>
                                          </div>
                                          <div class="body-sub">
                                            <input type="text" name="newDescription" id="eventDescription" placeholder="일정 설명" value="` + eventDescription + `" required>
                                          </div>
                                        </div>
                                        <div class="modal-bottom">
                                          <button id="updateEventBtn">일정 수정</button>
                                          <button id="deleteEventBtn" style="background-color: red; color: white;">일정 삭제</button>
                                        </div>
                                    </div>
                                    <div class="end"></div>
                                </div>
                          </div>
                        </div>
                        </form>
                      `;
                    document.body.appendChild(modal);

                    var modalClose = modal.querySelector('.close');
                    modalClose.onclick = function() {
                        document.body.removeChild(modal);
                    };

                    var updateEventBtn = modal.querySelector('#updateEventBtn');
                    var deleteEventBtn = modal.querySelector('#deleteEventBtn');
                    var titleInput = modal.querySelector('#eventTitle');
                    var descriptionInput = modal.querySelector('#eventDescription');

                    titleInput.value = eventTitle;
                    descriptionInput.value = eventDescription;

                    updateEventBtn.onclick = function() {
                        var newEventTitle = titleInput.value;
                        var newEventDescription = descriptionInput.value;
                        clickedEvent.setProp('title', newEventTitle);
                        clickedEvent.setExtendedProp('description', newEventDescription); // 설명 업데이트
                        document.body.removeChild(modal);
                    };
                    deleteEventBtn.onclick = function() {
                        clickedEvent.remove(); // 이벤트 삭제
                        document.body.removeChild(modal);
                    };
                },

                eventDidMount: function(info) {
                    var description = info.event.extendedProps.description;
                    if (description) {
                        var descriptionEl = document.createElement('div');
                        descriptionEl.className = 'fc-event-description';
                        descriptionEl.innerHTML = description;
                        info.el.querySelector('.fc-event-title').appendChild(descriptionEl);
                    }
                }
            });
            calendar.render(); // 캘린더 렌더링
        });
    </script>
</head>
<body>
<div id='calendar'></div>
</body>
</html>