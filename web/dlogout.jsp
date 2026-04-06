<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    // Invalidate the session if it exists
    if (session != null) {
        session.invalidate();
    }
    // Redirect to login page
    response.sendRedirect("ddash.jsp");
%>
