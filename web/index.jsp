<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang='en'>
<head>
  <title>DB ProJect 초심</title>
  <meta charset='utf-8' />
  <link href="${pageContext.request.contextPath}/FullCalendar/lib/main.css" rel="stylesheet" />
  <script src="${pageContext.request.contextPath}/FullCalendar/lib//main.js"></script>
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
                <span class="close">&times;</span>
                <p>일정 추가 ${clickedDate}</p>
                  <div class = "modal-body">
                    <input type="text" id="eventTitle" placeholder="일정 제목">
                    <input type="text" id="eventDescription" placeholder="설명">
                  </div>
                <button id="addEventBtn">일정 추가</button>
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
                <span class="close">&times;</span>
                <p>일정 수정 ${eventTitle}</p>
                <input type="text" id="eventTitle" placeholder="일정 제목" value="${eventTitle}">
                <input type="text" id="eventDescription" placeholder="일정 설명" value="${eventDescription}">
                <button id="updateEventBtn">일정 수정</button>
              </div>
            </div>
          `;
          document.body.appendChild(modal);

          var modalClose = modal.querySelector('.close');
          modalClose.onclick = function() {
            document.body.removeChild(modal);
          };

          var updateEventBtn = modal.querySelector('#updateEventBtn');
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
    /* 모달 스타일 */
    .modal {
      display: block;
      position: fixed;
      z-index: 1;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      overflow: auto;
      background-color: rgba(0, 0, 0, 0.4);
    }

    .modal-content {
      background-color: #fefefe;
      margin: 15% auto;
      width: 50%;
      display: block;
      padding: 20px;
      border: 1px solid #888;
    }
    .modal-body {
      display: flex;
      text-align: center;
      flex-direction: column;
      height: 100%;

    }
    #eventTitle {
      width: 80%;
    }
    #eventDescription {
      width: 80%;
      height: 100%;
    }
    .close {
      color: #aaa;
      float: right;
      font-size: 28px;
      font-weight: bold;
    }

    .close:hover,
    .close:focus {
      color: black;
      text-decoration: none;
      cursor: pointer;
    }

    .fc-event-title {
      margin-top: 5px;
      font-size: 15px;
      color: #ffffff; /* 설명 글꼴 색상 */
    }

    .fc-event-description {
      margin-top: 5px;
      width: 50px;
      height: 30px;
      font-size: 12px;
      color: #ffffff; /* 설명 글꼴 색상 */
    }
  </style>
</head>
<body>
<div id='calendar'></div>
</body>
</html>