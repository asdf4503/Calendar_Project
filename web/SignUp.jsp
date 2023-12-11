<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="Database.DatabaseConnector" %>
<!DOCTYPE html>
<html>
<head>
    <link rel ="stylesheet" href="./css/SignUpStyle.css" />
    <title>회원가입</title>
    <script type="text/javascript">
        // 콤보 박스에서 팀을 선택했을 때 호출되는 함수
        function onTeamChange() {
            var teamSelect = document.getElementById('team');
            var passwordInput = document.getElementById('team-password');
            var selectedTeam = teamSelect.options[teamSelect.selectedIndex].value;

            // 선택한 팀에 따라 비밀번호 입력란을 표시하거나 숨김
            if (selectedTeam !== '') {
                passwordInput.style.display = 'block';
            } else {
                passwordInput.style.display = 'none';
            }
        }
    </script>
</head>
<body>
<div class="container">
    <div class="header-container">
        <div class="header-text">회원가입</div>
    </div>
    <div class="body-container">
        <div class="body-box">
            <form action="SignUpCheck.jsp" method="post">
                <!-- '팀' 콤보 박스 -->
                <label for="team">팀</label>
                <select id="team" name="team" onchange="onTeamChange()">
                    <option value="">팀 선택</option>
                    <%
                        Connection con = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;

                        try {
                            con = DatabaseConnector.getConnection();
                            String sql = "SELECT team_name FROM team";
                            pstmt = con.prepareStatement(sql);
                            rs = pstmt.executeQuery();

                            while (rs.next()) {
                                String teamName = rs.getString("team_name");
                                out.println("<option value=\"" + teamName + "\">" + teamName + "</option>");
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                            // 오류 처리
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException ex) {}
                            if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
                            if (con != null) try { con.close(); } catch (SQLException ex) {}
                        }
                    %>
                </select>

                <!-- '팀' 비밀번호 입력란 -->
                <div id="team-password" style="display: none;">
                    <label for="Group-password">팀 비밀번호</label>
                    <input type="Group-password" id="Group-password" name="Group-password">
                </div>

                <label for="userid">사원 번호</label>
                <input type="text" id="userid" name="userid" required>

                <label for="username">이름</label>
                <input type="text" id="username" name="username" required>

                <label for="email">이메일</label>
                <input type="email" id="email" name="email" required>

                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" required>

                <label for="confirm-password">비밀번호 확인</label>
                <input type="password" id="confirm-password" name="confirm-password" required>

                <input type="submit" value="회원가입">
            </form>
        </div>
    </div>
    <div class="footer-container"></div>
</div>
</body>
</html>

