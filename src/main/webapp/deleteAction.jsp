<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>


    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
<title>글삭제 처리</title>
</head>
<body>

    <%
    
	    String userID = null;
	    if (session.getAttribute("userID")!=null){  //세션의 userID속성이 null이 아니면
	        userID = (String) session.getAttribute("userID");
	    }
	    if(userID ==null){  //로그인이 되어있는사람만 글을 쓸수있어야 한다.        
	        PrintWriter script = response.getWriter();
	        script.println("<script>");
	        script.println("alert('로그인을 하세요')");
	        script.println("location.href = 'login.jsp'");
	        script.println("</script>");
	    } 
	    
	    int bbsID = 0;
	    if(request.getParameter("bbsID")!=null){
	        bbsID = Integer.parseInt(request.getParameter("bbsID"));
	    }
	    if(bbsID == 0){
	        PrintWriter script = response.getWriter();
	        script.println("<script>");
	        script.println("alert('유효하지 않은 글입니다.')");  
	        script.println("location.href = 'bbs.jsp'");  
	        script.println("</script>");
	    }
	    Bbs bbs = new BbsDAO().getBbs(bbsID);
	    if(!userID.equals(bbs.getUserID())){
	       PrintWriter script = response.getWriter();
	       script.println("<script>");
	       script.println("alert('권한이 없습니다.')");  
	       script.println("location.href = 'bbs.jsp'");  
	       script.println("</script>");
	    } else{    //로그인이 되어있고 권한도 있다면
             BbsDAO bbsDAO = new BbsDAO();
             int result = bbsDAO.delete(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));   //글삭제 로직 실행
             if(result == -1){      //데이터베이스 오류
                 PrintWriter script = response.getWriter();
                 script.println("<script>");
                 script.println("alert('글삭제에 실패했습니다.')");
                 script.println("history.back()");
                 script.println("</script>");
             }
             else {             //글삭제 정상 실행     
                 PrintWriter script = response.getWriter();
                 script.println("<script>");
                 script.println("location.href = 'bbs.jsp'");
                 script.println("</script>");
             }
	    }
    

    %>
</body>
</html>