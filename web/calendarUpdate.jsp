<%@ page contentType="application/json; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="Database.DatabaseConnector" %>
<%@ page import="com.google.gson.Gson" %>
<%
  response.setContentType("application/json");
  response.setCharacterEncoding("UTF-8");

  String calendarID = (String) session.getAttribute("calendarID");
  String newTitle = request.getParameter("newTitle");
  String newDescription = request.getParameter("newDescription");
  String Date = request.getParameter("Date"); // 날짜 형식 확인 필요

  Connection con = null;
  PreparedStatement pstmt = null;

  try {
    con = DatabaseConnector.getConnection();
    String sql = "UPDATE event SET title = ?, description = ? WHERE date = ?";

    pstmt = con.prepareStatement(sql);
    pstmt.setString(1, newTitle);
    pstmt.setString(2, newDescription);
    pstmt.setString(3, Date);

    int updatedRows = pstmt.executeUpdate();

    // 업데이트된 행의 수를 반환 (예외 처리가 필요할 수 있음)
    Map<String, Object> responseMap = new HashMap<>();
    responseMap.put("updatedRows", updatedRows);
    Gson gson = new Gson();
    String jsonResponse = gson.toJson(responseMap);
    out.print(jsonResponse);
  } catch(Exception e) {
    Map<String, Object> errorResponse = new HashMap<>();
    errorResponse.put("error", "이벤트를 수정하는 중 오류가 발생했습니다.");
    errorResponse.put("message", e.getMessage());
    String errorJson = new Gson().toJson(errorResponse);
    out.print(errorJson);
    return;
  } finally {
    if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
    if (con != null) try { con.close(); } catch (SQLException ex) {}
  }
%>
