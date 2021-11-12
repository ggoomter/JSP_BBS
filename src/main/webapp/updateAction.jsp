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
<title>글수정 처리</title>
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
		        if(request.getParameter("bbsTitle")==null || request.getParameter("bbsContent")==null
		        ||request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals("")
		                ){  //제목이나 내용을 입력안했다면
		                    PrintWriter script = response.getWriter();
		                    script.println("<script>");
		                    script.println("alert('입력이 안 된 사항이 있습니다.')");
		                    script.println("history.back()");
		                    script.println("</script>");
	            }else{  //제목과 내용이 정상 입력되었다면
	                 BbsDAO bbsDAO = new BbsDAO();
	                 int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));   //글수정 로직 실행
	                 if(result == -1){      //데이터베이스 오류
	                     PrintWriter script = response.getWriter();
	                     script.println("<script>");
	                     script.println("alert('글수정에 실패했습니다.')");
	                     script.println("history.back()");
	                     script.println("</script>");
	                 }
	                 else {             //글수정 정상 실행     
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