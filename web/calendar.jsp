<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang='en'>
<head>
    <title>DB ProJect~ 초심</title>
    <meta charset='utf-8' />
    <link href="${pageContext.request.contextPath}/FullCalendar/lib/main.css" rel="stylesheet" />
    <script src="${pageContext.request.contextPath}/FullCalendar/lib/main.js"></script>
    <script src='FullCalendar/lib/locales/ko.js'></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                locale: 'ko',
                dateClick: function(info) {
                    var clickedDate = info.dateStr;
                    var modal = document.createElement('div');
                    modal.innerHTML = `
            <div id="myModal" class="modal">
                <div class="modal-content">
                  <div class="content-header"></div>
                    <div class="content-body">
                        <div class="first"></div>
                    <div class="middle">
                      <div class="modal-top">
                        <span class="close">&times;</span>
                        <p style="font-weight: bold;">일정 추가 ${clickedDate}</p>
                      </div>
                      <div class = "modal-body">
                        <div class = "body-title">
                          <input type="text" id="eventTitle" placeholder="일정 제목">
                        </div>
                        <div class = "body-sub">
                          <input type="text" id="eventDescription" placeholder="일정 내용">
                        </div>
                      </div>
                      <div class="modal-bottom">
                        <button id="addEventBtn">추가 하기</button>
                      </div>
                    </div>
                    <div class="end"></div>
                    </div>
                </div>
            </div>
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
            <div id="myModal" class="modal">
              <div class="modal-content">
                <div class="content-header"></div>
                    <div class="content-body">
                        <div class="first"></div>
                        <div class="middle">
                            <div class="modal-top">
                                <span class="close">&times;</span>
                                <p style="font-weight: bold;">일정 수정 ${eventTitle}</p>
                            </div>
                            <div class="modal-body">
                              <div class="body-title">
                                 <input type="text" id="eventTitle" placeholder="일정 제목" value="${eventTitle}">
                              </div>
                              <div class="body-sub">
                                <input type="text" id="eventDescription" placeholder="일정 설명" value="${eventDescription}">
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
            calendar.render();
        });

    </script>
    <style>
        html, body {
            min-height: 100%;
            margin: 0;
            padding: 0;
            position: relative;
        }
        /* 모달 스타일 */
        .modal {
            position: absolute;
            z-index: 1;
            display: grid;
            place-items: center;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
        }
        .modal-content {
            height: 100%;
            width: 100%;
            display: flex;
            flex-direction: column;


        }
        .content-header {
            width: 100%;
            height: 10%;
        }
        .content-body {
            width: 100%;
            height: 70%;
            display: flex;
            flex-direction: row;
        }
        .first {
            height: 40%;

            width: 30%;
        }
        .end {
            height: 40%;
            width: 30%;
        }
        .middle {
            position: relative;
            flex-direction: column;
            display: flex;
            flex: 1;
            height: 60%;
            width: 40%;

        }

        .modal-top {
            top: 0;
            height: 10%;
            width: 100%;
            text-align: center;
            background-color: #ffe4c4;
        }
        .modal-body {

            align-items: center;
            justify-content: center;
            display: flex;
            flex-direction: column;
            width: 100%;
            height: 80%;
            background-color: #fffaf0;
        }
        .close {
            cursor: pointer; /* 마우스 오버 시 커서 변경 */
            position: absolute;

            right: 10px;
            font-size: 30px;
            color: #fff;
        }
        .body-title {
            text-align: center;
            width: 100%;
            align-items: center;
            height: 20%;

            justify-content: center;
            border: 50px;
        }
        #eventTitle {
            width: 80%;
            height: 30%;

        }

        .body-sub {
            width: 100%;

            display: flex;
            align-items: center;
            justify-content: center;
            border: 30px;
            height: 50%;
        }
        #eventDescription {
            width: 80%;
            height: 100%;

        }

        .modal-bottom {
            width: 100%;

            bottom: 0;
            height: 20%;
            text-align: center;
            align-items: end;
            background-color: #fffaf0;
            display: flex;
            justify-content: center;
        }
        #addEventBtn {
            height: 40%;
            margin: 10px;
            border: 2px solid darksalmon;
            background-color: rgba(0,0,0,0);
            color: darksalmon;
            border-radius: 5px;
            font-weight: bold;
        }
        #updateEventBtn {
            height: 40%;
            margin: 10px;
            border: 2px solid darksalmon;
            background-color: rgba(0,0,0,0);
            color: darksalmon;
            border-radius: 5px;
            font-weight: bold;
        }
        #deleteEventBtn {
            height: 40%;
            margin: 10px;
            border: 2px solid darksalmon;
            background-color: rgba(0,0,0,0);
            color: darksalmon;
            border-radius: 5px;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div id='calendar'></div>
</body>
</html>