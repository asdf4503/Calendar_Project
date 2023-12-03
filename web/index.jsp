<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>로그인</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            color: #666;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
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
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .forgot-password {
            text-align: center;
            display: block;
            margin-top: 10px;
            color: #007bff;
        }
    </style>
</head>
<body>

<h2>Login</h2>

<!-- 로그인 폼 -->
<form action="loginCheck.jsp" method="post">
    <div class="form-group">
        <label for="username">USER NAME</label>
        <input type="text" id="username" name="username">
    </div>
    <div class="form-group">
        <label for="password">PASSWORD</label>
        <input type="password" id="password" name="password">
    </div>
    <div class="form-group">
        <input type="submit" value="LOGIN">
    </div>
    <a href="#" class="forgot-password">회원가입</a>
</form>

</body>
</html>
