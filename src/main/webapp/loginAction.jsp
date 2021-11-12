<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
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

    <%
        String userID = null;
        if (session.getAttribute("userID")!=null){  //세션의 userID속성이 null이 아니면
            userID = (String) session.getAttribute("userID");
        }
        if(userID !=null){  //이미 로그인된사람은 로그인되지 않도록 하는 처리
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('이미 로그인 되어있습니다.')");
            script.println("location.href = 'main.jsp'");
            script.println("</script>");
        }
        
    
        UserDAO userDAO = new UserDAO();
        int result = userDAO.login(user.getUserID(), user.getUserPassword());
        
        if(result == 1){    //로그인 성공    
            session.setAttribute("userID", user.getUserID());   //세션값부여
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("location.href = 'main.jsp'");
            script.println("</script>");
        }
        else if(result == 0){   //비밀번호 불일치
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('비밀번호가 틀립니다.')");
            script.println("history.back()");
            script.println("</script>");
        }
        else if(result == -1){  //아이디가 없음
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('존재하지 않는 아이디입니다.')");
            script.println("history.back()");
            script.println("</script>");
        }
        else if(result == -2){  //데이터베이스 오류
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('데이터베이스 오류가 발생했습니다.')");
            script.println("history.back()");
            script.println("</script>");
        }
    %>
</body>
</html>