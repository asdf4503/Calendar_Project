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
  ResultSet rs = null;
  boolean loginSuccess = false;

  // 개발자 아이디
  if("db".equals(username) && "1234".equals(password))
    // 로그인 성공: 캘린더 페이지로 리디렉션
    response.sendRedirect("calendar.jsp");


    try {
    // 데이터베이스 연결
    con = DatabaseConnector.getConnection();

    // SQL 쿼리 준비
    String sql = "SELECT * FROM user WHERE user_name = ? AND user_PW = ?";
    pstmt = con.prepareStatement(sql);

    // 쿼리 매개변수 설정
    pstmt.setString(1, username);
    pstmt.setString(2, password);

    // 쿼리 실행
    rs = pstmt.executeQuery();

    // 결과 확인
    if (rs.next()) {
      loginSuccess = true; // 사용자가 존재하면 로그인 성공
    }

  } catch (SQLException e) {
    e.printStackTrace();
    // 오류 처리
  } finally {
    // 자원 정리
    if (rs != null) try { rs.close(); } catch (SQLException ex) {}
    if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
    if (con != null) try { con.close(); } catch (SQLException ex) {}
  }

  // 로그인 검증
  if (loginSuccess) {
    // 로그인 성공: 캘린더 페이지로 리디렉션
    response.sendRedirect("calendar.jsp");
  } else {
    // 로그인 실패: 경고 메시지와 함께 로그인 페이지로 돌아감
    out.println("<script>alert('로그인 실패했습니다.'); history.back();</script>");
  }
%>
