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
  String userTeamID = null;
  String teamName = null;

  // 디자인용 계정
  if("db".equals(username) && "1234".equals(password))
    // 로그인 성공: 캘린더 페이지로 리디렉션
    response.sendRedirect("calendar.jsp");

  try {
    // 데이터베이스 연결
    con = DatabaseConnector.getConnection();

    // 사용자 인증 쿼리
    String sql = "SELECT * FROM user WHERE user_name = ? AND user_PW = ?";
    pstmt = con.prepareStatement(sql);
    pstmt.setString(1, username);
    pstmt.setString(2, password);
    rs = pstmt.executeQuery();

    if (rs.next()) {
      loginSuccess = true; // 로그인 성공
      String userID = rs.getString("user_id"); // 사용자 ID

      // userteam에서 사용자의 team_ID 조회
      sql = "SELECT team_ID FROM userteam WHERE user_ID = ?";
      pstmt = con.prepareStatement(sql);
      pstmt.setString(1, userID);
      rs = pstmt.executeQuery();

      if (rs.next()) {
        userTeamID = rs.getString("team_ID"); // 사용자의 team_ID

        // team 테이블에서 team_name 조회
        sql = "SELECT team_name FROM team WHERE team_ID = ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, userTeamID);
        rs = pstmt.executeQuery();

        if (rs.next()) {
          teamName = rs.getString("team_name");
        }
      }
    }

    if (loginSuccess && teamName != null) {
      session.setAttribute("username", username); // 사용자 이름을 세션에 저장
      session.setAttribute("userTeamID", userTeamID); //팀 ID 세션에 저장
      // 적절한 메시지와 함께 팀 캘린더 페이지로 리디렉션
      out.println("<script>alert('" + teamName + "팀의 캘린더로 이동합니다.'); window.location = 'calendar.jsp?teamID=" + userTeamID + "';</script>");
    } else {
      // 로그인 실패 또는 팀 이름을 찾을 수 없음
      out.println("<script>alert('로그인 실패하였거나 팀 정보를 찾을 수 없습니다.'); history.back();</script>");
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
%>
