<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="Database.DatabaseConnector" %> <!-- DatabaseConnector 클래스 임포트 -->
<!DOCTYPE html>
<html>
<head>
    <title>회원가입</title>
    <script type="text/javascript">
        function showMessage(message) {
            alert(message);
        }
    </script>
</head>
<body>
<%
    String username = request.getParameter("username");
    String userid = request.getParameter("userid");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirm-password");
    String selectTeam = request.getParameter("team");
    String GroupPassword = request.getParameter("Group-password");

    boolean hasError = false;
    String errorMessage = "";
    String successMessage = "회원가입이 완료되었습니다!";

    if (username == null || username.trim().isEmpty()) {
        hasError = true;
        errorMessage += "사용자 이름을 입력해주세요.\\n";
    }

    Pattern pattern = Pattern.compile("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$");
    Matcher matcher = pattern.matcher(email);
    if (email == null || email.trim().isEmpty() || !matcher.matches()) {
        hasError = true;
        errorMessage += "유효한 이메일 주소를 입력해주세요.\\n";
    }

    if (password == null || password.length() < 8) {
        hasError = true;
        errorMessage += "비밀번호는 8자 이상이어야 합니다.\\n";
    }

    if (!password.equals(confirmPassword)) {
        hasError = true;
        errorMessage += "비밀번호가 일치하지 않습니다.\\n";
    }

    if (!hasError) {
        Connection con = null;
        PreparedStatement pstmtUser = null;
        PreparedStatement pstmtTeam = null;
        PreparedStatement pstmt = null;
        boolean autoCommit = true;
        ResultSet rs = null;

        try {
            // 데이터베이스 연결
            con = DatabaseConnector.getConnection();
            autoCommit = con.getAutoCommit();
            con.setAutoCommit(false); // 트랜잭션 시작

            String sql = "SELECT team_PW FROM team WHERE team_name = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, selectTeam);
            rs = pstmt.executeQuery();

            String teamPassword = null;
            if (rs.next()) {
                teamPassword = rs.getString("team_PW"); // 데이터베이스에서 가져온 팀 비밀번호
            }

            sql = "SELECT team_name FROM team WHERE team_name = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, selectTeam);
            rs = pstmt.executeQuery();

            String teamName = null;
            if(rs.next()) {
                teamName = rs.getString("team_name");
            }
            // SQL 쿼리 실행
            String sql_user = "INSERT INTO User (user_ID, user_name, user_email, user_PW) VALUES (?, ?, ?, ?)";
            pstmtUser = con.prepareStatement(sql_user);
            pstmtUser.setString(1, userid);
            pstmtUser.setString(2, username);
            pstmtUser.setString(3, email);
            pstmtUser.setString(4, password); // 실제 애플리케이션에서는 비밀번호 해시 처리 필요
            int userResult = pstmtUser.executeUpdate();


            String sql_user_team = "INSERT INTO userteam (user_ID, team_ID) VALUES (?, ?)";
            pstmtTeam = con.prepareStatement(sql_user_team);

            //개발자 팀 회원가입
            if(GroupPassword.equals(teamPassword) && selectTeam.equals("개발자"))    { pstmtTeam.setString(1, userid); pstmtTeam.setString(2, "1"); }
            //디자이너 팀 회원가입
            else if(GroupPassword.equals(teamPassword) && selectTeam.equals("디자이너"))     { pstmtTeam.setString(1, userid); pstmtTeam.setString(2, "2"); }
            //연구원 팀 회원가입
            else if(GroupPassword.equals(teamPassword) && selectTeam.equals("연구원"))     { pstmtTeam.setString(1, userid); pstmtTeam.setString(2, "3"); }
            else {
                con.rollback(); // 트랜잭션 롤백
                out.println("<script type='text/javascript'>showMessage('"+ selectTeam + "팀의 비밀번호가 일치하지 않습니다." +"'); window.location.href = 'SignUp.jsp';</script>");
            }

            int teamresult = pstmtTeam.executeUpdate();

            int i = 1;
            // 모든 쿼리가 성공적으로 실행되면 커밋
            if (teamresult > 0 && userResult > 0) {
                con.commit(); // 트랜잭션 커밋
                successMessage = "회원가입이 완료되었습니다. 로그인 페이지로 이동합니다.";
                out.println("<script type='text/javascript'>showMessage('" + successMessage +"'); window.location.href = 'index.jsp';</script>");
            } else {
                errorMessage = "회원가입에 실패했습니다. 다시 시도해주세요.";
                out.println("<script type='text/javascript'>showMessage('" + errorMessage + "'); history.back();</script>");
            }
        } catch(Exception e) {
            if(con != null) {
                try {
                    con.rollback(); // 오류 발생 시 트랜잭션 롤백
                } catch(SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            errorMessage = "데이터베이스 처리 중 오류가 발생했습니다.";
            out.println("<script type='text/javascript'>showMessage('" + errorMessage + "'); history.back();</script>");
        } finally {
            if(pstmtUser != null) try { pstmtUser.close(); } catch(SQLException ex) {}
            if(pstmtTeam != null) try { pstmtTeam.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
            if (rs != null) try { rs.close(); } catch (SQLException ex) {}
            if(con != null) {
                try {
                    con.setAutoCommit(autoCommit); // 원래의 auto-commit 상태로 복구
                    con.close();
                } catch(SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
    } else {
        out.println("<script type='text/javascript'>showMessage('" + errorMessage + "'); history.back();</script>");
    }
%>
</body>
</html>