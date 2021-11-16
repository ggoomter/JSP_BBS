<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>

    <%
        String userID = null;
        if (session.getAttribute("userID")!=null){  //세션의 userID속성이 null이 아니면
            userID = (String) session.getAttribute("userID");
        }else{  //현재 세션의 userID가 null이면

        }
    %>