<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="Database.DatabaseConnector" %>
<%
  response.setCharacterEncoding("UTF-8");

  //폼을 통해 데이터 받아오기
  String originalTitle = request.getParameter("originalTitle");
  String originalDescription = request.getParameter("originalDescription");

  String newTitle = request.getParameter("newTitle");
  String newDescription = request.getParameter("newDescription");

  //수정인지 삭제인지 값 받아오기
  String updateAction = request.getParameter("updateAction");
  String deleteAction = request.getParameter("deleteAction");

  Connection con = null;
  PreparedStatement pstmt = null;
  ResultSet rs = null;

  try {
    con = DatabaseConnector.getConnection();
    con.setAutoCommit(false); // 트랜잭션 시작

    // event_ID 값을 가져오기 위한 SELECT 쿼리
    String sql = "SELECT event_ID FROM event WHERE title = ? AND description = ?";
    pstmt = con.prepareStatement(sql);
    pstmt.setString(1, originalTitle);
    pstmt.setString(2, originalDescription);
    rs = pstmt.executeQuery();

    String eventID = null;
    if(rs.next()) {
        eventID = rs.getString("event_ID");
    }

    if(updateAction != null) {
        if (eventID != null) {
            // 이벤트 업데이트를 위한 UPDATE 쿼리
            sql = "UPDATE event SET title = ?, description = ? WHERE event_ID = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, newTitle);
            pstmt.setString(2, newDescription);
            pstmt.setString(3, eventID);
            int updatedRows = pstmt.executeUpdate();

            // 업데이트가 성공했는지 여부에 따라 알림 및 리다이렉션
            if (updatedRows > 0) {
                con.commit();
                out.println("<script>alert('일정이 변경되었습니다.'); window.location.href = 'calendar.jsp';</script>");
            } else {
                con.rollback();
                out.println("<script>alert('수정할 일정을 찾을 수 없습니다.'); window.location.href = 'calendar.jsp';</script>");
            }
        } else {
            con.rollback();
            out.println("<script>alert('일치하는 일정이 없습니다.'); window.location.href = 'calendar.jsp';</script>");
        }
    }
    if(deleteAction != null) {
        if (eventID != null) {
            sql = "DELETE FROM event WHERE event_ID = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, eventID);
            int deleteRows = pstmt.executeUpdate();

            if(deleteRows > 0) {
                con.commit();
                out.println("<script>alert('일정이 삭제되었습니다.'); window.location.href = 'calendar.jsp';</script>");
            } else {
                con.rollback();
                out.println("<script>alert('삭제할 일정을 찾을 수 없습니다.'); window.location.href = 'calendar.jsp';</script>");
            }
        }
    } else {
          con.rollback();
          out.println("<script>alert('일치하는 일정이 없습니다.'); window.location.href = 'calendar.jsp';</script>");
      }


  } catch(Exception e) {
      con.rollback();
      out.println("<script>alert('오류가 발생했습니다: " + e.getMessage() + "'); window.location.href = 'calendar.jsp';</script>");
  } finally {
    // 자원 해제
    if (rs != null) try { rs.close(); } catch (SQLException ex) {}
    if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
    if (con != null) try { con.close(); } catch (SQLException ex) {}
  }
%>
