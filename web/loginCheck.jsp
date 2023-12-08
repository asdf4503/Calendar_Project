<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="Database.DatabaseConnector" %> <!-- DatabaseConnector 클래스 임포트 -->
<%
  // 사용자 입력 값 가져오기
  String username = request.getParameter("username");
  String password = request.getParameter("password");

  Connection con = null;
  PreparedStatement pstmt = null;

  // 로그인 검증
  if("db".equals(username) && "1234".equals(password)) {
    // 로그인 성공: 캘린더 페이지로 리디렉션
    response.sendRedirect("calendar.jsp");
  } else {
    // 로그인 실패: 경고 메시지와 함께 로그인 페이지로 돌아감
    out.println("<script>alert('로그인 실패했습니다.'); history.back();</script>");
  }
%>
