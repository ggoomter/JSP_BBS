<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="comment.CommentDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!-- 이전화면에서 넘어온 파라미터의 변수들을 빈으로 등록하는 과정 -->
	<!-- 클래스이름 빈이름 = new 클래스(); 와 동일 -->
	<jsp:useBean id = "comment" class="comment.Comment" scope="page" />

	<!-- useBean 액션태그로 생성한 자바빈 인스턴스에 setter를 사용하는 역할 -->
	<jsp:setProperty name ="comment" property="bbsID" />
	<jsp:setProperty name ="comment" property="commentID" />
	<jsp:setProperty name ="comment" property="commentText" />
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>댓글쓰기 처리</title>
</head>
<body>
    <%@ include file="session.jsp" %><!-- 정적포함 -->
    
    <%
        /* 자바단 사용할 변수 선언 */
        request.setCharacterEncoding("UTF-8");
        int bbsID = 0;
        int commentID = 0;
        String commentText = null;
        String type = request.getParameter("type");
 
        
        /* 빈이 널이 아니면 값 대입 */
        if(comment !=null){
            bbsID = comment.getBbsID();
            commentID = comment.getCommentID();
            commentText = comment.getCommentText();
        }

	    if(userID ==null){  //로그인이 되어있는사람만 댓글을 쓸수있어야 한다.        
	        PrintWriter script = response.getWriter();
	        script.println("<script>");
	        script.println("alert('로그인을 하세요')");
	        //script.println("location.href = 'login.jsp'");
	        script.println("</script>");
	    } else{    //로그인이 되어있다면
	        if(comment.getCommentText()==null || comment.getCommentText()==""){  //댓글 내용이 비었고 타입이 delete가 아닐경우
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('댓글내용을 입력해주세요.')");
                //script.println("history.back()");
                script.println("</script>"); 
            }else{  //제목과 내용이 정상 입력되었다면
                 CommentDAO commentDAO = new CommentDAO();

                 switch(type){
                 case "create":{
                     //댓글쓰기 로직 실행
                     int result = commentDAO.write(String.valueOf(comment.getBbsID()), userID, comment.getCommentText());   
                     
                     if(result == -1){      //데이터베이스 오류
                         PrintWriter script = response.getWriter();
                         script.println("<script>");
                         script.println("alert('댓글작성을 실패했습니다.')");
                         //script.println("history.back()");
                         script.println("</script>");
                     }
                     else {             //댓글쓰기 정상 실행후 메세지   
                         PrintWriter script = response.getWriter();
                         script.println("<script>");
                         script.println("alert('댓글이 정상적으로 등록되었습니다.')");
                         String url = "view.jsp?bbsID="+comment.getBbsID();
                         script.println("location.href = "+"'"+url+"'");
                         script.println("</script>");
                     }
                     
                 }
                 case "update":{
                     PrintWriter script = response.getWriter();
                     script.println("<script>");
                     script.println("alert(bbsID+'댓글을 수정하겠습니다.')");
                     script.println("</script>");
                     break;
                 }
                 case "delete":{
                     PrintWriter script = response.getWriter();
                     script.println("<script>");
                     script.println("alert(bbsID+'댓글을 삭제하겠습니다.')");
                     script.println("</script>");
                     break;
                 }
                 default:
                 }
                

            }
	    }
    

    %>
</body>
</html>