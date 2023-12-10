<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="Database.DatabaseConnector" %> <!-- DatabaseConnector 클래스 임포트 -->
<%
  String eventTitle = request.getParameter("eventTitle");
  String eventDescription = request.getParameter("eventDescription");
  String eventDate = request.getParameter("eventDate");

  // 사용자 이름을 세션에서 가져옵니다.
  String username = (String) session.getAttribute("username");

  Connection con = null;
  PreparedStatement pstmt = null;
  PreparedStatement pstmt_event = null;
  ResultSet rs = null;

  try {
    // 데이터베이스 연결
    con = DatabaseConnector.getConnection();
    con.setAutoCommit(false); // 트랜잭션 시작

    String sql = "SELECT user_ID FROM User WHERE user_name = ?";
    pstmt = con.prepareStatement(sql);
    pstmt.setString(1, username);
    rs = pstmt.executeQuery();

    String userID = null;
    if(rs.next()) {
      userID = rs.getString("user_ID");
    }

    sql = "SELECT team_ID FROM userteam WHERE user_ID = ?";
    pstmt = con.prepareStatement(sql);
    pstmt.setString(1, userID);
    rs = pstmt.executeQuery();

    String teamID = null;
    if(rs.next()) {
      teamID = rs.getString("team_ID");
    }

    sql = "SELECT calendar_ID FROM calendar WHERE team_ID = ?";
    pstmt = con.prepareStatement(sql);
    pstmt.setString(1, teamID);
    rs = pstmt.executeQuery();

    String calendarID = null;
    if(rs.next()) {
      calendarID = rs.getString("calendar_ID");
    }

    String sql_event = "INSERT INTO event (calendar_ID, title, description, date) VALUES (?, ?, ?, ?)";
    pstmt_event = con.prepareStatement(sql_event);
    pstmt_event.setString(1, calendarID);
    pstmt_event.setString(2, eventTitle);
    pstmt_event.setString(3, eventDescription);
    pstmt_event.setString(4, eventDate);
    int eventResult = pstmt_event.executeUpdate();

    con.commit(); // 트랜잭션 커밋
    out.println("<script>alert('이벤트가 성공적으로 추가되었습니다.'); window.location.href = 'calendar.jsp';</script>");
  } catch(Exception e) {
    if(con != null) {
      try { con.rollback(); } catch(SQLException ex) {}
      e.printStackTrace(); // 오류 로그 출력
      out.println("<script>alert('이벤트 추가 중 오류가 발생했습니다: " + e.getMessage() + "'); history.back();</script>");
    }
    e.printStackTrace(); // 오류 로그 출력
    // 오류 발생 시 사용자에게 메시지를 보내는 코드
    out.println("<script type='text/javascript'>showMessage('" + "데이터베이스 처리 중 오류가 발생했습니다." + "'); history.back();</script>");
  } finally {
    if (rs != null) try { rs.close(); } catch (SQLException ex) {}
    if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
    if (pstmt_event != null) try { pstmt_event.close(); } catch (SQLException ex) {}
    if (con != null) try { con.close(); } catch (SQLException ex) {}
  }
%>