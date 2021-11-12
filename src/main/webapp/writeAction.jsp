<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id = "bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name ="bbs" property="bbsTitle" />
<jsp:setProperty name ="bbs" property="bbsContent" />


    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
<title>글쓰기 처리</title>
</head>
<body>
    <%@ include file="session.jsp" %><!-- 정적포함 -->
    <%
	    if(userID ==null){  //로그인이 되어있는사람만 글을 쓸수있어야 한다.        
	        PrintWriter script = response.getWriter();
	        script.println("<script>");
	        script.println("alert('로그인을 하세요')");
	        script.println("location.href = 'login.jsp'");
	        script.println("</script>");
	    } else{    //로그인이 되어있다면
	        if(bbs.getBbsTitle()==null || bbs.getBbsContent()==null){  //제목이나 내용을 입력안했다면
	                    PrintWriter script = response.getWriter();
	                    script.println("<script>");
	                    script.println("alert('입력이 안 된 사항이 있습니다.')");
	                    script.println("history.back()");
	                    script.println("</script>");
            }else{  //제목과 내용이 정상 입력되었다면
                 BbsDAO bbsDAO = new BbsDAO();
                 int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());   //글쓰기 로직 실행
                 
                 if(result == -1){      //데이터베이스 오류
                     PrintWriter script = response.getWriter();
                     script.println("<script>");
                     script.println("alert('글쓰기에 실패했습니다.')");
                     script.println("history.back()");
                     script.println("</script>");
                 }
                 else {             //글쓰기 정상 실행     
                     PrintWriter script = response.getWriter();
                     script.println("<script>");
                     script.println("location.href = 'bbs.jsp'");
                     script.println("</script>");
                 }
            }
	    }
    

    %>
</body>
</html>