<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>회원가입</title>
    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }
        .container {
            display: flex;
            flex-direction: column;
            height: 100%;
        }
        .header-container {
            background-color: #f0f0f0;
            text-align: center;
            padding: 20px;
        }
        .header-text {
            font-size: 30px;
            font-weight: bold;
        }
        .body-container {
            background-color: #f0f0f0;
            flex-grow: 1;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .body-box {
            width: 300px;
            padding: 20px;
            border: 1px solid #000;
            background-color: #fff;
            border-radius: 10px;
        }
        input[type = "text"],
        input[type = "userid"],
        input[type = "email"],
        input[type = "password"],
        input[type = "Group-password"]{
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: white;
            cursor: pointer;
            margin-top: 10px;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        select {
            width: 100%; /* 콤보 박스의 너비를 부모 요소에 맞춤 */
            padding: 15px; /* 패딩을 늘려 크기를 키움 */
            margin: 10px 0; /* 여백을 추가하여 주변 요소와의 간격을 설정 */
            font-size: 16px; /* 글꼴 크기를 키움 */
            border: 1px solid #ddd; /* 테두리 설정 */
            border-radius: 5px; /* 모서리를 둥글게 설정 */
            box-sizing: border-box; /* 박스 크기 계산 방법을 지정 */
        }
    </style>

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
                    <option value="developer">개발자</option>
                    <option value="designer">디자이너</option>
                    <option value="manager">매니저</option>
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
</div>
</body>
</html>

