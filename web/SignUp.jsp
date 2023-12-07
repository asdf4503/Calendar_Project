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
        input[type = "email"],
        input[type = "password"],
        input[type = "Group"]{
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
    </style>
</head>
<body>
<div class="container">
    <div class="header-container">
        <div class="header-text">회원가입</div>
    </div>
    <div class="body-container">
        <div class="body-box">
            <form action="SignUpCheck.jsp" method="post">
                <label for="username">이름</label>
                <input type="text" id="username" name="username" required>

                <label for="email">이메일</label>
                <input type="email" id="email" name="email" required>

                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" required>

                <label for="confirm-password">비밀번호 확인</label>
                <input type="password" id="confirm-password" name="confirm-password" required>

                <label for="Group">팀</label>
                <input type="Group" id="Group" name="Group" required>

                <input type="submit" value="회원가입">
            </form>
        </div>
    </div>
</div>
</body>
</html>

