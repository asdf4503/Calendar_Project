package com.servlet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

public class HolidayServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String> holidays = Arrays.asList(
                "2023-01-01,신정",
                "2023-01-22,설날",
                "2023-12-25,크리스마스"
                // 추가 공휴일
        );

        request.setAttribute("holidays", holidays);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/calendar.jsp");
        dispatcher.forward(request, response);
    }
}
