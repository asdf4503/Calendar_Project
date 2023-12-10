<%@ page contentType="application/json; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="Database.DatabaseConnector" %>
<%@ page import="com.google.gson.Gson" %>

<%
  // 기존에 설정된 Content-Type을 덮어쓰지 않도록 상단에 설정
  response.setContentType("application/json");
  response.setCharacterEncoding("UTF-8");

  String userTeamID = (String) session.getAttribute("userTeamID");

  Connection con = null;
  PreparedStatement pstmt = null;
  ResultSet rs = null;
  List<Map<String, Object>> eventsList = new ArrayList<>();

  try {
    con = DatabaseConnector.getConnection();
    String sql = "SELECT calendar_ID FROM calendar WHERE team_ID = ?";
    pstmt = con.prepareStatement(sql);
    pstmt.setString(1, userTeamID);
    rs = pstmt.executeQuery();

    String calendarID = null;
    if(rs.next()) {
        calendarID = rs.getString("calendar_ID");
        session.setAttribute("calendarID", calendarID); //캘린더 ID 세션에 저장
    }

    sql = "SELECT title, description, date FROM event WHERE calendar_ID = ?";
    pstmt = con.prepareStatement(sql);
    pstmt.setString(1, calendarID);
    rs = pstmt.executeQuery();

    while (rs.next()) {
      Map<String, Object> event = new HashMap<>();
      event.put("title", rs.getString("title"));
      event.put("start", rs.getString("date")); // 날짜 형식 확인 필요
      event.put("description", rs.getString("description"));
      eventsList.add(event);
    }
  } catch(Exception e) {
    // JSON 객체로 오류 메시지 반환
    Map<String, Object> errorResponse = new HashMap<>();
    errorResponse.put("error", "이벤트를 가져오는 중 오류가 발생했습니다.");
    errorResponse.put("message", e.getMessage());
    String errorJson = new Gson().toJson(errorResponse);
    out.print(errorJson);
    return; // 오류 발생 시 나머지 코드 실행 방지
  } finally {
    if (rs != null) try { rs.close(); } catch (SQLException ex) {}
    if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
    if (con != null) try { con.close(); } catch (SQLException ex) {}
  }

  // 정상적인 데이터 응답
  Gson gson = new Gson();
  String json = gson.toJson(eventsList);
  out.print(json);
%>
