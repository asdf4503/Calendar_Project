<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>로그인</title>
    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }
        .container {
            display: flex;
            flex-direction: column;
            height: 100%;
        }
        form {
            height: 100%;
        }

        .header-container {
            background-color: #f0f0f0;
            text-align: center;
            height: 30%;
            display: flex;
            width: 100%;
            justify-content: flex-end;
            flex-direction: column;
            align-items: center;
        }
        .header-text {
            font-size: 30px;

            font-weight: bold;
        }

        .body-container {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            width: 100%;
            height: 40%; /* 바디 컨테이너의 높이를 40%로 설정 */
            text-align: center;
            justify-content: center;
            align-items: center;
            display: flex;

        }
        .body-box {
            width: 250px;
            height: 250px;
            border: 1px solid #000;
            background-color: #f0f0f0;
            margin: 19px;
            display: flex;
            align-items: center;
            text-align: center;
            justify-content: center;
            padding: 20px;
            border-radius: 10px;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 7px;
            border: 2px solid #ddd;
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
            margin: 7px;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        #username {
            font-size: 12px;
        }
        .form-group {
            flex-direction: column;
            display: flex;
            height: 100%;
            width: 100%;
            text-align: center;
            justify-content: center;
            align-items: center;
        }
        button[type="button"] {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: white;
            cursor: pointer;
            margin: 7px;

        }
        button[type="button"]:hover {
            background-color: #0056b3;
        }

        .footer-container {
            background-color: #f0f0f0;
            height: 30%;
            width: 100%;
            text-align: center;
            justify-content: flex-end;
            flex-direction: column;
            align-items: center;
            display: flex;
        }
        .footer-text {
            font-weight: bold;
            font-size: 30px;
            margin: 10px;
        }
    </style>
</head>
<body>


<!-- 로그인 폼 -->
<form action="loginCheck.jsp" method="post">
    <div class="container">
        <div class="header-container">
            <div class="header-text">LOGIN</div>
        </div>
        <div class="body-container">
            <div class="body-box">
                <div class="form-group">
                    <label for="username">USER NAME</label>
                    <input type="text" id="username" name="username">

                    <label for="password">PASSWORD</label>
                    <input type="password" id="password" name="password">

                    <input type="submit" value="LOGIN">

                    <button type="button" onclick="location.href='SignUp.jsp'">회원가입</button>
                </div>
            </div>
        </div>
        <div class="footer-container">

        </div>
    </div>
</form>

</body>
</html>