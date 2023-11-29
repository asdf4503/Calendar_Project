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
        locale: 'ko'
      });
      calendar.render();
    });

  </script>
</head>
<body>
<div id='calendar'></div>
</body>
</html>
//t