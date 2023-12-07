<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.regex.*" %>
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
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirm-password");

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

    if (hasError) {
        out.println("<script type='text/javascript'>showMessage('" + errorMessage + "'); history.back();</script>");
    } else {
        out.println("<script type='text/javascript'>showMessage('" + successMessage + "'); window.location.href = 'index.jsp';</script>");
    }
%>
</body>
</html>