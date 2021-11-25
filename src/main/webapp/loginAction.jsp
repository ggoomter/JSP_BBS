<%@page import="java.nio.charset.Charset"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- login.jsp(로그인화면)에서 넘겨받은 데이터들을 user Bean에 세팅해준다. -->
<jsp:useBean id = "user" class="user.User" scope="page" />
<jsp:setProperty name ="user" property="userID" />
<jsp:setProperty name ="user" property="userPassword" />
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
<title>로그인처리</title>
</head>
<body>
    <%@ include file="session.jsp" %><!-- 정적포함 -->
    <%!
    UserDAO userDAO = new UserDAO();
    int result = -999;
    String msg = "";
    %>
    
    <c:if test="${sessionScope.userID}!=null"><!-- 이미 로그인된사람은 로그인 할수없도록 하는 처리.--> 
            <c:set var="msg" value="이미 로그인 되어있습니다."></c:set>
            <c:out value="alert('msg')" />

    </c:if>
        
    <%  result = userDAO.login(user.getUserID(), user.getUserPassword());
        out.println("로그인 리절트 결과 : "+result);
        out.println("로그인 리절트 1과 비교결과 : "+(result == 1));
        
    %>
    
    <c:choose>
        <c:when test="${result == 1}"> <!-- 로그인 성공 -->
            로그인성공
            <%
            out.println("choose의 when==1 안");
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('비밀번호가 틀립니다.')");
            script.println("history.back()");
            script.println("</script>");
            %>
        </c:when>
        <c:when test="${result == 0}"> <!-- 비밀번호 불일치 -->
            비밀번호불일치
            <%
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('비밀번호가 틀립니다.')");
            script.println("history.back()");
            script.println("</script>");
            %>
        </c:when>
        <c:when test="${result == -1}"> <!-- 아이디가 없음 -->
            아이디가없음
            <%
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('존재하지 않는 아이디입니다.')");
            script.println("history.back()");
            script.println("</script>");
            %>
        </c:when>
        <c:when test="${result == -2}"> <!-- 데이터베이스 오류 -->
            데이터베이스오류
            <%
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('데이터베이스 오류가 발생했습니다.')");
            script.println("history.back()");
            script.println("</script>");
            %>
        </c:when>
        <c:otherwise>
            디폴트
            <% 
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('jstl otherwise 테스트')");
            script.println("history.back()");
            script.println("</script>");
            script.flush();
            script.close();
            %>
        </c:otherwise>
    </c:choose>
    
    <BR>
    업데이트중 확인3
</body>
</html>