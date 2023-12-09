<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>로그인</title>
    <link rel = "stylesheet" href="css/loginStyle.css" />
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